-- Option B: tie reviews to renters and completed trips (one review per reservation).
-- Run once against `ouroboro_ev` after base schema exists. Safe if columns already exist: remove failing clauses manually.

USE ouroboro_ev;

ALTER TABLE review
  ADD COLUMN user_id INT NULL,
  ADD COLUMN reservation_id VARCHAR(32) NULL;

ALTER TABLE review
  ADD UNIQUE KEY uk_review_reservation (reservation_id);
