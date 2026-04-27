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
    public List<Car> getCarsByOwnerId(int ownerId) {
        List<Car> cars = new ArrayList<>();

        String sql = "SELECT car_id, model, year, manufacturer, car_type, transmission_type, " +
                "features, seats, bag_capacity, price, availability " +
                "FROM car WHERE user_id = ? ORDER BY price ASC";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ownerId);

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
    public boolean addCar(int ownerId, String manufacturer, String model, int year, int seats,
                          int bagCapacity, String transmissionType, String carType,
                          String features, String availability, double price) {

        String nextCarIdSql =
                "SELECT COALESCE(MAX(CAST(SUBSTRING(car_id, 2) AS UNSIGNED)), 0) + 1 AS next_id FROM car";

        String insertCarSql =
                "INSERT INTO car (car_id, user_id, manufacturer, transmission_type, car_type, price, seats, features, year, model, bag_capacity, availability) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBinfo.getConnection()) {
            String carId = null;

            // Generate new car_id
            try (PreparedStatement ps = conn.prepareStatement(nextCarIdSql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    carId = "C" + rs.getInt("next_id");
                }
            }

            // Insert car
            try (PreparedStatement insertCarStmt = conn.prepareStatement(insertCarSql)) {
                insertCarStmt.setString(1, carId);
                insertCarStmt.setInt(2, ownerId);
                insertCarStmt.setString(3, manufacturer);
                insertCarStmt.setString(4, transmissionType);
                insertCarStmt.setString(5, carType);
                insertCarStmt.setDouble(6, price);
                insertCarStmt.setInt(7, seats);
                insertCarStmt.setString(8, features);
                insertCarStmt.setInt(9, year);
                insertCarStmt.setString(10, model);
                insertCarStmt.setInt(11, bagCapacity);
                insertCarStmt.setString(12, availability);

                int rows = insertCarStmt.executeUpdate();

                System.out.println("Inserted rows: " + rows);
                return rows > 0; // ✅ success if insert worked
            }

        } catch (Exception e) {
            System.out.println("Add car failed:");
            e.printStackTrace();
            return false; //  failure
        }
    }
    public Car getCarById(String carId, int ownerId) {
        String sql = "SELECT car_id, model, year, manufacturer, car_type, transmission_type, " +
                "features, seats, bag_capacity, price, availability " +
                "FROM car WHERE car_id = ? AND user_id = ?";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, carId);
            ps.setInt(2, ownerId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToCar(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public boolean updateCar(String carId, int ownerId, String manufacturer, String model, int year,
                             int seats, int bagCapacity, String transmissionType, String carType,
                             String features, String availability, double price) {

        String sql = "UPDATE car SET manufacturer = ?, model = ?, year = ?, seats = ?, bag_capacity = ?, " +
                "transmission_type = ?, car_type = ?, features = ?, availability = ?, price = ? " +
                "WHERE car_id = ? AND user_id = ?";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, manufacturer);
            ps.setString(2, model);
            ps.setInt(3, year);
            ps.setInt(4, seats);
            ps.setInt(5, bagCapacity);
            ps.setString(6, transmissionType);
            ps.setString(7, carType);
            ps.setString(8, features);
            ps.setString(9, availability);
            ps.setDouble(10, price);
            ps.setString(11, carId);
            ps.setInt(12, ownerId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteCar(String carId, int ownerId) {
        String sql = "DELETE FROM car WHERE car_id = ? AND user_id = ?";

        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, carId);
            ps.setInt(2, ownerId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
