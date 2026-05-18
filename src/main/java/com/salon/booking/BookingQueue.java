package com.salon.booking;

import com.salon.booking.Booking;
import java.util.LinkedList;

public class BookingQueue {
    private LinkedList<Booking> queue = new LinkedList<>();

    public void enqueue(Booking booking) {
        queue.add(booking);
    }

    public Booking dequeue() {
        return queue.poll();
    }

    public boolean isEmpty() {
        return queue.isEmpty();
    }
}