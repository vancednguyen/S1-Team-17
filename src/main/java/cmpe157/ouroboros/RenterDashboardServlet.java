package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.ReservationDao;
import cmpe157.ouroboros.model.Reservation;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/RenterDashboardServlet")
public class RenterDashboardServlet extends HttpServlet {

    private final ReservationDao reservationDao = new ReservationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check — only renters can access this
        String role = (String) request.getSession().getAttribute("userRole");
        if (role == null || !role.equals("renter")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get the logged in renter's userId from session
        int userId = (Integer) request.getSession().getAttribute("userId");

        // Get all reservations for this renter
        List<Reservation> reservations = reservationDao.getReservationsByUserId(userId);

        HttpSession session = request.getSession();
        String reviewMessage = (String) session.getAttribute("reviewMessage");
        if (reviewMessage != null) {
            request.setAttribute("reviewMessage", reviewMessage);
            session.removeAttribute("reviewMessage");
        }
        String reviewErrorFlash = (String) session.getAttribute("reviewError");
        if (reviewErrorFlash != null) {
            request.setAttribute("reviewErrorFlash", reviewErrorFlash);
            session.removeAttribute("reviewError");
        }

        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/renterDashboard.jsp").forward(request, response);
    }
}