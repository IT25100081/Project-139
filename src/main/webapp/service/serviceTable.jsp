<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.salon.service.Service" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service List - Glamour Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #f8f9ff;
            padding: 2rem;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }

        h2 {
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .search-box {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            color: white;
            text-decoration: none;
            margin-bottom: 1rem;
        }

        .btn-secondary {
            background: #6c757d;
        }

        .btn-update {
            background: #ff69b4;
        }

        .btn-delete {
            background: #dc3545;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        th {
            background: #ff69b4;
            color: white;
            text-align: left;
            padding: 1rem;
            font-weight: 500;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .action-cell {
            display: flex;
            gap: 0.5rem;
        }

        .action-cell input {
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 0.5rem;
        }

        @media (max-width: 768px) {
            .action-cell {
                flex-direction: column;
            }

            td {
                padding: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>Service List</h2>
        <a href="${pageContext.request.contextPath}/service/serviceManagement.jsp" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            Back to Management
        </a>
        <input type="text" class="search-box" placeholder="Search services..." id="searchInput" onkeyup="searchTable()">

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                List<Service> services = (List<Service>) request.getAttribute("services");
                if (services != null) {
                    for (Service service : services) {
                %>
                <tr>
                    <td><%= service.getId() %></td>
                    <td><%= service.getName() %></td>
                    <td>LKR <%= String.format("%.2f", service.getPrice()) %></td>
                    <td><%= service.getDescription() %></td>
                    <td class="action-cell">
                        <form action="${pageContext.request.contextPath}/ServiceController" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="updateService">
                            <input type="hidden" name="id" value="<%= service.getId() %>">
                            <input type="text" name="name" placeholder="New name" required>
                            <input type="number" name="price" step="0.01" placeholder="New price" required>
                            <input type="text" name="description" placeholder="New description" required>
                            <button type="submit" class="btn btn-update">
                                <i class="fas fa-edit"></i>
                                Update
                            </button>
                        </form>
                        <form action="${pageContext.request.contextPath}/ServiceController" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="deleteService">
                            <input type="hidden" name="id" value="<%= service.getId() %>">
                            <button type="submit" class="btn btn-delete">
                                <i class="fas fa-trash"></i>
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <% 
                    }
                }
                %>
            </tbody>
        </table>
    </div>

    <script>
        function searchTable() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.querySelector("table");
            tr = table.getElementsByTagName("tr");

            for (i = 1; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td");
                var found = false;
                for (var j = 0; j < td.length; j++) {
                    if (td[j]) {
                        txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                tr[i].style.display = found ? "" : "none";
            }
        }
    </script>
</body>
</html> 