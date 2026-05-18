<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Glamour Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.css' rel='stylesheet' />
    <script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.js'></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #f8f9ff;
            min-height: 100vh;
            display: flex;
        }

        .sidebar {
            width: 280px;
            background: white;
            padding: 2rem;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            height: 100vh;
            transition: all 0.3s ease;
        }

        .sidebar-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .sidebar-header h1 {
            font-family: 'Playfair Display', serif;
            color: #333;
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .nav-links {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 1rem;
            color: #666;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: #fce8f3;
            color: #ff69b4;
        }

        .nav-link.active {
            background: #ff69b4;
            color: white;
        }

        .nav-link i {
            margin-right: 1rem;
            width: 20px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        .dashboard-header {
            margin-bottom: 2rem;
        }

        .dashboard-header h2 {
            font-family: 'Playfair Display', serif;
            color: #333;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-header {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            background: #fce8f3;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }

        .stat-icon i {
            color: #ff69b4;
            font-size: 1.2rem;
        }

        .stat-title {
            color: #666;
            font-size: 0.9rem;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
        }

        .quick-actions {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .quick-actions h3 {
            font-family: 'Playfair Display', serif;
            color: #333;
            margin-bottom: 1rem;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .action-button {
            display: flex;
            align-items: center;
            padding: 1rem;
            background: #f8f9ff;
            border: none;
            border-radius: 10px;
            color: #666;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .action-button:hover {
            background: #fce8f3;
            color: #ff69b4;
        }

        .action-button i {
            margin-right: 0.5rem;
        }

        .logout-button {
            position: absolute;
            bottom: 2rem;
            width: calc(100% - 4rem);
            padding: 1rem;
            background: #ff69b4;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logout-button:hover {
            background: #ff4da6;
        }

        .logout-button i {
            margin-right: 0.5rem;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
                padding: 1rem;
            }

            .sidebar-header h1,
            .nav-link span {
                display: none;
            }

            .nav-link {
                justify-content: center;
                padding: 0.8rem;
            }

            .nav-link i {
                margin: 0;
            }

            .main-content {
                margin-left: 70px;
            }

            .logout-button {
                width: calc(100% - 2rem);
            }

            .logout-button span {
                display: none;
            }
        }

        .calendar-section {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .calendar-section h3 {
            font-family: 'Playfair Display', serif;
            color: #333;
            margin-bottom: 1rem;
        }

        #booking-calendar {
            height: 600px;
            margin-bottom: 1rem;
            background: white;
        }

        .fc {
            background: white;
        }

        .fc-toolbar-title {
            font-family: 'Playfair Display', serif;
            color: #333;
        }

        .fc-button-primary {
            background-color: #ff69b4 !important;
            border-color: #ff69b4 !important;
        }

        .fc-button-primary:hover {
            background-color: #ff4da6 !important;
            border-color: #ff4da6 !important;
        }

        .fc-daygrid-day {
            cursor: pointer;
        }

        .fc-event {
            cursor: pointer;
            padding: 4px;
            margin: 2px 0;
            border-radius: 4px;
        }

        .fc-event-title {
            font-weight: 500;
            font-size: 0.9em;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .fc-h-event {
            background-color: #ff69b4;
            border: 1px solid #ff69b4;
        }

        .fc-h-event:hover {
            background-color: #ff4da6;
        }
    </style>
</head>
<body>
    <nav class="sidebar">
        <div class="sidebar-header">
            <h1>Admin Panel</h1>
        </div>
        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/AdminDashboardController" class="nav-link active">
                    <i class="fas fa-chart-line"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/BookingController?action=manage" class="nav-link">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Bookings</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/CustomerController?action=manage" class="nav-link">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/EmployeeController?action=manage" class="nav-link">
                    <i class="fas fa-user-tie"></i>
                    <span>Employees</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/ServiceController?action=manage" class="nav-link">
                    <i class="fas fa-spa"></i>
                    <span>Services</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/ReviewController?action=manage" class="nav-link">
                    <i class="fas fa-comments"></i>
                    <span>Reviews</span>
                </a>
            </li>
        </ul>
        <a href="${pageContext.request.contextPath}/CustomerController?action=logout" class="logout-button">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </nav>

    <main class="main-content">
        <div class="dashboard-header">
            <h2>Dashboard Overview</h2>
            <p>Welcome back, Admin!</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div>
                        <div class="stat-title">Total Bookings</div>
                        <div class="stat-value">${totalBookings}</div>
                    </div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div>
                        <div class="stat-title">Active Users</div>
                        <div class="stat-value">${activeUsers}</div>
                    </div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <div>
                        <div class="stat-title">Staff Members</div>
                        <div class="stat-value">${staffMembers}</div>
                    </div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-spa"></i>
                    </div>
                    <div>
                        <div class="stat-title">Services Offered</div>
                        <div class="stat-value">${servicesOffered}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="calendar-section">
            <h3>Booking Calendar</h3>
            <div id="booking-calendar"></div>
        </div>

        <div class="quick-actions">
            <h3>Quick Actions</h3>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/BookingController?action=manage" class="action-button">
                    <i class="fas fa-calendar-plus"></i>
                    Manage Bookings
                </a>
                <a href="${pageContext.request.contextPath}/CustomerController?action=manage" class="action-button">
                    <i class="fas fa-user-plus"></i>
                    Manage Users
                </a>
                <a href="${pageContext.request.contextPath}/EmployeeController?action=manage" class="action-button">
                    <i class="fas fa-user-tie"></i>
                    Manage Employees
                </a>
                <a href="${pageContext.request.contextPath}/ServiceController?action=manage" class="action-button">
                    <i class="fas fa-spa"></i>
                    Manage Services
                </a>
            </div>
        </div>

    <style>
    .footer {
        background: linear-gradient(135deg, #ff69b4 0%, #ffc0cb 100%);
        padding: 4rem 0 2rem;
        position: static;
        width: 100%;
        box-shadow: 0 -2px 20px rgba(255, 105, 180, 0.15);
        margin-top: 4rem;
        border-radius: 15px;
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 2rem;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 3rem;
    }

    .footer-section {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .footer-section h3 {
        font-family: 'Playfair Display', serif;
        color: white;
        font-size: 1.5rem;
        margin-bottom: 1rem;
        position: relative;
    }

    .footer-section h3::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: -5px;
        width: 40px;
        height: 2px;
        background-color: white;
    }

    .footer-section p {
        color: rgba(255, 255, 255, 0.9);
        line-height: 1.8;
    }

    .footer-links {
        display: flex;
        flex-direction: column;
        gap: 0.8rem;
    }

    .footer-links a {
        color: white;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        opacity: 0.9;
    }

    .footer-links a:hover {
        opacity: 1;
        transform: translateX(5px);
        text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
    }

    .footer-links a i {
        font-size: 0.8rem;
    }

    .footer-social {
        display: flex;
        gap: 1rem;
        margin-top: 1rem;
    }

    .footer-social a {
        background: rgba(255, 255, 255, 0.9);
        color: #ff69b4;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .footer-social a:hover {
        background: white;
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }

    .footer-bottom {
        text-align: center;
        margin-top: 3rem;
        padding-top: 2rem;
        border-top: 1px solid rgba(255, 255, 255, 0.2);
        color: white;
        font-size: 0.9rem;
    }
    </style>
    <footer class="footer" style="border-radius: 15px; margin-top: 2rem;">
        <div class="footer-content">
            <div class="footer-section">
                <h3>About Us</h3>
                <p>Glamour Haven is your premier destination for beauty and wellness. We provide exceptional services to help you look and feel your absolute best.</p>
                <div class="footer-social">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-pinterest"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h3>Quick Links</h3>
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/HomeController"><i class="fas fa-chevron-right"></i> Home</a>
                    <a href="${pageContext.request.contextPath}/about.jsp"><i class="fas fa-chevron-right"></i> About Us</a>
                    <a href="${pageContext.request.contextPath}/ServiceController?action=list"><i class="fas fa-chevron-right"></i> Services</a>
                    <a href="${pageContext.request.contextPath}/HomeController#contact"><i class="fas fa-chevron-right"></i> Contact</a>
                    <a href="${pageContext.request.contextPath}/privacy-policy.jsp"><i class="fas fa-chevron-right"></i> Privacy Policy</a>
                </div>
            </div>

            <div class="footer-section">
                <h3>Contact Info</h3>
                <div class="footer-links">
                    <a href="#"><i class="fas fa-map-marker-alt"></i> 123 Beauty Street, Colombo, Sri Lanka</a>
                    <a href="tel:+94112345678"><i class="fas fa-phone"></i> +94 11 234 5678</a>
                    <a href="mailto:info@glamourhaven.com"><i class="fas fa-envelope"></i> info@glamourhaven.com</a>
                    <a href="#"><i class="fas fa-clock"></i> Mon - Sat: 9:00 AM - 8:00 PM</a>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2026 Glamour Haven Beauty Salon. All rights reserved.</p>
        </div>
    </footer>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('booking-calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                height: 650,
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,dayGridWeek'
                },
                buttonText: {
                    today: 'Today',
                    month: 'Month',
                    week: 'Week'
                },
                events: function(fetchInfo, successCallback, failureCallback) {
                    fetch('${pageContext.request.contextPath}/BookingController?action=getBookings')
                        .then(response => response.json())
                        .then(data => {
                            const events = data.map(booking => ({
                                id: booking.id,
                                title: `${booking.serviceName} - ${booking.customerName}`,
                                start: booking.date + 'T' + booking.time,
                                backgroundColor: getStatusColor(booking.status),
                                borderColor: getStatusColor(booking.status),
                                extendedProps: {
                                    status: booking.status,
                                    customer: booking.customerName,
                                    service: booking.serviceName,
                                    employee: booking.employeeName
                                }
                            }));
                            successCallback(events);
                        })
                        .catch(error => {
                            console.error('Error fetching events:', error);
                            failureCallback(error);
                        });
                },
                eventClick: function(info) {
                    const event = info.event;
                    const props = event.extendedProps;
                    alert(
                        `Booking Details:\n\n` +
                        `Service: ${props.service}\n` +
                        `Customer: ${props.customer}\n` +
                        `Stylist: ${props.employee}\n` +
                        `Status: ${props.status}\n` +
                        `Time: ${event.start.toLocaleTimeString()}`
                    );
                },
                dayMaxEvents: true,
                displayEventTime: true,
                eventTimeFormat: {
                    hour: '2-digit',
                    minute: '2-digit',
                    hour12: true
                }
            });
            
            calendar.render();
        });

        function getStatusColor(status) {
            switch(status?.toLowerCase()) {
                case 'confirmed': return '#4CAF50';
                case 'pending': return '#FFC107';
                case 'cancelled': return '#F44336';
                case 'completed': return '#2196F3';
                default: return '#ff69b4';
            }
        }
    </script>
</body>
</html>