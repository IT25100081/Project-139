package com.salon.common;

import com.salon.booking.Booking;
import com.salon.customer.Customer;
import com.salon.employee.Employee;
import com.salon.service.Service;
import com.salon.review.Review;

import jakarta.servlet.ServletContext;
import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Centralized file handler for reading and writing all entity data
 * to text files stored under WEB-INF/classes.
 */
public class FileHandler {
    private ServletContext servletContext;

    private static final String USERS_FILE = "users.txt";
    private static final String SERVICES_FILE = "services.txt";
    private static final String BOOKINGS_FILE = "bookings.txt";
    private static final String EMPLOYEES_FILE = "employees.txt";
    private static final String REVIEWS_FILE = "reviews.txt";
    private static final String SALON_REVIEWS_FILE = "salon_reviews.txt";

    public FileHandler() {
    }

    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    // ==================== Helper Methods ====================

    /**
     * Resolves the absolute path for a data file under WEB-INF/classes.
     */
    private String getFilePath(String fileName) {
        if (servletContext != null) {
            String path = servletContext.getRealPath("/WEB-INF/classes/" + fileName);
            if (path != null) {
                return path;
            }
        }
        // Fallback: use classpath resource location
        try {
            java.net.URL resource = getClass().getClassLoader().getResource(fileName);
            if (resource != null) {
                return Paths.get(resource.toURI()).toString();
            }
        } catch (Exception e) {
            System.err.println("FileHandler: Error resolving classpath resource for " + fileName + ": " + e.getMessage());
        }
        // Last resort fallback
        return fileName;
    }

    /**
     * Reads all lines from a data file. Returns empty list if file doesn't exist.
     */
    private List<String> readLines(String fileName) {
        String filePath = getFilePath(fileName);
        List<String> lines = new ArrayList<>();
        File file = new File(filePath);

        if (!file.exists()) {
            return lines;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (!line.isEmpty()) {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            System.err.println("FileHandler: Error reading " + fileName + ": " + e.getMessage());
        }
        return lines;
    }

    /**
     * Writes all lines to a data file, creating parent directories if needed.
     */
    private void writeLines(String fileName, List<String> lines) {
        String filePath = getFilePath(fileName);
        File file = new File(filePath);

        // Ensure parent directory exists
        File parentDir = file.getParentFile();
        if (parentDir != null && !parentDir.exists()) {
            parentDir.mkdirs();
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("FileHandler: Error writing " + fileName + ": " + e.getMessage());
        }
    }

    // ==================== Customers (users.txt) ====================
    // Format: id,username,password,email[,role]

    public List<Customer> loadCustomers() {
        List<Customer> customers = new ArrayList<>();
        List<String> lines = readLines(USERS_FILE);

        for (String line : lines) {
            try {
                String[] parts = line.split(",", -1);
                if (parts.length >= 4) {
                    int id = Integer.parseInt(parts[0].trim());
                    String username = parts[1].trim();
                    String password = parts[2].trim();
                    String email = parts[3].trim();
                    String role = (parts.length >= 5 && !parts[4].trim().isEmpty()) ? parts[4].trim() : "user";
                    customers.add(new Customer(id, username, password, email, role));
                }
            } catch (Exception e) {
                System.err.println("FileHandler: Error parsing customer line: " + line + " - " + e.getMessage());
            }
        }
        return customers;
    }

    public void saveCustomers(List<Customer> customers) {
        List<String> lines = new ArrayList<>();
        for (Customer c : customers) {
            String line = c.getId() + "," + c.getUsername() + "," + c.getPassword() + "," + c.getEmail();
            if (c.getRole() != null && !c.getRole().equals("user")) {
                line += "," + c.getRole();
            }
            lines.add(line);
        }
        writeLines(USERS_FILE, lines);
    }

    // ==================== Services (services.txt) ====================
    // Format: id,name,price,description,imagePath

    public List<Service> loadServices() {
        List<Service> services = new ArrayList<>();
        List<String> lines = readLines(SERVICES_FILE);

        for (String line : lines) {
            try {
                String[] parts = line.split(",", 5);
                if (parts.length >= 3) {
                    int id = Integer.parseInt(parts[0].trim());
                    String name = parts[1].trim();
                    double price = Double.parseDouble(parts[2].trim());
                    String description = (parts.length >= 4) ? parts[3].trim() : "";
                    String imagePath = (parts.length >= 5) ? parts[4].trim() : "default-service-image.jpg";
                    services.add(new Service(id, name, price, description, imagePath));
                }
            } catch (Exception e) {
                System.err.println("FileHandler: Error parsing service line: " + line + " - " + e.getMessage());
            }
        }
        return services;
    }

    public void saveServices(List<Service> services) {
        List<String> lines = new ArrayList<>();
        for (Service s : services) {
            lines.add(s.getId() + "," + s.getName() + "," + s.getPrice() + "," +
                    s.getDescription() + "," + s.getImagePath());
        }
        writeLines(SERVICES_FILE, lines);
    }

    // ==================== Bookings (bookings.txt) ====================
    // Format: id,customerId,serviceId,employeeId,date,time,status

    public List<Booking> loadBookings() {
        List<Booking> bookings = new ArrayList<>();
        List<String> lines = readLines(BOOKINGS_FILE);

        for (String line : lines) {
            try {
                String[] parts = line.split(",", -1);
                if (parts.length >= 7) {
                    int id = Integer.parseInt(parts[0].trim());
                    int customerId = Integer.parseInt(parts[1].trim());
                    int serviceId = Integer.parseInt(parts[2].trim());
                    int employeeId = Integer.parseInt(parts[3].trim());
                    String date = parts[4].trim();
                    String time = parts[5].trim();
                    String status = parts[6].trim();
                    bookings.add(new Booking(id, customerId, serviceId, employeeId, date, time, status));
                }
            } catch (Exception e) {
                System.err.println("FileHandler: Error parsing booking line: " + line + " - " + e.getMessage());
            }
        }
        return bookings;
    }

    public void saveBookings(List<Booking> bookings) {
        List<String> lines = new ArrayList<>();
        for (Booking b : bookings) {
            lines.add(b.getId() + "," + b.getCustomerId() + "," + b.getServiceId() + "," +
                    b.getEmployeeId() + "," + b.getDate() + "," + b.getTime() + "," + b.getStatus());
        }
        writeLines(BOOKINGS_FILE, lines);
    }

    // ==================== Employees (employees.txt) ====================
    // Format: id,name,specialization,imagePath

    public List<Employee> loadEmployees() {
        List<Employee> employees = new ArrayList<>();
        List<String> lines = readLines(EMPLOYEES_FILE);

        for (String line : lines) {
            try {
                String[] parts = line.split(",", 4);
                if (parts.length >= 3) {
                    int id = Integer.parseInt(parts[0].trim());
                    String name = parts[1].trim();
                    String specialization = parts[2].trim();
                    String imagePath = (parts.length >= 4) ? parts[3].trim() : null;
                    employees.add(new Employee(id, name, specialization, imagePath));
                }
            } catch (Exception e) {
                System.err.println("FileHandler: Error parsing employee line: " + line + " - " + e.getMessage());
            }
        }
        return employees;
    }

    public void saveEmployees(List<Employee> employees) {
        List<String> lines = new ArrayList<>();
        for (Employee e : employees) {
            String line = e.getId() + "," + e.getName() + "," + e.getSpecialization();
            if (e.getImagePath() != null) {
                line += "," + e.getImagePath();
            }
            lines.add(line);
        }
        writeLines(EMPLOYEES_FILE, lines);
    }

    // ==================== Reviews (reviews.txt) ====================
    // Format: id,customerId,serviceId,comment

    public List<Review> loadReviews() {
        List<Review> reviews = new ArrayList<>();
        List<String> lines = readLines(REVIEWS_FILE);

        for (String line : lines) {
            try {
                String[] parts = line.split(",", 4);
                if (parts.length >= 4) {
                    int id = Integer.parseInt(parts[0].trim());
                    int customerId = Integer.parseInt(parts[1].trim());
                    int serviceId = Integer.parseInt(parts[2].trim());
                    String comment = parts[3].trim();
                    reviews.add(new Review(id, customerId, serviceId, comment));
                }
            } catch (Exception e) {
                System.err.println("FileHandler: Error parsing review line: " + line + " - " + e.getMessage());
            }
        }
        return reviews;
    }

    public void saveReviews(List<Review> reviews) {
        List<String> lines = new ArrayList<>();
        for (Review r : reviews) {
            lines.add(r.getId() + "," + r.getCustomerId() + "," + r.getServiceId() + "," + r.getComment());
        }
        writeLines(REVIEWS_FILE, lines);
    }

    // ==================== Salon Reviews (salon_reviews.txt) ====================
    // Format: username|reviewText

    public List<String[]> loadSalonReviews() {
        List<String[]> salonReviews = new ArrayList<>();
        List<String> lines = readLines(SALON_REVIEWS_FILE);

        for (String line : lines) {
            String[] parts = line.split("\\|", 2);
            if (parts.length == 2) {
                salonReviews.add(new String[]{parts[0].trim(), parts[1].trim()});
            }
        }
        return salonReviews;
    }

    public void saveSalonReview(String username, String reviewText) {
        String filePath = getFilePath(SALON_REVIEWS_FILE);
        File file = new File(filePath);

        // Ensure parent directory exists
        File parentDir = file.getParentFile();
        if (parentDir != null && !parentDir.exists()) {
            parentDir.mkdirs();
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(username + "|" + reviewText);
            writer.newLine();
        } catch (IOException e) {
            System.err.println("FileHandler: Error saving salon review: " + e.getMessage());
        }
    }

    public void saveAllSalonReviews(List<String[]> salonReviews) {
        List<String> lines = new ArrayList<>();
        for (String[] review : salonReviews) {
            if (review.length >= 2) {
                lines.add(review[0] + "|" + review[1]);
            }
        }
        writeLines(SALON_REVIEWS_FILE, lines);
    }
}
