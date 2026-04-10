<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CRDMS | Conference Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>

        /* BODY */

        body{
        font-family:'Segoe UI',sans-serif;
        background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
        height:100vh;
        overflow:hidden;
        display:flex;
        align-items:center;
        justify-content:center;
        }

        /* CARD */

        .form-card{
        background:rgba(255,255,255,0.08);
        backdrop-filter:blur(18px);
        border-radius:18px;
        padding:25px;
        width:100%;
        max-width:800px;
        color:white;
        box-shadow:0 12px 30px rgba(0,0,0,0.3);
        }

        /* TITLE */

        h3{
        font-size:20px;
        margin-bottom:10px !important;
        }

        /* INPUTS */

        .form-control{
        border-radius:10px;
        padding:8px 10px;
        font-size:14px;
        }

        /* LABEL */

        .section-label{
        font-weight:600;
        margin-top:10px;
        margin-bottom:5px;
        font-size:14px;
        color:#ffcc80;
        }

        /* BUTTON */

        .btn-main{
        background:#ff9800;
        border:none;
        border-radius:25px;
        padding:8px;
        font-size:14px;
        }

        .btn-main:hover{
        background:#e68900;
        }

        /* BOX */

        .option-box{
        border:1px solid rgba(255,255,255,0.2);
        border-radius:12px;
        padding:10px;
        margin-top:5px;
        }

        /* FILE BOX */

        .file-box{
        background:rgba(255,255,255,0.08);
        padding:8px;
        border-radius:8px;
        }

        /* SMALL TEXT */

        small{
        font-size:12px;
        color:#ddd;
        }

        /* RESPONSIVE SCALE */

        @media (max-height: 750px){
        .form-card{
        transform:scale(0.92);
        }
        }

    </style>

</head>

<body>

<div class="form-card" data-aos="zoom-in">

    <h3 class="text-center">
        <i class="fas fa-microphone"></i>
        Conference Registration
    </h3>

    <!-- SUCCESS / ERROR -->

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success text-center p-2">${successMsg}</div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger text-center p-2">${errorMsg}</div>
    </c:if>

    <form action="conferenceRegister" method="post" enctype="multipart/form-data">

        <div class="row g-2">

            <!-- HOST NAME -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="Host Name"
                       name="hostName"
                       value="${dto.hostName}">
            </div>

            <!-- EMAIL -->
            <div class="col-md-6">
                <input type="email" class="form-control"
                       placeholder="Host Email"
                       name="email"
                       value="${dto.email}">
            </div>

            <!-- TOPIC -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="Conference Topic"
                       name="conferenceTopic"
                       value="${dto.conferenceTopic}">
            </div>

            <!-- AUDIENCE -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="Target Audience"
                       name="targetedAudience"
                       value="${dto.targetedAudience}">
            </div>

            <!-- DATE -->
            <div class="col-md-6">
                <input type="date" class="form-control"
                       name="date"
                       value="${dto.date}">
            </div>

            <!-- TIME -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="hh:mm AM/PM"
                       name="time"
                       value="${dto.time}">
            </div>

            <!-- POSTER -->

            <div class="col-12">
                <label class="section-label">
                    <i class="fas fa-image"></i> Upload Poster
                </label>

                <div class="file-box">
                    <input type="file" class="form-control form-control-sm" name="poster">
                </div>
            </div>

            <!-- DELEGATES -->

            <div class="col-12">
                <label class="section-label">
                    <i class="fas fa-users"></i> Add Delegates
                </label>

                <div class="option-box">

                    <input type="text" class="form-control mb-1"
                           placeholder="Single Delegate Email"
                           name="delegatesEmail"
                           value="${dto.delegatesEmail}">

                    <div class="text-center small mb-1">OR</div>

                    <div class="file-box">

                        <div class="row g-1 align-items-center">

                            <div class="col-5">
                                <a href="${pageContext.request.contextPath}/downloadDelegateTemplate"
                                   class="btn btn-outline-light btn-sm w-100">
                                    <i class="fas fa-download"></i>
                                    Template
                                </a>
                            </div>

                            <div class="col-7">
                                <input type="file"
                                       name="delegateFile"
                                       class="form-control form-control-sm">
                            </div>

                        </div>

                    </div>

                    <small>Use single email OR Excel</small>

                </div>
            </div>

            <!-- SUBMIT -->

            <div class="col-12 text-center mt-2">
                <button type="submit" class="btn btn-main w-50">
                    Register Conference
                </button>
            </div>

        </div>

    </form>

    <div class="text-center mt-2">
        <a href="backToIndex" class="text-light small">
            ← Back to Home
        </a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({duration:800});
</script>

</body>
</html>