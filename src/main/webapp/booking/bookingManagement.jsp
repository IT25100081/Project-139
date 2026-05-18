<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.salon.booking.Booking" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Management - Glamour Haven</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        h1 {
            color: #ff69b4;
            font-size: 2.5rem;
            font-weight: 600;
        }

        .bookings-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #ff69b4;
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 500;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #fce8f3;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-block;
        }

        .status-Pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-Confirmed {
            background: #d4edda;
            color: #155724;
        }

        .status-Completed {
            background: #cce5ff;
            color: #004085;
        }

        .status-Cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .action-cell {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .update-form {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .status-select {
            padding: 0.6rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: 'Poppins', sans-serif;
            color: #666;
            min-width: 130px;
        }

        .update-button {
            padding: 0.6rem 1rem;
            background: #ff69b4;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
        }

        .update-button:hover {
            background: #ff4da6;
            transform: translateY(-1px);
        }

        .success-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: none;
            z-index: 1000;
        }

        .error-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: none;
            z-index: 1000;
        }

        .delete-button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 0.6rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 0.5rem;
            transition: background-color 0.3s;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .delete-button:hover {
            background-color: #c82333;
        }

        .return-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            background-color: #ff69b4;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 500;
            margin: 2rem 0;
            transition: all 0.3s ease;
        }

        .return-button:hover {
            background-color: #ff4da6;
            transform: translateY(-2px);
        }

        .return-button i {
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Booking Management</h1>
        </div>

        <div class="bookings-table">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Customer ID</th>
                    <th>Service ID</th>
                    <th>Employee ID</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <% 
                    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                    if (bookings != null) {
                        for (Booking booking : bookings) {
                %>
                <tr>
                    <td><%= booking.getId() %></td>
                    <td><%= booking.getCustomerId() %></td>
                    <td><%= booking.getServiceId() %></td>
                    <td><%= booking.getEmployeeId() %></td>
                    <td><%= booking.getDate() %></td>
                    <td><%= booking.getTime() %></td>
                    <td><div class="status-badge status-<%= booking.getStatus() %>"><%= booking.getStatus() %></div></td>
                    <td class="action-cell">
                        <form class="update-form" onsubmit="updateBooking(event, <%= booking.getId() %>)">
                            <select name="status" class="status-select">
                                <option value="Pending" <%= booking.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                                <option value="Confirmed" <%= booking.getStatus().equals("Confirmed") ? "selected" : "" %>>Confirmed</option>
                                <option value="Completed" <%= booking.getStatus().equals("Completed") ? "selected" : "" %>>Completed</option>
                                <option value="Cancelled" <%= booking.getStatus().equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                            </select>
                            <button type="submit" class="update-button">Update</button>
                        </form>
                        <button onclick="deleteBooking(this, <%= booking.getId() %>)" class="delete-button">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </td>
                </tr>
                <% 
                        }
                    }
                %>
            </table>
        </div>

        <a href="${pageContext.request.contextPath}/admin/adminDashboard.jsp" class="return-button">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <div id="successMessage" class="success-message">
        Status updated successfully!
    </div>
    <div id="errorMessage" class="error-message">
        Failed to update status. Please try again.
    </div>

    <script>
        function updateBooking(event, bookingId) {
            event.preventDefault();
            const form = event.target;
            const status = form.querySelector('select[name="status"]').value;
            const statusCell = form.closest('tr').querySelector('.status-badge');

            fetch('BookingController', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=updateStatus&bookingId=' + bookingId + '&status=' + status
            })
            .then(response => response.text())
            .then(data => {
                statusCell.className = `status-badge status-${status}`;
                statusCell.textContent = status;
                
                const successMessage = document.getElementById('successMessage');
                successMessage.style.display = 'block';
                setTimeout(() => {
                    successMessage.style.display = 'none';
                }, 3000);
            })
            .catch(error => {
                const errorMessage = document.getElementById('errorMessage');
                errorMessage.style.display = 'block';
                setTimeout(() => {
                    errorMessage.style.display = 'none';
                }, 3000);
            });
        }

        function deleteBooking(btn, bookingId) {
            if (confirm('Are you sure you want to delete this booking? This action cannot be undone.')) {
                fetch('BookingController', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=deleteBooking&bookingId=' + bookingId
                })
                .then(response => response.text())
                .then(data => {
                    if (data.trim() === 'success') {
                        const row = btn.closest('tr');
                        row.remove();
                        
                        const successMessage = document.getElementById('successMessage');
                        successMessage.textContent = 'Booking deleted successfully!';
                        successMessage.style.display = 'block';
                        setTimeout(() => {
                            successMessage.style.display = 'none';
                            successMessage.textContent = 'Status updated successfully!';
                        }, 3000);
                    } else {
                        throw new Error('Failed to delete booking');
                    }
                })
                .catch(error => {
                    const errorMessage = document.getElementById('errorMessage');
                    errorMessage.textContent = 'Failed to delete booking. Please try again.';
                    errorMessage.style.display = 'block';
                    setTimeout(() => {
                        errorMessage.style.display = 'none';
                        errorMessage.textContent = 'Failed to update status. Please try again.';
                    }, 3000);
                });
            }
        }
    </script>
</body>
</html>