package cmpe157.ouroboros.model;

/**
 * Matches minimal {@code review} table: review_id, car_id, rating, text column (see {@link cmpe157.ouroboros.dao.ReviewDao}).
 */
public class Review {
    private String reviewId;
    private String carId;
    private int rating;
    private String comment;
    /** Display label only (not stored in DB for Option A). */
    private String reviewerName;

    public Review() {}

    public String getReviewId() {
        return reviewId;
    }

    public void setReviewId(String reviewId) {
        this.reviewId = reviewId;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getReviewerName() {
        return reviewerName;
    }

    public void setReviewerName(String reviewerName) {
        this.reviewerName = reviewerName;
    }
}
