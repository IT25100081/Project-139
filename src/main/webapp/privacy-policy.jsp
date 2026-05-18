<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- header.jspf is automatically included via web.xml prelude --%>

<style>
    .privacy-header {
        background-color: #ffe4e1;
        padding: 4rem 0;
        text-align: center;
        margin-top: 70px; /* Offset for fixed navbar */
    }

    .privacy-header h1 {
        font-family: 'Playfair Display', serif;
        color: #333;
        font-size: 2.5rem;
        margin-bottom: 1rem;
    }

    .privacy-header p {
        color: #666;
        font-size: 1.1rem;
    }

    .privacy-content {
        max-width: 800px;
        margin: 3rem auto 5rem;
        padding: 0 2rem;
        background: #fff;
    }

    .privacy-section {
        margin-bottom: 2.5rem;
    }

    .privacy-section h2 {
        font-family: 'Playfair Display', serif;
        color: #ff69b4;
        font-size: 1.8rem;
        margin-bottom: 1rem;
        border-bottom: 2px solid #ffe0f0;
        padding-bottom: 0.5rem;
    }

    .privacy-section p {
        color: #555;
        line-height: 1.8;
        margin-bottom: 1rem;
    }

    .privacy-section ul {
        margin-left: 2rem;
        margin-bottom: 1rem;
        color: #555;
        line-height: 1.8;
    }

    .privacy-section li {
        margin-bottom: 0.5rem;
    }
</style>

<div class="privacy-header">
    <div data-aos="fade-up">
        <h1>Privacy Policy</h1>
        <p>Last updated: <%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("MMMM dd, yyyy")) %></p>
    </div>
</div>

<main class="privacy-content" data-aos="fade-up" data-aos-delay="100">
    <div class="privacy-section">
        <h2>1. Information We Collect</h2>
        <p>At Glamour Haven Beauty Salon, we collect information that you provide directly to us when you book an appointment, create an account, or communicate with us. This may include:</p>
        <ul>
            <li>Name and contact information (email address, phone number)</li>
            <li>Booking history and service preferences</li>
            <li>Account login credentials</li>
            <li>Reviews and feedback you provide</li>
        </ul>
    </div>

    <div class="privacy-section">
        <h2>2. How We Use Your Information</h2>
        <p>We use the information we collect to provide, maintain, and improve our services, including to:</p>
        <ul>
            <li>Process your bookings and appointments</li>
            <li>Send you appointment reminders and confirmations</li>
            <li>Respond to your comments, questions, and requests</li>
            <li>Communicate with you about new services, promotions, and salon updates</li>
            <li>Improve the functionality and user experience of our website</li>
        </ul>
    </div>

    <div class="privacy-section">
        <h2>3. Data Security</h2>
        <p>We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction. Your data is stored securely and accessed only by authorized personnel.</p>
    </div>

    <div class="privacy-section">
        <h2>4. Sharing of Information</h2>
        <p>We do not sell, trade, or rent your personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners and trusted affiliates for the purposes outlined above.</p>
    </div>

    <div class="privacy-section">
        <h2>5. Your Choices</h2>
        <p>You may update, correct, or delete your account information at any time by logging into your online account or contacting us directly. If you wish to opt-out of promotional communications, you may do so by following the instructions provided in those communications.</p>
    </div>

    <div class="privacy-section">
        <h2>6. Contact Us</h2>
        <p>If you have any questions about this Privacy Policy, please contact us at:</p>
        <p>
            <strong>Email:</strong> info@glamourhaven.com<br>
            <strong>Phone:</strong> +94 11 234 5678<br>
            <strong>Address:</strong> 123 Beauty Street, Colombo, Sri Lanka
        </p>
    </div>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    if (typeof AOS !== 'undefined') {
        AOS.init({
            duration: 800,
            once: true
        });
    }
</script>

<%-- footer.jspf is automatically included via web.xml coda --%>
