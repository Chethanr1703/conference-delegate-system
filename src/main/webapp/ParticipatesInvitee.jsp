<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Invite Participants | CRDMS</title>

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

        /* HEADER */

        .page-header{
        background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
        color:white;
        padding:60px 0;
        text-align:center;
        }

        /* MAIN PANEL */

        .main-panel{
        background:white;
        border-radius:12px;
        padding:30px;
        max-width:1000px;
margin:auto;
        box-shadow:0 10px 25px rgba(0,0,0,0.08);
        }

        /* OPTION TILES */

        .option-tile{

        border:2px solid #e9ecef;

        border-radius:14px;

        padding:30px;

        text-align:center;

        transition:all 0.3s ease;

        height:100%;

        }

        .option-tile:hover{

        border-color:#0d6efd;

        transform:translateY(-6px);

        box-shadow:0 8px 20px rgba(0,0,0,0.12);

        }

        .icon-box{

        font-size:38px;

        margin-bottom:12px;

        color:#0d6efd;

        }

        /* FILE INPUT */

        .file-box{

        background:#f8f9fa;

        padding:15px;

        border-radius:10px;

        margin-top:10px;

        }

        footer{
        background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);
        color:white;
        text-align:center;
        padding:15px;
        margin-top:60px;
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-dark">

    <div class="container-fluid">

<span class="navbar-brand fw-bold">
CRDMS
</span>

        <a href="delegatesPage.jsp" class="btn btn-warning btn-sm">
            <i class="fas fa-arrow-left"></i> Back
        </a>

    </div>

</nav>

<!-- HEADER -->

<section class="page-header">

    <div class="container" data-aos="fade-down">

        <h2>Invite Participants</h2>

        <p>Select how you want to submit invitees</p>

    </div>

</section>

<!-- MAIN PANEL -->

<section class="container mt-4">

    <div class="main-panel">

        <div class="row g-4 justify-content-center">

            <!-- BULK SUBMISSION -->

            <div class="col-md-5" data-aos="fade-right">
                <c:if test="${not empty successMsg}">
                    <div class="alert alert-success">
                        ${successMsg}
                    </div>
                </c:if>

                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger">
                        ${errorMsg}
                    </div>
                </c:if>

                <div class="option-tile">

                    <div class="icon-box">
                        <i class="fas fa-file-upload"></i>
                    </div>

                    <h4>Bulk Submission</h4>

                    <p class="text-muted">
                        Upload multiple participants using Excel template
                    </p>

                    <form action="${pageContext.request.contextPath}/downloadTemplate" method="get" class="mb-3">

                        <input type="hidden"
                               name="conferenceId"
                               value="${conferenceId}">

                        <button id="downloadBtn" class="btn btn-outline-primary w-100">

                            <i class="fas fa-download"></i>
                            Download Template

                        </button>

                    </form>

                    <div class="file-box">

                        <form action="${pageContext.request.contextPath}/uploadParticipants"
                              method="post"
                              enctype="multipart/form-data">

                            <input type="hidden"
                                   name="conferenceId"
                                   value="${conferenceId}" />

                            <input type="file"
                                   name="file"
                                   class="form-control mb-3"
                                   required />

                            <button id="uploadBtn" class="btn btn-success w-100"  >

                                <i class="fas fa-upload"></i>
                                Upload Participants

                            </button>

                        </form><c:if test="${not empty errors}">
                        <div class="alert alert-danger mt-3">
                            <ul>
                                <c:forEach var="e" items="${errors}">
                                    <li>${e}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    </div>

                </div>

            </div>

            <!-- INDIVIDUAL INVITEE -->

            <div class="col-md-5" data-aos="fade-left">

                <div class="option-tile">

                    <div class="icon-box">
                        <i class="fas fa-user-plus"></i>
                    </div>

                    <h4>Individual Invitee</h4>

                    <p class="text-muted">
                        Add participants manually one by one
                    </p>

                    <form action="individualInviteePage" method="get">

                        <input type="hidden"
                               name="conferenceId"
                               value="${conferenceId}">

                        <button class="btn btn-primary w-100 mt-3">

                            <i class="fas fa-user"></i>
                            Add Invitee

                        </button>

                    </form>

                </div>

            </div>

        </div>

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

<!--    const downloadBtn = document.getElementById("downloadBtn");-->
<!--    const uploadBtn = document.getElementById("uploadBtn");-->

<!--    downloadBtn.addEventListener("click", function () {-->

<!--        uploadBtn.disabled = false;-->

<!--    });-->

</script>

</script>

</body>

</html>