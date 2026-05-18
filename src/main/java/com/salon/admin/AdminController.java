package com.salon.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin")
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("dashboard")) {
            HttpSession session = request.getSession();
            Boolean isAdmin = (Boolean) session.getAttribute("admin");
            if (isAdmin != null && isAdmin) {
                request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect("customer?action=login");
            }
        }
    }
}