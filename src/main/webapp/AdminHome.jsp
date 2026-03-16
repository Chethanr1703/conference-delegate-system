<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

        /* NAVBAR */

        .navbar{
        background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
        box-shadow:0 4px 12px rgba(0,0,0,0.25);
        }

        /* Hamburger Menu */

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

        /* Sidebar */

        .offcanvas-body{
        background:#f4f7fb;
        }

        .offcanvas-body a{
        transition:0.25s;
        }

        .offcanvas-body a:hover{
        transform:translateX(5px);
        }

        /* SECTION TITLES */

        .section-title{
        margin:60px 0 30px;
        font-weight:700;
        letter-spacing:0.5px;
        color:#1f2d3d;
        }

        /* CONFERENCE CARDS */

        .conf-card{
        background:white;
        border-radius:18px;
        padding:25px;
        box-shadow:0 10px 25px rgba(0,0,0,0.12);
        transition:all 0.3s ease;
        border-left:5px solid #2c5364;
        }

        .conf-card:hover{
        transform:translateY(-6px);
        box-shadow:0 16px 35px rgba(0,0,0,0.18);
        }

        .conf-card h5{
        font-weight:600;
        margin-bottom:12px;
        color:#2c5364;
        }

        .conf-card p{
        margin-bottom:6px;
        color:#555;
        font-size:14px;
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

        <a href="${pageContext.request.contextPath}/index.jsp"
           class="btn btn-warning btn-sm">
            Logout
        </a>

    </div>

</nav>


<!-- ADMIN SIDEBAR -->

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


<main class="flex-grow-1">

    <div class="container">

        <!-- PENDING SECTION -->

        <c:if test="${showPending}">

            <h3 class="section-title text-danger text-center">
                Pending Conference Approvals
            </h3>

            <div class="row">
                <c:forEach var="conf" items="${conferenceList}">

                <div class="col-md-4 mb-4">

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

                                Approve Conference

                            </button>

                        </form>

                    </div>

                </div>

                </c:forEach>
            </div>
            </c:if>

        </div>


        <!-- APPROVED SECTION -->
                <c:if test="${showApproved}">
        <h3 class="section-title text-success text-center">
            Approved Conferences
        </h3>

        <div class="row">
                <c:forEach var="conf" items="${conferenceList}">

                <div class="col-md-4 mb-4">

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

                                Send To Delegates

                            </button>

                        </form>

                    </div>

                </div>

                </c:forEach>
        </div>
            </c:if>



    </div>

    <c:if test="${showSent}">

        <section class="container mt-5">

            <div class="table-section">

                <h4 class="mb-3">Sent To Delegates Conferences</h4>

                <table class="table table-hover">

                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Conference</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:forEach var="conf" items="${conferenceList}">

                        <tr>

                            <td>${conf.id}</td>
                            <td>${conf.conferenceTopic}</td>
                            <td>${conf.date}</td>

                            <td>
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
                            </td>

                            <td>

                                <form action="${pageContext.request.contextPath}/participantsAdmin"
                                      method="get">

                                    <input type="hidden"
                                           name="conferenceId"
                                           value="${conf.id}">

                                    <button class="btn btn-sm btn-primary">
                                        View Participants
                                    </button>

                                </form>

                            </td>

                        </tr>

                    </c:forEach>

                    <c:if test="${empty conferenceList}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">
                                No Conferences Sent To Delegates Yet
                            </td>
                        </tr>
                    </c:if>

                    </tbody>

                </table>

            </div>

        </section>

    </c:if>

    <c:if test="${showAll}">

        <h3 class="section-title text-center">
            All Conferences
        </h3>

        <div class="row">

            <c:forEach var="conf" items="${conferenceList}">

                <div class="col-md-4 mb-4">

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

        </div>

    </c:if>

</main>


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