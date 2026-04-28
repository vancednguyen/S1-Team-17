package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.AdminDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminActionServlet")
public class AdminActionServlet extends HttpServlet {

    private final AdminDao adminDao = new AdminDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check — only admins can access this
        String role = (String) request.getSession().getAttribute("userRole");
        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // Delete a user
            String userIdStr = request.getParameter("userId");
            if (userIdStr != null && !userIdStr.isEmpty()) {
                int userId = Integer.parseInt(userIdStr);
                adminDao.deleteUser(userId);
            }

        } else if ("deleteCar".equals(action)) {
            // Delete a car
            String carId = request.getParameter("carId");
            if (carId != null && !carId.isEmpty()) {
                adminDao.deleteCar(carId);
            }
        }

        // After any action redirect back to dashboard
        response.sendRedirect("AdminDashboardServlet");
    }
}