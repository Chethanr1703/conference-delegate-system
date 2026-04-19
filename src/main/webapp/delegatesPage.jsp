<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CRDMS | TPO / HR Dashboard</title>

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

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--light-bg);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
            color: var(--text-primary);
        }

        /* ─── BACKGROUND BLOBS ───────────────────────────────── */
        body::before, body::after {
            content: "";
            position: fixed;
            width: 480px; height: 480px;
            border-radius: 50%;
            filter: blur(130px);
            z-index: -1;
            pointer-events: none;
        }
        body::before {
            background: var(--teal);
            top: -150px; left: -150px;
            opacity: 0.15;
            animation: floatBlob 18s infinite alternate ease-in-out;
        }
        body::after {
            background: var(--mid);
            bottom: -150px; right: -150px;
            opacity: 0.15;
            animation: floatBlob 22s infinite alternate-reverse ease-in-out;
        }
        @keyframes floatBlob {
            0%   { transform: translate(0,0) scale(1); }
            50%  { transform: translate(60px,-40px) scale(1.1); }
            100% { transform: translate(-40px,40px) scale(1); }
        }

        /* ─── NAVBAR ─────────────────────────────────────────── */
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
            font-size: 1.25rem;
            font-weight: 800;
            letter-spacing: 2px;
            background: linear-gradient(90deg, #fff 30%, var(--orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .navbar-sub {
            color: rgba(255,255,255,0.35);
            font-size: 0.72rem;
            font-weight: 500;
            letter-spacing: 1px;
        }
        .menu-btn {
            font-size: 20px;
            border: none;
            background: rgba(255,255,255,0.1);
            color: white;
            width: 40px; height: 40px;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            transition: all 0.3s;
        }
        .menu-btn:hover { background: rgba(255,255,255,0.2); transform: scale(1.08); }

        /* ─── SIDEBAR ────────────────────────────────────────── */
        .offcanvas { width: 280px !important; border: none; }
        .offcanvas-header {
            background: linear-gradient(135deg, var(--deep), var(--teal));
            padding: 20px 22px;
        }
        .offcanvas-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.1rem;
            font-weight: 800;
            letter-spacing: 1px;
            background: linear-gradient(90deg, #fff 30%, var(--orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .offcanvas-body {
            background: var(--card-bg);
            padding: 22px 16px !important;
        }
        .sidebar-label {
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--text-muted);
            padding: 0 10px;
            margin-bottom: 10px;
            margin-top: 6px;
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 16px;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-primary);
            text-decoration: none;
            transition: all 0.25s;
            border: 1px solid transparent;
        }
        .sidebar-link:hover {
            background: linear-gradient(90deg, rgba(44,83,100,0.08), rgba(255,152,0,0.06));
            border-color: var(--border);
            color: var(--teal);
            transform: translateX(4px);
        }
        .sidebar-icon {
            width: 34px; height: 34px;
            border-radius: 9px;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.85rem;
            flex-shrink: 0;
        }
        .icon-all   { background: rgba(44,83,100,0.1);  color: var(--teal); }
        .icon-acc   { background: rgba(0,200,83,0.1);   color: var(--green); }
        .icon-inv   { background: rgba(255,152,0,0.12); color: var(--orange); }
        .sidebar-divider { border-color: var(--border); margin: 14px 0; }

        /* ─── PAGE HEADER ────────────────────────────────────── */
        .page-header {
            background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));

            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .page-header::before {
            content:"";
            position:absolute; inset:0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }
        .ph-orb {
            position: absolute; border-radius: 50%;
            filter: blur(70px); pointer-events: none;
        }
        .ph-orb-1 { width:240px; height:240px; background:rgba(255,152,0,0.15); top:-90px; right:5%; }
        .ph-orb-2 { width:160px; height:160px; background:rgba(0,200,83,0.1);   bottom:-60px; left:4%; }

        .page-header-badge {
            display: inline-block;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.22);
            border-radius: 30px;
            padding: 4px 16px;
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--orange);
            margin-bottom: 12px;
        }
        .page-header h2 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(1.5rem, 3vw, 2.1rem);
            font-weight: 800;
            color: white;
            line-height: 1.2;
        }
        .page-header h2 span {
            background: linear-gradient(90deg, var(--orange), #ffd54f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .page-header .sub {
            color: rgba(255,255,255,0.6);
            font-size: 0.9rem;
            margin-top: 8px;
            letter-spacing: 0.3px;
        }
        .page-header .sub i { color: var(--orange); margin: 0 4px; }

        /* Quick stat pills in header */
        .header-pills {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin-top: 18px;
        }
        .header-pill {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.18);
            border-radius: 20px;
            padding: 5px 14px;
            font-size: 0.78rem;
            color: rgba(255,255,255,0.75);
        }
        .header-pill i { color: var(--orange); margin-right: 5px; }

        /* ─── SECTION HEADING ────────────────────────────────── */
        .section-heading {
            font-family: 'Syne', sans-serif;
            font-size: 1.35rem;
            font-weight: 800;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 50px 0 26px;
        }
        .sh-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 13px;
            border-radius: 20px;
            font-size: 0.74rem;
            font-weight: 700;
        }
        .sh-invite  { background: rgba(44,83,100,0.1);  color: var(--teal);  border: 1px solid rgba(44,83,100,0.2); }
        .sh-success { background: rgba(0,200,83,0.1);   color: #00843a;       border: 1px solid rgba(0,200,83,0.2); }
        .sh-all     { background: rgba(255,152,0,0.1);  color: #e68900;       border: 1px solid rgba(255,152,0,0.22); }

        /* ─── FEATURE CARD ───────────────────────────────────── */
        .feature-card {
            background: var(--card-bg);
            border-radius: 18px;
            padding: 24px 22px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
            min-height: 230px;
            box-shadow: 0 6px 24px rgba(44,83,100,0.10);
            border: 1px solid var(--border);
            border-left: 4px solid var(--teal);
            position: relative;
            overflow: hidden;
            transition: all 0.35s cubic-bezier(0.23,1,0.32,1);
        }
        .feature-card::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--teal), var(--orange), var(--green));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }
        .feature-card:hover::before { transform: scaleX(1); }
        .feature-card:hover {
            transform: translateY(-8px) scale(1.01);
            box-shadow: 0 20px 45px rgba(44,83,100,0.18);
        }

        .card-topic-label {
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 1.2px;
            text-transform: uppercase;
            color: var(--text-muted);
            margin-bottom: 5px;
        }
        .feature-card h4 {
            font-family: 'Syne', sans-serif;
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--teal);
            margin-bottom: 14px;
            line-height: 1.3;
        }
        .conf-detail {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.83rem;
            color: var(--text-muted);
            margin-bottom: 6px;
        }
        .conf-detail i {
            width: 16px;
            color: var(--teal);
            font-size: 0.76rem;
            opacity: 0.85;
            transition: transform 0.3s;
        }
        .feature-card:hover .conf-detail i { transform: scale(1.15); }
        .conf-detail strong { color: var(--text-primary); font-weight: 600; }

        /* ─── CARD BUTTONS ───────────────────────────────────── */
        .feature-card form { margin-top: auto; }
        .feature-card .btn {
            border-radius: 10px;
            font-size: 0.83rem;
            font-weight: 600;
            padding: 9px 14px;
            transition: all 0.25s;
            border: none;
        }
        .feature-card .btn:hover { transform: translateY(-2px); box-shadow: 0 6px 16px rgba(0,0,0,0.14); }

        .btn-accept {
            background: linear-gradient(135deg, #00c853, #00a843);
            color: white;
        }
        .btn-accept:hover { background: linear-gradient(135deg, #00a843, #008c39); color: white; }

        .btn-decline {
            background: linear-gradient(135deg, #ef5350, #c62828);
            color: white;
        }
        .btn-decline:hover { background: linear-gradient(135deg, #c62828, #b71c1c); color: white; }

        .btn-send-inv {
            background: linear-gradient(135deg, var(--mid), var(--teal));
            color: white;
        }
        .btn-send-inv:hover { background: linear-gradient(135deg, var(--deep), var(--mid)); color: white; }

        .btn-view-part {
            background: transparent;
            color: var(--teal);
            border: 1.5px solid var(--teal) !important;
        }
        .btn-view-part:hover {
            background: var(--teal);
            color: white;
        }

        /* ─── EMPTY STATE ────────────────────────────────────── */
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            color: var(--text-muted);
            width: 100%;
        }
        .empty-state-icon {
            width: 70px; height: 70px;
            border-radius: 20px;
            background: linear-gradient(135deg, rgba(44,83,100,0.07), rgba(255,152,0,0.07));
            border: 1px solid var(--border);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.6rem;
            color: rgba(44,83,100,0.28);
            margin: 0 auto 16px;
        }
        .empty-state p { font-size: 0.9rem; }

        /* ─── PROFILE MODAL ──────────────────────────────────── */
        .modal-content { border-radius: 20px; border: none; overflow: hidden; }
        .profile-modal-header {
            background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));
            padding: 30px 20px 22px;
            text-align: center;
            position: relative;
        }
        .profile-modal-body { background: #f8fbfd; padding: 24px 28px 28px; }
        .profile-detail-row {
            display: flex; align-items: center; gap: 12px;
            padding: 12px 16px;
            background: white;
            border: 1px solid var(--border);
            border-radius: 12px;
            margin-bottom: 10px;
        }
        .profile-detail-icon {
            width: 36px; height: 36px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--deep), var(--teal));
            display: flex; align-items: center; justify-content: center;
            color: white; font-size: 0.82rem; flex-shrink: 0;
        }
        .profile-detail-label { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: var(--text-muted); }
        .profile-detail-value { font-size: 0.88rem; font-weight: 600; color: var(--text-primary); word-break: break-all; }
        .btn-logout {
            background: linear-gradient(135deg, #dc3545, #b02a37);
            color: white; border: none;
            padding: 11px 0; border-radius: 12px;
            font-weight: 700; font-size: 0.9rem;
            width: 100%; transition: all 0.3s;
            display: block; text-align: center; text-decoration: none;
        }
        .btn-logout:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(220,53,69,0.35); color: white; }

        /* ─── FOOTER ─────────────────────────────────────────── */
        footer {
            background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
            color: rgba(255,255,255,0.65);
            text-align: center;
            padding: 18px;
            font-size: 0.82rem;
            margin-top: auto;
        }
        footer span { color: var(--orange); font-weight: 600; }

        /* ─── MAIN ───────────────────────────────────────────── */
        main { flex-grow: 1; padding-bottom: 55px; }

        @media (max-width: 768px) {
            .page-header { padding: 30px 0 26px; }
            .header-pills { display: none; }
        }/* ================= ROOT COLORS ================= */
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

/* ================= GLOBAL ================= */
*,
*::before,
*::after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

html, body {
    height: 100%;
}

body {
    font-family: 'DM Sans', sans-serif;
    background: var(--light-bg);
    color: var(--text-primary);
    display: flex;
    flex-direction: column;
    min-height: 100vh;

    /* ✨ IMPROVED TEXT LOOK */
    letter-spacing: 0.4px;
    line-height: 1.6;
}

/* ================= NAVBAR ================= */
.navbar-brand-text {
    font-family: 'Syne', sans-serif;
    font-size: 1.15rem;
    font-weight: 700;
    letter-spacing: 1.5px;
}

.navbar-sub {
    font-size: 0.72rem;
    letter-spacing: 1px;
    color: rgba(255,255,255,0.5);
}

/* ================= PAGE HEADER ================= */
.page-header h2 {
    font-family: 'Syne', sans-serif;
    font-size: 1.8rem;
    font-weight: 700;
    letter-spacing: 0.5px;
}

.page-header .sub {
    font-size: 0.88rem;
    letter-spacing: 0.4px;
}

/* ================= SECTION HEADING ================= */
.section-heading {
    font-family: 'Syne', sans-serif;
    font-size: 1.2rem;
    font-weight: 700;
    letter-spacing: 0.6px;
}

/* ================= CARD ================= */
.feature-card {
    background: var(--card-bg);
    border-radius: 18px;
    padding: 22px;
    min-height: 230px;

    box-shadow: 0 6px 24px rgba(44,83,100,0.10);
    border: 1px solid var(--border);
    border-left: 4px solid var(--teal);

    display: flex;
    flex-direction: column;
    justify-content: space-between;

    transition: all 0.35s ease;
}

.feature-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 18px 35px rgba(44,83,100,0.18);
}

/* ================= CARD TITLE ================= */
.feature-card h4 {
    font-family: 'Syne', sans-serif;
    font-size: 0.95rem;
    font-weight: 600;
    line-height: 1.4;
    color: var(--teal);
    margin-bottom: 12px;
}

/* ================= LABEL ================= */
.card-topic-label {
    font-size: 0.65rem;
    letter-spacing: 1.5px;
    font-weight: 600;
    color: var(--text-muted);
}

/* ================= DETAILS ================= */
.conf-detail {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.78rem;
    color: var(--text-muted);
    margin-bottom: 7px;
    line-height: 1.5;
}

.conf-detail strong {
    font-weight: 600;
    color: var(--text-primary);
}

.conf-detail i {
    font-size: 0.75rem;
    color: var(--teal);
}

/* ================= BUTTONS ================= */
.feature-card .btn {
    font-size: 0.78rem;
    font-weight: 600;
    letter-spacing: 0.4px;
    border-radius: 10px;
    padding: 9px 14px;
    transition: 0.3s;
}

.feature-card .btn:hover {
    transform: translateY(-2px);
}

/* ================= BUTTON COLORS ================= */
.btn-accept {
    background: linear-gradient(135deg, #00c853, #00a843);
    color: white;
}

.btn-decline {
    background: linear-gradient(135deg, #ef5350, #c62828);
    color: white;
}

.btn-send-inv {
    background: linear-gradient(135deg, var(--mid), var(--teal));
    color: white;
}

.btn-view-part {
    background: transparent;
    border: 1.5px solid var(--teal);
    color: var(--teal);
}

.btn-view-part:hover {
    background: var(--teal);
    color: white;
}

/* ================= EMPTY STATE ================= */
.empty-state {
    text-align: center;
    padding: 60px 30px;
}

.empty-state p {
    font-size: 0.9rem;
    color: var(--text-muted);
}

/* ================= PROFILE ================= */
.profile-detail-label {
    font-size: 0.68rem;
    letter-spacing: 1px;
    color: var(--text-muted);
}

.profile-detail-value {
    font-size: 0.85rem;
    font-weight: 600;
}

/* ================= FOOTER ================= */
footer {
    background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
    color: rgba(255,255,255,0.7);
    text-align: center;
    padding: 15px;
    font-size: 0.8rem;
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
            <button class="menu-btn"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#dashboardOffcanvas"
                    aria-label="Open sidebar">
                <i class="fas fa-bars"></i>
            </button>
            <span class="navbar-brand-text">CRDMS</span>
            <span class="navbar-sub">TPO / HR</span>
        </div>

        <div class="ms-auto">
            <button class="btn p-0 border-0 bg-transparent"
                    data-bs-toggle="modal"
                    data-bs-target="#adminProfileModal"
                    title="Profile">
                <img src="https://ui-avatars.com/api/?name=${sessionScope.delegate.email}&background=ff9800&color=fff&size=40"
                     class="rounded-circle border border-2"
                     style="border-color:rgba(255,255,255,0.3) !important;"
                     width="40" height="40"
                     alt="Delegate Avatar">
            </button>
        </div>

    </div>
</nav>

<!-- ═══════════════════════════════════════════════════
     SIDEBAR
════════════════════════════════════════════════════ -->
<div class="offcanvas offcanvas-start shadow" tabindex="-1" id="dashboardOffcanvas">

    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Dashboard</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>

    <div class="offcanvas-body">

        <div class="sidebar-label">Conferences</div>

        <a href="${pageContext.request.contextPath}/allConference" class="sidebar-link">
            <span class="sidebar-icon icon-all"><i class="fas fa-th-large"></i></span>
            All Conferences
        </a>

        <a href="${pageContext.request.contextPath}/acceptedConferences" class="sidebar-link">
            <span class="sidebar-icon icon-acc"><i class="fas fa-check-circle"></i></span>
            Accepted Conferences
        </a>

        <a href="${pageContext.request.contextPath}/delegatesPage" class="sidebar-link">
            <span class="sidebar-icon icon-inv"><i class="fas fa-envelope-open-text"></i></span>
            View Invitations
        </a>

        <hr class="sidebar-divider">

        <div class="sidebar-label">Account</div>

        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link" style="color:#dc3545;">
            <span class="sidebar-icon" style="background:rgba(220,53,69,0.1);color:#dc3545;"><i class="fas fa-sign-out-alt"></i></span>
            Logout
        </a>

    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     PAGE HEADER
════════════════════════════════════════════════════ -->
<div class="page-header">
    <div class="ph-orb ph-orb-1"></div>
    <div class="ph-orb ph-orb-2"></div>
    <div class="container" data-aos="fade-up">
        <div class="page-header-badge"><i class="fas fa-user-tie me-1"></i> TPO / HR Portal</div>
        <h2>Welcome to Your <span>Conference Portal</span></h2>
        <p class="sub">
            <i class="fas fa-envelope-open-text"></i> View Invitations
            <i class="fas fa-circle" style="font-size:0.3rem;opacity:0.5;"></i>
            <i class="fas fa-check-circle"></i> Confirm Participation
            <i class="fas fa-circle" style="font-size:0.3rem;opacity:0.5;"></i>
            <i class="fas fa-chart-bar"></i> Track Conferences
        </p>
        <div class="header-pills">
            <span class="header-pill"><i class="fas fa-calendar-check"></i> Manage Events</span>
            <span class="header-pill"><i class="fas fa-users"></i> Invite Participants</span>
            <span class="header-pill"><i class="fas fa-bell"></i> Stay Updated</span>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     MAIN CONTENT
════════════════════════════════════════════════════ -->
<!-- ═══════════════════════════════════════════════════
     MAIN CONTENT
════════════════════════════════════════════════════ -->
<main>

    <!-- ── INVITATIONS ─────────────────────────────── -->
    <c:if test="${showInvitations}">
        <section class="container">

            <div class="section-heading" data-aos="fade-right">
                Conference Invitations
                <span class="sh-badge sh-invite">
                    <i class="fas fa-envelope-open-text"></i> Action Required
                </span>
            </div>

            <div class="row g-4">
                <c:forEach var="conf" items="${conferenceList}">
                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                        <div class="feature-card">
                            <div>
                                <div class="card-topic-label">Conference Topic</div>
                                <h4>${conf.conferenceTopic}</h4>

                                <div class="conf-detail">
                                    <i class="fas fa-user"></i>
                                    <span><strong>Host:</strong> ${conf.hostName}</span>
                                </div>

                                <div class="conf-detail">
                                    <i class="fas fa-calendar"></i>
                                    <span><strong>Date:</strong> ${conf.date}</span>
                                </div>

                                <div class="conf-detail">
                                    <i class="fas fa-clock"></i>
                                    <span><strong>Time:</strong> ${conf.time}</span>
                                </div>
                            </div>

                            <form action="respondConference" method="post" style="margin-top:18px;">
                                <input type="hidden" name="id" value="${conf.id}">

                                <div class="d-flex gap-2">
                                    <button name="response" value="accepted" class="btn btn-accept w-50">
                                        <i class="fas fa-check me-1"></i>Accept
                                    </button>

                                    <button name="response" value="decline" class="btn btn-decline w-50">
                                        <i class="fas fa-times me-1"></i>Decline
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty conferenceList}">
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-envelope-open"></i>
                        </div>
                        <p>No pending invitations at the moment.</p>
                    </div>
                </c:if>

            </div>

        </section>
    </c:if>

    <!-- ── ACCEPTED ────────────────────────────────── -->
    <c:if test="${showAccepted}">
        <section class="container">

            <div class="section-heading" data-aos="fade-right">
                Accepted Conferences
                <span class="sh-badge sh-success">
                    <i class="fas fa-check-circle"></i> Confirmed
                </span>
            </div>

            <div class="row g-4">
                <c:forEach var="conf" items="${acceptedConferenceList}">
                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                        <div class="feature-card">

                            <div>
                                <div class="card-topic-label">Conference Topic</div>
                                <h4>${conf.conferenceTopic}</h4>

                                <div class="conf-detail">
                                    <i class="fas fa-user"></i>
                                    <span><strong>Host:</strong> ${conf.hostName}</span>
                                </div>

                                <div class="conf-detail">
                                    <i class="fas fa-calendar"></i>
                                    <span><strong>Date:</strong> ${conf.date}</span>
                                </div>

                                <div class="conf-detail">
                                    <i class="fas fa-clock"></i>
                                    <span><strong>Time:</strong> ${conf.time}</span>
                                </div>
                            </div>

                            <div class="d-flex gap-2 mt-3">

                                <form action="loadParticipantsPage" method="get" class="w-50">
                                    <input type="hidden" name="conferenceId" value="${conf.id}">
                                    <button class="btn btn-send-inv w-100">
                                        <i class="fas fa-paper-plane me-1"></i>Send Invitee
                                    </button>
                                </form>

                                <form action="participants" method="get" class="w-50">
                                    <input type="hidden" name="conferenceId" value="${conf.id}">
                                    <button class="btn btn-view-part w-100">
                                        <i class="fas fa-users me-1"></i>View
                                    </button>
                                </form>

                            </div>

                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty acceptedConferenceList}">
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <p>No accepted conferences yet.</p>
                    </div>
                </c:if>

            </div>

        </section>
    </c:if>

    <!-- ── ALL CONFERENCES ─────────────────────────── -->
    <c:if test="${showAllConference}">
        <section class="container">

            <div class="section-heading" data-aos="fade-right">
                All Conferences
                <span class="sh-badge sh-all">
                    <i class="fas fa-th-large"></i> Complete List
                </span>
            </div>

            <div class="row g-4">
                <c:forEach var="conf" items="${allConferenceList}">
                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                        <div class="feature-card">

                            <div class="card-topic-label">Conference Topic</div>
                            <h4>${conf.conferenceTopic}</h4>

                            <div class="conf-detail">
                                <i class="fas fa-user"></i>
                                <span><strong>Host:</strong> ${conf.hostName}</span>
                            </div>

                            <div class="conf-detail">
                                <i class="fas fa-calendar"></i>
                                <span><strong>Date:</strong> ${conf.date}</span>
                            </div>

                            <div class="conf-detail">
                                <i class="fas fa-clock"></i>
                                <span><strong>Time:</strong> ${conf.time}</span>
                            </div>

                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty allConferenceList}">
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-folder-open"></i>
                        </div>
                        <p>No conferences available.</p>
                    </div>
                </c:if>

            </div>

        </section>
    </c:if>

</main>

<!-- ═══════════════════════════════════════════════════
     PROFILE MODAL
════════════════════════════════════════════════════ -->
<div class="modal fade" id="adminProfileModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered" style="max-width:380px;">
        <div class="modal-content">

            <div class="profile-modal-header">
                <button class="btn-close btn-close-white position-absolute end-0 top-0 m-3"
                        data-bs-dismiss="modal"></button>
                <img src="https://ui-avatars.com/api/?name=${sessionScope.delegate.email}&background=ff9800&color=fff&size=110"
                     class="rounded-circle shadow"
                     style="border:3px solid rgba(255,255,255,0.3);"
                     width="90" height="90"
                     alt="Delegate Avatar">
                <div style="color:rgba(255,255,255,0.5);font-size:0.7rem;letter-spacing:1.5px;text-transform:uppercase;margin-top:10px;">Delegate Account</div>
            </div>

            <div class="profile-modal-body">
                <div class="profile-detail-row">
                    <div class="profile-detail-icon"><i class="fas fa-envelope"></i></div>
                    <div>
                        <div class="profile-detail-label">Email</div>
                        <div class="profile-detail-value">${sessionScope.delegate.email}</div>
                    </div>
                </div>
                <div class="profile-detail-row">
                    <div class="profile-detail-icon"><i class="fas fa-user-tie"></i></div>
                    <div>
                        <div class="profile-detail-label">Role</div>
                        <div class="profile-detail-value">TPO / HR Delegate</div>
                    </div>
                </div>
                <div class="profile-detail-row">
                    <div class="profile-detail-icon" style="font-size:0.6rem;"><i class="fas fa-circle" style="color:var(--green);"></i></div>
                    <div>
                        <div class="profile-detail-label">Status</div>
                        <div class="profile-detail-value" style="color:var(--green);">Active Session</div>
                    </div>
                </div>
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     FOOTER
════════════════════════════════════════════════════ -->
<footer>
    © 2026 <span>CRDMS</span> TPO / HR Dashboard
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 900, once: true, offset: 50 });
</script>

</body>
</html>
