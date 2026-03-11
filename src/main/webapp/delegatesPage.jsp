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


        html, body{
height:100%;
}

body{
font-family:'Segoe UI',sans-serif;

/* soft project background */
background:linear-gradient(135deg,#eef3f8,#dce6ef);

display:flex;
flex-direction:column;
min-height:100vh;
overflow-x:hidden;
position:relative;
}

/* subtle animated background */

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

body::before{
background:#2c5364;
top:-120px;
left:-120px;
opacity:0.15;
animation:floatBlob 18s infinite alternate ease-in-out;
}

body::after{
background:#203a43;
bottom:-120px;
right:-120px;
opacity:0.15;
animation:floatBlob 22s infinite alternate-reverse ease-in-out;
}

@keyframes floatBlob{
0%{transform:translate(0,0) scale(1);}
50%{transform:translate(60px,-40px) scale(1.1);}
100%{transform:translate(-40px,40px) scale(1);}
}

/* NAVBAR */

.navbar{
background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
box-shadow:0 4px 15px rgba(0,0,0,0.25);
}

/* HERO */

.dashboard-hero{
background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
color:white;
padding:70px 0;
text-align:center;
box-shadow:0 6px 20px rgba(0,0,0,0.3);
}

/* CARDS */

.feature-card{
background:rgba(255,255,255,0.95);
border-radius:18px;
padding:22px;
box-shadow:0 10px 25px rgba(0,0,0,0.12);
transition:all 0.35s ease;
border-left:5px solid #2c5364;
backdrop-filter:blur(6px);
}

.feature-card:hover{
transform:translateY(-8px);
box-shadow:0 18px 35px rgba(0,0,0,0.18);
}

/* CARD TEXT */

.feature-card h4{
color:#2c5364;
font-weight:600;
margin-top:5px;
}

.feature-card p{
font-size:14px;
color:#555;
margin-bottom:6px;
}

/* BUTTONS */

.btn-success,
.btn-danger,
.btn-primary{
border-radius:30px;
font-weight:500;
}

/* OFFCANVAS MENU BUTTON */

.menu-btn{
font-size:22px;
border:none;
background:none;
color:white;
transition:0.3s;
}

.menu-btn:hover{
transform:scale(1.15);
}

/* SIDEBAR */

.offcanvas-header{
background:linear-gradient(135deg,#203a43,#2c5364);
}

.offcanvas-body{
background:#f4f7fb;
}

/* SIDEBAR BUTTONS */

.offcanvas-body a{
transition:0.25s;
}

.offcanvas-body a:hover{
transform:translateX(5px);
}

/* FOOTER */

footer{
background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
color:white;
text-align:center;
padding:15px 0;
margin-top:auto;
box-shadow:0 -4px 12px rgba(0,0,0,0.2);
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

        <a href="delegateLogin.jsp" class="btn btn-warning btn-sm">
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

            <a href="${pageContext.request.contextPath}/delegatesPage"
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

                            <div class="d-flex justify-content-between gap-2 mt-3">

                                <form action="loadParticipantsPage" method="get" class="w-50">

                                    <input type="hidden"
                                           name="conferenceId"
                                           value="${conf.id}">

                                    <button class="btn btn-primary w-100">
                                        Send Invitee
                                    </button>

                                </form>

                                <form action="participants" method="get" class="w-50">

                                    <input type="hidden"
                                           name="conferenceId"
                                           value="${conf.id}">

                                    <button class="btn btn-outline-primary w-100">
                                        View Participants
                                    </button>

                                </form>

                            </div>

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