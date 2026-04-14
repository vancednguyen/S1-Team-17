package cmpe157.ouroboros;
import cmpe157.ouroboros.model.Car;
import cmpe157.ouroboros.dao.carDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/Browse-Cars")
public class BrowseCarServlet extends HttpServlet {
    private final carDao carDAO = new carDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String year = request.getParameter("year");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String seats = request.getParameter("seats");

       // List<Car> cars = carDAO.getAllAvailableCars();

        List<Car> cars;
        boolean hasFilters =
                (keyword != null && !keyword.trim().isEmpty()) ||
                        (year != null && !year.trim().isEmpty()) ||
                        (minPrice != null && !minPrice.trim().isEmpty()) ||
                        (maxPrice != null && !maxPrice.trim().isEmpty()) ||
                        (seats != null && !seats.trim().isEmpty());

        if (hasFilters) {
            cars = carDAO.searchCars(keyword, year, minPrice, maxPrice, seats);
        } else {
            cars = carDAO.getAllAvailableCars();
        }
        //System.out.println("Servlet got cars: " + cars.size());
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/browseCars.jsp").forward(request, response);
    }
}