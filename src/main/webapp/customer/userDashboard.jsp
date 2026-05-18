<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Glamour Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            padding-top: 70px; /* Consistent with index.jsp */
            font-family: 'Poppins', sans-serif;
            color: #333;
            line-height: 1.6;
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
        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem; /* Reduced gap slightly */
        }
        .welcome-text {
            color: #333;
            font-weight: 500;
            margin-right: 0.5rem;
        }
        .dashboard-btn, .logout-btn, .profile-btn { /* Added profile-btn */
            display: inline-flex; /* Use inline-flex for better alignment */
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 500; /* Ensure consistent font weight */
        }
        .profile-btn { /* Style for the edit profile button */
            background-color: #ff69b4;
            color: white !important; /* Ensure text is white */
        }
        .profile-btn:hover {
            background-color: #ff4da6;
            transform: translateY(-2px);
        }

        .dashboard-container {
            padding: 3rem 5%;
            max-width: 900px;
            margin: 0 auto;
        }
        .dashboard-container h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            color: #333;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .dashboard-section {
            background-color: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            margin-bottom: 2rem;
        }
        .dashboard-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: #ff69b4;
            margin-bottom: 1rem;
            border-bottom: 2px solid #ffe0f0;
            padding-bottom: 0.5rem;
        }
        .dashboard-section p {
            font-size: 1rem;
            margin-bottom: 0.75rem;
        }
        .dashboard-section a {
            color: #ff69b4;
            text-decoration: none;
            font-weight: 500;
        }
        .dashboard-section a:hover {
            text-decoration: underline;
        }
        .action-link {
            display: inline-block;
            padding: 0.6rem 1.2rem;
            background-color: #ff69b4;
            color: white !important;
            text-decoration: none;
            border-radius: 20px;
            transition: background-color 0.3s;
            margin-top: 0.5rem;
        }
        .action-link:hover {
            background-color: #ff4da6;
            text-decoration: none;
        }

        .bookings-grid {
            display: grid;
            gap: 1.5rem;
            margin-top: 1.5rem;
        }
        
        .booking-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 1.5rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .booking-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        
        .booking-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: #ff69b4;
        }
        
        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .booking-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }
        
        .booking-status {
            padding: 0.4rem 1rem;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .status-confirmed {
            background: #e6fff2;
            color: #00b359;
        }
        
        .status-pending {
            background: #fff3e6;
            color: #ff9933;
        }
        
        .status-cancelled {
            background: #ffe6e6;
            color: #ff3333;
        }
        
        .booking-info {
            margin: 1rem 0;
        }
        
        .booking-info p {
            margin: 0.5rem 0;
            color: #666;
        }
        
        .booking-info i {
            width: 20px;
            color: #ff69b4;
            margin-right: 0.5rem;
        }
        
        .booking-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .btn-view-details, 
        .btn-cancel {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.6rem 1.2rem;
            border-radius: 20px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 500;
            cursor: pointer;
            border: none;
        }

        .btn-view-details {
            background-color: #ff69b4;
            color: white !important;
        }

        .btn-cancel {
            background-color: #ff4d4d;
            color: white !important;
        }

        .btn-view-details:hover,
        .btn-cancel:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-view-details:hover {
            background-color: #ff4da6;
        }

        .btn-cancel:hover {
            background-color: #ff3333;
        }

        .btn-view-details i,
        .btn-cancel i {
            font-size: 0.9rem;
        }
        
        .no-bookings {
            text-align: center;
            padding: 2rem;
            background: #f9f9f9;
            border-radius: 10px;
            margin: 1rem 0;
        }
        
        .no-bookings i {
            font-size: 2.5rem;
            color: #ddd;
            margin-bottom: 1rem;
        }

        .success-message, .error-message {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 5px;
            z-index: 1000;
            display: none;
        }

        .success-message {
            background-color: #4CAF50;
            color: white;
        }

        .error-message {
            background-color: #f44336;
            color: white;
        }

        .btn-cancel {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 10px;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: background-color 0.3s;
        }

        .btn-cancel:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<header class="header">
    <nav class="nav">
        <div class="logo">Glamour Haven</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/HomeController">Home</a>
            <a href="${pageContext.request.contextPath}/ServiceController?action=list#services">Services</a>
            <a href="${pageContext.request.contextPath}/HomeController#gallery">Gallery</a>
            <a href="${pageContext.request.contextPath}/EmployeeController?action=list">Our Team</a>
            <a href="${pageContext.request.contextPath}/HomeController#contact">Contact</a>
            <c:if test="${not empty sessionScope.customer}">
                <div class="user-menu">
                    <span class="welcome-text">Welcome, <c:out value="${sessionScope.customer.username}"/></span>
                    <a href="${pageContext.request.contextPath}/CustomerController?action=editProfile" class="profile-btn">
                        <i class="fas fa-user-edit"></i> Edit Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/CustomerController?action=logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </c:if>
            <%-- If user is not logged in, auth buttons could be shown if needed, but typical for dashboard to require login --%>
        </div>
    </nav>
</header>

<main class="dashboard-container">
    <h1>User Dashboard</h1>

    <%-- Display Review Submission Messages --%>
    <c:if test="${not empty sessionScope.reviewMessage}">
        <div style="padding: 1rem; margin-bottom: 1rem; border-radius: 5px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb;">
            <c:out value="${sessionScope.reviewMessage}"/>
        </div>
        <% session.removeAttribute("reviewMessage"); %>
    </c:if>
    <c:if test="${not empty sessionScope.reviewError}">
        <div style="padding: 1rem; margin-bottom: 1rem; border-radius: 5px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;">
            <c:out value="${sessionScope.reviewError}"/>
        </div>
        <% session.removeAttribute("reviewError"); %>
    </c:if>

    <section class="dashboard-section" data-aos="fade-up">
        <h2>Your Profile</h2>
        <p><strong>Username:</strong> <c:out value="${sessionScope.customer.username}"/></p>
        <p><strong>Email:</strong> <c:out value="${sessionScope.customer.email}"/></p>
        <a href="${pageContext.request.contextPath}/CustomerController?action=editProfile" class="action-link">
            <i class="fas fa-edit"></i> Edit Profile
        </a>
    </section>

    <section class="dashboard-section" data-aos="fade-up" data-aos-delay="100">
        <h2>Your Bookings</h2>
        <style>
            .bookings-grid {
                display: grid;
                gap: 1.5rem;
                margin-top: 1.5rem;
            }
            
            .booking-card {
                background: #fff;
                border: 1px solid #eee;
                border-radius: 10px;
                padding: 1.5rem;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }
            
            .booking-card:hover {
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transform: translateY(-2px);
            }
            
            .booking-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: #ff69b4;
            }
            
            .booking-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }
            
            .booking-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: #333;
            }
            
            .booking-status {
                padding: 0.4rem 1rem;
                border-radius: 15px;
                font-size: 0.9rem;
                font-weight: 500;
            }
            
            .status-confirmed {
                background: #e6fff2;
                color: #00b359;
            }
            
            .status-pending {
                background: #fff3e6;
                color: #ff9933;
            }
            
            .status-cancelled {
                background: #ffe6e6;
                color: #ff3333;
            }
            
            .booking-info {
                margin: 1rem 0;
            }
            
            .booking-info p {
                margin: 0.5rem 0;
                color: #666;
            }
            
            .booking-info i {
                width: 20px;
                color: #ff69b4;
                margin-right: 0.5rem;
            }
            
            .booking-actions {
                display: flex;
                gap: 1rem;
                margin-top: 1rem;
            }
            
            .btn-view-details {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.6rem 1.2rem;
                background-color: #ff69b4;
                color: white;
                text-decoration: none;
                border-radius: 20px;
                transition: all 0.3s ease;
                font-weight: 500;
            }
            
            .btn-view-details:hover {
                background-color: #ff4da6;
                transform: translateY(-2px);
            }
            
            .no-bookings {
                text-align: center;
                padding: 2rem;
                background: #f9f9f9;
                border-radius: 10px;
                margin: 1rem 0;
            }
            
            .no-bookings i {
                font-size: 2.5rem;
                color: #ddd;
                margin-bottom: 1rem;
            }
        </style>
        
        <c:choose>
            <c:when test="${not empty customerBookings}">
                <div class="bookings-grid">
                    <c:forEach var="booking" items="${customerBookings}">
                        <div class="booking-card">
                            <div class="booking-header">
                                <span class="booking-title">${booking.serviceName}</span>
                                <span class="booking-status status-${fn:toLowerCase(booking.status)}">${booking.status}</span>
                            </div>
                            <div class="booking-info">
                                <p><i class="far fa-calendar-alt"></i> Date: ${booking.date}</p>
                                <p><i class="far fa-clock"></i> Time: ${booking.time}</p>
                                <p><i class="fas fa-user"></i> Stylist: ${booking.employeeName}</p>
                            </div>
                            <div class="booking-actions">
                                <a href="${pageContext.request.contextPath}/CustomerController?action=viewBookingDetails&bookingId=${booking.bookingId}" 
                                   class="btn-view-details">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                                <c:if test="${booking.status != 'Cancelled' && booking.status != 'Completed'}">
                                    <button onclick="cancelBooking(${booking.bookingId})" class="btn-cancel">
                                        <i class="fas fa-times"></i> Cancel Booking
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-bookings">
                    <i class="far fa-calendar-times"></i>
                    <p>You have no bookings yet.</p>
                </div>
            </c:otherwise>
        </c:choose>
        
        <a href="${pageContext.request.contextPath}/ServiceController?action=list#services" class="action-link" style="margin-top: 2rem;">
            <i class="fas fa-calendar-plus"></i> Book a New Service
        </a>
    </section>

    <%-- Removed embedded review form, replaced with a link to the review page --%>
    <section class="dashboard-section" data-aos="fade-up" data-aos-delay="200">
        <h2>Share Your Feedback</h2>
        <p>We value your opinion! Click the button below to leave a review about your experience with Glamour Haven.</p>
        <a href="${pageContext.request.contextPath}/ReviewController?action=showReviewForm" class="action-link" style="margin-top: 1rem;">
            <i class="fas fa-star"></i> Add Your Review
        </a>
    </section>

    <%-- Add more sections as needed, e.g., Order History, Settings, etc. --%>

</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    AOS.init({
        duration: 800,
        once: true
    });
</script>

<!-- Add success and error messages -->
<div id="successMessage" class="success-message" style="display: none;">
    Booking cancelled successfully!
</div>
<div id="errorMessage" class="error-message" style="display: none;">
    Failed to cancel booking. Please try again.
</div>

<script>
    function cancelBooking(bookingId) {
        if (confirm('Are you sure you want to cancel this booking?')) {
            fetch('${pageContext.request.contextPath}/CustomerController?action=cancelBooking&bookingId=' + bookingId, {
                method: 'POST'
            })
            .then(response => response.text())
            .then(data => {
                if (data === 'success') {
                    // Show success message
                    const successMessage = document.getElementById('successMessage');
                    successMessage.style.display = 'block';
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                        // Reload the page to reflect the changes
                        window.location.reload();
                    }, 2000);
                } else {
                    throw new Error('Failed to cancel booking');
                }
            })
            .catch(error => {
                // Show error message
                const errorMessage = document.getElementById('errorMessage');
                errorMessage.style.display = 'block';
                setTimeout(() => {
                    errorMessage.style.display = 'none';
                }, 3000);
            });
        }
    }
</script>
</body>
</html>