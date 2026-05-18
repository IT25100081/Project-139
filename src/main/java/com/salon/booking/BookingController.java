package com.salon.booking;
import com.salon.customer.Customer;

import com.salon.booking.Booking;
import com.salon.service.Service;
import com.salon.employee.Employee;
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
import com.google.gson.Gson;
import java.io.IOException;
import java.util.List;

@WebServlet("/BookingController")
public class BookingController extends HttpServlet {
    private BookingService bookingService;
    private ServiceService serviceService;
    private EmployeeService employeeService;
    private FileHandler fileHandler;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        try {
            fileHandler = new FileHandler();
            fileHandler.setServletContext(getServletContext());
            bookingService = new BookingService();
            bookingService.setFileHandler(fileHandler);
            serviceService = new ServiceService();
            serviceService.setFileHandler(fileHandler);
            employeeService = new EmployeeService();
            employeeService.setFileHandler(fileHandler);
            gson = new Gson();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize BookingController", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("viewBookings".equals(action)) {
            request.setAttribute("bookings", bookingService.getAllBookings());
            request.getRequestDispatcher("/booking/bookings.jsp").forward(request, response);
        } else if ("manage".equals(action)) {
            // For admin booking management
            request.setAttribute("bookings", bookingService.getAllBookings());
            request.getRequestDispatcher("/booking/bookingManagement.jsp").forward(request, response);
        } else if ("getBookings".equals(action)) {
            // Return bookings as JSON for the calendar
            List<Booking> bookings = bookingService.getAllBookings();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(bookings));
        } else {
            // Default to showing all bookings instead of redirecting to services
            request.setAttribute("bookings", bookingService.getAllBookings());
            request.getRequestDispatcher("/booking/bookings.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("book".equals(action)) {
            HttpSession session = request.getSession();
            Integer customerId = null;
            Object customerObj = session.getAttribute("customer");
            if (customerObj instanceof com.salon.customer.Customer) {
                customerId = ((com.salon.customer.Customer) customerObj).getId();
            } else if (customerObj instanceof Integer) {
                customerId = (Integer) customerObj;
            }

            if (customerId == null) {
                response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
                return;
            }

            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int employeeId = Integer.parseInt(request.getParameter("employeeId"));
            String date = request.getParameter("date");
            String time = request.getParameter("time");

            int bookingId = bookingService.getAllBookings().size() + 1;
            Booking booking = new Booking(bookingId, customerId, serviceId, employeeId, date, time, "Pending");
            bookingService.addBooking(booking);

            Service service = serviceService.getServiceById(serviceId);
            Employee employee = employeeService.getEmployeeById(employeeId);

            request.setAttribute("booking", booking);
            request.setAttribute("service", service);
            request.setAttribute("bookedEmployee", employee);

            request.getRequestDispatcher("/booking/bookingConfirmation.jsp").forward(request, response);
        } else if ("updateStatus".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String status = request.getParameter("status");

            try {
                bookingService.updateBookingStatus(bookingId, status);
                response.setContentType("text/plain");
                response.getWriter().write("success");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("error");
            }
        } else if ("deleteBooking".equals(action)) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                boolean deleted = bookingService.deleteBooking(bookingId);

                response.setContentType("text/plain");
                if (deleted) {
                    response.getWriter().write("success");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("error");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("error");
            }
        }
    }
}