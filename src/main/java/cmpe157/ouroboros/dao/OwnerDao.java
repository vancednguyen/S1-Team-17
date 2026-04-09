package cmpe157.ouroboros.dao;

import cmpe157.ouroboros.model.Owner;
import cmpe157.ouroboros.util.DBinfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OwnerDao {

    public boolean registerOwner(Owner owner) {
    	String insertUser = "INSERT INTO user (user_name, password, phone_number, email, driver_license, driver_license_exp) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
String insertOwner = "INSERT INTO owner (user_id, location) VALUES (?, ?)";

        try (Connection conn = DBinfo.getConnection()) {

            // Turn off auto-commit so both inserts succeed or both fail together
            conn.setAutoCommit(false);

            // Step 1 — insert into User table
            PreparedStatement psUser = conn.prepareStatement(insertUser, PreparedStatement.RETURN_GENERATED_KEYS);
            psUser.setString(1, owner.getUsername());
            psUser.setString(2, owner.getPassword());
            psUser.setString(3, owner.getPhoneNumber());
            psUser.setString(4, owner.getEmail());
            psUser.setString(5, owner.getDriversLicense());
            psUser.setString(6, owner.getLicenseExp()); // change this to String in Owner.java
            psUser.executeUpdate();

            // Step 2 — get the auto-generated user_id
            ResultSet keys = psUser.getGeneratedKeys();
            if (!keys.next()) {
                conn.rollback();
                return false;
            }
            int userId = keys.getInt(1);

            // Step 3 — insert into Owner table using that user_id
            PreparedStatement psOwner = conn.prepareStatement(insertOwner);
            psOwner.setInt(1, userId);
            psOwner.setString(2, owner.getLocation());
            psOwner.executeUpdate();

            // Step 4 — commit both inserts
            conn.commit();
            return true;

        } catch (Exception e) {
            System.out.println("Error registering owner:");
            e.printStackTrace();
            return false;
        }
    }

    public boolean usernameExists(String username) {
        String sql = "SELECT user_name FROM User WHERE user_name = ?";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean emailExists(String email) {
        String sql = "SELECT email FROM User WHERE email = ?";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}