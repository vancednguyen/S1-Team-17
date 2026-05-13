package cmpe157.ouroboros.dao;

import cmpe157.ouroboros.model.Review;
import cmpe157.ouroboros.util.DBinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ReviewDao {

    /**
     * DB column for the written review. Many course schemas use {@code review_text} instead of {@code comment}
     * because {@code comment} is awkward in MySQL. If {@code DESCRIBE review} shows a different name, change this constant.
     */
    private static final String REVIEW_BODY_COLUMN = "review_text";

    /**
     * If the reservation is completed, belongs to the user, and has no review yet, returns car_id; otherwise null.
     */
    public String findCarIdIfReviewable(String reservationId, int userId) {
        String sql = "SELECT r.car_id FROM reservation r "
                + "WHERE r.reservation_id = ? AND r.user_id = ? AND r.reservation_status = 'Completed' "
                + "AND NOT EXISTS (SELECT 1 FROM review rev WHERE rev.reservation_id = r.reservation_id)";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reservationId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("car_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Set<String> findReviewedReservationIdsForUser(int userId) {
        Set<String> ids = new HashSet<>();
        String sql = "SELECT reservation_id FROM review WHERE user_id = ? AND reservation_id IS NOT NULL";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getString("reservation_id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
    }

    public List<Review> findByCarIdWithReviewer(String carId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.review_id, r.car_id, r.user_id, r.reservation_id, r.rating, r." + REVIEW_BODY_COLUMN + " AS comment, "
                + "u.user_name AS reviewer_name "
                + "FROM review r "
                + "LEFT JOIN user u ON r.user_id = u.user_id "
                + "WHERE r.car_id = ? "
                + "ORDER BY r.review_id DESC";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review rev = new Review();
                    rev.setReviewId(rs.getString("review_id"));
                    rev.setCarId(rs.getString("car_id"));
                    int uid = rs.getInt("user_id");
                    if (rs.wasNull()) {
                        rev.setUserId(null);
                    } else {
                        rev.setUserId(uid);
                    }
                    rev.setReservationId(rs.getString("reservation_id"));
                    rev.setRating(rs.getInt("rating"));
                    rev.setComment(rs.getString("comment"));
                    rev.setReviewerName(rs.getString("reviewer_name"));
                    list.add(rev);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public double getAverageRating(String carId) {
        String sql = "SELECT AVG(rating) AS avg_rating FROM review WHERE car_id = ?";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double v = rs.getDouble("avg_rating");
                    return rs.wasNull() ? 0.0 : v;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public boolean insertReview(String carId, int userId, String reservationId, int rating, String comment) {
        String nextIdSql = "SELECT COALESCE(MAX(CAST(SUBSTRING(review_id, 4) AS UNSIGNED)), 0) + 1 AS next_id FROM review";
        String insertSql = "INSERT INTO review (review_id, car_id, user_id, reservation_id, rating, " + REVIEW_BODY_COLUMN + ") "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        for (int attempt = 0; attempt < 12; attempt++) {
            try (Connection conn = DBinfo.getConnection()) {
                String reviewId;
                try (PreparedStatement ps = conn.prepareStatement(nextIdSql);
                     ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        return false;
                    }
                    reviewId = "REV" + rs.getInt("next_id");
                }
                try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                    ps.setString(1, reviewId);
                    ps.setString(2, carId);
                    ps.setInt(3, userId);
                    ps.setString(4, reservationId);
                    ps.setInt(5, rating);
                    ps.setString(6, comment);
                    if (ps.executeUpdate() > 0) {
                        return true;
                    }
                }
            } catch (SQLException e) {
                // MySQL 1062: duplicate key — retry only if it looks like a review_id (PK) race, not same reservation twice.
                if (e.getErrorCode() == 1062 || e instanceof SQLIntegrityConstraintViolationException) {
                    String msg = e.getMessage() != null ? e.getMessage() : "";
                    if (msg.contains("uk_review_reservation")) {
                        System.err.println("[ReviewDao.insertReview] duplicate reservation review: " + msg);
                        return false;
                    }
                    System.err.println("[ReviewDao.insertReview] duplicate key, retrying (attempt " + (attempt + 1) + "): " + msg);
                    if (attempt == 11) {
                        e.printStackTrace();
                        return false;
                    }
                    continue;
                }
                System.err.println("[ReviewDao.insertReview] SQLState=" + e.getSQLState() + " errorCode=" + e.getErrorCode() + " msg=" + e.getMessage());
                e.printStackTrace();
                return false;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
        return false;
    }
}
