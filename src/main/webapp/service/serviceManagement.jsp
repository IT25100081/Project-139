<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.salon.service.Service" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Management - Glamour Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
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

        /* ===== Sidebar (identical to Employee Management) ===== */
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

        /* ===== Main Content ===== */
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

        /* ===== Add Service Card ===== */
        .add-service-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .add-service-card h3 {
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
            font-size: 0.9rem;
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

        /* ===== Search Bar ===== */
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

        /* ===== Services Table ===== */
        .services-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .services-table table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .services-table th {
            background: #ff69b4;
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 500;
            white-space: nowrap;
        }

        /* Column widths */
        .services-table th:nth-child(1),
        .services-table td:nth-child(1) { width: 50px; }    /* ID */
        .services-table th:nth-child(2),
        .services-table td:nth-child(2) { width: 18%; }     /* Name */
        .services-table th:nth-child(3),
        .services-table td:nth-child(3) { width: 10%; }     /* Price */
        .services-table th:nth-child(4),
        .services-table td:nth-child(4) { }                  /* Description - takes remaining */
        .services-table th:nth-child(5),
        .services-table td:nth-child(5) { width: 220px; }   /* Actions */

        .services-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .services-table tr:last-child td {
            border-bottom: none;
        }

        .services-table tr:hover {
            background: #fce8f3;
        }

        .desc-text {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            font-size: 0.85rem;
            color: #666;
            line-height: 1.5;
        }

        /* ===== Action Buttons ===== */
        .action-cell {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .edit-button, .delete-button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
            white-space: nowrap;
        }

        .edit-button {
            background: #ff69b4;
            color: white;
        }

        .edit-button:hover {
            background: #ff4da6;
        }

        .delete-button {
            background: #dc3545;
            color: white;
        }

        .delete-button:hover {
            background: #c82333;
        }

        /* ===== Edit Modal ===== */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            width: 90%;
            max-width: 550px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            animation: modalSlideIn 0.3s ease;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal h3 {
            font-family: 'Playfair Display', serif;
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
        }

        .modal .form-group {
            margin-bottom: 1rem;
        }

        .modal .form-input {
            width: 100%;
        }

        .modal-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            justify-content: flex-end;
        }

        .modal-cancel {
            padding: 0.8rem 1.5rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: white;
            color: #666;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .modal-cancel:hover {
            background: #f5f5f5;
        }

        .modal-save {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            background: #ff69b4;
            color: white;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .modal-save:hover {
            background: #ff4da6;
            transform: translateY(-2px);
        }

        /* ===== Back Button ===== */
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

        /* ===== Responsive ===== */
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

            .services-table {
                overflow-x: auto;
            }

            .services-table table {
                table-layout: auto;
                min-width: 600px;
            }

            .action-cell {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar (identical to Employee Management) -->
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
                <a href="${pageContext.request.contextPath}/EmployeeController?action=manage" class="nav-link">
                    <i class="fas fa-user-tie"></i>
                    <span>Employees</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/ServiceController?action=manage" class="nav-link active">
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

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-header">
            <h2>Service Management</h2>
        </div>

        <!-- Add New Service Form -->
        <div class="add-service-card">
            <h3>Add New Service</h3>
            <form action="${pageContext.request.contextPath}/ServiceController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="addService">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Service Name</label>
                        <input type="text" name="name" class="form-input" placeholder="Enter service name" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Price (LKR)</label>
                        <input type="number" name="price" class="form-input" placeholder="Enter price" step="0.01" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <input type="text" name="description" class="form-input" placeholder="Enter description">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Service Image</label>
                        <input type="file" name="image" class="form-input" accept="image/*">
                    </div>
                </div>
                <button type="submit" class="add-button">
                    <i class="fas fa-plus"></i>
                    Add Service
                </button>
            </form>
        </div>

        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Search services..." id="searchInput" onkeyup="searchTable()">
        </div>

        <!-- Services Table -->
        <div class="services-table">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price (LKR)</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
                <%
                    List<Service> services = (List<Service>) request.getAttribute("services");
                    if (services != null) {
                        for (Service service : services) {
                %>
                <tr>
                    <td><%= service.getId() %></td>
                    <td><%= service.getName() %></td>
                    <td><%= String.format("%.2f", service.getPrice()) %></td>
                    <td><div class="desc-text"><%= service.getDescription() != null ? service.getDescription() : "" %></div></td>
                    <td>
                        <div class="action-cell">
                            <button type="button" class="edit-button" onclick="openEditModal(<%= service.getId() %>, '<%= service.getName().replace("'", "\\'") %>', <%= service.getPrice() %>, '<%= service.getDescription() != null ? service.getDescription().replace("'", "\\'") : "" %>')">
                                <i class="fas fa-edit"></i>
                                Edit
                            </button>
                            <form action="${pageContext.request.contextPath}/ServiceController" method="post" style="margin:0;" onsubmit="return confirm('Are you sure you want to delete this service?');">
                                <input type="hidden" name="action" value="deleteService">
                                <input type="hidden" name="id" value="<%= service.getId() %>">
                                <button type="submit" class="delete-button">
                                    <i class="fas fa-trash-alt"></i>
                                    Delete
                                </button>
                            </form>
                        </div>
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

    <!-- Edit Service Modal -->
    <div class="modal-overlay" id="editModal">
        <div class="modal">
            <h3>Edit Service</h3>
            <form action="${pageContext.request.contextPath}/ServiceController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="updateService">
                <input type="hidden" name="id" id="editId">
                <div class="form-group">
                    <label class="form-label">Service Name</label>
                    <input type="text" name="name" id="editName" class="form-input" placeholder="Enter service name" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Price (LKR)</label>
                    <input type="number" name="price" id="editPrice" class="form-input" placeholder="Enter price" step="0.01" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Description</label>
                    <input type="text" name="description" id="editDescription" class="form-input" placeholder="Enter description">
                </div>
                <div class="form-group">
                    <label class="form-label">Update Image (optional)</label>
                    <input type="file" name="image" class="form-input" accept="image/*">
                </div>
                <div class="modal-actions">
                    <button type="button" class="modal-cancel" onclick="closeEditModal()">Cancel</button>
                    <button type="submit" class="modal-save">
                        <i class="fas fa-save"></i>
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Search functionality
        function searchTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.querySelector('.services-table table');
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

        // Edit modal
        function openEditModal(id, name, price, description) {
            document.getElementById('editId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editPrice').value = price;
            document.getElementById('editDescription').value = description;
            document.getElementById('editModal').classList.add('active');
        }

        function closeEditModal() {
            document.getElementById('editModal').classList.remove('active');
        }

        // Close modal when clicking outside
        document.getElementById('editModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeEditModal();
            }
        });
    </script>
</body>
</html>