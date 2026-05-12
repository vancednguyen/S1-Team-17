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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {

    private final ReservationDao reservationDao = new ReservationDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check — only renters can make reservations
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId");

        if (userRole == null || !"renter".equals(userRole) || userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Grab form fields
        String carId = request.getParameter("carId");
        String pickupTime = request.getParameter("pickupTime");
        String returnTime = request.getParameter("returnTime");

        // 2. Validate fields
        if (carId == null || pickupTime == null || returnTime == null ||
            carId.isEmpty() || pickupTime.isEmpty() || returnTime.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.setAttribute("carId", carId);
            request.getRequestDispatcher("/makeReservation.jsp").forward(request, response);
            return;
        }

        // 3. Convert datetime-local format to MySQL datetime format
        // datetime-local gives "2026-05-01T10:00" we need "2026-05-01 10:00:00"
        String pickupFormatted = pickupTime.replace("T", " ") + ":00";
        String returnFormatted = returnTime.replace("T", " ") + ":00";

        // 4. Make sure return time is after pickup time
        LocalDateTime pickup = LocalDateTime.parse(pickupTime, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
        LocalDateTime returnDt = LocalDateTime.parse(returnTime, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));

        if (!returnDt.isAfter(pickup)) {
            request.setAttribute("error", "Return time must be after pickup time.");
            request.setAttribute("carId", carId);
            request.getRequestDispatcher("/makeReservation.jsp").forward(request, response);
            return;
        }

        // 5. Check for overlapping bookings
        boolean available = reservationDao.isCarAvailable(carId, pickupFormatted, returnFormatted);
        if (!available) {
            request.setAttribute("error", "Sorry this car is already booked for the selected dates. Please choose different dates.");
            request.setAttribute("carId", carId);
            request.getRequestDispatcher("/makeReservation.jsp").forward(request, response);
            return;
        }

        // 6. Calculate total cost
        long days = ChronoUnit.DAYS.between(pickup, returnDt);
        if (days == 0) days = 1; // minimum 1 day charge
        double pricePerDay = reservationDao.getCarPrice(carId);
        double totalCost = days * pricePerDay;

        // 7. Build reservation object
        Reservation reservation = new Reservation();
        reservation.setUserId(userId);
        reservation.setCarId(carId);
        reservation.setPickupTime(pickupFormatted);
        reservation.setReturnTime(returnFormatted);
        reservation.setTotalCost(totalCost);
        reservation.setReservationStatus("Booked");

        // 8. Save to database
        boolean success = reservationDao.makeReservation(reservation);

        if (success) {
            // Pass total cost to confirmation page
            session.setAttribute("lastReservationCost", totalCost);
            session.setAttribute("lastReservationCar", carId);
            response.sendRedirect("reservationConfirmation.jsp");
        } else {
            request.setAttribute("error", "Reservation failed. Please try again.");
            request.setAttribute("carId", carId);
            request.getRequestDispatcher("/makeReservation.jsp").forward(request, response);
        }
    }
}