package com.salon.employee;

import com.salon.employee.EmployeeService;
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

@WebServlet("/employee")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class EmployeeController extends HttpServlet {
    private EmployeeService employeeService;
    private static final String UPLOAD_DIR = "images/employees";

    @Override
    public void init() throws ServletException {
        FileHandler fileHandler = new FileHandler();
        fileHandler.setServletContext(getServletContext());
        employeeService = new EmployeeService();
        employeeService.setFileHandler(fileHandler);
        
        // Create upload directory if it doesn't exist
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("manage")) {
            request.setAttribute("employees", employeeService.getAllEmployees());
            request.getRequestDispatcher("/employee/employeeManagement.jsp").forward(request, response);
        } else if (action.equals("details")) {
            request.setAttribute("employees", employeeService.getAllEmployees());
            request.getRequestDispatcher("/employee/employeeDetails.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action.equals("add")) {
            String name = request.getParameter("name");
            String specialization = request.getParameter("specialization");
            
            // Handle image upload
            String imagePath = null;
            if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
                Part filePart = request.getPart("image");
                
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    
                    // Create directory if it doesn't exist
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    // Save the file
                    filePart.write(uploadPath + File.separator + uniqueFileName);
                    imagePath = UPLOAD_DIR + "/" + uniqueFileName;
                }
            }
            
            employeeService.addEmployee(name, specialization, imagePath);
            response.sendRedirect("employee?action=manage");
            
        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String specialization = request.getParameter("specialization");
            
            // Handle image update
            String imagePath = null;
            if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
                Part filePart = request.getPart("image");
                
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    
                    // Create directory if it doesn't exist
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    // Save the file
                    filePart.write(uploadPath + File.separator + uniqueFileName);
                    imagePath = UPLOAD_DIR + "/" + uniqueFileName;
                }
            }
            
            employeeService.updateEmployee(id, name, specialization, imagePath);
            response.sendRedirect("employee?action=manage");
            
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            employeeService.deleteEmployee(id);
            response.sendRedirect("employee?action=manage");
        }
    }
}