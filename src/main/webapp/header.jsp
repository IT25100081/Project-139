<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <header class="header">
            <nav class="nav">
                <div class="logo">Glamour Haven</div>
                <div class="nav-links">
                    <c:choose>
                        <c:when test="${not empty sessionScope.customer}">
                            <a href="${pageContext.request.contextPath}/ServiceController?action=list">Home</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/HomeController">Home</a>
                        </c:otherwise>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}/ServiceController?action=list#services">Services</a>
                    <a href="${pageContext.request.contextPath}/HomeController#gallery">Gallery</a>
                    <a href="${pageContext.request.contextPath}/employee?action=details">Our Team</a>
                    <a href="${pageContext.request.contextPath}/HomeController#contact">Contact</a>
                    <c:if test="${not empty sessionScope.customer}">
                        <div class="user-menu">
                            <span class="welcome-text">Welcome,
                                <c:out value="${sessionScope.customer.username}" />
                            </span>
                            <a href="${pageContext.request.contextPath}/CustomerController?action=editProfile"
                                class="profile-btn">
                                <i class="fas fa-user-edit"></i> Edit Profile
                            </a>
                            <a href="${pageContext.request.contextPath}/CustomerController?action=logout"
                                class="logout-btn">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </c:if>
                    <c:if test="${empty sessionScope.customer}">
                        <div class="auth-buttons">
                            <a href="${pageContext.request.contextPath}/customer/login.jsp" class="login-btn">Login</a>
                            <a href="${pageContext.request.contextPath}/customer/register.jsp" class="signup-btn">Sign Up</a>
                        </div>
                    </c:if>
                </div>
            </nav>
        </header>