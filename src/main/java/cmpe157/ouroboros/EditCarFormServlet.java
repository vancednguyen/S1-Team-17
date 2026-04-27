package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.carDao;
import cmpe157.ouroboros.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/Edit-Car-Form")
public class EditCarFormServlet extends HttpServlet {
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

        int ownerId = (Integer) session.getAttribute("userId");
        String carId = request.getParameter("carId");

        Car car = carDAO.getCarById(carId, ownerId);

        if (car == null) {
            response.sendRedirect("Edit-Cars");
            return;
        }

        request.setAttribute("car", car);
        request.getRequestDispatcher("/editCarForm.jsp").forward(request, response);
    }
}