<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>CRDMS | Participants</title>

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
        }

        /* NAVBAR */

        .navbar{
        background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
        box-shadow:0 4px 12px rgba(0,0,0,0.25);
        }

        /* PAGE HEADER */

        .page-header{
        background:linear-gradient(135deg,#203a43,#2c5364);
        color:white;
        padding:40px 0;
        text-align:center;
        box-shadow:0 5px 15px rgba(0,0,0,0.25);
        }

        /* TABLE CARD */

        .table-card{
        background:white;
        border-radius:18px;
        padding:30px;
        box-shadow:0 10px 25px rgba(0,0,0,0.12);
        transition:0.3s;
        }

        .table-card:hover{
        transform:translateY(-4px);
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

        /* STATUS BADGES */

        .badge{
        font-size:12px;
        padding:6px 10px;
        border-radius:20px;
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

<span class="navbar-brand fw-bold">
CRDMS Admin
</span>

        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-warning btn-sm">
            Back
        </a>

    </div>

</nav>


<!-- HEADER -->

<section class="page-header">

    <div class="container" data-aos="fade-down">

        <h3>Conference Participants</h3>

        <p class="mt-2">
            Participants invited for this conference
        </p>

    </div>

</section>


<!-- PARTICIPANTS TABLE -->

<section class="container mt-5">

    <div class="table-card" data-aos="fade-up">

        <h4 class="mb-4">
            Participants List
        </h4>

        <table class="table table-hover">

            <thead>

            <tr>

                <th>#</th>
                <th>Name</th>
                <th>Email</th>
                <th>Organization</th>

                <th>Delegate Email</th>
                <th>Status</th>

            </tr>

            </thead>

            <tbody>

            <c:forEach var="p" items="${participantsList}" varStatus="loop">

                <tr>

                    <td>${loop.index + 1}</td>

                    <td>${p.fullName}</td>

                    <td>${p.email}</td>

                    <td>${p.organization}</td>

                    <td>${p.delegate.email}</td>

                    <td>

                        <c:choose>

                            <c:when test="${p.attending == 'yes'}">
                                <span class="badge bg-success">Attending</span>
                            </c:when>

                            <c:when test="${p.attending == 'no'}">
                                <span class="badge bg-danger">Declined</span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge bg-secondary">No Response</span>
                            </c:otherwise>

                        </c:choose>

                    </td>

                </tr>

            </c:forEach>

            <c:if test="${empty participantsList}">

                <tr>
                    <td colspan="5" class="text-center text-muted">
                        No Participants Found
                    </td>
                </tr>

            </c:if>

            </tbody>

        </table>

    </div>

</section>

<footer>

    © 2026 CRDMS Conference System

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