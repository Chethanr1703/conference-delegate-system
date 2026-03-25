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
        min-height:100vh;
        display:flex;
        align-items:center;
        justify-content:center;
        }

        /* CARD */

        .form-card{
        background:rgba(255,255,255,0.08);
        backdrop-filter:blur(18px);
        border-radius:20px;
        padding:40px;
        width:100%;
        max-width:950px;
        color:white;
        box-shadow:0 15px 40px rgba(0,0,0,0.35);
        transition:0.3s;
        }

        .form-card:hover{
        transform:translateY(-5px);
        }

        /* INPUTS */

        .form-control{
        border-radius:12px;
        padding:12px;
        }

        /* SECTION LABEL */

        .section-label{
        font-weight:600;
        margin-top:15px;
        color:#ffcc80;
        }

        /* BUTTON */

        .btn-main{
        background:#ff9800;
        border:none;
        border-radius:30px;
        padding:12px;
        font-weight:600;
        }

        .btn-main:hover{
        background:#e68900;
        }

        /* OPTION BOX */

        .option-box{
        border:1px solid rgba(255,255,255,0.2);
        border-radius:15px;
        padding:15px;
        margin-top:10px;
        }

        /* FILE BOX */

        .file-box{
        background:rgba(255,255,255,0.08);
        padding:12px;
        border-radius:10px;
        }

    </style>

</head>

<body>

<div class="form-card" data-aos="zoom-in">

    <h3 class="text-center mb-4">
        <i class="fas fa-microphone"></i>
        Conference Registration
    </h3>

    <!-- SUCCESS / ERROR -->

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success text-center">${successMsg}</div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger text-center">${errorMsg}</div>
    </c:if>

    <form action="conferenceRegister" method="post" enctype="multipart/form-data">

        <div class="row g-3">

            <!-- HOST NAME -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       placeholder="Host Name"
                       name="hostName"
                       value="${dto.hostName}">
                <div class="text-danger small">${hostNameError}</div>
            </div>

            <!-- EMAIL -->
            <div class="col-md-6">
                <input type="email" class="form-control"
                       placeholder="Host Email"
                       name="email"
                       value="${dto.email}">
                <div class="text-danger small">${emailError}</div>
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

            <!-- POSTER UPLOAD -->
            <div class="col-12">
                <label class="section-label">
                    <i class="fas fa-image"></i> Upload Conference Poster (Optional)
                </label>

                <div class="file-box">
                    <input type="file" class="form-control" name="poster">
                </div>
            </div>

            <!-- ================= DELEGATE SECTION ================= -->

            <div class="col-12">
                <label class="section-label">
                    <i class="fas fa-users"></i> Add Delegates
                </label>

                <div class="option-box">

                    <!-- SINGLE EMAIL -->

                    <input type="text" class="form-control mb-2"
                           placeholder="Single Delegate Email"
                           name="delegatesEmail"
                           value="${dto.delegatesEmail}">

                    <div class="text-center mb-2">OR</div>

                    <!-- BULK OPTION -->

                    <div class="file-box">

                            <div class="row g-2 align-items-center">

                            <div class="col-5">
                                <a href="${pageContext.request.contextPath}/downloadDelegateTemplate"
                                   class="btn btn-outline-light w-100 btn-sm">
                                    <i class="fas fa-download"></i>
                                    Download Template
                                </a>
                            </div>

                                <!-- FILE INPUT -->
                                <div class="col-7">
                                    <input type="file"
                                           name="delegateFile"
                                           class="form-control form-control-sm">
                                </div>

                            </div>

                        </form>
                    </div>

                    <small >
                        Use single email OR upload Excel (not both)
                    </small>

                </div>
            </div>

            <!-- SUBMIT -->

            <div class="col-12 text-center mt-3">
                <button type="submit" class="btn btn-main w-50">
                    Register Conference
                </button>
            </div>

        </div>

    </form>

    <div class="text-center mt-3">
        <a href="index.jsp" class="text-light">
            ← Back to Home
        </a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({duration:1000});
</script>

</body>
</html>