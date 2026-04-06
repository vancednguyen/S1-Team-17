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

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    private final carDao carDAO = new carDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Car> cars = carDAO.getAllAvailableCars();
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}