package com.salon.admin;
import com.salon.service.ServiceService;
import com.salon.employee.EmployeeService;
import com.salon.customer.CustomerService;
import com.salon.booking.BookingService;
import com.salon.common.FileHandler;

import com.salon.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminDashboardController")
public class AdminDashboardController extends HttpServlet {
    private BookingService bookingService;
    private CustomerService customerService;
    private EmployeeService employeeService;
    private ServiceService serviceService;

    @Override
    public void init() throws ServletException {
        FileHandler fileHandler = new FileHandler();
        fileHandler.setServletContext(getServletContext());
        
    
        bookingService = new BookingService();
        bookingService.setFileHandler(fileHandler);
        
        customerService = new CustomerService();
        customerService.setFileHandler(fileHandler);
        
        employeeService = new EmployeeService();
        employeeService.setFileHandler(fileHandler);
        
        serviceService = new ServiceService();
        serviceService.setFileHandler(fileHandler);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        int totalBookings = bookingService.getAllBookings().size();
        int activeUsers = customerService.getAllCustomers().size();
        int staffMembers = employeeService.getAllEmployees().size();
        int servicesOffered = serviceService.getAllServices().size();

    
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("staffMembers", staffMembers);
        request.setAttribute("servicesOffered", servicesOffered);

    
        request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
    }
} 
