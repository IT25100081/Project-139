package com.salon.customer;

import com.salon.customer.Customer;
import com.salon.booking.Booking;
import com.salon.service.Service;
import com.salon.employee.Employee;
import com.salon.customer.CustomerService;
import com.salon.booking.BookingService;
import com.salon.service.ServiceService;
import com.salon.employee.EmployeeService;
import com.salon.common.FileHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/CustomerController")
public class CustomerController extends HttpServlet {
    private CustomerService customerService;
    private BookingService bookingService;
    private ServiceService serviceService;
    private EmployeeService employeeService;
    private FileHandler fileHandler;

    // Wrapper class for displaying booking details
    public static class BookingDisplayDetail {
        private int bookingId;
        private String serviceName;
        private String employeeName;
        private String date;
        private String time;
        private String status;
        private double price;
        private String serviceDescription;

        public BookingDisplayDetail(int bookingId, String serviceName, String employeeName, String date, String time, String status) {
            this.bookingId = bookingId;
            this.serviceName = serviceName;
            this.employeeName = employeeName;
            this.date = date;
            this.time = time;
            this.status = status;
        }

        // Getters
        public int getBookingId() { return bookingId; }
        public String getServiceName() { return serviceName; }
        public String getEmployeeName() { return employeeName; }
        public String getDate() { return date; }
        public String getTime() { return time; }
        public String getStatus() { return status; }
        public double getPrice() { return price; }
        public String getServiceDescription() { return serviceDescription; }

        // Setters
        public void setPrice(double price) { this.price = price; }
        public void setServiceDescription(String serviceDescription) { this.serviceDescription = serviceDescription; }
    }

    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler();
        fileHandler.setServletContext(getServletContext());
        
        customerService = new CustomerService();
        customerService.setFileHandler(fileHandler);

        bookingService = new BookingService();
        bookingService.setFileHandler(fileHandler);

        serviceService = new ServiceService();
        serviceService.setFileHandler(fileHandler);

        employeeService = new EmployeeService();
        employeeService.setFileHandler(fileHandler);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            boolean registered = customerService.register(username, password, email);
            if (registered) {
                response.sendRedirect("/customer/login.jsp");
            } else {
                request.setAttribute("error", "Registration failed");
                request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
            }
        } else if ("login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            Customer customer = customerService.login(username, password);
            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);
                
                if ("admin".equals(customer.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/AdminDashboardController");
                } else {
                    response.sendRedirect(request.getContextPath() + "/CustomerController?action=viewDashboard");
                }
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/customer/login.jsp").forward(request, response);
            }
        } else if ("addCustomer".equals(action)) {
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                
                customerService.register(username, password, email);
                response.setContentType("text/plain");
                response.getWriter().write("success");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("error");
            }
        } else if ("updateCustomer".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");

                // If password is empty, keep the existing password
                if (password == null || password.trim().isEmpty()) {
                    Customer existingCustomer = customerService.getAllCustomers().stream()
                            .filter(c -> c.getId() == id)
                            .findFirst()
                            .orElse(null);
                    if (existingCustomer != null) {
                        password = existingCustomer.getPassword();
                    }
                }

                customerService.updateCustomer(id, username, password, email);
                response.setContentType("text/plain");
                response.getWriter().write("success");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("error");
            }
        } else if ("deleteCustomer".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                customerService.deleteCustomer(id);
                response.setContentType("text/plain");
                response.getWriter().write("success");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("error");
            }
        } else if ("updateProfile".equals(action)) {
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");
            if (customer != null) {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                customer.setUsername(username);
                customer.setEmail(email);
                if (password != null && !password.trim().isEmpty()) {
                    customer.setPassword(password);
                }

                boolean updated = customerService.updateCustomer(customer);
                if (updated) {
                    session.setAttribute("customer", customer);
                    response.sendRedirect("/customer/profile.jsp");
                } else {
                    request.setAttribute("error", "Failed to update profile");
                    request.getRequestDispatcher("/customer/editProfile.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("/customer/login.jsp");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/HomeController");
        } else if ("manage".equals(action)) {
            // Admin action to manage customers
            request.setAttribute("customers", customerService.getAllCustomers());
            request.getRequestDispatcher("/customer/userManagement.jsp").forward(request, response);
        } else if ("editProfile".equals(action)) {
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/customer/editProfile.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            }
        } else if ("viewBookingDetails".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("customer") != null) {
                try {
                    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                    Customer currentCustomer = (Customer) session.getAttribute("customer");
                    List<Booking> allBookings = bookingService.getAllBookings();
                    
                    // Find the specific booking
                    Booking targetBooking = allBookings.stream()
                        .filter(b -> b.getId() == bookingId && b.getCustomerId() == currentCustomer.getId())
                        .findFirst()
                        .orElse(null);
                    
                    if (targetBooking != null) {
                        // Get associated service and employee details
                        Service service = serviceService.getServiceById(targetBooking.getServiceId());
                        Employee employee = employeeService.getEmployeeById(targetBooking.getEmployeeId());
                        
                        // Create a booking detail object with all necessary information
                        BookingDisplayDetail bookingDetail = new BookingDisplayDetail(
                            targetBooking.getId(),
                            service != null ? service.getName() : "N/A",
                            employee != null ? employee.getName() : "N/A",
                            targetBooking.getDate(),
                            targetBooking.getTime(),
                            targetBooking.getStatus()
                        );
                        
                        // Set additional details
                        if (service != null) {
                            bookingDetail.setPrice(service.getPrice());
                            bookingDetail.setServiceDescription(service.getDescription());
                        }
                        
                        // Add the booking detail to the request
                        request.setAttribute("booking", bookingDetail);
                        request.getRequestDispatcher("/booking/bookingDetails.jsp").forward(request, response);
                    } else {
                        // Booking not found or doesn't belong to current customer
                        response.sendRedirect(request.getContextPath() + "/CustomerController?action=viewDashboard");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/CustomerController?action=viewDashboard");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            }
        } else if ("viewDashboard".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("customer") != null) {
                Customer currentCustomer = (Customer) session.getAttribute("customer");
                List<Booking> allBookings = bookingService.getAllBookings();
                List<BookingDisplayDetail> customerBookingsDisplay = new ArrayList<>();

                if (allBookings != null) {
                    List<Booking> filteredBookings = allBookings.stream()
                        .filter(b -> b.getCustomerId() == currentCustomer.getId())
                        .collect(Collectors.toList());

                    for (Booking booking : filteredBookings) {
                        Service service = serviceService.getServiceById(booking.getServiceId());
                        Employee employee = employeeService.getEmployeeById(booking.getEmployeeId()); // Assumes getEmployeeById exists
                        
                        String serviceName = (service != null) ? service.getName() : "N/A";
                        String employeeName = (employee != null) ? employee.getName() : "N/A";
                        
                        customerBookingsDisplay.add(new BookingDisplayDetail(
                            booking.getId(),
                            serviceName,
                            employeeName,
                            booking.getDate(),
                            booking.getTime(),
                            booking.getStatus()
                        ));
                    }
                }
                request.setAttribute("customerBookings", customerBookingsDisplay);
                request.getRequestDispatcher("/customer/userDashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            }
        } else if ("cancelBooking".equals(action)) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingService.updateBookingStatus(bookingId, "Cancelled");
                response.setContentType("text/plain");
                response.getWriter().write("success");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("error");
            }
        }
    }
}