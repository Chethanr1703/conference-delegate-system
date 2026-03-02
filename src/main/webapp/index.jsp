<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <title>Conference Registration & Delegate System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            scroll-behavior: smooth;
        }

        /* Navbar */
        .navbar {
            transition: 0.3s;
        }

        .navbar.scrolled {
            background: #1c1c1c !important;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: white;
            padding: 140px 0;
        }

        .hero h1 {
            font-size: 3rem;
            font-weight: bold;
        }

        .btn-custom {
            padding: 12px 25px;
            border-radius: 30px;
            transition: 0.3s;
        }

        .btn-host {
            background-color: #ff9800;
            color: white;
        }

        .btn-host:hover {
            background-color: #e68900;
        }

        .btn-delegate {
            background-color: #00c853;
            color: white;
        }

        .btn-delegate:hover {
            background-color: #00a843;
        }

        /* Section */
        .section {
            padding: 80px 0;
        }

        .section h2 {
            font-weight: bold;
        }

        /* Cards */
        .card {
            border: none;
            border-radius: 15px;
            transition: 0.4s;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        /* Forms */
        form .form-control {
            border-radius: 10px;
            padding: 10px;
        }

        .btn-main {
            background-color: #2c5364;
            color: white;
        }

        .btn-main:hover {
            background-color: #1e3c48;
            color: white;
        }

        footer {
            background: #1c1c1c;
            color: white;
            padding: 10px 0;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">CRDMS</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#works">Previous Conferences</a></li>
                <li class="nav-item"><a class="nav-link" href="#register">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="#admin">Admin</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- HERO SECTION -->
<section class="hero text-center">
    <div class="container" data-aos="fade-up">
        <h1>Conference Registration & Delegate Management System</h1>
        <p class="lead mt-3">
            Manage Conferences | Invite Delegates | Track Responses | Generate Reports
        </p>

        <div class="mt-4">
            <a href="#register" class="btn btn-host btn-custom me-3">
                <i class="fas fa-microphone"></i> Host a Conference
            </a>
            <a href="#admin" class="btn btn-delegate btn-custom">
                <i class="fas fa-user-shield"></i> Admin Login
            </a>
        </div>
    </div>
</section>

<section id="future" class="section">
    <div class="container">
        <h2 class="text-center mb-5" data-aos="fade-down">
            Upcoming Conferences
        </h2>

        <div class="row g-4">

            <c:forEach var="conf" items="${upcomingList}">
                <div class="col-md-4" data-aos="zoom-in">
                    <div class="card p-4 text-center">

                        <h5>${conf.conferenceTopic}</h5>

                        <p>
                            <strong>Date:</strong> ${conf.date}
                        </p>

                        <p>
                            <strong>Time:</strong> ${conf.time}
                        </p>

                        <p>
                            <strong>Audience:</strong> ${conf.targetedAudience}
                        </p>

<!--                        <a href="/delegate/register?id=${conf.id}"-->
<!--                           class="btn btn-main mt-2">-->
<!--                            Register Now-->
<!--                        </a>-->

                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty upcomingList}">
                <div class="col-12 text-center">
                    <div class="alert alert-info">
                        No Upcoming Conferences Available
                    </div>
                </div>
            </c:if>

        </div>
    </div>
</section>


<!-- PREVIOUS CONFERENCES -->
<section id="works" class="section">
    <div class="container">
        <h2 class="text-center mb-5" data-aos="fade-down">Previous Conferences</h2>

        <div class="row g-4">
            <div class="col-md-4" data-aos="zoom-in">
                <div class="card p-4 text-center">
                    <h5>AI Summit 2025</h5>
                    <p>Focused on Artificial Intelligence trends and innovations.</p>
                </div>
            </div>

            <div class="col-md-4" data-aos="zoom-in">
                <div class="card p-4 text-center">
                    <h5>Java Conference</h5>
                    <p>Spring Boot, Microservices & Enterprise application deep dive.</p>
                </div>
            </div>

            <div class="col-md-4" data-aos="zoom-in">
                <div class="card p-4 text-center">
                    <h5>Cloud Expo</h5>
                    <p>Exploring AWS, Azure, DevOps & Cloud Infrastructure tools.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- REGISTRATION -->
<section id="register" class="section bg-light">
    <div class="container">
        <h2 class="text-center mb-5" data-aos="fade-up">New Conference Registration</h2>

        <c:if test="${not empty successMsg}">
            <div class="alert alert-success text-center mt-3">
                ${successMsg}
            </div>
        </c:if>

        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger text-center mt-3">
                ${errorMsg}
            </div>
        </c:if>

        <form class="row g-3" data-aos="fade-up" action="conferenceRegister" method="post">

            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="Host Name"
                       name="hostName"
                       value="${dto.hostName}">
                <div class="text-danger small">${hostNameError}</div>
            </div>

            <div class="col-md-6">
                <input type="email" class="form-control"
                       placeholder="Host email"
                       name="email"
                       value="${dto.email}">
                <div class="text-danger small">${emailError}</div>
            </div>

            <!-- Delegates Email Field -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="Delegates Email"
                       name="delegatesEmail"
                       value="${dto.delegatesEmail}">
                <div class="text-danger small">${delegatesEmailError}</div>
            </div>

            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="Conference Topic"
                       name="conferenceTopic"
                       value="${dto.conferenceTopic}">
                <div class="text-danger small">${topicError}</div>
            </div>

            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="Target Audience(Students , Employees )"
                       name="targetedAudience"
                       value="${dto.targetedAudience}">
                <div class="text-danger small">${audienceError}</div>
            </div>

            <div class="col-md-6">
                <input type="date" class="form-control"
                       name="date"
                       value="${dto.date}">
                <div class="text-danger small">${dateError}</div>
            </div>

            <div class="col-md-6">
                <input type="text" class="form-control"
                       name="time"
                       placeholder="hh:mm AM/PM"
                       pattern="(0[1-9]|1[0-2]):[0-5][0-9] (AM|PM)"
                       value="${dto.time}">
                <div class="text-danger small">${timeError}</div>
            </div>

            <div class="col-12 text-center">
                <button type="submit" class="btn btn-main btn-lg">
                    Register Conference
                </button>
            </div>

        </form>
    </div>
</section>

<!-- ADMIN LOGIN -->
<section id="admin" class="section text-center">
    <div class="container">
        <h2 class="mb-4" data-aos="fade-up">Admin Login</h2>
        <c:if test="${not empty errorMsg1}">
            <div class="alert alert-danger mt-2">
                ${errorMsg1}
            </div>
        </c:if>

        <form class="row justify-content-center" data-aos="zoom-in" action="login" method="post">

            <div class="col-md-4">
                <input type="email" class="form-control mb-3" placeholder="Admin Email" name="email" required>
            </div>

            <div class="col-md-4">
                <input type="password" class="form-control mb-3" placeholder="Password" name="password" required>
            </div>

            <div class="col-12">
                <button class="btn btn-primary btn-lg">Login</button>
            </div>
        </form>
    </div>
</section>
<!-- ABOUT -->
<section id="about" class="section text-center bg-light">
    <div class="container" data-aos="fade-up">
        <h2 class="mb-4">About</h2>
        <p class="lead">
            This Website helps organizers manage conferences efficiently.
            Delegates can register easily, and admins can track and manage events in real-time.
        </p>
    </div>
</section>
<!-- FOOTER -->
<footer class="text-center">
    <div class="container">
        <p>© 2026 Conference Registration & Delegate Management System</p>
        <p>Email: support@crdms.com | Bengaluru, India</p>
    </div>
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({duration: 1000});

    window.addEventListener("scroll", function () {
        let nav = document.querySelector(".navbar");
        nav.classList.toggle("scrolled", window.scrollY > 50);
    });
</script>

</body>
</html>