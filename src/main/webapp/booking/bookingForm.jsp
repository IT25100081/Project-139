<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.salon.service.Service, com.salon.employee.Employee, java.util.List" %>
<html>
<head>
    <title>Book Service - Beauty Salon</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <h2>Book Service: <%= ((Service) request.getAttribute("service")).getName() %></h2>
    <form action="${pageContext.request.contextPath}/BookingController" method="post">
        <input type="hidden" name="action" value="addBooking">
        <input type="hidden" name="serviceId" value="<%= ((Service) request.getAttribute("service")).getId() %>">
        <input type="hidden" name="customerId" value="<%= request.getAttribute("customerId") %>">
        <p>Time Slot: <input type="datetime-local" name="timeSlot" required></p>
        <p>Employee:
            <select name="employeeId" required>
                <%
                    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
                    if (employees != null) {
                        for (Employee employee : employees) {
                %>
                <option value="<%= employee.getId() %>"><%= employee.getName() %> (<%= employee.getSpecialization() %>)</option>
                <% 
                        }
                    }
                %>
            </select>
        </p>
        <p><input type="submit" value="Book"></p>
    </form>
    <p><a href="${pageContext.request.contextPath}/ServiceController?action=list">Back to Services</a></p>
</div>
</body>
</html>