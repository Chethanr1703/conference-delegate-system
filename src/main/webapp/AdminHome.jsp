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

    <!-- ================= UI EDIT START ================= -->

    <style>

        html,body{
 height:100%;
 }

 body{
 font-family:'Segoe UI',sans-serif;

 /* slightly darker project gradient */
 background:linear-gradient(135deg,#e6edf4,#cfd9e3);

 display:flex;
 flex-direction:column;
 min-height:100vh;
 position:relative;
 overflow-x:hidden;
 }

 /* subtle pattern overlay */

 body::before{
 content:"";
 position:fixed;
 top:0;
 left:0;
 width:100%;
 height:100%;

 background-image:
 radial-gradient(circle at 25% 30%, rgba(44,83,100,0.08) 2px, transparent 2px),
 radial-gradient(circle at 75% 70%, rgba(44,83,100,0.08) 2px, transparent 2px);

 background-size:140px 140px;
 pointer-events:none;
 z-index:0;
 }

 /* NAVBAR */

 .navbar{
 background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
 box-shadow:0 4px 12px rgba(0,0,0,0.25);
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
 position:relative;
 z-index:1;
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

 /* BUTTON */

 .btn-admin{
 background:#2c5364;
 color:white;
 border:none;
 }

 .btn-admin:hover{
 background:#1e3c48;
 color:white;
 }

 /* TABLE SECTION */

 .table-section{
 background:white;
 border-radius:18px;
 padding:30px;
 box-shadow:0 10px 25px rgba(0,0,0,0.12);
 position:relative;
 z-index:1;
 }

 /* TABLE */

 .table{
 border-radius:10px;
 overflow:hidden;
 }

 .table thead{
 background:#2c5364;
 color:white;
 }

 /* FOOTER */

 footer{
 background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
 color:white;
 text-align:center;
 padding:18px;
 margin-top:auto;
 box-shadow:0 -4px 12px rgba(0,0,0,0.2);
 }
    </style>

    <!-- ================= UI EDIT END ================= -->

</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">CRDMS Admin</a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a class="nav-link" href="admin/dashboard">Dashboard</a></li>
            <li class="nav-item"><a class="nav-link text-warning" href="index.jsp">Logout</a></li>
        </ul>
    </div>
</nav>

<!-- ================= UI EDIT START ================= -->
<main class="flex-grow-1">


    <div class="container">

        <!-- ================= PENDING SECTION ================= -->

        <h3 class="section-title text-danger text-center">
            Pending Conference Approvals
        </h3>

        <div class="row">

            <c:forEach var="conf" items="${pendingList}">

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

                            <button type="submit" class="btn btn-success w-100">

                                <i class="fas fa-check-circle"></i>
                                Approve Conference

                            </button>

                        </form>

                    </div>

                </div>

            </c:forEach>

        </div>


        <!-- ================= APPROVED SECTION ================= -->

        <h3 class="section-title text-success text-center">
            Approved Conferences
        </h3>

        <div class="row">

            <c:forEach var="conf" items="${approvedList}">

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

                            <button type="submit" class="btn btn-primary w-100">

                                <i class="fas fa-paper-plane"></i>
                                Send To Delegates

                            </button>

                        </form>

                    </div>

                </div>

            </c:forEach>

        </div>

    </div>

    <section class="container mt-5">

        <div class="table-section" data-aos="fade-up">

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

                <c:forEach var="conf" items="${sentList}">

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

                            <form action="${pageContext.request.contextPath}/participantsAdmin" method="get" class="w-50">

                                <input type="hidden"
                                       name="conferenceId"
                                       value="${conf.id}">

                                <button  class="btn btn-sm btn-primary">
                                    View Participants
                                </button>

                            </form>

                        </td>

                    </tr>

                </c:forEach>

                <c:if test="${empty sentList}">
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

    <!-- ================= UI EDIT START ================= -->
</main>
<!-- ================= UI EDIT END ================= -->

<footer class="text-center">

    © 2026 CRDMS Admin Dashboard | Secure Management Portal

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({duration:1000});
</script>

</body>
</html>