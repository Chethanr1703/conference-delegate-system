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

        /* Soft project background */
        background: linear-gradient(135deg,#eef3f8,#d8e3ec);

        position: relative;
        overflow-x: hidden;
    }

    /* Modern animated background blobs */

    body::before,
    body::after{
        content:"";
        position:fixed;
        width:420px;
        height:420px;
        border-radius:50%;
        filter:blur(120px);
        z-index:-1;
    }

    /* blue blob */

    body::before{
        background:#2c5364;
        top:-120px;
        left:-120px;
        opacity:0.18;
        animation:floatBlob 18s infinite alternate ease-in-out;
    }

    /* teal blob */

    body::after{
        background:#203a43;
        bottom:-120px;
        right:-120px;
        opacity:0.18;
        animation:floatBlob 22s infinite alternate-reverse ease-in-out;
    }

    @keyframes floatBlob{
        0%{
            transform:translate(0,0) scale(1);
        }
        50%{
            transform:translate(60px,-40px) scale(1.1);
        }
        100%{
            transform:translate(-40px,40px) scale(1);
        }
    }

    /* Navbar */

    .navbar{
        transition:0.3s;
    }

    .navbar.scrolled{
        background:#1c1c1c !important;
    }

    /* Hero */

    .hero{
        background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
        color:white;
        padding:140px 0;
    }

    .hero h1{
        font-size:3rem;
        font-weight:bold;
    }

    /* Buttons */

    .btn-custom{
        padding:12px 25px;
        border-radius:30px;
        transition:0.3s;
    }

    .btn-host{
        background:#ff9800;
        color:white;
    }

    .btn-host:hover{
        background:#e68900;
    }

    .btn-delegate{
        background:#00c853;
        color:white;
    }

    .btn-delegate:hover{
        background:#00a843;
    }

    /* Sections */

    .section{
        padding:80px 0;
    }

    .section h2{
        font-weight:bold;
    }

    /* Cards */

    .card{
        border:none;
        border-radius:15px;
        transition:0.4s;
    }

    .card:hover{
        transform:translateY(-8px);
        box-shadow:0 15px 30px rgba(0,0,0,0.15);
    }

    /* Forms */

    form .form-control{
        border-radius:10px;
        padding:10px;
    }

    /* Buttons */

    .btn-main{
        background:#2c5364;
        color:white;
    }

    .btn-main:hover{
        background:#1e3c48;
        color:white;
    }

    /* Footer */

    footer{
        background:#1c1c1c;
        color:white;
        padding:10px 0;
    }
   /* AUTO SLIDER */

.auto-slider {
    overflow: hidden;
    position: relative;
}

.auto-slide-track {
    display: flex;
    width: max-content;
    animation: scrollLeft 20s linear infinite;
}

.slide-card {
    width: 300px;
    margin-right: 20px;
    flex-shrink: 0;
}

/* pause on hover */
.auto-slider:hover .auto-slide-track {
    animation-play-state: paused;
}

/* smooth infinite scroll */
@keyframes scrollLeft {
    from {
        transform: translateX(0);
    }
    to {
        transform: translateX(-50%);
    }
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
                <li class="nav-item"><a class="nav-link" href="registerConference">Register Conference</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogin">Admin Login</a></li>
                <li class="nav-item"><a class="nav-link" href="delegateLogin">Delegate Login</a></li>
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
            <a href="adminLogin" class="btn btn-delegate btn-custom">
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

        <!-- SLIDER WRAPPER -->

        <div class="auto-slider">

            <div class="auto-slide-track" id="upcomingTrack">

                <c:forEach var="conf" items="${upcomingList}">
                    <div class="slide-card">
                        <div class="card p-4 text-center">

                            <h5>${conf.conferenceTopic}</h5>

                            <p><strong>Date:</strong> ${conf.date}</p>
                            <p><strong>Time:</strong> ${conf.time}</p>
                            <p><strong>Audience:</strong> ${conf.targetedAudience}</p>

                        </div>
                    </div>
                </c:forEach>

<!--                &lt;!&ndash; duplicate for smooth infinite scroll &ndash;&gt;-->
<!--                <c:forEach var="conf" items="${upcomingList}">-->
<!--                    <div class="slide-card">-->
<!--                        <div class="card p-4 text-center">-->

<!--                            <h5>${conf.conferenceTopic}</h5>-->

<!--                            <p><strong>Date:</strong> ${conf.date}</p>-->
<!--                            <p><strong>Time:</strong> ${conf.time}</p>-->
<!--                            <p><strong>Audience:</strong> ${conf.targetedAudience}</p>-->

<!--                        </div>-->
<!--                    </div>-->
<!--                </c:forEach>-->

            </div>

        </div>

        <c:if test="${empty upcomingList}">
            <div class="text-center mt-3">
                <div class="alert alert-info">
                    No Upcoming Conferences Available
                </div>
            </div>
        </c:if>

    </div>
</section>

<!-- PREVIOUS CONFERENCES -->
<section id="works" class="section">
    <div class="container">
        <h2 class="text-center mb-5" data-aos="fade-down">
            Previous Conferences
        </h2>

        <div class="auto-slider">

            <div class="auto-slide-track" id="previousTrack">
                <!-- ORIGINAL -->
                <div class="slide-card">
                    <div class="card p-4 text-center">
                        <h5>AI Summit 2025</h5>
                        <p>Focused on Artificial Intelligence trends and innovations.</p>
                    </div>
                </div>

                <div class="slide-card">
                    <div class="card p-4 text-center">
                        <h5>Java Conference</h5>
                        <p>Spring Boot, Microservices & Enterprise application deep dive.</p>
                    </div>
                </div>

                <div class="slide-card">
                    <div class="card p-4 text-center">
                        <h5>Cloud Expo</h5>
                        <p>Exploring AWS, Azure, DevOps & Cloud Infrastructure tools.</p>
                    </div>
                </div>


            </div>

        </div>
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

    /* 🔥 AUTO CLONE FOR INFINITE SLIDER (NO BACKEND CHANGE) */

    function createInfiniteSlider(trackId) {
        const track = document.getElementById(trackId);

        if (!track) return;

        const items = track.innerHTML;
        track.innerHTML += items; // duplicate using JS
    }

    // apply for both sliders
    window.addEventListener("load", () => {
        createInfiniteSlider("upcomingTrack");
        createInfiniteSlider("previousTrack");
    });
</script>

</body>
</html>