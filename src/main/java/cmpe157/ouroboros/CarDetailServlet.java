package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.ReviewDao;
import cmpe157.ouroboros.dao.carDao;
import cmpe157.ouroboros.model.Car;
import cmpe157.ouroboros.model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/CarDetailServlet")
public class CarDetailServlet extends HttpServlet {

    private final carDao carDao = new carDao();
    private final ReviewDao reviewDao = new ReviewDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String carId = request.getParameter("carId");
        if (carId == null || carId.isEmpty()) {
            response.sendRedirect("Browse-Cars");
            return;
        }

        Car car = carDao.getCarByIdPublic(carId);
        if (car == null) {
            response.sendRedirect("Browse-Cars");
            return;
        }

        List<Review> reviews = reviewDao.findByCarId(carId);
        double avgRating = reviewDao.getAverageRating(carId);

        request.setAttribute("car", car);
        request.setAttribute("reviews", reviews);
        request.setAttribute("avgRating", avgRating);
        request.getRequestDispatcher("/carDetail.jsp").forward(request, response);
    }
}
