package cmpe157.ouroboros.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

final class DeletionCascadeHelper {

    private DeletionCascadeHelper() {
    }

    private static String placeholders(int n) {
        return String.join(",", Collections.nCopies(n, "?"));
    }

    private static List<String> reservationIdsForCar(Connection conn, String carId) throws SQLException {
        List<String> ids = new ArrayList<>();
        String sql = "SELECT reservation_id FROM reservation WHERE car_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getString(1));
                }
            }
        }
        return ids;
    }

    private static List<String> reservationIdsForRenter(Connection conn, int renterUserId) throws SQLException {
        List<String> ids = new ArrayList<>();
        String sql = "SELECT reservation_id FROM reservation WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, renterUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getString(1));
                }
            }
        }
        return ids;
    }

    private static List<String> carIdsForOwner(Connection conn, int ownerUserId) throws SQLException {
        List<String> ids = new ArrayList<>();
        String sql = "SELECT car_id FROM car WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getString(1));
                }
            }
        }
        return ids;
    }

    private static void deleteByReservationIds(
            Connection conn, String sqlTemplate, List<String> resIds) throws SQLException {
        if (resIds.isEmpty()) {
            return;
        }
        String sql = String.format(sqlTemplate, placeholders(resIds.size()));
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int i = 1;
            for (String id : resIds) {
                ps.setString(i++, id);
            }
            ps.executeUpdate();
        }
    }

    /**
     * Deletes rows in {@code table} where a user-key column equals {@code userId}.
     * Tries common course-schema column names; ignores "unknown column" so one schema shape still works.
     */
    private static void deleteFromTableWhereUserKeyColumn(
            Connection conn, String table, int userId, String... columnCandidates) throws SQLException {
        for (String col : columnCandidates) {
            String sql = "DELETE FROM " + table + " WHERE " + col + " = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
                return;
            } catch (SQLException e) {
                if (isUnknownColumnSQLException(e)) {
                    continue;
                }
                throw e;
            }
        }
    }

    private static boolean isUnknownColumnSQLException(SQLException e) {
        return "42S22".equals(e.getSQLState())
                || e.getErrorCode() == 1054
                || (e.getMessage() != null && e.getMessage().contains("Unknown column"));
    }

    /**
     * Removes rows that reference {@code carId} or its reservations. Does not delete the {@code car} row.
     */
    static void deleteDependentsForCar(Connection conn, String carId) throws SQLException {
        List<String> resIds = reservationIdsForCar(conn, carId);

        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM review WHERE car_id = ?")) {
            ps.setString(1, carId);
            ps.executeUpdate();
        }

        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM manages WHERE car_id = ?")) {
            ps.setString(1, carId);
            ps.executeUpdate();
        }
        deleteByReservationIds(conn, "DELETE FROM manages WHERE reservation_id IN (%s)", resIds);

        deleteByReservationIds(conn, "DELETE FROM books WHERE reservation_id IN (%s)", resIds);

        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM `has` WHERE car_id = ?")) {
            ps.setString(1, carId);
            ps.executeUpdate();
        }
        deleteByReservationIds(conn, "DELETE FROM `has` WHERE reservation_id IN (%s)", resIds);

        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM reservation WHERE car_id = ?")) {
            ps.setString(1, carId);
            ps.executeUpdate();
        }

        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM register WHERE car_id = ?")) {
            ps.setString(1, carId);
            ps.executeUpdate();
        }
    }

    /**
     * Removes reservations and related rows for a renter. Does not delete {@code renter} or {@code user}.
     */
    static void deleteDependentsForRenter(Connection conn, int renterUserId) throws SQLException {
        List<String> resIds = reservationIdsForRenter(conn, renterUserId);

        deleteByReservationIds(conn, "DELETE FROM manages WHERE reservation_id IN (%s)", resIds);
        deleteByReservationIds(conn, "DELETE FROM books WHERE reservation_id IN (%s)", resIds);
        deleteByReservationIds(conn, "DELETE FROM `has` WHERE reservation_id IN (%s)", resIds);

        // Rows keyed by renter id (column name varies by schema; seed uses first col as renter id, not always user_id)
        deleteFromTableWhereUserKeyColumn(conn, "books", renterUserId, "user_id", "renter_id", "renter_user_id");
        deleteFromTableWhereUserKeyColumn(conn, "manages", renterUserId, "user_id", "renter_id", "target_user_id", "managed_user_id");

        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM reservation WHERE user_id = ?")) {
            ps.setInt(1, renterUserId);
            ps.executeUpdate();
        }
    }

    /**
     * Removes all listings and reservation graph for an owner. Deletes every {@code car} row for {@code ownerUserId}.
     */
    static void deleteDependentsForOwner(Connection conn, int ownerUserId) throws SQLException {
        List<String> carIds = carIdsForOwner(conn, ownerUserId);
        for (String carId : carIds) {
            deleteDependentsForCar(conn, carId);
        }
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM car WHERE user_id = ?")) {
            ps.setInt(1, ownerUserId);
            ps.executeUpdate();
        }
        deleteFromTableWhereUserKeyColumn(conn, "manages", ownerUserId, "user_id", "owner_id", "renter_id", "target_user_id", "managed_user_id");
    }
}
