package cmpe157.ouroboros.dao;

import cmpe157.ouroboros.model.Review;
import cmpe157.ouroboros.util.DBinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

/**
 * Option A — minimal {@code review} row: {@code review_id}, {@code car_id}, {@code rating}, text column.
 * Does not persist renter or reservation, so the DB cannot enforce one-review-per-trip or FKs to those tables.
 */
public class ReviewDao {

    /**
     * Written body column name (seed / course schemas often use {@code review_text} instead of {@code comment}).
     */
    private static final String REVIEW_BODY_COLUMN = "review_text";

    /**
     * Returns {@code car_id} when the reservation is completed and belongs to this renter; otherwise null.
     * Does not consult {@code review} (no reservation column there), so duplicate reviews for the same trip are possible.
     */
    public String findCarIdIfReviewable(String reservationId, int userId) {
        String sql = "SELECT r.car_id FROM reservation r "
                + "WHERE r.reservation_id = ? AND r.user_id = ? AND r.reservation_status = 'Completed'";
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

    public List<Review> findByCarId(String carId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT review_id, car_id, rating, " + REVIEW_BODY_COLUMN + " AS comment "
                + "FROM review WHERE car_id = ? ORDER BY review_id DESC";
        try (Connection conn = DBinfo.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review rev = new Review();
                    rev.setReviewId(rs.getString("review_id"));
                    rev.setCarId(rs.getString("car_id"));
                    rev.setRating(rs.getInt("rating"));
                    rev.setComment(rs.getString("comment"));
                    rev.setReviewerName("Guest");
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

    public boolean insertReview(String carId, int rating, String comment) {
        String nextIdSql = "SELECT COALESCE(MAX(CAST(SUBSTRING(review_id, 4) AS UNSIGNED)), 0) + 1 AS next_id FROM review";
        String insertSql = "INSERT INTO review (review_id, car_id, rating, " + REVIEW_BODY_COLUMN + ") VALUES (?, ?, ?, ?)";
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
                    ps.setInt(3, rating);
                    ps.setString(4, comment);
                    if (ps.executeUpdate() > 0) {
                        return true;
                    }
                }
            } catch (SQLException e) {
                if (e.getErrorCode() == 1062 || e instanceof SQLIntegrityConstraintViolationException) {
                    System.err.println("[ReviewDao.insertReview] duplicate key, retrying (attempt " + (attempt + 1) + "): " + e.getMessage());
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
