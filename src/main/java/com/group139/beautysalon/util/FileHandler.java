package com.group139.beautysalon.util;

import com.group139.beautysalon.model.GuestReview;
import com.group139.beautysalon.model.Review;
import com.group139.beautysalon.model.VerifiedReview;
import org.springframework.stereotype.Component;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@Component
public class FileHandler {
    private static final String FILE_PATH = "reviews.txt";

    public List<Review> readReviews() {
        List<Review> reviews = new ArrayList<>();
        File file = new File(FILE_PATH);
        
        // Return empty list if file doesn't exist
        if (!file.exists()) {
            return reviews;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 8) {
                    Review review;
                    // Example of polymorphism & inheritance handling:
                    // If customer ID starts with 'C', consider them Verified. Otherwise, Guest.
                    if (data[1].startsWith("C") || !data[1].isEmpty()) {
                        review = new VerifiedReview(data[0], data[1], data[2], data[3], Integer.parseInt(data[4]), data[5], data[6], data[7]);
                    } else {
                        review = new GuestReview(data[0], "GUEST", data[2], data[3], Integer.parseInt(data[4]), data[5], data[6], data[7]);
                    }
                    reviews.add(review);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading reviews file: " + e.getMessage());
        }
        return reviews;
    }

    public void writeReviews(List<Review> reviews) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Review review : reviews) {
                String line = String.format("%s,%s,%s,%s,%d,%s,%s,%s\n",
                        review.getReviewId(), review.getCustomerId(), review.getServiceId(),
                        review.getCustomerName(), review.getStarRating(), review.getReviewComment(),
                        review.getDate(), review.getReviewStatus());
                bw.write(line);
            }
        } catch (IOException e) {
            System.err.println("Error writing to reviews file: " + e.getMessage());
        }
    }
}
