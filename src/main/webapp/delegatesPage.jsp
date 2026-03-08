<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
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
            text-align:center;

            bottom:0;
            left:0;
            width:100%;
             padding: 15px 0;

            margin-top:00px;
        }

        /* OFFCANVAS BUTTON */

        .menu-btn{
            font-size:22px;
            border:none;
            background:none;
            color:white;
        }

        .feature-card {
    background: #ffffff;
    border-radius: 12px;
    padding: 20px;
    margin-top: 15px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: transform 0.3s, box-shadow 0.3s;
    border-left: 6px solid #0d6efd;
}

.feature-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

.card-header h5 {
    color: #0d6efd;
    font-weight: 600;
    margin-bottom: 15px;
}

.card-body p {
    font-size: 15px;
    margin-bottom: 8px;
}

.label {
    font-weight: bold;
    color: #444;
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

            <a href="${pageContext.request.contextPath}/allConference"
               class="btn btn-outline-secondary rounded-pill fw-semibold py-2">
                All Conferences
            </a>

            <a href="${pageContext.request.contextPath}/acceptedConferences"
               class="btn btn-outline-success rounded-pill fw-semibold py-2">

                Accepted Conferences

            </a>

            <a href="/dashboard"
               class="btn btn-outline-primary rounded-pill fw-semibold py-2">

                View Invitations

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


<section class="container mt-5">



    <div class="row">

        <c:forEach var="conf" items="${conferenceList}">

            <div class="col-md-4 mb-4" data-aos="fade-up">

                <div class="feature-card">
                    <strong>Conference Topic:</strong>
                    <h4>${conf.conferenceTopic}</h4>

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

                    <form action="respondConference" method="post">

                        <input type="hidden"
                               name="id"
                               value="${conf.id}">

                        <div class="d-flex gap-2">

                            <button name="response"
                                    value="accepted" class="btn btn-success w-50">
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
<c:choose>


    <c:when test="${showAccepted}">

        <section class="container mt-5">

            <h3 class="text-center mb-4 text-success">
                Accepted Conferences
            </h3>

            <div class="row">

                <c:forEach var="conf" items="${acceptedConferenceList}">

                    <div class="col-md-4 mb-4">

                        <div class="feature-card">
                            <strong>Conference Topic:</strong>
                            <h4>${conf.conferenceTopic}</h4>

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

                            <form action="loadParticipantsPage" method="get">

                                <input type="hidden"
                                       name="conferenceId"
                                       value="${conf.id}">

                                <button class="btn btn-primary w-100">
                                    Send Invitee
                                </button>

                            </form>

                        </div>

                    </div>

                </c:forEach>

            </div>

        </section>

    </c:when>



    <c:when test="${showAllConference}">

        <section class="container mt-5">

            <h3 class="text-center mb-4">
                All Conferences
            </h3>

            <div class="row">

                <c:forEach var="conf" items="${allConferenceList}">

                    <div class="col-md-4 mb-4">

                        <div class="feature-card">
                            <strong>Conference Topic:</strong>
                            <h4>${conf.conferenceTopic}</h4>

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

                        </div>

                    </div>

                </c:forEach>

            </div>

        </section>

    </c:when>




    <c:otherwise>

        <section class="container mt-5">

            <h3 class="text-center mb-4">
                Conference Invitations
            </h3>

            <div class="row">

                <c:forEach var="conf" items="${conferenceList}">

                    <div class="col-md-4 mb-4">

                        <div class="feature-card">
                            <strong>Conference Topic:</strong>
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

                            <form action="respondConference" method="post">

                                <input type="hidden"
                                       name="id"
                                       value="${conf.id}">

                                <div class="d-flex gap-2">

                                    <button name="response"
                                            value="accepted"
                                            class="btn btn-success w-50">
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

    </c:otherwise>

</c:choose>

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