 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .footer {
        background: linear-gradient(135deg, #ff69b4 0%, #ffc0cb 100%);
        padding: 4rem 0 2rem;
        position: relative;
        width: 100%;
        box-shadow: 0 -2px 20px rgba(255, 105, 180, 0.15);
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

    @media (max-width: 768px) {
        .footer {
            padding: 3rem 0 1rem;
        }

        .footer-content {
            gap: 2rem;
            padding: 0 1rem;
        }

        .footer-section {
            text-align: center;
        }

        .footer-section h3::after {
            left: 50%;
            transform: translateX(-50%);
        }

        .footer-links a {
            justify-content: center;
        }

        .footer-social {
            justify-content: center;
        }
    }
</style>

<footer class="footer">
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
                <a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-chevron-right"></i> Home</a>
                <a href="${pageContext.request.contextPath}/about.jsp"><i class="fas fa-chevron-right"></i> About Us</a>
                <a href="${pageContext.request.contextPath}/ServiceController?action=list"><i class="fas fa-chevron-right"></i> Services</a>
                <a href="#contact"><i class="fas fa-chevron-right"></i> Contact</a>
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
        <p>&copy; <%= java.time.Year.now() %> Glamour Haven Beauty Salon. All rights reserved.</p>
    </div>
</footer> 