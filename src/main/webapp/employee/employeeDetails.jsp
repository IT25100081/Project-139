<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.salon.employee.Employee" %>
            <%-- taglib 'c' provided by header.jspf prelude --%>


                <style>
                    .container {
                        max-width: 1000px;
                        margin: 100px auto 40px auto;
                        padding: 2rem;
                        background: #fff;
                        border-radius: 18px;
                        box-shadow: 0 8px 32px rgba(255, 105, 180, 0.10);
                    }

                    .section-title {
                        text-align: center;
                        font-family: 'Playfair Display', serif;
                        font-size: 2.2rem;
                        margin-bottom: 2.5rem;
                        color: #b3005e;
                    }

                    .employee-list {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                        gap: 2rem;
                    }

                    .employee-card {
                        background: #fff0fa;
                        border-radius: 12px;
                        box-shadow: 0 4px 16px rgba(255, 105, 180, 0.08);
                        padding: 2rem 1.5rem;
                        text-align: center;
                        transition: transform 0.2s, box-shadow 0.2s;
                    }

                    .employee-card:hover {
                        transform: translateY(-5px) scale(1.03);
                        box-shadow: 0 8px 24px rgba(255, 105, 180, 0.15);
                    }

                    .employee-photo {
                        width: 110px;
                        height: 110px;
                        object-fit: cover;
                        border-radius: 50%;
                        margin-bottom: 1rem;
                        border: 3px solid #ff69b4;
                    }

                    .employee-name {
                        font-size: 1.3rem;
                        font-weight: 600;
                        color: #b3005e;
                        margin-bottom: 0.3rem;
                    }

                    .employee-role {
                        color: #ff69b4;
                        font-weight: 500;
                        margin-bottom: 0.7rem;
                    }

                    .employee-contact {
                        font-size: 0.97rem;
                        color: #555;
                        margin-bottom: 0.7rem;
                    }

                    .employee-bio {
                        font-size: 0.95rem;
                        color: #666;
                    }

                    .default-photo {
                        width: 110px;
                        height: 110px;
                        background-color: #ddd;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin: 0 auto 1rem auto;
                        border: 3px solid #ff69b4;
                    }

                    .default-photo i {
                        font-size: 40px;
                        color: #fff;
                    }
                </style>

                <div class="container">
                    <h2 class="section-title">Our Team</h2>
                    <div class="employee-list">
                        <% List<Employee> employees = (List<Employee>) request.getAttribute("employees");
                                if (employees != null && !employees.isEmpty()) {
                                for (Employee employee : employees) {
                                %>
                                <div class="employee-card">
                                    <% if (employee.getImagePath() !=null && !employee.getImagePath().isEmpty()) { %>
                                        <img src="${pageContext.request.contextPath}/<%= employee.getImagePath() %>"
                                            alt="<%= employee.getName() %>" class="employee-photo">
                                        <% } else { %>
                                            <div class="default-photo">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <% } %>
                                                <div class="employee-name">
                                                    <%= employee.getName() %>
                                                </div>
                                                <div class="employee-role">
                                                    <%= employee.getSpecialization() %>
                                                </div>
                                                <div class="employee-contact">
                                                    <i class="fas fa-envelope"></i>
                                                    <%= employee.getName().toLowerCase().replace(" ", " .") %>
                                                        @glamourhaven.com<br>
                                                        <i class="fas fa-phone"></i> +94 77 XXX XXXX
                                                </div>
                                                <div class="employee-bio">
                                                    <%= employee.getName() %> is a skilled professional specializing in
                                                        <%= employee.getSpecialization().toLowerCase() %>.
                                                            With dedication and expertise, they ensure every client
                                                            receives exceptional service.
                                                </div>
                                </div>
                                <% } } else { %>
                                    <div style="text-align: center; width: 100%; padding: 2rem;">
                                        <p>No team members found. Please check back later.</p>
                                    </div>
                                    <% } %>
                    </div>
                </div>

                <script>
                    // Redirect to controller if accessed directly
                    if (window.location.pathname.endsWith('/employee/employeeDetails.jsp')) {
                        window.location.href = '${pageContext.request.contextPath}/employee?action=details';
                    }
                </script>
                <%-- footer.jspf coda automatically included --%>