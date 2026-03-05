<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRDMS | TPO / HR Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <!-- AOS -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body{
            font-family:'Segoe UI',sans-serif;
            background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        /* Glass Card */
        .login-card{
            background:rgba(255,255,255,0.1);
            backdrop-filter:blur(15px);
            border-radius:20px;
            padding:40px;
            width:100%;
            max-width:450px;
            box-shadow:0 15px 40px rgba(0,0,0,0.3);
            color:white;
            transition:0.4s;
        }

        .login-card:hover{
            transform:translateY(-5px);
        }

        /* Inputs */
        .form-control{
            border-radius:12px;
            padding:12px;
        }

        /* Button */
        .btn-role{
            background:#ff9800;
            border:none;
            border-radius:30px;
            padding:12px;
            font-weight:600;
            transition:0.3s;
        }

        .btn-role:hover{
            background:#e68900;
        }

        /* Back Link */
        .back-link{
            color:#00c853;
            text-decoration:none;
        }
        .back-link:hover{
            text-decoration:underline;
        }

        .role-icon{
            font-size:45px;
            margin-bottom:15px;
            color:#ff9800;
        }
    </style>
</head>

<body>

<div class="login-card text-center" data-aos="zoom-in">

    <i class="fas fa-briefcase role-icon"></i>

    <h3 class="mb-3">TPO / HR Login Portal</h3>
    <p class="mb-4">Access conference invitations & delegate management</p>

    <c:if test="${not empty errorMsg1}">
        <div class="alert alert-danger mt-2">
            ${errorMsg1}
        </div>
    </c:if>

    <form action="delegateLogin" method="post">

        <div class="mb-3">
            <input type="email" class="form-control"
                   placeholder="Official Email"
                   name="email" required>
        </div>

        <div class="mb-3">
            <input type="password" class="form-control"
                   placeholder="Password"
                   name="password" required>
        </div>

        <div class="mb-3">
            <select class="form-control" name="role" required>
                <option value="">Select Role</option>
                <option value="TPO">TPO</option>
                <option value="HR">HR</option>
                <option value="Others">Others</option>
            </select>
        </div>

        <button type="submit" class="btn btn-role w-100">
            Login Securely
        </button>

    </form>

    <div class="mt-4">
        <a href="index.jsp" class="back-link">
            ← Back to Home
        </a>
    </div>

</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({duration:1000});
</script>

</body>
</html>