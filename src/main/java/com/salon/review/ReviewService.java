package com.salon.review;
import com.salon.common.FileHandler;

import com.salon.review.Review;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletContext; 
public class ReviewService {
    private List<Review> reviews = new ArrayList<>();
    private FileHandler fileHandler = new FileHandler();

    public ReviewService() {
    }


    public void setFileHandlerContext(ServletContext context) {
        this.fileHandler.setServletContext(context);
    
    }

    public void addReview(int customerId, int serviceId, String comment) {
        getAllReviews(); // ensure fresh data
        int id = reviews.size() + 1;
        reviews.add(new Review(id, customerId, serviceId, comment));
        fileHandler.saveReviews(reviews);
    }


    public void addSalonReview(String username, String reviewText) {
    
        fileHandler.saveSalonReview(username, reviewText);
    }

    public List<Review> getAllReviews() {
        if (fileHandler != null) {
            reviews = fileHandler.loadReviews();
        }
        return reviews;
    }

    public void deleteReview(int id) {
        getAllReviews(); // refresh
        reviews.removeIf(review -> review.getId() == id);
        if (fileHandler != null) {
            fileHandler.saveReviews(reviews);
        }
    }

    public List<String[]> getAllSalonReviews() {
        if (fileHandler != null) {
            return fileHandler.loadSalonReviews();
        }
        return new ArrayList<>();
    }

    public void deleteSalonReview(int index) {
        if (fileHandler != null) {
            List<String[]> salonReviews = fileHandler.loadSalonReviews();
            if (index >= 0 && index < salonReviews.size()) {
                salonReviews.remove(index);
                fileHandler.saveAllSalonReviews(salonReviews);
            }
        }
    }
}
