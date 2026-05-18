//bookings
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.salon.booking.Booking" %>
<%@ page import="com.salon.service.Service" %>
<%@ page import="com.salon.employee.Employee" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Manage Bookings - Beauty Salon</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .bookings-container {
            padding: 20px;
        }
        .booking-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .booking-table th, .booking-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .booking-table th {
            background-color: #f8f9fa;
            color: #2c3e50;
        }
        .status-pending {
            color: #f39c12;
        }
        .status-confirmed {
            color: #2ecc71;
        }
        .status-cancelled {
            color: #e74c3c;
        }
        .action-button {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            margin: 2px;
        }
        .confirm-button {
            background-color: #2ecc71;
        }
        .cancel-button {
            background-color: #e74c3c;
        }
        .action-button:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="bookings-container">
        <h2>Manage Bookings</h2>
        
        <table class="booking-table">
            <tr>
                <th>Booking ID</th>
                <th>Customer ID</th>
                <th>Service</th>
                <th>Employee</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <% 
                List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                for (Booking booking : bookings) {
            %>
            <tr>
                <td><%= booking.getId() %></td>
                <td><%= booking.getCustomerId() %></td>
                <td><%= booking.getServiceId() %></td>
                <td><%= booking.getEmployeeId() %></td>
                <td><%= booking.getDate() %></td>
                <td><%= booking.getTime() %></td>
                <td class="status-<%= booking.getStatus().toLowerCase() %>">
                    <%= booking.getStatus() %>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/BookingController" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
                        
                        <% if (booking.getStatus().equals("Pending")) { %>
                            <button type="submit" name="status" value="Confirmed" class="action-button confirm-button">
                                Confirm
                            </button>
                            <button type="submit" name="status" value="Cancelled" class="action-button cancel-button">
                                Cancel
                            </button>
                        <% } %>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
        
        <p><a href="${pageContext.request.contextPath}/AdminController?action=dashboard">Back to Dashboard</a></p>
    </div>
</div>
</body>
</html> 