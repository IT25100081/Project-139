<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.salon.service.Service" %>
        <%@ page import="java.util.List" %>
            <%-- taglib 'c' provided by header.jspf prelude --%>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Poppins', sans-serif;
                        line-height: 1.6;
                        color: #333;
                        padding-top: 70px;
                    }

                    .header {
                        background-color: #fff;
                        position: fixed;
                        width: 100%;
                        top: 0;
                        left: 0;
                        z-index: 1000;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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

                    .auth-buttons {
                        display: flex;
                        gap: 1rem;
                        margin-left: 2rem;
                    }

                    .auth-buttons a {
                        padding: 0.5rem 1.5rem;
                        border-radius: 25px;
                        transition: all 0.3s ease;
                    }

                    .login-btn {
                        border: 2px solid #ff69b4;
                        color: #ff69b4 !important;
                    }

                    .login-btn:hover {
                        background-color: #ff69b4;
                        color: white !important;
                    }

                    .signup-btn {
                        background-color: #ff69b4;
                        color: white !important;
                    }

                    .signup-btn:hover {
                        background-color: #ff4da6;
                        transform: translateY(-2px);
                    }

                    .hero {
                        height: 100vh;
                        background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url('https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80');
                        background-size: cover;
                        background-position: center;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        text-align: center;
                        color: #fff;
                    }

                    .hero-content {
                        max-width: 800px;
                        padding: 2rem;
                    }

                    .hero-content h1 {
                        font-family: 'Playfair Display', serif;
                        font-size: 3.5rem;
                        margin-bottom: 1rem;
                    }

                    .hero-content p {
                        font-size: 1.2rem;
                        margin-bottom: 2rem;
                    }

                    .btn {
                        display: inline-block;
                        padding: 1rem 2rem;
                        background-color: #ff69b4;
                        color: #fff;
                        text-decoration: none;
                        border-radius: 30px;
                        transition: transform 0.3s, background-color 0.3s;
                    }

                    .btn:hover {
                        transform: translateY(-3px);
                        background-color: #ff4da6;
                    }

                    .services {
                        padding: 5rem 5%;
                        background-color: #f9f9f9;
                        position: relative;
                        overflow: hidden;
                    }

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
                        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                        gap: 2.5rem;
                        padding: 1rem;
                        min-height: 200px;
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
                        height: 200px;
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
                        flex: 1;
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

                    .service-card .price i {
                        font-size: 1rem;
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
                        gap: 0.5rem;
                        font-weight: 500;
                        margin-top: auto;
                        align-self: flex-start;
                    }

                    .service-btn:hover {
                        background-color: #ff4da6;
                        transform: translateY(-2px);
                    }

                    .service-btn i {
                        font-size: 0.9rem;
                    }

                    .gallery {
                        padding: 5rem 5%;
                    }

                    .gallery-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 1rem;
                    }

                    .gallery-item {
                        position: relative;
                        overflow: hidden;
                        border-radius: 10px;
                    }

                    .gallery-item img {
                        width: 100%;
                        height: 300px;
                        object-fit: cover;
                        transition: transform 0.3s;
                    }

                    .gallery-item:hover img {
                        transform: scale(1.1);
                    }

                    .contact {
                        padding: 5rem 5%;
                        background: linear-gradient(135deg, #ffe0f0 0%, #fff0fa 100%);
                        text-align: center;
                    }

                    .contact-card {
                        max-width: 600px;
                        margin: 0 auto;
                        background-color: #fff;
                        border-radius: 18px;
                        overflow: hidden;
                        box-shadow: 0 8px 32px rgba(255, 105, 180, 0.15);
                        padding: 2.5rem 2rem 2rem 2rem;
                        position: relative;
                    }

                    .contact-icons {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        gap: 1.5rem;
                        margin-bottom: 1.5rem;
                    }

                    .contact-icon {
                        width: 48px;
                        height: 48px;
                        border-radius: 50%;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        font-size: 1.5rem;
                        box-shadow: 0 2px 8px rgba(255, 105, 180, 0.15);
                        color: #fff;
                        transition: transform 0.2s, box-shadow 0.2s;
                    }

                    .contact-icon:hover {
                        transform: scale(1.1) rotate(-8deg);
                        box-shadow: 0 4px 16px rgba(255, 105, 180, 0.25);
                    }

                    .contact-info-modern {
                        text-align: center;
                    }

                    .contact-info-modern p {
                        font-size: 1.1rem;
                        margin: 0.7rem 0;
                        color: #b3005e;
                        letter-spacing: 0.01em;
                    }

                    .contact-label {
                        font-weight: 600;
                        color: #ff69b4;
                        margin-right: 0.5rem;
                    }



                    .user-menu {
                        display: flex;
                        align-items: center;
                        gap: 1.5rem;
                        margin-left: 2rem;
                    }

                    .welcome-text {
                        color: #333;
                        font-weight: 500;
                    }

                    .dashboard-btn,
                    .logout-btn {
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        padding: 0.5rem 1rem;
                        border-radius: 25px;
                        text-decoration: none;
                        transition: all 0.3s ease;
                    }

                    .dashboard-btn {
                        background-color: #ff69b4;
                        color: white;
                    }

                    .dashboard-btn:hover {
                        background-color: #ff4da6;
                        transform: translateY(-2px);
                    }


                    @media (max-width: 768px) {
                        .nav-links {
                            display: none;
                        }

                        .hero-content h1 {
                            font-size: 2.5rem;
                        }

                        .auth-buttons {
                            position: fixed;
                            bottom: 20px;
                            left: 50%;
                            transform: translateX(-50%);
                            background-color: white;
                            padding: 1rem;
                            border-radius: 30px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                            margin: 0;
                            z-index: 1000;
                        }

                        .user-menu {
                            position: fixed;
                            bottom: 20px;
                            left: 50%;
                            transform: translateX(-50%);
                            background-color: white;
                            padding: 1rem;
                            border-radius: 30px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                            margin: 0;
                            z-index: 1000;
                        }
                    }

                    /* Styles for Review Cards */
                    .reviews-section {
                        padding: 4rem 5%;
                        background-color: #fff;
                        /* Or a light contrasting color like #fdf6fa */
                    }

                    .reviews-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 2rem;
                        margin-top: 2rem;
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
                        font-size: 0.95rem;
                        color: #555;
                        line-height: 1.6;
                    }

                    /* End of Styles for Review Cards */
                </style>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const serviceImages = document.querySelectorAll('.service-card img');
                        serviceImages.forEach(img => {
                            img.loading = 'lazy';
                            img.style.backgroundColor = '#f5f5f5';
                        });
                    });
                </script>


                <c:if test="${empty sessionScope.customer}">
                    <section class="hero" id="home">
                        <div class="hero-content" data-aos="fade-up">
                            <h1>Welcome to Glamour Haven</h1>
                            <p>Experience luxury beauty treatments in a serene environment</p>
                            <a href="${pageContext.request.contextPath}/ServiceController?action=list" class="btn">Book Appointment</a>
                        </div>
                    </section>
                </c:if>

                <section class="services" id="services">
                    <h2 class="section-title" data-aos="fade-up">Our Services</h2>
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
                                <div class="service-card" data-aos="fade-up" data-aos-delay="100">
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

                <section id="gallery" class="gallery" data-aos="fade-up">
                    <h2 class="section-title">Our Gallery</h2>
                    <div class="gallery-grid">
                        <div class="gallery-item" data-aos="zoom-in"><img
                                src="${pageContext.request.contextPath}/images/barber-man-apron.jpg"
                                alt="Gallery Image 1"></div>
                        <div class="gallery-item" data-aos="zoom-in" data-aos-delay="100"><img
                                src="${pageContext.request.contextPath}/images/woman-sari.jpg" alt="Gallery Image 2">
                        </div>
                        <div class="gallery-item" data-aos="zoom-in" data-aos-delay="200"><img
                                src="${pageContext.request.contextPath}/images/indian-woman-sari.jpg"
                                alt="Gallery Image 3"></div>
                        <div class="gallery-item" data-aos="zoom-in" data-aos-delay="300"><img
                                src="${pageContext.request.contextPath}/images/model-career.jpg" alt="Gallery Image 4">
                        </div>
                        <div class="gallery-item" data-aos="zoom-in" data-aos-delay="400"><img
                                src="${pageContext.request.contextPath}/images/albino-woman.jpg" alt="Gallery Image 5">
                        </div>
                        <div class="gallery-item" data-aos="zoom-in" data-aos-delay="500"><img
                                src="${pageContext.request.contextPath}/images/barber-man-confident.jpg"
                                alt="Gallery Image 6"></div>
                    </div>
                </section>

                <section id="customer-reviews" class="reviews-section" data-aos="fade-up">
                    <h2 class="section-title">What Our Customers Say</h2>
                    <c:choose>
                        <c:when test="${not empty salonReviews}">
                            <div class="reviews-grid">
                                <c:forEach var="review" items="${salonReviews}">
                                    <div class="review-card" data-aos="fade-up" data-aos-delay="100">
                                        <p class="reviewer-name">
                                            <c:out value="${review[0]}" /> says:
                                        </p>
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

                <section class="contact" id="contact">
                    <h2 class="section-title" data-aos="fade-up">Contact Us</h2>
                    <div class="contact-card">
                        <div class="contact-icons">
                            <div class="contact-icon">
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                            <div class="contact-icon">
                                <i class="fas fa-phone"></i>
                            </div>
                            <div class="contact-icon">
                                <i class="fas fa-envelope"></i>
                            </div>
                        </div>
                        <div class="contact-info-modern">
                            <p><span class="contact-label">Address:</span> 123 Main Street, Colombo 02</p>
                            <p><span class="contact-label">Phone:</span> +94 11 234 5678</p>
                            <p><span class="contact-label">Email:</span> info@glamourhaven.com</p>
                        </div>
                    </div>
                </section>

                <%-- footer.jspf coda automatically included --%>