<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Submitted - Glamour Haven</title>
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
            margin: 80px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(255, 105, 180, 0.10);
            padding: 2.5rem 2rem 2rem 2rem;
            text-align: center;
        }
        h1 {
            color: #ff69b4;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
        p {
            font-size: 1.1rem;
            margin-bottom: 2rem;
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
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Thank You!</h1>
        <p>Your review has been submitted successfully.<br>We appreciate your feedback and support!</p>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn" style="margin-right: 1rem;">
            <i class="fas fa-home"></i> Return to Home
        </a>
        <a href="${pageContext.request.contextPath}/customer/userDashboard.jsp" class="btn" style="background: #6c63ff;">
            <i class="fas fa-th-large"></i> Return to Dashboard
        </a>
    </div>
</body>
</html> 