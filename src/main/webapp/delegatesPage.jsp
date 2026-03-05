<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>CRDMS | TPO / HR Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>

        body{
            font-family:'Segoe UI',sans-serif;
            background:#f4f7fb;
        }

        /* NAVBAR */

        .navbar{
            background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
        }

        /* HERO */

        .dashboard-hero{
            background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            color:white;
            padding:70px 0;
            text-align:center;
        }

        /* CARDS */

        .feature-card{
            background:white;
            border-radius:15px;
            padding:25px;
            box-shadow:0 8px 20px rgba(0,0,0,0.08);
            transition:0.3s;
        }

        .feature-card:hover{
            transform:translateY(-6px);
        }

        /* STAT BOX */

        .stat-box{
            background:white;
            padding:25px;
            border-radius:15px;
            text-align:center;
            box-shadow:0 8px 20px rgba(0,0,0,0.08);
        }

        /* FOOTER */

        footer{
            background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
            color:white;
            padding:25px;
            margin-top:60px;
        }

        /* OFFCANVAS BUTTON */

        .menu-btn{
            font-size:22px;
            border:none;
            background:none;
            color:white;
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-dark">

    <div class="container-fluid">

        <button class="menu-btn"
                data-bs-toggle="offcanvas"
                data-bs-target="#dashboardOffcanvas">

            <i class="fas fa-bars"></i>

        </button>

        <span class="navbar-brand fw-bold ms-2">
CRDMS TPO / HR
</span>

        <a href="index.jsp" class="btn btn-warning btn-sm">
            Logout
        </a>

    </div>

</nav>

<!-- OFFCANVAS DASHBOARD -->

<div class="offcanvas offcanvas-start shadow"
     tabindex="-1"
     id="dashboardOffcanvas"
     style="width:270px;">

    <div class="offcanvas-header bg-primary text-white">

        <h5 class="offcanvas-title fw-bold">
            Dashboard
        </h5>

        <button type="button"
                class="btn-close btn-close-white"
                data-bs-dismiss="offcanvas">
        </button>

    </div>

    <div class="offcanvas-body p-0 bg-light">

        <div class="d-flex flex-column p-3 gap-3">

            <a href="tpo/dashboard"
               class="btn btn-outline-primary rounded-pill fw-semibold py-2">

                View Invitations

            </a>

            <a href="tpo/acceptedConferences"
               class="btn btn-outline-success rounded-pill fw-semibold py-2">

                Accepted Conferences

            </a>

            <a href="tpo/upcomingEvents"
               class="btn btn-outline-info rounded-pill fw-semibold py-2">

                Upcoming Events

            </a>

            <a href="tpo/profile"
               class="btn btn-outline-secondary rounded-pill fw-semibold py-2">

                Profile Settings

            </a>

        </div>

    </div>

</div>

<!-- HERO SECTION -->

<section class="dashboard-hero">

    <div class="container" data-aos="fade-up">

        <h2>
            Welcome to TPO / HR Conference Portal
        </h2>

        <p class="mt-2">
            View invitations • Confirm participation • Track conferences
        </p>

    </div>

</section>

<!-- STATISTICS -->

<section class="container mt-5">

    <div class="row g-4">

        <div class="col-md-4" data-aos="zoom-in">

            <div class="stat-box">

                <h3 class="text-primary">12</h3>

                <p>Total Invitations</p>

            </div>

        </div>

        <div class="col-md-4" data-aos="zoom-in">

            <div class="stat-box">

                <h3 class="text-success">7</h3>

                <p>Accepted Conferences</p>

            </div>

        </div>

        <div class="col-md-4" data-aos="zoom-in">

            <div class="stat-box">

                <h3 class="text-warning">3</h3>

                <p>Upcoming Conferences</p>

            </div>

        </div>

    </div>

</section>

<!-- INVITATION CARDS -->

<section class="container mt-5">

    <h3 class="text-center mb-4">
        Conference Invitations
    </h3>

    <div class="row">

        <c:forEach var="conf" items="${conferenceList}">

            <div class="col-md-4 mb-4" data-aos="fade-up">

                <div class="feature-card">

                    <h5>${conf.conferenceTopic}</h5>

                    <p>
                        <strong>Host:</strong>
                        ${conf.hostName}
                    </p>

                    <p>
                        <strong>Date:</strong>
                        ${conf.date}
                    </p>

                    <p>
                        <strong>Time:</strong>
                        ${conf.time}
                    </p>

                    <form action="tpo/respondConference" method="post">

                        <input type="hidden"
                               name="id"
                               value="${conf.id}">

                        <div class="d-flex gap-2">

                            <button class="btn btn-success w-50">
                                Accept
                            </button>

                            <button name="response"
                                    value="decline"
                                    class="btn btn-danger w-50">
                                Decline
                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </c:forEach>

    </div>

</section>

<footer class="text-center">

    © 2026 CRDMS TPO / HR Dashboard

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>

    AOS.init({
    duration:1000
    });

</script>

</body>

</html>