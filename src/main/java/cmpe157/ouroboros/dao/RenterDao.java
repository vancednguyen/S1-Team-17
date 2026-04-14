package cmpe157.ouroboros.dao;

import cmpe157.ouroboros.model.Renter;
import cmpe157.ouroboros.util.DBinfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RenterDao {

    public boolean registerRenter(Renter renter) {
        String insertUser = "INSERT INTO user (user_name, password, phone_number, email, driver_license, driver_license_exp) " +
                            "VALUES (?, ?, ?, ?, ?, ?)";
        String insertRenter = "INSERT INTO renter (user_id, balance) VALUES (?, NULL)";

        try (Connection conn = DBinfo.getConnection()) {
            conn.setAutoCommit(false);

            PreparedStatement psUser = conn.prepareStatement(insertUser, PreparedStatement.RETURN_GENERATED_KEYS);
            psUser.setString(1, renter.getUsername());
            psUser.setString(2, renter.getPassword());
            psUser.setString(3, renter.getPhoneNumber());
            psUser.setString(4, renter.getEmail());
            psUser.setString(5, renter.getDriversLicense());
            psUser.setString(6, renter.getLicenseExp());
            psUser.executeUpdate();

            ResultSet keys = psUser.getGeneratedKeys();
            if (!keys.next()) {
                conn.rollback();
                return false;
            }
            int userId = keys.getInt(1);

            PreparedStatement psRenter = conn.prepareStatement(insertRenter);
            psRenter.setInt(1, userId);
            psRenter.executeUpdate();

            conn.commit();
            return true;

        } catch (Exception e) {
            System.out.println("Error registering renter:");
            e.printStackTrace();
            return false;
        }
    }

    public boolean usernameExists(String username) {
        String sql = "SELECT user_name FROM user WHERE user_name = ?";
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
        String sql = "SELECT email FROM user WHERE email = ?";
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