package com.salon.service;

import com.salon.service.Service;
import com.salon.employee.Employee;
import com.salon.service.ServiceService;
import com.salon.common.FileHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/ServiceController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
    maxFileSize = 1024 * 1024 * 50,         // 50MB
    maxRequestSize = 1024 * 1024 * 100      // 100MB
)
public class ServiceController extends HttpServlet {
    private ServiceService serviceService;
    private FileHandler fileHandler;
    private static final String UPLOAD_DIR = "service_images";
    private static final long MAX_FILE_SIZE = 1024 * 1024 * 50; // 50MB

    @Override
    public void init() throws ServletException {
        try {
            fileHandler = new FileHandler();
            fileHandler.setServletContext(getServletContext());
            serviceService = new ServiceService();
            serviceService.setFileHandler(fileHandler);
            
            // Create upload directory if it doesn't exist
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ServiceController", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            request.setAttribute("services", serviceService.getAllServices());
            
            // Load salon reviews
            List<String[]> salonReviews = fileHandler.loadSalonReviews();
            if (salonReviews == null || salonReviews.isEmpty()) {
                salonReviews = new ArrayList<>();
                salonReviews.add(new String[]{"Alice Wonderland", "Absolutely loved the ambiance and the stylists were so professional. My hair has never looked better!"});
                salonReviews.add(new String[]{"Bob The Builder", "A truly relaxing experience from start to finish. The massage service was top-notch. Highly recommend!"});
                salonReviews.add(new String[]{"Charlie Brown", "Great service and friendly staff. They really listen to what you want. I'll definitely be back for my next haircut."});
            }
            request.setAttribute("salonReviews", salonReviews);
            
            request.getRequestDispatcher("/service/services.jsp").forward(request, response);
        } else if (action.equals("manage")) {
            request.setAttribute("services", serviceService.getAllServices());
            request.getRequestDispatcher("/service/serviceManagement.jsp").forward(request, response);
        } else if (action.equals("view")) {
            int serviceId = Integer.parseInt(request.getParameter("id"));
            Service service = serviceService.getServiceById(serviceId);
            
            // Load employees for the booking form
            List<Employee> employees = fileHandler.loadEmployees();
            
            request.setAttribute("service", service);
            request.setAttribute("employees", employees);
            request.getRequestDispatcher("/service/serviceDetails.jsp").forward(request, response);
        } else if (action.equals("table")) {
            request.setAttribute("services", serviceService.getAllServices());
            request.getRequestDispatcher("/service/serviceTable.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("addService".equals(action)) {
            try {
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("description");
                
                // Handle file upload
                Part filePart = request.getPart("image");
                
                // Validate file size
                if (filePart.getSize() > MAX_FILE_SIZE) {
                    request.setAttribute("error", "File size exceeds maximum limit of 50MB");
                    request.getRequestDispatcher("addService.jsp").forward(request, response);
                    return;
                }
                
                // Validate file type
                String contentType = filePart.getContentType();
                if (!contentType.startsWith("image/")) {
                    request.setAttribute("error", "Only image files are allowed");
                    request.getRequestDispatcher("addService.jsp").forward(request, response);
                    return;
                }
                
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                
                // Save the file
                filePart.write(uploadPath + File.separator + uniqueFileName);
                String imagePath = UPLOAD_DIR + File.separator + uniqueFileName;
                
                int id = serviceService.getAllServices().size() + 1;
                Service service = new Service(id, name, price, description, imagePath);
                serviceService.addService(service);
                
                response.sendRedirect("ServiceController?action=manage");
            } catch (Exception e) {
                request.setAttribute("error", "Error uploading file: " + e.getMessage());
                request.getRequestDispatcher("addService.jsp").forward(request, response);
            }
        } else if ("updateService".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            
            // Handle file upload if new image is provided
            Part filePart = null;
            if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
                try {
                    filePart = request.getPart("image");
                } catch (Exception e) {
                    // Ignore, part not found or error
                }
            }
            String imagePath = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                filePart.write(uploadPath + File.separator + uniqueFileName);
                imagePath = UPLOAD_DIR + File.separator + uniqueFileName;
            }
            
            serviceService.updateService(id, name, price, description, imagePath);
            response.sendRedirect("ServiceController?action=manage");
        } else if ("deleteService".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            serviceService.deleteService(id);
            response.sendRedirect("ServiceController?action=manage");
        }
    }
}
