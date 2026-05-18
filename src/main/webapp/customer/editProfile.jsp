<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Glamour Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .edit-profile-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .edit-profile-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .edit-profile-header h1 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group i {
            color: #ff69b4;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .form-input {
            flex: 1;
            padding: 12px 20px;
            border: 1px solid #ddd;
            border-radius: 30px;
            font-size: 1rem;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
        }

        .form-input:focus {
            outline: none;
            border-color: #ff69b4;
            box-shadow: 0 0 0 2px rgba(255, 105, 180, 0.1);
        }

        .form-input::placeholder {
            color: #999;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .button {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 30px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .save-button {
            background: #ff69b4;
            color: white;
        }

        .save-button:hover {
            background: #ff4da6;
        }

        .cancel-button {
            background: #f0f0f0;
            color: #333;
        }

        .cancel-button:hover {
            background: #e0e0e0;
        }

        .error-message {
            color: #ff4444;
            text-align: center;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="edit-profile-container">
        <div class="edit-profile-header">
            <h1>Edit Profile</h1>
            <p>Update your personal information</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/CustomerController" method="post">
            <input type="hidden" name="action" value="updateProfile">
            
            <div class="form-group">
                <i class="fas fa-user"></i>
                <input type="text" name="username" class="form-input" value="${customer.username}" placeholder="Username" required>
            </div>

            <div class="form-group">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" class="form-input" value="${customer.email}" placeholder="Email" required>
            </div>

            <div class="form-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" class="form-input" placeholder="New Password (leave blank to keep current)">
            </div>

            <div class="button-group">
                <button type="submit" class="button save-button">
                    <i class="fas fa-save"></i> Save Changes
                </button>
                <a href="${pageContext.request.contextPath}/customer/profile.jsp" class="button cancel-button">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</body>
</html> 