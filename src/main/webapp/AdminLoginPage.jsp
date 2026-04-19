<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CRDMS | Admin Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <!-- AOS -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>

        /* ================= GLOBAL ================= */

        body{
        font-family:'Segoe UI',sans-serif;
        background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
        min-height:100vh;
        display:flex;
        align-items:center;
        justify-content:center;
        overflow:hidden;
        position:relative;
        }

        /* Animated Background Blobs */

        body::before,
        body::after{
        content:"";
        position:absolute;
        width:400px;
        height:400px;
        border-radius:50%;
        filter:blur(120px);
        z-index:0;
        }

        body::before{
        background:#2c5364;
        top:-120px;
        left:-120px;
        opacity:0.25;
        animation:floatBlob 18s infinite alternate ease-in-out;
        }

        body::after{
        background:#203a43;
        bottom:-120px;
        right:-120px;
        opacity:0.25;
        animation:floatBlob 22s infinite alternate-reverse ease-in-out;
        }

        @keyframes floatBlob{
        0%{transform:translate(0,0) scale(1);}
        50%{transform:translate(60px,-40px) scale(1.1);}
        100%{transform:translate(-40px,40px) scale(1);}
        }

        /* ================= CARD ================= */

        .login-card{
        background:rgba(255,255,255,0.12);
        backdrop-filter:blur(18px);
        border-radius:22px;
        padding:40px 35px;
        width:100%;
        max-width:420px;
        box-shadow:0 20px 50px rgba(0,0,0,0.4);
        color:white;
        transition:all 0.4s ease;
        position:relative;
        z-index:2;
        }

        .login-card:hover{
        transform:translateY(-6px);
        box-shadow:0 30px 60px rgba(0,0,0,0.5);
        }

        /* ================= ICON ================= */

        .role-icon{
        font-size:50px;
        margin-bottom:15px;
        color:#ff9800;
        }

        /* ================= TEXT ================= */

        .login-card h3{
        font-weight:600;
        letter-spacing:0.5px;
        }

        .login-card p{
        font-size:14px;
        color:#dcdcdc;
        }

        /* ================= INPUT ================= */

        .form-control{
        border-radius:12px;
        padding:12px 14px;
        border:none;
        font-size:14px;
        background:rgba(255,255,255,0.9);
        transition:0.3s;
        }

        .form-control:focus{
        box-shadow:0 0 0 2px rgba(255,152,0,0.4);
        }

        /* ================= BUTTON ================= */

        .btn-role{
        background:linear-gradient(135deg,#ff9800,#ffb74d);
        border:none;
        border-radius:30px;
        padding:12px;
        font-weight:600;
        letter-spacing:0.3px;
        transition:all 0.3s ease;
        }

        .btn-role:hover{
        background:linear-gradient(135deg,#e68900,#ffa726);
        transform:scale(1.03);
        }

        /* ================= LINK ================= */

        .back-link{
        color:#00e676;
        text-decoration:none;
        font-size:14px;
        }

        .back-link:hover{
        text-decoration:underline;
        }

        /* ================= ALERT ================= */

        .alert{
        border-radius:10px;
        font-size:14px;
        }
        /* ================= GLOBAL FONT ================= */

body{
    font-family:'DM Sans',sans-serif;
}

/* ================= HEADINGS ================= */

.login-card h3{
    font-family:'Syne',sans-serif;
    font-weight:700;
    letter-spacing:0.4px;
}

/* ================= PARAGRAPH ================= */

.login-card p{
    font-family:'DM Sans',sans-serif;
    font-size:0.85rem;
    color:rgba(255,255,255,0.75);
}

/* ================= INPUT TEXT ================= */

.form-control{
    font-family:'DM Sans',sans-serif;
    font-size:0.85rem;
    letter-spacing:0.2px;
}

/* ================= BUTTON TEXT ================= */

.btn-role{
    font-family:'DM Sans',sans-serif;
    font-size:0.85rem;
    font-weight:600;
    letter-spacing:0.3px;
}

/* ================= BACK LINK ================= */

.back-link{
    font-family:'DM Sans',sans-serif;
    font-size:0.85rem;
}

/* ================= ALERT ================= */

.alert{
    font-family:'DM Sans',sans-serif;
    font-size:0.85rem;
}

    </style>

</head>

<body>

<div class="login-card text-center" data-aos="zoom-in">

    <i class="fas fa-user-shield role-icon"></i>

    <h3 class="mb-2">Admin Login Portal</h3>

    <p class="mb-4">
        Secure access to conference approvals & system management
    </p>

    <c:if test="${not empty errorMsg1}">
        <div class="alert alert-danger mt-2">
            ${errorMsg1}
        </div>
    </c:if>

    <form action="login" method="post">

        <div class="mb-3">
            <input type="email"
                   class="form-control"
                   placeholder="Admin Email"
                   name="email"
                   required>
        </div>

        <div class="mb-3">
            <input type="password"
                   class="form-control"
                   placeholder="Password"
                   name="password"
                   required>
        </div>

        <button type="submit" class="btn btn-role w-100">

            <i class="fas fa-lock me-2"></i>
            Login Securely

        </button>

    </form>

    <div class="mt-4">

        <a href="backToIndex" class="back-link">
            ← Back to Home
        </a>

    </div>

</div>

<!-- Scripts -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({
    duration:1000
    });
</script>

</body>
</html>