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
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

    <style>
        :root {
    --deep:   #0f2027;
    --mid:    #203a43;
    --teal:   #2c5364;
    --orange: #ff9800;
    --green:  #00c853;
    --light-bg: #eef3f8;
    --card-bg:  #ffffff;
    --text-primary: #1a2a35;
    --text-muted:   #5a7080;
    --border: rgba(44,83,100,0.12);
}

/* ================= RESET ================= */
*, *::before, *::after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

html, body {
    height: 100%;
}

/* ================= GLOBAL TYPOGRAPHY ================= */
body {
    font-family: 'DM Sans', sans-serif;
    background: var(--light-bg);
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    overflow-x: hidden;
    color: var(--text-primary);
    font-size: 14px;
    line-height: 1.6;
    letter-spacing: 0.2px;
    position: relative;
}

h1, h2, h3, h4, h5 {
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    letter-spacing: 0.4px;
}

/* ================= BACKGROUND EFFECT ================= */
body::before,
body::after {
    content: "";
    position: fixed;
    width: 480px;
    height: 480px;
    border-radius: 50%;
    filter: blur(130px);
    z-index: -1;
}

body::before {
    background: var(--teal);
    top: -150px;
    left: -150px;
    opacity: 0.14;
}

body::after {
    background: var(--mid);
    bottom: -150px;
    right: -150px;
    opacity: 0.14;
}

/* ================= NAVBAR ================= */
.navbar {
    background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
    box-shadow: 0 4px 20px rgba(0,0,0,0.28);
    padding: 10px 0;
    position: sticky;
    top: 0;
    z-index: 1030;
}

.navbar-brand-text {
    font-family: 'Syne', sans-serif;
    font-size: 1.2rem;
    font-weight: 700;
    letter-spacing: 1.5px;
    background: linear-gradient(90deg, #fff 30%, var(--orange));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.navbar-sub {
    color: rgba(255,255,255,0.35);
    font-size: 0.75rem;
    letter-spacing: 1px;
}

.menu-btn {
    font-size: 20px;
    border: none;
    background: rgba(255,255,255,0.1);
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* BACK BUTTON */
.btn-back {
    background: rgba(255,255,255,0.12);
    color: white;
    border-radius: 8px;
    padding: 6px 14px;
    font-size: 0.8rem;
    text-decoration: none;
}

/* ================= PAGE HEADER ================= */
.page-header {
    background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));
    padding: 40px 0;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.page-header h1,
.page-header h2,
.page-header h3 {
    color: white;
}

.page-header .sub {
    color: rgba(255,255,255,0.65);
    font-size: 0.85rem;
}

/* ================= CARDS ================= */
.conf-card,
.table-card,
.option-tile {
    background: var(--card-bg);
    border-radius: 18px;
    padding: 24px;
    border: 1px solid var(--border);
    box-shadow: 0 6px 24px rgba(44,83,100,0.10);
    transition: 0.3s;
}

.conf-card:hover,
.table-card:hover,
.option-tile:hover {
    transform: translateY(-5px);
    box-shadow: 0 16px 40px rgba(44,83,100,0.18);
}

/* ================= TABLE ================= */
.table-wrapper {
    border-radius: 14px;
    overflow: hidden;
    border: 1px solid var(--border);
}

.table thead tr {
    background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
}

.table thead th {
    color: white;
    font-size: 0.7rem;
    font-family: 'Syne', sans-serif;
    letter-spacing: 1px;
    padding: 12px;
    border: none;
}

.table tbody td {
    font-size: 0.82rem;
    padding: 12px;
}

/* ================= PARTICIPANTS ================= */
.participant-avatar {
    width: 34px;
    height: 34px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--mid), var(--teal));
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
}

/* ================= STATUS ================= */
.status-badge {
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 0.72rem;
    font-weight: 700;
}

.status-attending {
    background: rgba(0,200,83,0.12);
    color: #00843a;
}

.status-declined {
    background: rgba(220,53,69,0.1);
    color: #b02a37;
}

/* ================= BUTTONS ================= */
.btn-tile-primary,
.btn-tile-outline,
.btn-tile-orange {
    border-radius: 10px;
    font-size: 0.82rem;
    padding: 10px;
    font-weight: 600;
    width: 100%;
}

.btn-tile-primary {
    background: linear-gradient(135deg, var(--mid), var(--teal));
    color: white;
    border: none;
}

.btn-tile-outline {
    background: transparent;
    color: var(--teal);
    border: 1.5px solid var(--teal);
}

.btn-tile-orange {
    background: linear-gradient(135deg, var(--orange), #e68900);
    color: white;
    border: none;
}

/* ================= ICON BOX ================= */
.icon-box {
    width: 60px;
    height: 60px;
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.4rem;
    margin: 0 auto 16px;
}

/* ================= ALERT ================= */
.alert {
    border-radius: 12px;
    font-size: 0.88rem;
}

/* ================= EMPTY ================= */
.empty-state {
    text-align: center;
    padding: 50px;
    color: var(--text-muted);
}

/* ================= FOOTER ================= */
footer {
    background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
    color: rgba(255,255,255,0.7);
    text-align: center;
    padding: 15px;
    font-size: 0.8rem;
    margin-top: auto;
}



        /* ─── RESPONSIVE ─────────────────────────────────────── */
        @media (max-width: 768px) {
            .page-header { padding: 34px 0 30px; }
            .option-tile  { padding: 26px 18px; }
        }
    </style>
</head>

<body>

<!-- ═══════════════════════════════════════════════════
     NAVBAR
════════════════════════════════════════════════════ -->
<nav class="navbar navbar-dark">
    <div class="container-fluid px-3">

        <div class="d-flex align-items-center gap-3">
            <span class="navbar-brand-text">CRDMS</span>
            <span class="navbar-sub">TPO / HR</span>
        </div>

        <div class="ms-auto">
            <a href="delegatesPage" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>

    </div>
</nav>

<!-- ═══════════════════════════════════════════════════
     PAGE HEADER
════════════════════════════════════════════════════ -->
<div class="page-header">
    <div class="ph-orb ph-orb-1"></div>
    <div class="ph-orb ph-orb-2"></div>
    <div class="container" data-aos="fade-up">
        <div class="page-header-badge"><i class="fas fa-envelope-open-text me-1"></i> Participant Management</div>
        <h2>Invite <span>Participants</span></h2>
        <p class="sub">Select how you want to submit invitees for this conference</p>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     MAIN CONTENT
════════════════════════════════════════════════════ -->
<main>
    <section class="container mt-5">

        <!-- ALERTS -->
        <c:if test="${not empty successMsg}">
            <div class="alert alert-success d-flex align-items-center gap-2 mb-4" data-aos="fade-down">
                <i class="fas fa-check-circle"></i>
                <span>${successMsg}</span>
            </div>
        </c:if>
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger d-flex align-items-center gap-2 mb-4" data-aos="fade-down">
                <i class="fas fa-exclamation-circle"></i>
                <span>${errorMsg}</span>
            </div>
        </c:if>

        <div class="row g-4 justify-content-center">

            <!-- ── BULK SUBMISSION ─────────────────────────── -->
            <div class="col-md-5" data-aos="fade-right">
                <div class="option-tile tile-bulk">

                    <div class="icon-box icon-bulk">
                        <i class="fas fa-file-upload"></i>
                    </div>

                    <h4>Bulk Submission</h4>
                    <p class="tile-desc">Upload multiple participants at once using our pre-formatted Excel template.</p>

                    <hr class="tile-divider">

                    <!-- Step 1: Download template -->
                    <div class="text-start mb-3">
                        <div style="font-size:0.72rem;font-weight:700;letter-spacing:1px;text-transform:uppercase;color:var(--text-muted);margin-bottom:8px;">
                            <i class="fas fa-circle-1 me-1" style="color:var(--teal);"></i> Step 1 — Download Template
                        </div>
                        <form action="${pageContext.request.contextPath}/downloadTemplate" method="get">
                            <input type="hidden" name="conferenceId" value="${conferenceId}">
                            <button id="downloadBtn" class="btn-tile-outline">
                                <i class="fas fa-download"></i> Download Template
                            </button>
                        </form>
                    </div>

                    <!-- Step 2: Upload file -->
                    <div class="text-start">
                        <div style="font-size:0.72rem;font-weight:700;letter-spacing:1px;text-transform:uppercase;color:var(--text-muted);margin-bottom:8px;">
                            <i class="fas fa-circle-2 me-1" style="color:var(--teal);"></i> Step 2 — Upload Filled File
                        </div>
                        <div class="file-box">
                            <form action="${pageContext.request.contextPath}/uploadParticipants"
                                  method="post"
                                  enctype="multipart/form-data">

                                <input type="hidden" name="conferenceId" value="${conferenceId}" />

                                <input type="file"
                                       name="file"
                                       class="form-control mb-3"
                                       required />

                                <button id="uploadBtn" class="btn-tile-primary">
                                    <i class="fas fa-upload"></i> Upload Participants
                                </button>

                            </form>

                            <c:if test="${not empty errors}">
                                <div class="error-list mt-3">
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
            </div>

            <!-- ── INDIVIDUAL INVITEE ──────────────────────── -->
            <div class="col-md-5" data-aos="fade-left">
                <div class="option-tile tile-manual">

                    <div class="icon-box icon-manual">
                        <i class="fas fa-user-plus"></i>
                    </div>

                    <h4>Individual Invitee</h4>
                    <p class="tile-desc">Add participants manually one by one with full control over each entry.</p>

                    <hr class="tile-divider">

                    <div style="font-size:0.72rem;font-weight:700;letter-spacing:1px;text-transform:uppercase;color:var(--text-muted);margin-bottom:12px;text-align:left;">
                        <i class="fas fa-user me-1" style="color:var(--orange);"></i> Add a Single Participant
                    </div>

                    <!-- Benefits list -->
                    <div class="text-start mb-4">
                        <div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;font-size:0.84rem;color:var(--text-muted);">
                            <span style="width:22px;height:22px;border-radius:50%;background:rgba(0,200,83,0.12);border:1px solid rgba(0,200,83,0.25);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                <i class="fas fa-check" style="font-size:0.6rem;color:var(--green);"></i>
                            </span>
                            Enter name, email and organisation
                        </div>
                        <div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;font-size:0.84rem;color:var(--text-muted);">
                            <span style="width:22px;height:22px;border-radius:50%;background:rgba(0,200,83,0.12);border:1px solid rgba(0,200,83,0.25);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                <i class="fas fa-check" style="font-size:0.6rem;color:var(--green);"></i>
                            </span>
                            Invite confirmation sent instantly
                        </div>
                        <div style="display:flex;align-items:center;gap:10px;font-size:0.84rem;color:var(--text-muted);">
                            <span style="width:22px;height:22px;border-radius:50%;background:rgba(0,200,83,0.12);border:1px solid rgba(0,200,83,0.25);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                <i class="fas fa-check" style="font-size:0.6rem;color:var(--green);"></i>
                            </span>
                            Track response from the dashboard
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/individualInviteePage"  method="get">
                        <input type="hidden" name="conferenceId" value="${conferenceId}">
                        <button class="btn-tile-orange">
                            <i class="fas fa-user-plus"></i> Add Invitee
                        </button>
                    </form>

                </div>
            </div>

        </div>
    </section>
</main>

<!-- ═══════════════════════════════════════════════════
     FOOTER
════════════════════════════════════════════════════ -->
<footer>
    © 2026 <span>CRDMS</span> Conference System
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 900, once: true, offset: 50 });

</script>

</body>
</html>
