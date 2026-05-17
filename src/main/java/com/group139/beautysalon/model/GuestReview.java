package com.group139.beautysalon.model;

/**
 * Inherits from Review class. Used for guest customers.
 */
public class GuestReview extends Review {

    public GuestReview() {
        super();
    }

    public GuestReview(String reviewId, String customerId, String serviceId, String customerName, int starRating, String reviewComment, String date, String reviewStatus) {
        super(reviewId, customerId, serviceId, customerName, starRating, reviewComment, date, reviewStatus);
    }

    @Override
    public String getReviewType() {
        return "Guest";
    }
}
