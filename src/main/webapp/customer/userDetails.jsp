<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Mock data for demonstration. Replace with real data fetching logic.
    String id = request.getParameter("id");
    String username = "SampleUser";
    String email = "sampleuser@email.com";
    if (id != null && id.equals("1")) {
        username = "Venuri";
        email = "dampahalagevenuri@gmail.com";
    } else if (id != null && id.equals("2")) {
        username = "Dampahalage";
        email = "dampahalagevenuri@gmail.com";
    } else if (id != null && id.equals("3")) {
        username = "admin";
        email = "dampahalagevenuri@gmail.com";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details - Glamour Haven</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Poppins', sans-serif;
            color: #333;
        }
        .container {
            max-width: 500px;
            margin: 60px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(255, 105, 180, 0.10);
            padding: 2.5rem 2rem 2rem 2rem;
        }
        h1 {
            color: #ff69b4;
            font-size: 2rem;
            font-weight: 600;
            text-align: center;
            margin-bottom: 2rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            color: #666;
            font-weight: 500;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            font-family: 'Poppins', sans-serif;
        }
        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            color: white;
            background: #ff69b4;
            text-decoration: none;
            font-weight: 500;
        }
        .btn-primary {
            background: #ff69b4;
        }
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
        .btn-back {
            background: #6c63ff;
            margin-top: 1.5rem;
        }
        .btn-row {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Details</h1>
        <form action="${pageContext.request.contextPath}/CustomerController" method="post">
            <input type="hidden" name="action" value="updateCustomer">
            <input type="hidden" name="id" value="<%= id %>">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" value="<%= username %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= email %>" required>
            </div>
            <div class="form-group">
                <label for="password">New Password</label>
                <input type="password" id="password" name="password" placeholder="Enter new password">
            </div>
            <div class="btn-row">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save
                </button>
                <a href="${pageContext.request.contextPath}/customer/userManagement.jsp" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i> Back to User Management
                </a>
            </div>
        </form>
    </div>
</body>
</html> 