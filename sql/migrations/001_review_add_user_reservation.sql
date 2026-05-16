-- Option B (superseded): tie reviews to renters and completed trips (one review per reservation).
-- Prefer Option A in code: minimal review(review_id, car_id, rating, review_text) with no user/reservation columns.
-- If you already applied this migration, use sql/migrations/002_review_option_a_revert.sql to drop those columns.
-- Run once against `ouroboro_ev` after base schema exists. Safe if columns already exist: remove failing clauses manually.

USE ouroboro_ev;

ALTER TABLE review
  ADD COLUMN user_id INT NULL,
  ADD COLUMN reservation_id VARCHAR(32) NULL;

ALTER TABLE review
  ADD UNIQUE KEY uk_review_reservation (reservation_id);
