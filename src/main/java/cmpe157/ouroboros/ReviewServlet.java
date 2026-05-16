package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.ReviewDao;
import cmpe157.ouroboros.dao.carDao;
import cmpe157.ouroboros.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {

    private static final int COMMENT_MAX = 2000;

    private final ReviewDao reviewDao = new ReviewDao();
    private final carDao carDao = new carDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId");
        if (userRole == null || !"renter".equals(userRole) || userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String flashErr = (String) session.getAttribute("reviewError");
        if (flashErr != null) {
            request.setAttribute("error", flashErr);
            session.removeAttribute("reviewError");
        }

        String reservationId = request.getParameter("reservationId");
        if (reservationId == null || reservationId.isEmpty()) {
            response.sendRedirect("RenterDashboardServlet");
            return;
        }

        String carId = reviewDao.findCarIdIfReviewable(reservationId, userId);
        if (carId == null) {
            session.setAttribute("reviewError", "You cannot leave a review for this reservation.");
            response.sendRedirect("RenterDashboardServlet");
            return;
        }

        Car car = carDao.getCarByIdPublic(carId);
        if (car == null) {
            session.setAttribute("reviewError", "Vehicle not found.");
            response.sendRedirect("RenterDashboardServlet");
            return;
        }

        request.setAttribute("reservationId", reservationId);
        request.setAttribute("car", car);
        request.getRequestDispatcher("/leaveReview.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId");
        if (userRole == null || !"renter".equals(userRole) || userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String reservationId = request.getParameter("reservationId");
        String ratingRaw = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (reservationId == null || reservationId.isEmpty()) {
            session.setAttribute("reviewError", "Missing reservation.");
            response.sendRedirect("RenterDashboardServlet");
            return;
        }

        String carId = reviewDao.findCarIdIfReviewable(reservationId, userId);
        if (carId == null) {
            session.setAttribute("reviewError", "You cannot leave a review for this reservation.");
            response.sendRedirect("RenterDashboardServlet");
            return;
        }

        int rating;
        try {
            rating = Integer.parseInt(ratingRaw);
        } catch (Exception e) {
            session.setAttribute("reviewError", "Please choose a star rating.");
            response.sendRedirect(reviewFormUrl(reservationId));
            return;
        }
        if (rating < 1 || rating > 5) {
            session.setAttribute("reviewError", "Rating must be between 1 and 5.");
            response.sendRedirect(reviewFormUrl(reservationId));
            return;
        }

        if (comment == null) {
            comment = "";
        }
        comment = comment.trim();
        if (comment.isEmpty()) {
            session.setAttribute("reviewError", "Please write a short comment.");
            response.sendRedirect(reviewFormUrl(reservationId));
            return;
        }
        if (comment.length() > COMMENT_MAX) {
            session.setAttribute("reviewError", "Comment is too long (max " + COMMENT_MAX + " characters).");
            response.sendRedirect(reviewFormUrl(reservationId));
            return;
        }

        boolean ok = reviewDao.insertReview(carId, rating, comment);
        if (ok) {
            session.setAttribute("reviewMessage", "Thanks for your review!");
            session.removeAttribute("reviewError");
        } else {
            session.setAttribute("reviewError",
                    "Could not save your review. Ensure the review table uses Option A columns "
                            + "(review_id, car_id, rating, review_text). See sql/migrations/002_review_option_a_revert.sql if you need to drop Option B columns.");
        }
        response.sendRedirect("RenterDashboardServlet");
    }

    private static String reviewFormUrl(String reservationId) {
        return "ReviewServlet?reservationId=" + URLEncoder.encode(reservationId, StandardCharsets.UTF_8);
    }
}
