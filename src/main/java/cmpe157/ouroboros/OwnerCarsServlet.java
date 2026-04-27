package cmpe157.ouroboros;
import cmpe157.ouroboros.dao.carDao;
import cmpe157.ouroboros.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Owner-Cars")
public class OwnerCarsServlet extends HttpServlet {
    private final carDao carDAO = new carDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("userRole");
        if (!"owner".equals(role)) {
            response.sendRedirect("Browse-Cars");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        List<Car> cars = carDAO.getCarsByOwnerId(userId);
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/ownerCars.jsp").forward(request, response);
    }
}
