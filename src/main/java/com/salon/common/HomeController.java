package com.salon.common;

import com.salon.service.ServiceService;
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

@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
    private ServiceService serviceService;
    private FileHandler fileHandler;

    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler();
        fileHandler.setServletContext(getServletContext());
        serviceService = new ServiceService();
        serviceService.setFileHandler(fileHandler);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Load data for index page
        request.setAttribute("services", serviceService.getAllServices());
        
        List<String[]> salonReviews = fileHandler.loadSalonReviews();

        if (salonReviews == null || salonReviews.isEmpty()) {
            salonReviews = new ArrayList<>();
            salonReviews.add(new String[]{"Alice Wonderland", "Absolutely loved the ambiance and the stylists were so professional. My hair has never looked better!"});
            salonReviews.add(new String[]{"Bob The Builder", "A truly relaxing experience from start to finish. The massage service was top-notch. Highly recommend!"});
            salonReviews.add(new String[]{"Charlie Brown", "Great service and friendly staff. They really listen to what you want. I'll definitely be back for my next haircut."});
            System.out.println("HomeController INFO: No real reviews found, added fake reviews for display.");
        }

        request.setAttribute("salonReviews", salonReviews);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
} 