<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback & Reviews Management - Glamour Haven</title>
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

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .card h2 {
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            border-bottom: 2px solid #fce8f3;
            padding-bottom: 0.5rem;
        }

        .table-container {
            overflow-x: auto;
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
            vertical-align: middle;
        }

        tr:hover {
            background: #fce8f3;
        }

        .action-cell {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .delete-button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            color: white;
            background: #dc3545;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .delete-button:hover {
            background: #c82333;
            transform: translateY(-1px);
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            background: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .back-button:hover {
            background: #5a6268;
            transform: translateY(-1px);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Feedback & Reviews</h1>
            <a href="${pageContext.request.contextPath}/AdminDashboardController" class="back-button">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <div class="card">
            <h2>General Salon Reviews</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th width="20%">Customer Name</th>
                            <th width="65%">Review / Feedback</th>
                            <th width="15%">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<String[]> salonReviews = (List<String[]>) request.getAttribute("salonReviews");
                            if (salonReviews != null && !salonReviews.isEmpty()) {
                                for (int i = 0; i < salonReviews.size(); i++) {
                                    String[] reviewData = salonReviews.get(i);
                        %>
                                <tr>
                                    <td><strong><%= reviewData[0] %></strong></td>
                                    <td><%= reviewData[1].replace("<br>", "\n") %></td>
                                    <td class="action-cell">
                                        <form action="${pageContext.request.contextPath}/ReviewController" method="post" style="margin: 0;" onsubmit="return confirm('Are you sure you want to delete this review?');">
                                            <input type="hidden" name="action" value="deleteSalonReview">
                                            <input type="hidden" name="index" value="<%= i %>">
                                            <button type="submit" class="delete-button" title="Delete Review">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                        <% 
                                }
                            } else { 
                        %>
                            <tr>
                                <td colspan="3" class="empty-state">
                                    <i class="fas fa-comment-slash" style="font-size: 2rem; color: #ccc; margin-bottom: 1rem; display: block;"></i>
                                    No general salon reviews found.
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
