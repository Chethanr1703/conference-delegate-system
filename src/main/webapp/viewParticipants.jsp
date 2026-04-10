<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" xmlns:c="">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>CRDMS | Conference Participants</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>

        html,body{
        height:100%;
        }

        body{
        font-family:'Segoe UI',sans-serif;

        background:linear-gradient(135deg,#eef3f8,#dce6ef);

        display:flex;
        flex-direction:column;
        min-height:100vh;
        overflow-x:hidden;
        }

        /* NAVBAR */

        .navbar{
        background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
        box-shadow:0 4px 15px rgba(0,0,0,0.25);
        }

        /* HERO */

        .page-header{
        background:linear-gradient(135deg,#203a43,#2c5364);
        color:white;
        padding:20px 0;
        text-align:center;
        box-shadow:0 5px 15px rgba(0,0,0,0.25);
        }

        /* TABLE CARD */

        .table-card{

        background:white;

        border-radius:18px;

        padding:30px;

        box-shadow:0 12px 25px rgba(0,0,0,0.1);

        transition:0.3s;

        }

        .table-card:hover{

        transform:translateY(-4px);

        }

        /* TABLE */

        .table thead{

        background:#2c5364;

        color:white;

        }

        .table{

        border-radius:10px;

        overflow:hidden;

        }

        /* BADGE */

        .badge-status{

        font-size:13px;

        padding:6px 10px;

        border-radius:20px;

        }

        /* FOOTER */

        footer{

        background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);

        color:white;

        text-align:center;

        padding:15px 0;

        margin-top:auto;

        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-dark">

    <div class="container-fluid">

<span class="navbar-brand fw-bold">
CRDMS TPO / HR
</span>

        <a href="delegatesPage" class="btn btn-warning btn-sm">
            Back
        </a>

    </div>

</nav>

<!-- HEADER -->

<section class="page-header">

    <div class="container" data-aos="fade-down">

        <h3>
            Conference Participants
        </h3>

        <p class="mt-2">
            List of all invited participants for this conference
        </p>

    </div>

</section>

<!-- PARTICIPANTS TABLE -->

<section class="container mt-5">

    <div class="table-card" data-aos="fade-up">

        <h4 class="mb-4">
            Participants
        </h4>

        <table class="table table-hover">

            <thead>

            <tr>

                <th>#</th>

                <th>Name</th>

                <th>Email</th>

                <th>Organization</th>

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

                    <td>

                        <c:choose>

                            <c:when test="${p.attending == 'yes'}">

<span class="badge bg-success badge-status">
Attending
</span>

                            </c:when>

                            <c:otherwise>

<span class="badge bg-secondary badge-status">
Not Attending
</span>

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