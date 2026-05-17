package com.group139.beautysalon.model;

/**
 * Base Review class demonstrating encapsulation and inheritance.
 */
public class Review {
    private String reviewId;
    private String customerId;
    private String serviceId;
    private String customerName;
    private int starRating;
    private String reviewComment;
    private String date;
    private String reviewStatus; // e.g., Pending, Approved, Removed

    public Review() {}

    public Review(String reviewId, String customerId, String serviceId, String customerName, int starRating, String reviewComment, String date, String reviewStatus) {
        this.reviewId = reviewId;
        this.customerId = customerId;
        this.serviceId = serviceId;
        this.customerName = customerName;
        this.starRating = starRating;
        this.reviewComment = reviewComment;
        this.date = date;
        this.reviewStatus = reviewStatus;
    }

    // Getters and Setters
    public String getReviewId() { return reviewId; }
    public void setReviewId(String reviewId) { this.reviewId = reviewId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getServiceId() { return serviceId; }
    public void setServiceId(String serviceId) { this.serviceId = serviceId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public int getStarRating() { return starRating; }
    public void setStarRating(int starRating) { this.starRating = starRating; }

    public String getReviewComment() { return reviewComment; }
    public void setReviewComment(String reviewComment) { this.reviewComment = reviewComment; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getReviewStatus() { return reviewStatus; }
    public void setReviewStatus(String reviewStatus) { this.reviewStatus = reviewStatus; }

    /**
     * Demonstrates polymorphism. Will be overridden by subclasses.
     */
    public String getReviewType() {
        return "Standard Review";
    }
}
