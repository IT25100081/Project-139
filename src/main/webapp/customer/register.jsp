<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%-- taglib 'c' provided by header.jspf prelude --%>

        <style>
            .auth-page-wrapper {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #fce8f3 0%, #ffffff 100%);
                min-height: calc(100vh - 70px);
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }

            .register-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                width: 100%;
                max-width: 1000px;
                display: flex;
                min-height: 600px;
            }

            .register-image {
                flex: 1;
                background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url('https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') center/cover;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }

            .register-image-text {
                color: white;
                text-align: center;
                z-index: 1;
            }

            .register-image-text h2 {
                font-family: 'Playfair Display', serif;
                font-size: 2.5rem;
                margin-bottom: 1rem;
            }

            .register-form-container {
                flex: 1;
                padding: 3rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .register-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .register-header h1 {
                font-family: 'Playfair Display', serif;
                color: #333;
                font-size: 2rem;
                margin-bottom: 0.5rem;
            }

            .register-header p {
                color: #666;
                font-size: 0.9rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
                position: relative;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .form-group i {
                position: static;
                color: #ff69b4;
                font-size: 1.1rem;
                width: 20px;
                text-align: center;
            }

            .form-input {
                flex: 1;
                padding: 15px 20px;
                border: none;
                border-radius: 30px;
                font-size: 1rem;
                transition: all 0.3s ease;
                font-family: 'Poppins', sans-serif;
                background: #f8f9ff;
            }

            .form-input:focus {
                outline: none;
                box-shadow: 0 0 0 2px #ff69b4;
            }

            .form-input::placeholder {
                color: #999;
            }

            .register-button {
                width: 100%;
                padding: 15px;
                background: #ff69b4;
                color: white;
                border: none;
                border-radius: 30px;
                font-size: 1rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-bottom: 1.5rem;
            }

            .register-button:hover {
                background: #ff4da6;
                transform: translateY(-2px);
            }

            .login-link {
                text-align: center;
                color: #666;
            }

            .login-link a {
                color: #ff69b4;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .login-link a:hover {
                color: #ff4da6;
            }

            .error-message {
                color: #ff4d4d;
                text-align: center;
                margin-bottom: 1rem;
                font-size: 0.9rem;
            }

            @media (max-width: 768px) {
                .register-container {
                    flex-direction: column;
                    max-width: 400px;
                }

                .register-image {
                    display: none;
                }

                .register-form-container {
                    padding: 2rem;
                }
            }
        </style>

        <div class="auth-page-wrapper">
            <div class="register-container">
                <div class="register-image">
                    <div class="register-image-text">
                        <h2 style="color: white; font-size: 2.8rem; margin-bottom: 1rem;">Join Our Beauty Community</h2>
                        <p>Start your journey to radiant beauty today</p>
                    </div>
                </div>
                <div class="register-form-container">
                    <div class="register-header">
                        <h1>Create Your Account</h1>
                        <p>Please fill in your details to register</p>
                    </div>
                    <% if (request.getAttribute("error") !=null) { %>
                        <div class="error-message">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>
                            <form action="${pageContext.request.contextPath}/CustomerController" method="post">
                                <input type="hidden" name="action" value="register">
                                <div class="form-group">
                                    <i class="fas fa-user"></i>
                                    <input type="text" name="username" class="form-input" placeholder="Username"
                                        required>
                                </div>
                                <div class="form-group">
                                    <i class="fas fa-envelope"></i>
                                    <input type="email" name="email" class="form-input" placeholder="Email" required>
                                </div>
                                <div class="form-group">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" name="password" class="form-input" placeholder="Password"
                                        required>
                                </div>
                                <div class="form-group">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" name="confirm_password" class="form-input"
                                        placeholder="Confirm Password" required>
                                </div>
                                <button type="submit" class="register-button">Create Account</button>
                            </form>
                            <div class="login-link">
                                Already have an account? <a href="${pageContext.request.contextPath}/customer/login.jsp">Login</a>
                            </div>
                </div>
            </div>
        </div>
        <%-- footer.jspf coda automatically included --%>