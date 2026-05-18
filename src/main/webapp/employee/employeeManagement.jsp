<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.salon.employee.Employee, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management - Glamour Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #f8f9ff;
            min-height: 100vh;
            display: flex;
        }

        .sidebar {
            width: 280px;
            background: white;
            padding: 2rem;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            height: 100vh;
            transition: all 0.3s ease;
        }

        .sidebar-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .sidebar-header h1 {
            font-family: 'Playfair Display', serif;
            color: #333;
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .nav-links {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 1rem;
            color: #666;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: #fce8f3;
            color: #ff69b4;
        }

        .nav-link.active {
            background: #ff69b4;
            color: white;
        }

        .nav-link i {
            margin-right: 1rem;
            width: 20px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h2 {
            font-family: 'Playfair Display', serif;
            color: #333;
            font-size: 2rem;
        }

        .add-employee-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .add-employee-card h3 {
            font-family: 'Playfair Display', serif;
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-label {
            color: #666;
            font-size: 0.9rem;
        }

        .form-input {
            padding: 0.8rem 1rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: #ff69b4;
            box-shadow: 0 0 0 2px rgba(255, 105, 180, 0.1);
        }

        .add-button {
            background: #ff69b4;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.8rem 2rem;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            width: fit-content;
        }

        .add-button:hover {
            background: #ff4da6;
            transform: translateY(-2px);
        }

        .search-bar {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .search-input {
            flex: 1;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 10px;
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            font-family: 'Poppins', sans-serif;
        }

        .search-input:focus {
            outline: none;
            box-shadow: 0 0 0 2px #ff69b4;
        }

        .employees-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .employees-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .employees-table th {
            background: #ff69b4;
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 500;
        }

        .employees-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        .employees-table tr:last-child td {
            border-bottom: none;
        }

        .employees-table tr:hover {
            background: #fce8f3;
        }

        .action-cell {
            display: flex;
            gap: 1rem;
        }

        .edit-form {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .update-button, .delete-button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .update-button {
            background: #ff69b4;
            color: white;
        }

        .update-button:hover {
            background: #ff4da6;
        }

        .delete-button {
            background: #dc3545;
            color: white;
        }

        .delete-button:hover {
            background: #c82333;
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            background: #ff69b4;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            margin-top: 2rem;
        }

        .back-button:hover {
            background: #ff4da6;
            transform: translateY(-2px);
        }

        .back-button i {
            margin-right: 0.5rem;
        }

        .logout-button {
            position: absolute;
            bottom: 2rem;
            width: calc(100% - 4rem);
            padding: 1rem;
            background: #ff69b4;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
        }

        .logout-button:hover {
            background: #ff4da6;
            color: white;
            transform: translateY(-2px);
        }

        .logout-button i {
            margin-right: 0.5rem;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
                padding: 1rem;
            }

            .sidebar-header h1,
            .nav-link span {
                display: none;
            }

            .nav-link {
                justify-content: center;
                padding: 0.8rem;
            }

            .nav-link i {
                margin: 0;
            }

            .main-content {
                margin-left: 70px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .employees-table {
                overflow-x: auto;
            }

            .action-cell {
                flex-direction: column;
            }

            .edit-form {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <nav class="sidebar">
        <div class="sidebar-header">
            <h1>Admin Panel</h1>
        </div>
        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/adminDashboard.jsp" class="nav-link">
                    <i class="fas fa-chart-line"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/BookingController?action=manage" class="nav-link">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Bookings</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/CustomerController?action=manage" class="nav-link">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/EmployeeController?action=manage" class="nav-link active">
                    <i class="fas fa-user-tie"></i>
                    <span>Employees</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/ServiceController?action=manage" class="nav-link">
                    <i class="fas fa-spa"></i>
                    <span>Services</span>
                </a>
            </li>
        </ul>
        <a href="${pageContext.request.contextPath}/CustomerController?action=logout" class="logout-button">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </nav>

    <main class="main-content">
        <div class="page-header">
            <h2>Employee Management</h2>
        </div>

        <div class="add-employee-card">
            <h3>Add New Employee</h3>
            <form action="employee" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Name</label>
                        <input type="text" name="name" class="form-input" placeholder="Enter employee name" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Specialization</label>
                        <input type="text" name="specialization" class="form-input" placeholder="Enter specialization" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Profile Image</label>
                        <input type="file" name="image" class="form-input" accept="image/*">
                    </div>
                </div>
                <button type="submit" class="add-button">
                    <i class="fas fa-plus"></i>
                    Add Employee
                </button>
            </form>
        </div>

        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Search employees..." id="searchInput" onkeyup="searchTable()">
        </div>

        <div class="employees-table">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Specialization</th>
                    <th>Actions</th>
                </tr>
                <%
                    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
                    if (employees != null) {
                        for (Employee employee : employees) {
                %>
                <tr>
                    <td><%= employee.getId() %></td>
                    <td><%= employee.getName() %></td>
                    <td><%= employee.getSpecialization() %></td>
                    <td class="action-cell">
                        <form action="employee" method="post" enctype="multipart/form-data" class="edit-form">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<%= employee.getId() %>">
                            <input type="text" name="name" value="<%= employee.getName() %>" class="form-input" placeholder="Name">
                            <input type="text" name="specialization" value="<%= employee.getSpecialization() %>" class="form-input" placeholder="Specialization">
                            <input type="file" name="image" class="form-input" accept="image/*" style="max-width: 150px;">
                            <button type="submit" class="update-button">
                                <i class="fas fa-save"></i>
                                Update
                            </button>
                        </form>
                        <form action="employee" method="post" onsubmit="return confirm('Are you sure you want to delete this employee?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= employee.getId() %>">
                            <button type="submit" class="delete-button">
                                <i class="fas fa-trash-alt"></i>
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <% 
                        }
                    }
                %>
            </table>
        </div>

        <a href="${pageContext.request.contextPath}/admin/adminDashboard.jsp" class="back-button">
            <i class="fas fa-arrow-left"></i>
            Back to Dashboard
        </a>
    </main>

    <script>
        function searchTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.querySelector('.employees-table table');
            const rows = table.getElementsByTagName('tr');

            for (let i = 1; i < rows.length; i++) {
                const row = rows[i];
                const cells = row.getElementsByTagName('td');
                let found = false;

                for (let j = 0; j < cells.length - 1; j++) {
                    const cell = cells[j];
                    if (cell) {
                        const text = cell.textContent || cell.innerText;
                        if (text.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }

                row.style.display = found ? '' : 'none';
            }
        }
    </script>
</body>
</html>
