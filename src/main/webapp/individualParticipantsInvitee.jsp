<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CRDMS | Participant Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

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

        .form-card{

        background:rgba(255,255,255,0.1);

        backdrop-filter:blur(15px);

        border-radius:20px;

        padding:40px;

        width:100%;

        max-width:500px;

        box-shadow:0 15px 40px rgba(0,0,0,0.3);

        color:white;

        transition:0.4s;

        }

        .form-card:hover{

        transform:translateY(-5px);

        }

        /* Inputs */

        .form-control{

        border-radius:12px;

        padding:12px;

        }

        /* Button */

        .btn-main{

        background:#ff9800;

        border:none;

        border-radius:30px;

        padding:12px;

        font-weight:600;

        transition:0.3s;

        }

        .btn-main:hover{

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

        .page-icon{

        font-size:45px;

        margin-bottom:15px;

        color:#ff9800;

        }

    </style>

</head>

<body>

<div class="form-card text-center" data-aos="zoom-in">

    <i class="fas fa-user-plus page-icon"></i>

    <h3 class="mb-3">Participant Registration</h3>

    <p class="mb-4">
        Register to participate in this conference
    </p>

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success">
            ${successMsg}
        </div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">
            ${errorMsg}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/participantRegister" method="post">

        <input type="hidden"
               name="conferenceId"
               value="${conferenceId}">

        <div class="mb-3">
            <input type="text"
                   class="form-control"
                   placeholder="Full Name"
                   name="fullName"
                   required>
        </div>

        <div class="mb-3">
            <input type="email"
                   class="form-control"
                   placeholder="Email Address"
                   name="email"
                   required>
        </div>

        <div class="mb-3">
            <input type="text"
                   class="form-control"
                   placeholder="Mobile Number"
                   name="mobile"
                   required>
        </div>

        <div class="mb-3">
            <input type="text"
                   class="form-control"
                   placeholder="Organization / College / Company"
                   name="organization"
                   required>
        </div>

        <div class="mb-3">

            <select class="form-control" name="attending" required>

                <option value="">Will you attend the conference?</option>

                <option value="yes">Yes, I will attend</option>

                <option value="no">No, I cannot attend</option>

            </select>

        </div>

        <button type="submit" class="btn btn-main w-100">
            Submit Registration
        </button>

    </form>

    <div class="mt-4">

        <a href="delegatesPage.jsp" class="back-link">
            ← Back to Home
        </a>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>

    AOS.init({
    duration:1000
    });

</script>

</body>

</html>