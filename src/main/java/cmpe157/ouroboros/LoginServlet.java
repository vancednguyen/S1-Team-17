package cmpe157.ouroboros;

import cmpe157.ouroboros.util.DBinfo;

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
            String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                int userId = result.getInt("user_id");
                String userName = result.getString("user_name");

                String role = "renter";

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

                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        }
    }
}