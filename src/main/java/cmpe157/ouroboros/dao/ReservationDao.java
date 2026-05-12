package cmpe157.ouroboros.dao;

import cmpe157.ouroboros.model.Reservation;
import cmpe157.ouroboros.util.DBinfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import cmpe157.ouroboros.model.Car;

public class ReservationDao {

    // Check if car is available for the requested time window
    public boolean isCarAvailable(String carId, String pickupTime, String returnTime) {
        String sql = "SELECT reservation_id FROM reservation " +
                     "WHERE car_id = ? " +
                     "AND reservation_status != 'Cancelled' " +
                     "AND NOT (return_time_date <= ? OR pickup_time_date >= ?)";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, carId);
            ps.setString(2, pickupTime);
            ps.setString(3, returnTime);

            ResultSet rs = ps.executeQuery();
            return !rs.next(); // if no results, car is available

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Create a new reservation
    public boolean makeReservation(Reservation reservation) {
        // Generate next reservation ID
        String nextIdSql = "SELECT COALESCE(MAX(CAST(SUBSTRING(reservation_id, 4) AS UNSIGNED)), 0) + 1 AS next_id FROM reservation";
        String insertSql = "INSERT INTO reservation (reservation_id, user_id, car_id, pickup_time_date, return_time_date, total_cost, reservation_status) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBinfo.getConnection()) {
            conn.setAutoCommit(false);

            // Step 1 — generate reservation ID like RES11, RES12 etc
            String reservationId = null;
            try (PreparedStatement ps = conn.prepareStatement(nextIdSql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reservationId = "RES" + rs.getInt("next_id");
                }
            }

            // Step 2 — insert reservation
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setString(1, reservationId);
                ps.setInt(2, reservation.getUserId());
                ps.setString(3, reservation.getCarId());
                ps.setString(4, reservation.getPickupTime());
                ps.setString(5, reservation.getReturnTime());
                ps.setDouble(6, reservation.getTotalCost());
                ps.setString(7, "Booked");
                ps.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            System.out.println("Error making reservation:");
            e.printStackTrace();
            return false;
        }
    }

    // Get all reservations for a renter
    public List<Reservation> getReservationsByUserId(int userId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM reservation WHERE user_id = ? ORDER BY pickup_time_date DESC";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationId(rs.getString("reservation_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setCarId(rs.getString("car_id"));
                r.setPickupTime(rs.getString("pickup_time_date"));
                r.setReturnTime(rs.getString("return_time_date"));
                r.setTotalCost(rs.getDouble("total_cost"));
                r.setReservationStatus(rs.getString("reservation_status"));
                reservations.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reservations;
    }

    // Cancel a reservation
    public boolean cancelReservation(String reservationId, int userId) {
        String sql = "UPDATE reservation SET reservation_status = 'Cancelled' " +
                     "WHERE reservation_id = ? AND user_id = ?";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reservationId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get price of a car by car ID
    public double getCarPrice(String carId) {
        String sql = "SELECT price FROM car WHERE car_id = ?";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, carId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("price");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }
    
    public Car getCarById(String carId) {
        String sql = "SELECT car_id, model, year, manufacturer, car_type, transmission_type, " +
                     "features, seats, bag_capacity, price, availability " +
                     "FROM car WHERE car_id = ?";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, carId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getString("car_id"));
                car.setManufacturer(rs.getString("manufacturer"));
                car.setModel(rs.getString("model"));
                car.setYear(rs.getInt("year"));
                car.setPrice(rs.getDouble("price"));
                return car;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}