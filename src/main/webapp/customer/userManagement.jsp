<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.salon.customer.Customer" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Glamour Haven</title>
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

        /* ===== Sidebar ===== */
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

        /* ===== Add User Card ===== */
        .add-user-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .add-user-card h3 {
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

        /* ===== Users Table ===== */
        .users-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .users-table table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .users-table th {
            background: #ff69b4;
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 500;
            white-space: nowrap;
        }

        /* Column widths */
        .users-table th:nth-child(1),
        .users-table td:nth-child(1) { width: 60px; }     /* ID */
        .users-table th:nth-child(2),
        .users-table td:nth-child(2) { width: 25%; }      /* Username */
        .users-table th:nth-child(3),
        .users-table td:nth-child(3) { }                   /* Email - takes remaining */
        .users-table th:nth-child(4),
        .users-table td:nth-child(4) { width: 100px; }    /* Role */
        .users-table th:nth-child(5),
        .users-table td:nth-child(5) { width: 220px; }    /* Actions */

        .users-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .users-table tr:last-child td {
            border-bottom: none;
        }

        .users-table tr:hover {
            background: #fce8f3;
        }

        .role-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .role-admin {
            background: #fff0f5;
            color: #ff69b4;
            border: 1px solid #ff69b4;
        }

        .role-user {
            background: #f0f0f0;
            color: #666;
            border: 1px solid #ddd;
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
            color: white;
        }

        .edit-button {
            background: #ff69b4;
        }

        .edit-button:hover {
            background: #ff4da6;
        }

        .delete-button {
            background: #dc3545;
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

        /* ===== Toast Messages ===== */
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            display: none;
            z-index: 3000;
            font-weight: 500;
            animation: toastSlideIn 0.3s ease;
        }

        @keyframes toastSlideIn {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .toast-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .toast-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
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

            .users-table {
                overflow-x: auto;
            }

            .users-table table {
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
    <!-- Sidebar -->
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
                <a href="${pageContext.request.contextPath}/CustomerController?action=manage" class="nav-link active">
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

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-header">
            <h2>User Management</h2>
        </div>

        <!-- Add New User Form -->
        <div class="add-user-card">
            <h3>Add New User</h3>
            <form id="addUserForm" onsubmit="addUser(event)">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-input" placeholder="Enter username" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-input" placeholder="Enter email" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-input" placeholder="Enter password" required>
                    </div>
                </div>
                <button type="submit" class="add-button">
                    <i class="fas fa-plus"></i>
                    Add User
                </button>
            </form>
        </div>

        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Search users..." id="searchInput" onkeyup="searchTable()">
        </div>

        <!-- Users Table -->
        <div class="users-table">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
                <%
                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                    if (customers != null) {
                        for (Customer customer : customers) {
                %>
                <tr data-user-id="<%= customer.getId() %>">
                    <td><%= customer.getId() %></td>
                    <td><%= customer.getUsername() %></td>
                    <td><%= customer.getEmail() %></td>
                    <td>
                        <span class="role-badge <%= "admin".equals(customer.getRole()) ? "role-admin" : "role-user" %>">
                            <%= customer.getRole() != null ? customer.getRole() : "user" %>
                        </span>
                    </td>
                    <td>
                        <div class="action-cell">
                            <button type="button" class="edit-button" onclick="openEditModal(<%= customer.getId() %>, '<%= customer.getUsername().replace("'", "\\'") %>', '<%= customer.getEmail().replace("'", "\\'") %>')">
                                <i class="fas fa-edit"></i>
                                Edit
                            </button>
                            <button type="button" class="delete-button" onclick="deleteUser(<%= customer.getId() %>)">
                                <i class="fas fa-trash-alt"></i>
                                Delete
                            </button>
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

    <!-- Edit User Modal -->
    <div class="modal-overlay" id="editModal">
        <div class="modal">
            <h3>Edit User</h3>
            <form id="editUserForm" onsubmit="updateUser(event)">
                <input type="hidden" name="id" id="editId">
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" id="editUsername" class="form-input" placeholder="Enter username" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" id="editEmail" class="form-input" placeholder="Enter email" required>
                </div>
                <div class="form-group">
                    <label class="form-label">New Password (leave blank to keep current)</label>
                    <input type="password" name="password" id="editPassword" class="form-input" placeholder="Enter new password">
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

    <!-- Toast Messages -->
    <div id="toastSuccess" class="toast toast-success">
        <i class="fas fa-check-circle"></i> Operation completed successfully!
    </div>
    <div id="toastError" class="toast toast-error">
        <i class="fas fa-exclamation-circle"></i> An error occurred. Please try again.
    </div>

    <script>
        // Search functionality
        function searchTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.querySelector('.users-table table');
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

        // Toast message
        function showToast(type, duration) {
            duration = duration || 3000;
            const toast = document.getElementById(type === 'success' ? 'toastSuccess' : 'toastError');
            toast.style.display = 'block';
            setTimeout(function() {
                toast.style.display = 'none';
            }, duration);
        }

        // Edit modal
        function openEditModal(id, username, email) {
            document.getElementById('editId').value = id;
            document.getElementById('editUsername').value = username;
            document.getElementById('editEmail').value = email;
            document.getElementById('editPassword').value = '';
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

        // Add user (AJAX)
        function addUser(event) {
            event.preventDefault();
            const form = event.target;
            const formData = new FormData(form);

            fetch('${pageContext.request.contextPath}/CustomerController', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=addCustomer&username=' + encodeURIComponent(formData.get('username')) + '&email=' + encodeURIComponent(formData.get('email')) + '&password=' + encodeURIComponent(formData.get('password'))
            })
            .then(function(response) {
                if (response.ok) {
                    showToast('success');
                    setTimeout(function() { window.location.reload(); }, 1000);
                } else {
                    showToast('error');
                }
            })
            .catch(function(error) {
                showToast('error');
            });
        }

        // Update user (AJAX)
        function updateUser(event) {
            event.preventDefault();
            const form = event.target;
            const formData = new FormData(form);
            const userId = formData.get('id');

            fetch('${pageContext.request.contextPath}/CustomerController', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=updateCustomer&id=' + userId + '&username=' + encodeURIComponent(formData.get('username')) + '&email=' + encodeURIComponent(formData.get('email')) + '&password=' + encodeURIComponent(formData.get('password'))
            })
            .then(function(response) {
                if (response.ok) {
                    showToast('success');
                    closeEditModal();
                    // Update the row in the table
                    const row = document.querySelector('tr[data-user-id="' + userId + '"]');
                    if (row) {
                        row.cells[1].textContent = formData.get('username');
                        row.cells[2].textContent = formData.get('email');
                    }
                } else {
                    showToast('error');
                }
            })
            .catch(function(error) {
                showToast('error');
            });
        }

        // Delete user (AJAX)
        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                fetch('${pageContext.request.contextPath}/CustomerController', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=deleteCustomer&id=' + userId
                })
                .then(function(response) {
                    if (response.ok) {
                        const row = document.querySelector('tr[data-user-id="' + userId + '"]');
                        if (row) row.remove();
                        showToast('success');
                    } else {
                        showToast('error');
                    }
                })
                .catch(function(error) {
                    showToast('error');
                });
            }
        }
    </script>
</body>
</html>