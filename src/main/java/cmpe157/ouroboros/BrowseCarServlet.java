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

        List<Car> cars;
        boolean hasFilters = keyword != null && !keyword.trim().isEmpty();

        if (hasFilters) {
            cars = carDAO.searchCars(keyword);
        } else {
            cars = carDAO.getAllAvailableCars();
        }
        //System.out.println("Servlet got cars: " + cars.size());
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/browseCars.jsp").forward(request, response);
    }
}