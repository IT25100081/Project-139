package com.group139.beautysalon.model;

/**
 * Inherits from Review class. Used for registered customers.
 */
public class VerifiedReview extends Review {

    public VerifiedReview() {
        super();
    }

    public VerifiedReview(String reviewId, String customerId, String serviceId, String customerName, int starRating, String reviewComment, String date, String reviewStatus) {
        super(reviewId, customerId, serviceId, customerName, starRating, reviewComment, date, reviewStatus);
    }

    @Override
    public String getReviewType() {
        return "Verified Customer";
    }
}
