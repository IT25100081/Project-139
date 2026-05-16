package com.group139.beautysalon.repository;

import com.group139.beautysalon.model.Review;
import com.group139.beautysalon.util.FileHandler;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewRepository {

    private final FileHandler fileHandler;

    public ReviewRepository(FileHandler fileHandler) {
        this.fileHandler = fileHandler;
    }

    public List<Review> findAll() {
        return fileHandler.readReviews();
    }

    public void saveAll(List<Review> reviews) {
        fileHandler.writeReviews(reviews);
    }
}
