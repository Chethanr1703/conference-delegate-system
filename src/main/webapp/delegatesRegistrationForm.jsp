<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRDMS | Delegate Registration</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <!-- AOS -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body{
            font-family:'Segoe UI',sans-serif;
            background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        /* Glass Card */
        .register-card{
            background:rgba(255,255,255,0.1);
            backdrop-filter:blur(15px);
            border-radius:20px;
            padding:40px;
            width:100%;
            max-width:700px;
            box-shadow:0 15px 40px rgba(0,0,0,0.3);
            color:white;
            transition:0.4s;
        }

        .register-card:hover{
            transform:translateY(-5px);
        }

        /* Input Styling */
        .form-control, .form-select{
            border-radius:12px;
            padding:12px;
        }

        /* Button */
        .btn-register{
            background:#00c853;
            border:none;
            border-radius:30px;
            padding:12px;
            font-weight:600;
            transition:0.3s;
        }

        .btn-register:hover{
            background:#00a843;
        }

        /* Attendance Buttons */
        .btn-check:checked + .btn-success{
            background:#00a843 !important;
        }

        .btn-check:checked + .btn-danger{
            background:#c62828 !important;
        }

        .role-icon{
            font-size:45px;
            color:#00c853;
            margin-bottom:15px;
        }

        .back-link{
            color:#ff9800;
            text-decoration:none;
        }
        .back-link:hover{
            text-decoration:underline;
        }
    </style>
</head>

<body>

<div class="register-card" data-aos="zoom-in">

    <div class="text-center">
        <i class="fas fa-user-plus role-icon"></i>
        <h3 class="mb-2">Delegate Registration</h3>
        <p class="mb-4">Register as Student or Employee to attend conferences</p>
    </div>

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success">${successMsg}</div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${errorMsg}</div>
    </c:if>

    <form action="delegateRegister" method="post">

        <div class="row">

            <div class="col-md-6 mb-3">
                <input type="text" class="form-control"
                       placeholder="Full Name"
                       name="fullName" required>
            </div>

            <div class="col-md-6 mb-3">
                <input type="email" class="form-control"
                       placeholder="Email Address"
                       name="email" required>
            </div>

            <div class="col-md-6 mb-3">
                <input type="text" class="form-control"
                       placeholder="Mobile Number"
                       name="mobile" required>
            </div>

            <div class="col-md-6 mb-3">
                <input type="text" class="form-control"
                       placeholder="College / Company Name"
                       name="organization" required>
            </div>





            <!-- Attendance Selection -->
            <div class="col-12 mb-4 text-center">

                <label class="mb-2 d-block fw-bold">
                    Are you attending the conference?
                </label>

                <div class="d-flex justify-content-center gap-4">

                    <input type="radio" class="btn-check"
                           name="attending" id="yesOption"
                           value="YES" required>

                    <label class="btn btn-success px-4 py-2 rounded-pill"
                           for="yesOption">
                        <i class="fas fa-check-circle"></i> Yes, I Will Attend
                    </label>


                    <input type="radio" class="btn-check"
                           name="attending" id="noOption"
                           value="NO">

                    <label class="btn btn-danger px-4 py-2 rounded-pill"
                           for="noOption">
                        <i class="fas fa-times-circle"></i> No, Not Attending
                    </label>

                </div>

            </div>

        </div>

        <button type="submit" class="btn btn-register w-100">
            Register Now
        </button>

    </form>

    <div class="text-center mt-4">
        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>

</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({duration:1000});
</script>

</body>
</html>