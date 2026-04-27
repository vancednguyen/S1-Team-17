package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.carDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/Update-Car")
public class UpdateCarServlet extends HttpServlet {
    private final carDao carDAO = new carDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int ownerId = (Integer) session.getAttribute("userId");

        String carId = request.getParameter("carId");
        String manufacturer = request.getParameter("manufacturer");
        String model = request.getParameter("model");
        int year = Integer.parseInt(request.getParameter("year"));
        int seats = Integer.parseInt(request.getParameter("seats"));
        int bagCapacity = Integer.parseInt(request.getParameter("bagCapacity"));
        String transmissionType = request.getParameter("transmissionType");
        String carType = request.getParameter("carType");
        String features = request.getParameter("features");
        String availability = request.getParameter("availability");
        double price = Double.parseDouble(request.getParameter("price"));

        boolean success = carDAO.updateCar(carId, ownerId, manufacturer, model, year, seats,
                bagCapacity, transmissionType, carType, features, availability, price);

        if (success) {
            response.sendRedirect("Edit-Cars");
        } else {
            response.sendRedirect("Edit-Cars");
        }
    }
}