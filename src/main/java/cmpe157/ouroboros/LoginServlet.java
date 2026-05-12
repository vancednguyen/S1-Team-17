package cmpe157.ouroboros;

import cmpe157.ouroboros.util.DBinfo;
import cmpe157.ouroboros.util.PasswordUtil;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBinfo.getConnection()) {

            // Step 1 — find user by email only. Do NOT search by password in SQL.
            String sql = "SELECT * FROM user WHERE email = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet result = statement.executeQuery();

            if (result.next()) {
                String storedPassword = result.getString("password");

                boolean validPassword;

                if (PasswordUtil.isBCryptHash(storedPassword)) {
                    validPassword = PasswordUtil.checkPassword(password, storedPassword);
                } else {
                    // Temporary backwards compatibility for old plaintext test accounts.
                    // Remove this block after you reset/migrate all old passwords.
                    validPassword = password != null && password.equals(storedPassword);

                    // If the old plaintext password was correct, immediately replace it with a hash.
                    if (validPassword) {
                        String hashedPassword = PasswordUtil.hashPassword(password);
                        String updateSql = "UPDATE user SET password = ? WHERE user_id = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                            updateStmt.setString(1, hashedPassword);
                            updateStmt.setInt(2, result.getInt("user_id"));
                            updateStmt.executeUpdate();
                        }
                    }
                }

                if (!validPassword) {
                    response.sendRedirect("login.jsp?error=invalid");
                    return;
                }

                // Found in user table and password matched
                int userId = result.getInt("user_id");
                String userName = result.getString("user_name");
                String phoneNumber = result.getString("phone_number");
                String role = "renter";

                // Check if they are an owner
                String ownerSql = "SELECT 1 FROM owner WHERE user_id = ?";
                try (PreparedStatement ownerStmt = conn.prepareStatement(ownerSql)) {
                    ownerStmt.setInt(1, userId);
                    ResultSet ownerRs = ownerStmt.executeQuery();
                    if (ownerRs.next()) {
                        role = "owner";
                    }
                }

                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("userEmail", email);
                session.setAttribute("userName", userName);
                session.setAttribute("userRole", role);
                session.setAttribute("userPhoneNumber", phoneNumber);

                if ("owner".equals(role)) {
                    response.sendRedirect("Owner-Cars");
                } else {
                    response.sendRedirect("RenterDashboardServlet");
                }

            } else {
                // Step 2 — not found in user table, check admin table.
                // This keeps your current admin login unchanged. You can hash admin passwords too later.
                String adminSql = "SELECT * FROM admin WHERE email = ? AND password = ?";
                PreparedStatement adminStmt = conn.prepareStatement(adminSql);
                adminStmt.setString(1, email);
                adminStmt.setString(2, password);
                ResultSet adminResult = adminStmt.executeQuery();

                if (adminResult.next()) {
                    int adminId = adminResult.getInt("admin_id");

                    HttpSession session = request.getSession();
                    session.setAttribute("adminId", adminId);
                    session.setAttribute("userEmail", email);
                    session.setAttribute("userRole", "admin");

                    response.sendRedirect("AdminDashboardServlet");

                } else {
                    response.sendRedirect("login.jsp?error=invalid");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        }
    }
}
