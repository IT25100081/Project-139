package com.salon.common;

import com.salon.booking.Booking;
import java.util.List;

public class QuickSort {
    public static void sort(List<Booking> bookings) {
        quickSort(bookings, 0, bookings.size() - 1);
    }

    private static void quickSort(List<Booking> bookings, int low, int high) {
        if (low < high) {
            int pi = partition(bookings, low, high);
            quickSort(bookings, low, pi - 1);
            quickSort(bookings, pi + 1, high);
        }
    }

    private static int partition(List<Booking> bookings, int low, int high) {
        String pivot = bookings.get(high).getTime();
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (bookings.get(j).getTime().compareTo(pivot) <= 0) {
                i++;
                Booking temp = bookings.get(i);
                bookings.set(i, bookings.get(j));
                bookings.set(j, temp);
            }
        }
        Booking temp = bookings.get(i + 1);
        bookings.set(i + 1, bookings.get(high));
        bookings.set(high, temp);
        return i + 1;
    }
}