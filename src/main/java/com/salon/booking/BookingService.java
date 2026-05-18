package com.salon.booking;
import com.salon.common.FileHandler;

import com.salon.booking.Booking;
import java.util.ArrayList;
import java.util.List;

public class BookingService {
    private List<Booking> bookings = new ArrayList<>();
    private FileHandler fileHandler;

    public BookingService() {
        bookings = new ArrayList<>();
    }

    public void setFileHandler(FileHandler fileHandler) {
        this.fileHandler = fileHandler;
        if (fileHandler != null) {
            bookings = fileHandler.loadBookings();
        }
    }

    public List<Booking> getAllBookings() {
        // Always load fresh bookings from the file handler
        if (fileHandler != null) {
            this.bookings = fileHandler.loadBookings(); 
        } else {
            System.err.println("BookingService WARN: FileHandler is null in getAllBookings. Returning potentially stale or empty list.");
        }
        return bookings;
    }

    public void addBooking(Booking booking) {
        getAllBookings(); // ensure fresh data
        bookings.add(booking);
        if (fileHandler != null) {
            fileHandler.saveBookings(bookings);
        }
    }

    public void updateBookingStatus(int id, String status) {
        getAllBookings(); // ensure fresh data
        for (Booking booking : bookings) {
            if (booking.getId() == id) {
                booking.setStatus(status);
                if (fileHandler != null) {
                    fileHandler.saveBookings(bookings);
                }
                break;
            }
        }
    }

    public Booking getBookingById(int id) {
        getAllBookings(); // ensure fresh data
        return bookings.stream()
                .filter(booking -> booking.getId() == id)
                .findFirst()
                .orElse(null);
    }

    public boolean deleteBooking(int id) {
        Booking bookingToRemove = getBookingById(id);
        if (bookingToRemove != null) {
            bookings.remove(bookingToRemove);
            if (fileHandler != null) {
                fileHandler.saveBookings(bookings);
            }
            return true;
        }
        return false;
    }
}