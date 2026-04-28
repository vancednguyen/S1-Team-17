package cmpe157.ouroboros.dao;

import cmpe157.ouroboros.model.Car;
import cmpe157.ouroboros.model.User;
import cmpe157.ouroboros.util.DBinfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {

    // Get all users with their role (owner or renter)
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.user_id, u.user_name, u.email, u.phone_number, " +
                     "u.driver_license, u.driver_license_exp, " +
                     "CASE WHEN o.user_id IS NOT NULL THEN 'owner' ELSE 'renter' END AS role " +
                     "FROM user u " +
                     "LEFT JOIN owner o ON u.user_id = o.user_id";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("user_name"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setDriversLicense(rs.getString("driver_license"));
                user.setLicenseExp(rs.getString("driver_license_exp"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }

        } catch (Exception e) {
            System.out.println("Error getting all users:");
            e.printStackTrace();
        }
        return users;
    }

    // Get all cars
    public List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        String sql = "SELECT * FROM car";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getString("car_id"));
                car.setManufacturer(rs.getString("manufacturer"));
                car.setModel(rs.getString("model"));
                car.setYear(rs.getInt("year"));
                car.setPrice(rs.getDouble("price"));
                car.setSeats(rs.getInt("seats"));
                car.setAvailability(rs.getString("availability"));
                car.setCarType(rs.getString("car_type"));
                car.setTransmissionType(rs.getString("transmission_type"));
                car.setFeatures(rs.getString("features"));
                car.setBagCapacity(rs.getInt("bag_capacity"));
                cars.add(car);
            }

        } catch (Exception e) {
            System.out.println("Error getting all cars:");
            e.printStackTrace();
        }
        return cars;
    }

    // Delete a user by user_id
    public boolean deleteUser(int userId) {
        String deleteOwner = "DELETE FROM owner WHERE user_id = ?";
        String deleteRenter = "DELETE FROM renter WHERE user_id = ?";
        String deleteUser = "DELETE FROM user WHERE user_id = ?";

        try (Connection conn = DBinfo.getConnection()) {
            conn.setAutoCommit(false);

            // Delete from owner or renter first due to foreign key
            PreparedStatement ps1 = conn.prepareStatement(deleteOwner);
            ps1.setInt(1, userId);
            ps1.executeUpdate();

            PreparedStatement ps2 = conn.prepareStatement(deleteRenter);
            ps2.setInt(1, userId);
            ps2.executeUpdate();

            // Then delete from user table
            PreparedStatement ps3 = conn.prepareStatement(deleteUser);
            ps3.setInt(1, userId);
            ps3.executeUpdate();

            conn.commit();
            return true;

        } catch (Exception e) {
            System.out.println("Error deleting user:");
            e.printStackTrace();
            return false;
        }
    }

    // Delete a car by car_id
    public boolean deleteCar(String carId) {
        String sql = "DELETE FROM car WHERE car_id = ?";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, carId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error deleting car:");
            e.printStackTrace();
            return false;
        }
    }
}