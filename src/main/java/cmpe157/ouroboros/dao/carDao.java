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

    public List<Car> searchCars(String keyword, String year, String minPrice, String maxPrice, String seats) {
        List<Car> cars = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT car_id, model, year, manufacturer, car_type, transmission_type, " +
                        "features, seats, bag_capacity, price, availability " +
                        "FROM car WHERE availability = 'Available' "
        );

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (LOWER(manufacturer) LIKE ? " +
                    "OR LOWER(model) LIKE ? " +
                    "OR LOWER(features) LIKE ? " +
                    "OR LOWER(car_type) LIKE ? " +
                    "OR LOWER(transmission_type) LIKE ?) ");
            String k = "%" + keyword.trim().toLowerCase() + "%";
            params.add(k);
            params.add(k);
            params.add(k);
            params.add(k);
            params.add(k);
        }

        if (year != null && !year.trim().isEmpty()) {
            sql.append("AND year = ? ");
            params.add(Integer.parseInt(year.trim()));
        }

        if (minPrice != null && !minPrice.trim().isEmpty()) {
            sql.append("AND price >= ? ");
            params.add(Double.parseDouble(minPrice.trim()));
        }

        if (maxPrice != null && !maxPrice.trim().isEmpty()) {
            sql.append("AND price <= ? ");
            params.add(Double.parseDouble(maxPrice.trim()));
        }

        if (seats != null && !seats.trim().isEmpty()) {
            sql.append("AND seats = ? ");
            params.add(Integer.parseInt(seats.trim()));
        }

        sql.append("ORDER BY price ASC");

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cars.add(mapRowToCar(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cars;
    }

    private Car mapRowToCar(ResultSet rs) throws Exception {
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
        return car;
    }
}
