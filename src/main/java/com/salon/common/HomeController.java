package com.salon.common;

import com.salon.service.Service;
import com.salon.service.ServiceService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Home page controller that loads services and salon reviews,
 * then forwards to index.jsp.
 */
@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
    private FileHandler fileHandler;
    private ServiceService serviceService;

    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler();
        fileHandler.setServletContext(getServletContext());
        serviceService = new ServiceService();
        serviceService.setFileHandler(fileHandler);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Load services
        List<Service> services = serviceService.getAllServices();
        request.setAttribute("services", services);

        // Load salon reviews
        List<String[]> salonReviews = fileHandler.loadSalonReviews();
        if (salonReviews == null || salonReviews.isEmpty()) {
            // Provide default reviews if none exist
            salonReviews = new ArrayList<>();
            salonReviews.add(new String[]{"Alice Wonderland", "Absolutely loved the ambiance and the stylists were so professional. My hair has never looked better!"});
            salonReviews.add(new String[]{"Bob The Builder", "A truly relaxing experience from start to finish. The massage service was top-notch. Highly recommend!"});
            salonReviews.add(new String[]{"Charlie Brown", "Great service and friendly staff. They really listen to what you want. I'll definitely be back for my next haircut."});
        }
        request.setAttribute("salonReviews", salonReviews);

        // Forward to index.jsp
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
