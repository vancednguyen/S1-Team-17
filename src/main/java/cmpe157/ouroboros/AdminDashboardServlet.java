package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.AdminDao;
import cmpe157.ouroboros.model.Car;
import cmpe157.ouroboros.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    private final AdminDao adminDao = new AdminDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check — only admins can access this
        String role = (String) request.getSession().getAttribute("userRole");
        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get all users and cars from database
        List<User> users = adminDao.getAllUsers();
        List<Car> cars = adminDao.getAllCars();

        // Attach to request and forward to dashboard JSP
        request.setAttribute("users", users);
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
    }
}