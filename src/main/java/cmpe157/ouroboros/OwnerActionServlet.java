package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.ReservationDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/OwnerActionServlet")
public class OwnerActionServlet extends HttpServlet {

    private final ReservationDao reservationDao = new ReservationDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check — owners only
        HttpSession session = request.getSession(false);
        String role = (String) (session != null ? session.getAttribute("userRole") : null);
        Integer ownerId = (Integer) (session != null ? session.getAttribute("userId") : null);

        if (role == null || !"owner".equals(role) || ownerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String reservationId = request.getParameter("reservationId");
        String action = request.getParameter("action"); // "Cancel" or "Complete"

        if (reservationId != null && !reservationId.isEmpty() && action != null) {
            String newStatus = "Cancel".equals(action) ? "Cancelled" : "Completed";
            reservationDao.updateReservationStatusByOwner(reservationId, ownerId, newStatus);
        }

        response.sendRedirect("Owner-Reservations");
    }
}
