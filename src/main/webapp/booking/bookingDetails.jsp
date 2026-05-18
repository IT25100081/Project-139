<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%-- header.jspf prelude automatically included --%>

            <style>
                body {
                    padding-top: 70px;
                    font-family: 'Poppins', sans-serif;
                    color: #333;
                    line-height: 1.6;
                    background-color: #f9f9f9;
                }

                .booking-details-container {
                    max-width: 800px;
                    margin: 2rem auto;
                    padding: 2rem;
                    background: white;
                    border-radius: 10px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }

                .booking-header {
                    text-align: center;
                    margin-bottom: 2rem;
                    padding-bottom: 1rem;
                    border-bottom: 2px solid #ff69b4;
                }

                .booking-header h1 {
                    font-family: 'Playfair Display', serif;
                    color: #333;
                    font-size: 2rem;
                    margin-bottom: 0.5rem;
                }

                .booking-info {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 1.5rem;
                    margin-bottom: 2rem;
                }

                .info-group {
                    padding: 1rem;
                    background: #f8f9fa;
                    border-radius: 8px;
                }

                .info-group h2 {
                    font-size: 1.2rem;
                    color: #ff69b4;
                    margin-bottom: 1rem;
                }

                .info-item {
                    margin-bottom: 0.8rem;
                    display: flex;
                    align-items: center;
                }

                .info-item i {
                    color: #ff69b4;
                    margin-right: 0.8rem;
                    width: 20px;
                    text-align: center;
                }

                .status-badge {
                    display: inline-block;
                    padding: 0.5rem 1rem;
                    border-radius: 20px;
                    font-weight: 500;
                    text-transform: capitalize;
                }

                .status-Pending {
                    background: #fff3cd;
                    color: #856404;
                }

                .status-Confirmed {
                    background: #d4edda;
                    color: #155724;
                }

                .status-Cancelled {
                    background: #f8d7da;
                    color: #721c24;
                }

                .status-Completed {
                    background: #cce5ff;
                    color: #004085;
                }

                .actions {
                    display: flex;
                    justify-content: center;
                    gap: 1rem;
                    margin-top: 2rem;
                    padding-top: 1rem;
                    border-top: 1px solid #eee;
                }

                .btn {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.5rem;
                    padding: 0.8rem 1.5rem;
                    border-radius: 25px;
                    font-weight: 500;
                    text-decoration: none;
                    transition: all 0.3s ease;
                }

                .btn-primary {
                    background-color: #ff69b4;
                    color: white;
                }

                .btn-primary:hover {
                    background-color: #ff4da6;
                    transform: translateY(-2px);
                }

                .btn-secondary {
                    background-color: #6c757d;
                    color: white;
                }

                .btn-secondary:hover {
                    background-color: #5a6268;
                    transform: translateY(-2px);
                }

                .price {
                    font-size: 1.5rem;
                    color: #ff69b4;
                    font-weight: 600;
                }

                .service-description {
                    margin-top: 1.5rem;
                    padding: 1rem;
                    background: #f8f9fa;
                    border-radius: 8px;
                    font-style: italic;
                    color: #666;
                }
            </style>

            <div class="booking-details-container">
                <div class="booking-header">
                    <h1>Booking Details</h1>
                    <div class="status-badge status-${booking.status}">${booking.status}</div>
                </div>

                <div class="booking-info">
                    <div class="info-group">
                        <h2>Service Information</h2>
                        <div class="info-item">
                            <i class="fas fa-spa"></i>
                            <span><strong>Service:</strong> ${booking.serviceName}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-dollar-sign"></i>
                            <span><strong>Price:</strong> <span class="price">$${booking.price}</span></span>
                        </div>
                        <div class="service-description">
                            <i class="fas fa-info-circle"></i>
                            <span>${booking.serviceDescription}</span>
                        </div>
                    </div>

                    <div class="info-group">
                        <h2>Appointment Details</h2>
                        <div class="info-item">
                            <i class="far fa-calendar-alt"></i>
                            <span><strong>Date:</strong> ${booking.date}</span>
                        </div>
                        <div class="info-item">
                            <i class="far fa-clock"></i>
                            <span><strong>Time:</strong> ${booking.time}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-user"></i>
                            <span><strong>Stylist:</strong> ${booking.employeeName}</span>
                        </div>
                    </div>
                </div>

                <div class="actions">
                    <a href="${pageContext.request.contextPath}/CustomerController?action=viewDashboard"
                        class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                    <c:if test="${booking.status != 'Cancelled' && booking.status != 'Completed'}">
                        <button onclick="cancelBooking('${booking.bookingId}')" class="btn btn-primary">
                            <i class="fas fa-times"></i> Cancel Booking
                        </button>
                    </c:if>
                </div>
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
                                    alert('Booking cancelled successfully!');
                                    window.location.href = '${pageContext.request.contextPath}/CustomerController?action=viewDashboard';
                                } else {
                                    alert('Failed to cancel booking. Please try again.');
                                }
                            })
                            .catch(error => {
                                alert('An error occurred. Please try again.');
                            });
                    }
                }
            </script>
            <%-- footer.jspf coda automatically included --%>