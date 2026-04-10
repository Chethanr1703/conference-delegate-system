<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>CRDMS Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>

        html,body{
        height:100%;
        }

        body{
        font-family:'Segoe UI',sans-serif;
        background:linear-gradient(135deg,#e6edf4,#cfd9e3);
        display:flex;
        flex-direction:column;
        min-height:100vh;
        position:relative;
        overflow-x:hidden;
        }

        /* subtle background */

        body::before{
        content:"";
        position:fixed;
        top:0;
        left:0;
        width:100%;
        height:100%;
        background-image:
        radial-gradient(circle at 20% 30%, rgba(44,83,100,0.08) 2px, transparent 2px),
        radial-gradient(circle at 80% 70%, rgba(44,83,100,0.08) 2px, transparent 2px);
        background-size:140px 140px;
        z-index:-1;
        }

        /* NAVBAR */

        .navbar{
        background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
        box-shadow:0 4px 12px rgba(0,0,0,0.25);
        }

        /* MENU BUTTON */

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

        .offcanvas-body{
        background:#f4f7fb;
        }

        .offcanvas-body a:hover{
        transform:translateX(5px);
        }

        /* SECTION TITLE */

        .section-title{
        margin:60px 0 30px;
        font-weight:700;
        text-align:center;
        }

        /* UNIFORM CARD FIX */

        .row{
        align-items:stretch;
        }

        .conf-card{
        background:white;
        border-radius:18px;
        padding:25px;

        display:flex;
        flex-direction:column;
        justify-content:space-between;

        height:100%;
        min-height:260px;

        box-shadow:0 10px 25px rgba(0,0,0,0.12);
        transition:all 0.35s ease;

        border-left:5px solid #2c5364;

        position:relative;
        overflow:hidden;
        }

        /* TOP GLOW LINE */

        .conf-card::before{
        content:"";
        position:absolute;
        top:0;
        left:0;
        width:100%;
        height:4px;
        background:linear-gradient(90deg,#0f2027,#2c5364,#00c853);
        opacity:0;
        transition:0.3s;
        }

        .conf-card:hover::before{
        opacity:1;
        }

        /* HOVER EFFECT */

        .conf-card:hover{
        transform:translateY(-8px) scale(1.02);
        box-shadow:0 20px 40px rgba(0,0,0,0.2);
        }

        /* TEXT */

        .conf-card h5{
        font-weight:600;
        color:#2c5364;
        }

        .conf-card p{
        font-size:14px;
        color:#555;
        }

        /* BUTTON ALIGNMENT */

        .conf-card form{
        margin-top:auto;
        }

        /* TABLE */

        .table-section{
        background:white;
        border-radius:18px;
        padding:30px;
        box-shadow:0 10px 25px rgba(0,0,0,0.12);
        }

        /* FOOTER */

        footer{
        background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
        color:white;
        text-align:center;
        padding:18px;
        margin-top:auto;
        }

        .profile-circle{
    width:40px;
    height:40px;
    border-radius:50%;
    background:#ff9800;
    color:white;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

.profile-circle:hover{
    transform:scale(1.1);
}

.dropdown-menu{
    border-radius:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
}
        .conf-card:hover i{
transform:scale(1.1);
transition:0.3s;
}

        /* COMPACT CARD DESIGN */
.conf-card{
    background:white;
    border-radius:14px;

    padding:16px;

    display:flex;
    flex-direction:column;
    justify-content:space-between;

    height:100%;
    min-height:190px;

    box-shadow:0 6px 15px rgba(0,0,0,0.10); /* lighter shadow */

    transition:all 0.3s ease;

    border-left:4px solid #2c5364;

    position:relative;
    overflow:hidden;
}

/* TEXT SIZE REDUCTION */
.conf-card h5{
    font-size:16px;
    margin-bottom:8px;
}

.conf-card p{
    font-size:15.5px;
    margin-bottom:4px;
}

/* BUTTON SIZE */
.conf-card .btn{
    font-size:12px;
    padding:6px 10px;
}

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-dark">

    <div class="container-fluid">

        <button class="menu-btn"
                data-bs-toggle="offcanvas"
                data-bs-target="#adminSidebar">

            <i class="fas fa-bars"></i>

        </button>

        <span class="navbar-brand fw-bold ms-2">
CRDMS Admin
</span>

        <div class="ms-auto d-flex gap-2">

            <button class="btn p-0 border-0 bg-transparent"
                    data-bs-toggle="modal"
                    data-bs-target="#adminProfileModal">

                <!-- PROFILE IMAGE OR LETTER -->
                <img src="https://ui-avatars.com/api/?name=${sessionScope.admin}&background=ff9800&color=fff&size=40"
                     class="rounded-circle border border-2 border-light"
                     width="40" height="40">

            </button>

        </div>

    </div>

</nav>

<!-- SIDEBAR -->

<div class="offcanvas offcanvas-start shadow"
     tabindex="-1"
     id="adminSidebar"
     style="width:270px;">

    <div class="offcanvas-header text-white"
         style="background:linear-gradient(135deg,#203a43,#2c5364);">

        <h5 class="offcanvas-title fw-bold">
            Admin Dashboard
        </h5>

        <button type="button"
                class="btn-close btn-close-white"
                data-bs-dismiss="offcanvas">
        </button>

    </div>

    <div class="offcanvas-body p-0">

        <div class="d-flex flex-column p-3 gap-3">

            <a href="${pageContext.request.contextPath}/admin/dashboard?filter=all"
               class="btn btn-outline-secondary rounded-pill fw-semibold">
                All Conferences
            </a>

            <a href="${pageContext.request.contextPath}/admin/dashboard?filter=pending"
               class="btn btn-outline-danger rounded-pill fw-semibold">
                Pending Conferences
            </a>

            <a href="${pageContext.request.contextPath}/admin/dashboard?filter=approved"
               class="btn btn-outline-success rounded-pill fw-semibold">
                Approved Conferences
            </a>

            <a href="${pageContext.request.contextPath}/admin/dashboard?filter=sent"
               class="btn btn-outline-secondary rounded-pill fw-semibold">
                Sent Conferences
            </a>

        </div>

    </div>

</div>

<!-- MAIN -->

<main class="flex-grow-1">

    <div class="container">

        <!-- PENDING -->

        <c:if test="${showPending}">
            <h3 class="section-title text-danger">Pending Conference Approvals</h3>

            <div class="row">
                <c:forEach var="conf" items="${conferenceList}">
                    <div class="col-md-4 mb-4" data-aos="fade-up">

                        <div class="conf-card">

                            <h5>${conf.conferenceTopic}</h5>

                            <p><strong>Host:</strong> ${conf.hostName}</p>
                            <p><strong>Email:</strong> ${conf.email}</p>
                            <p><strong>Audience:</strong> ${conf.targetedAudience}</p>
                            <p><strong>Date:</strong> ${conf.date}</p>
                            <p><strong>Time:</strong> ${conf.time}</p>

                            <form action="${pageContext.request.contextPath}/admin/approve" method="post">

                                <input type="hidden" name="id" value="${conf.id}">

                                <button class="btn btn-success w-100">
                                    <i class="fas fa-check-circle me-1"></i>
                                    Approve Conference
                                </button>

                            </form>

                        </div>

                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- APPROVED -->

        <c:if test="${showApproved}">
            <h3 class="section-title text-success">Approved Conferences</h3>

            <div class="row">
                <c:forEach var="conf" items="${conferenceList}">
                    <div class="col-md-4 mb-4" data-aos="fade-up">

                        <div class="conf-card">

                            <h5>${conf.conferenceTopic}</h5>

                            <p><strong>Host:</strong> ${conf.hostName}</p>
                            <p><strong>Email:</strong> ${conf.email}</p>
                            <p><strong>Audience:</strong> ${conf.targetedAudience}</p>
                            <p><strong>Date:</strong> ${conf.date}</p>
                            <p><strong>Time:</strong> ${conf.time}</p>

                            <form action="${pageContext.request.contextPath}/admin/sendToDelegates" method="post">

                                <input type="hidden" name="id" value="${conf.id}">

                                <button class="btn btn-primary w-100">
                                    <i class="fas fa-paper-plane me-1"></i>
                                    Send To Delegates
                                </button>

                            </form>

                        </div>

                    </div>
                </c:forEach>
            </div>
        </c:if>

    </div>

    <!-- SENT -->
    <c:if test="${showSent}">
        <section class="container mt-5">

            <h3 class="section-title text-center">
                Sent To Delegates Conferences
            </h3>

            <c:if test="${not empty successMsg}">
                <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                    ${successMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
                    ${errorMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <div class="row">


                <c:forEach var="conf" items="${conferenceList}">

                    <div class="col-md-4 mb-4" data-aos="fade-up">

                        <div class="conf-card">

                            <!-- TITLE -->
                            <h5>${conf.conferenceTopic}</h5>

                            <!-- DETAILS -->
                            <p><strong>Date:</strong> ${conf.date}</p>

                            <!-- STATUS -->
                            <p>
                                <strong>Status:</strong>
                                <c:choose>

                                    <c:when test="${conf.emailSent}">
                                        <span class="badge bg-success">Sent</span>
                                    </c:when>

                                    <c:when test="${conf.active}">
                                        <span class="badge bg-primary">Approved</span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="badge bg-warning">Pending</span>
                                    </c:otherwise>

                                </c:choose>
                            </p>

                            <!-- ACTION BUTTONS -->
                            <div class="d-flex gap-2 mt-3">

                                <!-- VIEW PARTICIPANTS -->
                                <form action="${pageContext.request.contextPath}/participantsAdmin"
                                      method="get" class="w-50">

                                    <input type="hidden"
                                           name="conferenceId"
                                           value="${conf.id}">

                                    <button class="btn btn-primary w-100 btn-sm">
                                        <i class="fas fa-users"></i>
                                        View
                                    </button>

                                </form>

                                <!-- SEND REMINDER -->
                                <form action="${pageContext.request.contextPath}/sendReminder"
                                      method="post" class="w-50">

                                    <input type="hidden"
                                           name="conferenceId"
                                           value="${conf.id}">

                                    <button class="btn btn-warning w-100 btn-sm">
                                        <i class="fas fa-bell"></i>
                                        Reminder
                                    </button>

                                </form>

                            </div>

                        </div>

                    </div>

                </c:forEach>

                <!-- EMPTY STATE -->
                <c:if test="${empty conferenceList}">
                    <div class="text-center text-muted">
                        No Conferences Sent To Delegates Yet
                    </div>
                </c:if>

            </div>

        </section>
    </c:if>

    <c:if test="${showAll}">

        <section class="container mt-5">

            <h3 class="section-title text-center">
                All Conferences
            </h3>

            <div class="row">

                <c:forEach var="conf" items="${conferenceList}">

                    <div class="col-md-4 mb-4" data-aos="fade-up">

                        <div class="conf-card">

                            <h5>${conf.conferenceTopic}</h5>

                            <p><strong>Host:</strong> ${conf.hostName}</p>
                            <p><strong>Email:</strong> ${conf.email}</p>
                            <p><strong>Audience:</strong> ${conf.targetedAudience}</p>
                            <p><strong>Date:</strong> ${conf.date}</p>
                            <p><strong>Time:</strong> ${conf.time}</p>

                        </div>

                    </div>

                </c:forEach>

                <c:if test="${empty conferenceList}">
                    <div class="text-center text-muted">
                        No Conferences Available
                    </div>
                </c:if>

            </div>

        </section>

    </c:if>

</main>
<div class="modal fade" id="adminProfileModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- PROFILE IMAGE -->
            <div class="modal-header border-0 justify-content-center pb-0">

                <div class="text-center">

                    <img src="https://ui-avatars.com/api/?name=${sessionScope.admin}&background=ff9800&color=fff&size=110"
                         class="rounded-circle shadow"
                         width="110" height="110">

                </div>

                <button class="btn-close position-absolute end-0 me-3"
                        data-bs-dismiss="modal"></button>

            </div>

            <!-- BODY -->
            <div class="modal-body text-center pt-3">

                <h5 class="fw-bold mb-1">
                    Admin
                </h5>

                <p class="text-muted mb-3">
                    ${sessionScope.admin}
                </p>

                <!-- LOGOUT BUTTON -->
                <div class="mt-4">

                    <a href="${pageContext.request.contextPath}/logoutAdmin"
                       class="btn btn-danger w-100">
                        <i class="fas fa-sign-out-alt me-2"></i>
                        Logout
                    </a>

                </div>

            </div>

        </div>
    </div>
</div>


<footer>
    © 2026 CRDMS Admin Dashboard | Secure Management Portal
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({duration:1000});
</script>

</body>
</html>