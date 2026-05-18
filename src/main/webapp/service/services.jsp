<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.salon.service.Service" %>
        <%@ page import="java.util.List" %>
            <%-- taglib 'c' provided by header.jspf prelude --%>

<style>
    .section-title {
        text-align: center;
        font-family: 'Playfair Display', serif;
        font-size: 2.5rem;
        margin-bottom: 3rem;
        position: relative;
    }
    .section-title::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 3px;
        background: #ff69b4;
    }
    .services-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        gap: 3rem;
        padding: 1rem 5%;
        min-height: 200px;
        max-width: 90%;
        margin: 0 auto;
    }
    .service-card {
        background: #fff;
        border-radius: 15px;
        overflow: hidden;
        transition: all 0.3s ease;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        position: relative;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    .service-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }
    .service-card img {
        width: 100%;
        height: 250px;
        object-fit: cover;
        transition: transform 0.5s ease;
        aspect-ratio: 16/9;
    }
    .service-card:hover img {
        transform: scale(1.1);
    }
    .service-content {
        padding: 1.5rem;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }
    .service-card h3 {
        color: #333;
        font-size: 1.5rem;
        margin-bottom: 0.8rem;
        font-weight: 600;
    }
    .service-card p {
        color: #666;
        font-size: 0.95rem;
        margin-bottom: 1rem;
        line-height: 1.6;
        flex-grow: 1;
    }
    .service-card .price {
        color: #ff69b4;
        font-weight: 600;
        font-size: 1.3rem;
        margin: 0.8rem 0;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    .service-btn {
        background-color: #ff69b4;
        color: white;
        padding: 0.8rem 1.5rem;
        border-radius: 25px;
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        font-weight: 500;
        margin-top: auto;
    }
    .service-btn:hover {
        background-color: #ff4da6;
        transform: translateY(-2px);
    }
    .reviews-section {
        padding: 4rem 5%;
        background-color: #fff;
    }
    .reviews-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
        max-width: 1200px;
        margin-left: auto;
        margin-right: auto;
    }
    .review-card {
        background-color: #fff;
        border: 1px solid #eee;
        border-radius: 10px;
        padding: 1.5rem;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .review-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
    }
    .review-card .reviewer-name {
        font-weight: 600;
        color: #ff69b4;
        margin-bottom: 0.5rem;
        font-size: 1.1rem;
    }
    .review-card .review-text {
        color: #555;
        line-height: 1.6;
        font-style: italic;
    }
</style>

<section class="services" id="services" style="padding: 4rem 0; background: #fdf6fa;">
                    <h2 class="section-title">Our Services</h2>
                    <div class="services-grid">
                        <% List<Service> services = (List<Service>) request.getAttribute("services");
                                if (services != null && !services.isEmpty()) {
                                for (Service service : services) {
                                String imagePath = service.getImagePath();
                                if (imagePath == null || imagePath.trim().isEmpty()) {
                                imagePath = request.getContextPath() + "/images/default-service.jpg";
                                } else if (!imagePath.startsWith("http") && !imagePath.startsWith("/")) {
                                imagePath = request.getContextPath() + "/" + imagePath;
                                }
                                %>
                                <div class="service-card">
                                    <img src="<%= imagePath %>" alt="<%= service.getName() %>"
                                        onerror="this.src='${pageContext.request.contextPath}/images/default-service.jpg'">
                                    <div class="service-content">
                                        <h3>
                                            <%= service.getName() %>
                                        </h3>
                                        <p>
                                            <%= service.getDescription() !=null ? service.getDescription()
                                                : "Experience our professional " + service.getName() + " service." %>
                                        </p>
                                        <div class="price">
                                            <i class="fas fa-tag"></i>
                                            LKR <%= String.format("%.2f", service.getPrice()) %>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/ServiceController?action=view&id=<%= service.getId() %>"
                                            class="service-btn">
                                            <i class="fas fa-calendar-plus"></i>
                                            Book Now
                                        </a>
                                    </div>
                                </div>
                                <% } } else { %>
                                    <div class="no-services"
                                        style="text-align: center; grid-column: 1/-1; padding: 2rem;">
                                        <p>No services available at the moment. Please check back later.</p>
                                    </div>
                                    <% } %>
                    </div>
                </section>

                <section id="customer-reviews" class="reviews-section">
                    <h2 class="section-title">What Our Customers Say</h2>
                    <c:choose>
                        <c:when test="${not empty salonReviews}">
                            <div class="reviews-grid">
                                <c:forEach var="review" items="${salonReviews}">
                                    <div class="review-card">
                                        <p class="reviewer-name">${review[0]} says:</p>
                                        <p class="review-text">${review[1]}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align:center; margin-top: 1rem; font-size: 1.1rem;">No reviews yet. Be
                                the first to add one!</p>
                        </c:otherwise>
                    </c:choose>
                </section>

                <%-- footer.jspf coda automatically included --%>