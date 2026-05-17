package com.group139.beautysalon.service;

import com.group139.beautysalon.model.Review;
import com.group139.beautysalon.model.VerifiedReview;
import com.group139.beautysalon.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReviewService {

    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public List<Review> getAllReviews() {
        return reviewRepository.findAll();
    }

    public List<Review> getApprovedReviews() {
        return getAllReviews().stream()
                .filter(r -> "Approved".equalsIgnoreCase(r.getReviewStatus()))
                .collect(Collectors.toList());
    }

    public List<Review> getReviewsByServiceId(String serviceId) {
        return getApprovedReviews().stream()
                .filter(r -> r.getServiceId().equalsIgnoreCase(serviceId))
                .collect(Collectors.toList());
    }

    public List<Review> filterReviewsByRating(int rating) {
        return getApprovedReviews().stream()
                .filter(r -> r.getStarRating() == rating)
                .collect(Collectors.toList());
    }

    public boolean addReview(Review review) {
        List<Review> reviews = reviewRepository.findAll();

        // Validation: Prevent duplicate reviews for same customer and service
        boolean exists = reviews.stream()
                .anyMatch(r -> r.getCustomerId().equals(review.getCustomerId())
                        && r.getServiceId().equals(review.getServiceId()));

        if (exists) {
            return false; // Review already exists
        }

        // Generate new ID
        int newIdNum = reviews.size() + 1;
        review.setReviewId("R" + String.format("%03d", newIdNum));
        review.setDate(LocalDate.now().toString());
        review.setReviewStatus("Pending"); // Default status for moderation

        reviews.add(review);
        reviewRepository.saveAll(reviews);
        return true;
    }

    public Review getReviewById(String reviewId) {
        return reviewRepository.findAll().stream()
                .filter(r -> r.getReviewId().equals(reviewId))
                .findFirst()
                .orElse(null);
    }

    public void updateReview(Review updatedReview) {
        List<Review> reviews = reviewRepository.findAll();
        for (int i = 0; i < reviews.size(); i++) {
            if (reviews.get(i).getReviewId().equals(updatedReview.getReviewId())) {
                Review existingReview = reviews.get(i);
                existingReview.setStarRating(updatedReview.getStarRating());
                existingReview.setReviewComment(updatedReview.getReviewComment());
                // Keep existing date and status unless admin modifies it
                reviews.set(i, existingReview);
                break;
            }
        }
        reviewRepository.saveAll(reviews);
    }

    public void deleteReview(String reviewId) {
        List<Review> reviews = reviewRepository.findAll();
        reviews.removeIf(r -> r.getReviewId().equals(reviewId));
        reviewRepository.saveAll(reviews);
    }

    public void updateReviewStatus(String reviewId, String status) {
        List<Review> reviews = reviewRepository.findAll();
        for (Review review : reviews) {
            if (review.getReviewId().equals(reviewId)) {
                review.setReviewStatus(status);
                break;
            }
        }
        reviewRepository.saveAll(reviews);
    }
    
    public double getAverageRating() {
        List<Review> approved = getApprovedReviews();
        if (approved.isEmpty()) return 0.0;
        double sum = approved.stream().mapToInt(Review::getStarRating).sum();
        return Math.round((sum / approved.size()) * 10.0) / 10.0;
    }
}
