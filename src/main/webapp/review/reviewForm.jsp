<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Your Review - Glamour Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            padding-top: 70px; /* Consistent with other pages */
            font-family: 'Poppins', sans-serif;
            color: #333;
            line-height: 1.6;
            background-color: #f9f9f9; /* Light background for the page */
        }
        .header {
            background-color: #fff;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 5%;
        }
        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: #ff69b4;
        }
        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }
        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s;
        }
        .nav-links a:hover {
            color: #ff69b4;
        }
        .form-container {
            max-width: 600px;
            margin: 3rem auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        .form-container h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: #333;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .action-link {
            display: inline-block;
            padding: 0.7rem 1.5rem;
            background-color: #ff69b4;
            color: white !important;
            text-decoration: none;
            border-radius: 25px;
            transition: background-color 0.3s;
            margin-top: 1rem;
            border: none;
            cursor: pointer;
            font-weight: 500;
        }
        .action-link:hover {
            background-color: #ff4da6;
            text-decoration: none;
        }
        textarea {
            width: 100%; 
            padding: 0.75rem; 
            border-radius: 5px; 
            border: 1px solid #ccc; 
            font-family: inherit;
            font-size: 1rem;
            min-height: 120px;
        }
        label {
            display:block; 
            margin-bottom: .75rem; 
            font-weight: 600;
            color: #555;
        }
        .message-area div {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 5px;
            font-size: 0.95rem;
        }
        .success-message {
            background-color: #d4edda; 
            color: #155724; 
            border: 1px solid #c3e6cb;
        }
        .error-message {
            background-color: #f8d7da; 
            color: #721c24; 
            border: 1px solid #f5c6cb;
        }
        .back-link {
             display: block;
             text-align: center;
             margin-top: 2rem;
             color: #ff69b4;
             text-decoration: none;
             font-weight: 500;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%-- Reusing header from userDashboard for consistency --%>
    <header class="header">
        <nav class="nav">
            <div class="logo">Glamour Haven</div>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="${pageContext.request.contextPath}/ServiceController?action=list#services">Services</a>
                <a href="${pageContext.request.contextPath}/index.jsp#gallery">Gallery</a>
                <a href="${pageContext.request.contextPath}/index.jsp#contact">Contact</a>
                <c:if test="${not empty sessionScope.customer}">
                     <a href="${pageContext.request.contextPath}/CustomerController?action=viewDashboard" style="font-weight: 600;">My Dashboard</a>
                    <a href="${pageContext.request.contextPath}/CustomerController?action=logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </c:if>
            </div>
        </nav>
    </header>

    <div class="form-container">
        <h1>Share Your Experience</h1>

        <div class="message-area">
            <c:if test="${not empty sessionScope.reviewMessage}">
                <div class="success-message">
                    <c:out value="${sessionScope.reviewMessage}"/>
                </div>
                <% session.removeAttribute("reviewMessage"); %>
            </c:if>
            <c:if test="${not empty sessionScope.reviewError}">
                <div class="error-message">
                    <c:out value="${sessionScope.reviewError}"/>
                </div>
                <% session.removeAttribute("reviewError"); %>
            </c:if>
        </div>

        <form action="${pageContext.request.contextPath}/ReviewController?action=add" method="post">
            <div>
                <label for="reviewText">Your Review:</label>
                <textarea id="reviewText" name="reviewText" rows="6" required></textarea>
            </div>
            <button type="submit" class="action-link" style="width: 100%;">
                <i class="fas fa-paper-plane"></i> Submit Review
            </button>
        </form>
        <a href="${pageContext.request.contextPath}/CustomerController?action=viewDashboard" class="back-link">Back to Dashboard</a>
    </div>



</body>
</html>