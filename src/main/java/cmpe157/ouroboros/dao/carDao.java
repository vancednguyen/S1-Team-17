package cmpe157.ouroboros.dao;
import cmpe157.ouroboros.model.Car;
import cmpe157.ouroboros.util.DBinfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class carDao {
    public List<Car> getAllAvailableCars() {
        List<Car> cars = new ArrayList<>();

        String sql = "SELECT car_id, model, year, manufacturer, car_type, transmission_type, " +
                "features, seats, bag_capacity, price, availability " +
                "FROM Car WHERE availability = 'Available' ORDER BY price ASC";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("Connected to DB successfully.");

            while (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getString("car_id"));
                car.setModel(rs.getString("model"));
                car.setYear(rs.getInt("year"));
                car.setManufacturer(rs.getString("manufacturer"));
                car.setCarType(rs.getString("car_type"));
                car.setTransmissionType(rs.getString("transmission_type"));
                car.setFeatures(rs.getString("features"));
                car.setSeats(rs.getInt("seats"));
                car.setBagCapacity(rs.getInt("bag_capacity"));
                car.setPrice(rs.getDouble("price"));
                car.setAvailability(rs.getString("availability"));
                cars.add(car);
            }

            System.out.println("Cars found: " + cars.size());

        } catch (Exception e) {
            System.out.println("Database error:");
            e.printStackTrace();
        }

        return cars;
    }
}
