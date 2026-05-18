<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.salon.service.Service" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Management - Glamour Haven</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 800px;
            padding: 2rem;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 3rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 2rem;
            font-size: 2rem;
            font-weight: 600;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .btn {
            padding: 0.8rem 2rem;
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
            min-width: 180px;
            justify-content: center;
        }

        .btn-primary {
            background: #ff69b4;
        }

        .btn-secondary {
            background: #6c757d;
        }

        .btn i {
            font-size: 1rem;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .back-button {
            display: block;
            margin-top: 2rem;
            text-align: center;
        }

        @media (max-width: 768px) {
            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .card {
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2>Service Management</h2>
            <div class="button-group">
                <a href="${pageContext.request.contextPath}/service/serviceForm.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Add New Service
                </a>
                <a href="${pageContext.request.contextPath}/ServiceController?action=table" class="btn btn-secondary">
                    <i class="fas fa-list"></i>
                    View Services
                </a>
            </div>
            <a href="${pageContext.request.contextPath}/admin/adminDashboard.jsp" class="btn btn-secondary back-button">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>