<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.salon.service.Service" %>
        <%@ page import="com.salon.employee.Employee" %>
            <%@ page import="java.util.List" %>
                <%-- taglib 'c' provided by header.jspf prelude --%>

                    <style>
                        .service-details {
                            max-width: 800px;
                            margin: 0 auto;
                            padding: 20px;
                        }

                        .service-image {
                            width: 100%;
                            max-height: 400px;
                            object-fit: cover;
                            border-radius: 8px;
                            margin-bottom: 20px;
                        }

                        .service-info {
                            background: white;
                            padding: 20px;
                            border-radius: 8px;
                            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                        }

                        .service-name {
                            font-size: 2em;
                            color: #2c3e50;
                            margin-bottom: 10px;
                        }

                        .service-price {
                            font-size: 1.5em;
                            color: #3498db;
                            margin-bottom: 20px;
                        }

                        .service-description {
                            font-size: 1.1em;
                            line-height: 1.6;
                            color: #34495e;
                            margin-bottom: 30px;
                        }

                        .booking-form {
                            margin-top: 30px;
                            padding: 20px;
                            background: #f8f9fa;
                            border-radius: 8px;
                        }

                        .form-group {
                            margin-bottom: 15px;
                        }

                        .form-group label {
                            display: block;
                            margin-bottom: 5px;
                            color: #2c3e50;
                        }

                        .form-group input,
                        .form-group select {
                            width: 100%;
                            padding: 8px;
                            border: 1px solid #ddd;
                            border-radius: 4px;
                            font-size: 1em;
                        }

                        .book-button {
                            background-color: #2ecc71;
                            color: white;
                            padding: 12px 24px;
                            border: none;
                            border-radius: 4px;
                            cursor: pointer;
                            font-size: 1.1em;
                            width: 100%;
                        }

                        .book-button:hover {
                            background-color: #27ae60;
                        }

                        .back-link {
                            display: inline-block;
                            margin-top: 20px;
                            color: #3498db;
                            text-decoration: none;
                        }

                        .back-link:hover {
                            text-decoration: underline;
                        }
                    </style>
                    <div class="container">
                        <div class="service-details">
                            <% Service service=(Service) request.getAttribute("service"); %>
                                <img src="<%= service.getImagePath() %>" alt="<%= service.getName() %>"
                                    class="service-image">

                                <div class="service-info">
                                    <h1 class="service-name">
                                        <%= service.getName() %>
                                    </h1>
                                    <div class="service-price">LKR <%= String.format("%.2f", service.getPrice()) %>
                                    </div>
                                    <div class="service-description">
                                        <%= service.getDescription() %>
                                    </div>

                                    <div class="booking-form">
                                        <h2>Book this Service</h2>
                                        <form action="${pageContext.request.contextPath}/BookingController" method="post">
                                            <input type="hidden" name="action" value="book">
                                            <input type="hidden" name="serviceId" value="<%= service.getId() %>">

                                            <div class="form-group">
                                                <label for="date">Preferred Date:</label>
                                                <input type="date" id="date" name="date" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="time">Preferred Time:</label>
                                                <input type="time" id="time" name="time" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="employee">Select Employee:</label>
                                                <select id="employee" name="employeeId" required>
                                                    <option value="">Select an employee</option>
                                                    <% List<Employee> employees = (List<Employee>)
                                                            request.getAttribute("employees");
                                                            if (employees != null) {
                                                            for (Employee employee : employees) {
                                                            %>
                                                            <option value="<%= employee.getId() %>">
                                                                <%= employee.getName() %> - <%=
                                                                        employee.getSpecialization() %>
                                                            </option>
                                                            <% } } %>
                                                </select>
                                            </div>

                                            <button type="submit" class="book-button">Book Now</button>
                                        </form>
                                    </div>
                                </div>

                                <a href="${pageContext.request.contextPath}/ServiceController?action=list" class="back-link">← Back to Services</a>
                        </div>
                    </div>
                    <%-- footer.jspf coda automatically included --%>