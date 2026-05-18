<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- header.jspf is automatically included via web.xml prelude --%>

<style>
    /* Prevent header/footer CSS bleed and set up base layout for About page */
    .about-header {
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1522337660859-02fbefca4702?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') center/cover;
        height: 40vh;
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
        color: white;
        margin-top: 70px; /* Offset for fixed navbar */
    }

    .about-header h1 {
        font-family: 'Playfair Display', serif;
        font-size: 3.5rem;
        margin-bottom: 1rem;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }

    .about-container {
        max-width: 1000px;
        margin: 4rem auto;
        padding: 0 2rem;
    }

    .about-grid {
        display: grid;
        grid-template-columns: 1fr;
        gap: 2rem;
        align-items: center;
        margin-bottom: 5rem;
        text-align: center;
    }

    .about-text h2 {
        font-family: 'Playfair Display', serif;
        font-size: 2.5rem;
        color: #ff69b4;
        margin-bottom: 1.5rem;
    }

    .about-text p {
        font-size: 1.1rem;
        color: #555;
        line-height: 1.8;
        margin-bottom: 1rem;
    }



    .values-section {
        background-color: #fff0fa;
        padding: 5rem 2rem;
        text-align: center;
    }

    .values-section h2 {
        font-family: 'Playfair Display', serif;
        font-size: 2.5rem;
        color: #333;
        margin-bottom: 3rem;
    }

    .values-grid {
        max-width: 1200px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
    }

    .value-card {
        background: white;
        padding: 2.5rem 2rem;
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        transition: transform 0.3s ease;
    }

    .value-card:hover {
        transform: translateY(-10px);
    }

    .value-card i {
        font-size: 2.5rem;
        color: #ff69b4;
        margin-bottom: 1.5rem;
    }

    .value-card h3 {
        font-size: 1.3rem;
        color: #333;
        margin-bottom: 1rem;
    }

    .value-card p {
        color: #666;
        line-height: 1.6;
    }

    @media (max-width: 768px) {
        .about-grid {
            grid-template-columns: 1fr;
            gap: 2rem;
        }

        .about-header h1 {
            font-size: 2.5rem;
        }
    }
</style>

<div class="about-header">
    <div data-aos="fade-up">
        <h1>About Glamour Haven</h1>
        <p style="font-size: 1.2rem;">Discover the story behind your favorite beauty destination</p>
    </div>
</div>

<main class="about-container">
    <div class="about-grid" data-aos="fade-up">
        <div class="about-text">
            <h2>Our Story</h2>
            <p>Founded with a passion for helping people discover their most confident selves, Glamour Haven has grown from a small neighborhood salon into a premier beauty destination. We believe that beauty is not just about how you look, but how you feel.</p>
            <p>Our team of expert stylists, therapists, and estheticians are dedicated to providing personalized experiences. We stay at the forefront of beauty trends and techniques to ensure you receive the best care possible.</p>
        </div>

    </div>
</main>

<section class="values-section">
    <h2 data-aos="fade-up">Why Choose Us</h2>
    <div class="values-grid">
        <div class="value-card" data-aos="fade-up" data-aos-delay="100">
            <i class="fas fa-gem"></i>
            <h3>Premium Products</h3>
            <p>We use only the highest quality, professional-grade products to ensure lasting, beautiful results for your hair and skin.</p>
        </div>
        <div class="value-card" data-aos="fade-up" data-aos-delay="200">
            <i class="fas fa-user-md"></i>
            <h3>Expert Staff</h3>
            <p>Our team consists of highly trained and certified professionals who are passionate about their craft and your satisfaction.</p>
        </div>
        <div class="value-card" data-aos="fade-up" data-aos-delay="300">
            <i class="fas fa-heart"></i>
            <h3>Personalized Care</h3>
            <p>Every client is unique. We take the time to understand your needs and tailor our services specifically for you.</p>
        </div>
    </div>
</section>

<!-- Initialize AOS animations if not already present -->
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
