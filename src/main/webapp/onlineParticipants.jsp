<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <title>CRDMS | Participant Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <!-- AOS -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        /* GLASS CARD */
        .register-card{
            background:rgba(255,255,255,0.08);
            backdrop-filter:blur(15px);
            border-radius:20px;
            padding:35px;
            width:100%;
            max-width:600px;
            box-shadow:0 15px 40px rgba(0,0,0,0.35);
            color:white;
            transition:0.3s;
        }

        .register-card:hover{
            transform:translateY(-5px);
        }

        /* TITLE */
        .title{
            font-family:'Outfit',sans-serif;
            font-weight:600;
            letter-spacing:1px;
        }

        /* INPUT */
        .form-control{
            border-radius:12px;
            padding:10px;
            font-size:14px;
        }

        /* BUTTON */
        .btn-main{
            background:#ff9800;
            border:none;
            border-radius:30px;
            padding:12px;
            font-weight:600;
            transition:0.3s;
        }

        .btn-main:hover{
            background:#e68900;
        }

        /* BACK */
        .back-link{
            color:#00c853;
            text-decoration:none;
        }

        .back-link:hover{
            text-decoration:underline;
        }

        /* ICON */
        .icon{
            font-size:40px;
            color:#ff9800;
            margin-bottom:10px;
        }

        /* FORM SECTION */
        .form-section{
            margin-top:20px;
        }

        /* ATTENDING BUTTON STYLE */
        .btn-check:checked + .btn-outline-success {
            background:#00c853;
            color:white;
            border:none;
        }

        .btn-check:checked + .btn-outline-danger {
            background:#ff5252;
            color:white;
            border:none;
        }
body {
    font-family: 'DM Sans', sans-serif;
}

/* ================= HEADINGS ================= */

.title,
h1, h2, h3, h4, h5 {
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    letter-spacing: 0.4px;
}

/* ================= PARAGRAPH ================= */

p {
    font-family: 'DM Sans', sans-serif;
    font-size: 0.85rem;
    color: rgba(255,255,255,0.75); /* keep dark theme */
}

/* ================= INPUT TEXT ================= */

.form-control {
    font-family: 'DM Sans', sans-serif;
    font-size: 0.85rem;
    letter-spacing: 0.2px;
}

/* ================= BUTTON TEXT ================= */

.btn-main {
    font-family: 'DM Sans', sans-serif;
    font-size: 0.85rem;
    font-weight: 600;
    letter-spacing: 0.3px;
}

/* ================= LABEL TEXT ================= */

label {
    font-family: 'DM Sans', sans-serif;
    font-size: 0.85rem;
}

/* ================= BACK LINK ================= */

.back-link {
    font-family: 'DM Sans', sans-serif;
    font-size: 0.85rem;
}

/* ================= ALERT ================= */

.alert {
    font-family: 'DM Sans', sans-serif;
    font-size: 0.85rem;
}
    </style>
</head>

<body>

<div class="register-card" data-aos="zoom-in">

    <div class="text-center">
        <i class="fas fa-user-plus icon"></i>
        <h3 class="title">Participant Registration</h3>
        <p class="mb-3">Register yourself for the conference</p>
    </div>

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success text-center">
            ${successMsg}
        </div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger text-center">
            ${errorMsg}
        </div>
    </c:if>
    <form action="onlineParticipantRegister" method="post">

        <input type="hidden" name="conferenceId" value="${param.confId}">
        <div class="row g-3 form-section">

            <!-- NAME -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       name="fullName"
                       placeholder="Full Name" required>
            </div>

            <!-- EMAIL -->
            <div class="col-md-6">
                <input type="email" class="form-control"
                       name="email"
                       placeholder="Email Address" required>
            </div>

            <!-- MOBILE -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       name="mobile"
                       placeholder="Mobile Number">
            </div>

            <!-- ORGANIZATION -->
            <div class="col-md-6">
                <input type="text" class="form-control"
                       name="organization"
                       placeholder="College / Company">
            </div>

            <!-- ATTENDING -->
            <div class="mb-3 text-center">

                <label class="mb-2 fw-semibold d-block">
                    Will you attend the conference?
                </label>

                <div class="d-flex justify-content-center gap-3">

                    <!-- YES -->
                    <input type="radio" class="btn-check"
                           name="attending"
                           id="yes"
                           value="Yes" required>

                    <label class="btn btn-outline-success px-4 rounded-pill" for="yes">
                        Yes, I will attend
                    </label>

                    <!-- NO -->
                    <input type="radio" class="btn-check"
                           name="attending"
                           id="no"
                           value="No">

                    <label class="btn btn-outline-danger px-4 rounded-pill" for="no">
                        No, I cannot attend
                    </label>

                </div>

            </div>

            <!-- SUBMIT -->
            <div class="col-12 text-center mt-4">
                <button type="submit" class="btn btn-main w-50">
                    Register Now
                </button>
            </div>

        </div>

    </form>

    <div class="text-center mt-4">
        <a href="backToIndex" class="back-link">
            ← Back to Home
        </a>
    </div>

</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({duration:1000});
</script>

</body>
</html>