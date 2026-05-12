package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.ReservationDao;
import cmpe157.ouroboros.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Owner-Reservations")
public class OwnerReservationsServlet extends HttpServlet {

    private final ReservationDao reservationDao = new ReservationDao();

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

        List<Reservation> reservations = reservationDao.getReservationsByOwnerId(ownerId);
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/ownerReservations.jsp").forward(request, response);
    }
}
