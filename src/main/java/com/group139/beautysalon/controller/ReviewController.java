package com.group139.beautysalon.controller;

import com.group139.beautysalon.model.Review;
import com.group139.beautysalon.service.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    // Customer: View all approved reviews
    @GetMapping
    public String viewReviews(Model model, @RequestParam(required = false) Integer rating, @RequestParam(required = false) String serviceId) {
        if (rating != null) {
            model.addAttribute("reviews", reviewService.filterReviewsByRating(rating));
        } else if (serviceId != null && !serviceId.isEmpty()) {
            model.addAttribute("reviews", reviewService.getReviewsByServiceId(serviceId));
        } else {
            model.addAttribute("reviews", reviewService.getApprovedReviews());
        }
        model.addAttribute("averageRating", reviewService.getAverageRating());
        return "review/view-reviews";
    }

    // Customer: Show submit review form
    @GetMapping("/submit")
    public String showSubmitForm(Model model) {
        model.addAttribute("review", new Review());
        return "review/submit-review";
    }

    // Customer: Handle review submission
    @PostMapping("/submit")
    public String submitReview(@ModelAttribute Review review, RedirectAttributes redirectAttributes) {
        // Validation logic
        if (review.getReviewComment().length() < 5) {
            redirectAttributes.addFlashAttribute("error", "Comment must be at least 5 characters long.");
            return "redirect:/reviews/submit";
        }
        if (review.getStarRating() < 1 || review.getStarRating() > 5) {
            redirectAttributes.addFlashAttribute("error", "Please select a valid rating.");
            return "redirect:/reviews/submit";
        }

        boolean success = reviewService.addReview(review);
        if (success) {
            redirectAttributes.addFlashAttribute("success", "Review submitted successfully and is pending approval!");
            return "redirect:/reviews";
        } else {
            redirectAttributes.addFlashAttribute("error", "You have already reviewed this service.");
            return "redirect:/reviews/submit";
        }
    }

    // Customer: Show edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Review review = reviewService.getReviewById(id);
        if (review != null) {
            model.addAttribute("review", review);
            return "review/edit-review";
        }
        return "redirect:/reviews";
    }

    // Customer: Handle edit submission
    @PostMapping("/edit")
    public String editReview(@ModelAttribute Review review, RedirectAttributes redirectAttributes) {
        if (review.getReviewComment().length() < 5) {
            redirectAttributes.addFlashAttribute("error", "Comment must be at least 5 characters long.");
            return "redirect:/reviews/edit/" + review.getReviewId();
        }
        reviewService.updateReview(review);
        redirectAttributes.addFlashAttribute("success", "Review updated successfully!");
        return "redirect:/reviews";
    }

    // Customer: Delete review
    @GetMapping("/delete/{id}")
    public String deleteReview(@PathVariable String id, RedirectAttributes redirectAttributes) {
        reviewService.deleteReview(id);
        redirectAttributes.addFlashAttribute("success", "Review deleted successfully.");
        return "redirect:/reviews";
    }

    // Admin: View all reviews for moderation
    @GetMapping("/admin")
    public String adminModeration(Model model) {
        model.addAttribute("reviews", reviewService.getAllReviews());
        return "review/admin-moderation";
    }

    // Admin: Approve/Reject review
    @GetMapping("/admin/status")
    public String updateStatus(@RequestParam String id, @RequestParam String status, RedirectAttributes redirectAttributes) {
        reviewService.updateReviewStatus(id, status);
        redirectAttributes.addFlashAttribute("success", "Review status updated to " + status);
        return "redirect:/reviews/admin";
    }
}
