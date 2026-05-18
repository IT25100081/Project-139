<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Glamour Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .profile-header h1 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .profile-info {
            display: grid;
            gap: 1.5rem;
        }

        .info-group {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .info-group i {
            color: #ff69b4;
            font-size: 1.2rem;
            width: 24px;
        }

        .info-label {
            font-weight: 500;
            color: #666;
            min-width: 100px;
        }

        .info-value {
            color: #333;
        }

        .profile-actions {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .profile-button {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 30px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .edit-button {
            background: #ff69b4;
            color: white;
        }

        .edit-button:hover {
            background: #ff4da6;
        }

        .back-button {
            background: #f0f0f0;
            color: #333;
        }

        .back-button:hover {
            background: #e0e0e0;
        }


    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <h1>My Profile</h1>
            <p>Welcome back, ${sessionScope.customer.username}!</p>
        </div>

        <div class="profile-info">
            <div class="info-group">
                <i class="fas fa-user"></i>
                <span class="info-label">Username:</span>
                <span class="info-value">${sessionScope.customer.username}</span>
            </div>
            <div class="info-group">
                <i class="fas fa-envelope"></i>
                <span class="info-label">Email:</span>
                <span class="info-value">${sessionScope.customer.email}</span>
            </div>
        </div>

        <div class="profile-actions">
            <a href="${pageContext.request.contextPath}/ServiceController?action=list" class="profile-button back-button">
                <i class="fas fa-arrow-left"></i> Back to Services
            </a>
            <a href="${pageContext.request.contextPath}/CustomerController?action=editProfile" class="profile-button edit-button">
                <i class="fas fa-edit"></i> Edit Profile
            </a>
            <a href="${pageContext.request.contextPath}/CustomerController?action=logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</body>
</html> 