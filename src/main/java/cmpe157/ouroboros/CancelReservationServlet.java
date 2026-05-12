package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.ReservationDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CancelReservationServlet")
public class CancelReservationServlet extends HttpServlet {

    private final ReservationDao reservationDao = new ReservationDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check
        String role = (String) request.getSession().getAttribute("userRole");
        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (role == null || !role.equals("renter") || userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String reservationId = request.getParameter("reservationId");

        if (reservationId != null && !reservationId.isEmpty()) {
            reservationDao.cancelReservation(reservationId, userId);
        }

        // Redirect back to dashboard after cancelling
        response.sendRedirect("RenterDashboardServlet");
    }
}