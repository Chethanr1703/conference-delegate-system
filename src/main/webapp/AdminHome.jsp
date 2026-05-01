<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CRDMS Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

    <style>
        :root {
            --deep:    #0f2027;
            --mid:     #203a43;
            --teal:    #2c5364;
            --orange:  #ff9800;
            --green:   #00c853;
            --light-bg: #eef3f8;
            --card-bg: #ffffff;
            --text-primary: #1a2a35;
            --text-muted: #5a7080;
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
            position: relative;
            overflow-x: hidden;
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
            top: -160px; left: -160px;
            opacity: 0.14;
            animation: floatBlob 18s infinite alternate ease-in-out;
        }
        body::after {
            background: var(--mid);
            bottom: -160px; right: -160px;
            opacity: 0.14;
            animation: floatBlob 22s infinite alternate-reverse ease-in-out;
        }
        @keyframes floatBlob {
            0%   { transform: translate(0,0) scale(1); }
            50%  { transform: translate(50px,-35px) scale(1.1); }
            100% { transform: translate(-35px,35px) scale(1); }
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
            font-size: 1.3rem;
            font-weight: 800;
            letter-spacing: 2px;
            background: linear-gradient(90deg, #fff 30%, var(--orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
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
        .sidebar-link .sidebar-icon {
            width: 34px; height: 34px;
            border-radius: 9px;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.85rem;
            flex-shrink: 0;
        }
        .icon-all    { background: rgba(44,83,100,0.1);  color: var(--teal); }
        .icon-pend   { background: rgba(220,53,69,0.1);  color: #dc3545; }
        .icon-appr   { background: rgba(0,200,83,0.1);   color: var(--green); }
        .icon-sent   { background: rgba(255,152,0,0.1);  color: var(--orange); }
        .sidebar-divider { border-color: var(--border); margin: 14px 0; }

        /* ─── PAGE HEADER ────────────────────────────────────── */
        .page-header {
            background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));
            padding: 38px 0 36px;
            position: relative;
            overflow: hidden;
        }
        .page-header::before {
            content:"";
            position:absolute; inset:0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }
        .page-header-orb {
            position:absolute; border-radius:50%; filter:blur(70px); pointer-events:none;
        }
        .ph-orb-1 { width:220px;height:220px;background:rgba(255,152,0,0.15);top:-80px;right:6%; }
        .ph-orb-2 { width:160px;height:160px;background:rgba(0,200,83,0.1);bottom:-60px;left:4%; }

        .page-header-badge {
            display: inline-block;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.22);
            border-radius: 30px;
            padding: 4px 14px;
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--orange);
            margin-bottom: 10px;
        }
        .page-header h1 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(1.5rem, 3vw, 2rem);
            font-weight: 800;
            color: white;
            line-height: 1.2;
        }
        .page-header p {
            color: rgba(255,255,255,0.62);
            font-size: 0.88rem;
            margin-top: 6px;
        }

        /* ─── SECTION TITLE ──────────────────────────────────── */
        .section-heading {
            font-family: 'Syne', sans-serif;
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--text-primary);
            margin: 50px 0 26px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .section-heading .sh-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        .sh-danger  { background: rgba(220,53,69,0.1);  color: #dc3545; border: 1px solid rgba(220,53,69,0.2); }
        .sh-success { background: rgba(0,200,83,0.1);   color: #00a843; border: 1px solid rgba(0,200,83,0.2); }
        .sh-primary { background: rgba(44,83,100,0.1);  color: var(--teal); border: 1px solid rgba(44,83,100,0.2); }
        .sh-orange  { background: rgba(255,152,0,0.12); color: #e68900;  border: 1px solid rgba(255,152,0,0.25); }

        /* ─── CONFERENCE CARD ────────────────────────────────── */
        .conf-card {
            background: var(--card-bg);
            border-radius: 18px;
            padding: 24px 22px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
            min-height: 220px;
            box-shadow: 0 6px 24px rgba(44,83,100,0.10);
            border: 1px solid var(--border);
            border-left: 4px solid var(--teal);
            position: relative;
            overflow: hidden;
            transition: all 0.35s cubic-bezier(0.23,1,0.32,1);
        }
        .conf-card::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--teal), var(--orange), var(--green));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }
        .conf-card:hover::before { transform: scaleX(1); }
        .conf-card:hover {
            transform: translateY(-8px) scale(1.01);
            box-shadow: 0 20px 45px rgba(44,83,100,0.18);
        }
        .conf-card-topic {
            font-family: 'Syne', sans-serif;
            font-size: 1rem;
            font-weight: 700;
            color: var(--teal);
            margin-bottom: 12px;
            line-height: 1.3;
        }
        .conf-detail {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.82rem;
            color: var(--text-muted);
            margin-bottom: 6px;
        }
        .conf-detail i {
            width: 18px;
            color: var(--teal);
            font-size: 0.78rem;
            opacity: 0.8;
            transition: transform 0.3s;
        }
        .conf-card:hover .conf-detail i { transform: scale(1.15); }
        .conf-detail strong { color: var(--text-primary); font-weight: 600; }

        /* Status badge */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.72rem;
            font-weight: 700;
        }

        /* ─── CARD BUTTONS ───────────────────────────────────── */
        .conf-card .btn { border-radius: 10px; font-size: 0.82rem; font-weight: 600; padding: 8px 14px; transition: all 0.25s; }
        .conf-card .btn:hover { transform: translateY(-2px); box-shadow: 0 6px 16px rgba(0,0,0,0.15); }
        .btn-approve {
            background: linear-gradient(135deg, #00c853, #00a843);
            border: none; color: white;
        }
        .btn-approve:hover { background: linear-gradient(135deg, #00a843, #008c39); color: white; }
        .btn-send {
            background: linear-gradient(135deg, var(--mid), var(--teal));
            border: none; color: white;
        }
        .btn-send:hover { background: linear-gradient(135deg, var(--deep), var(--mid)); color: white; }
        .btn-view {
            background: linear-gradient(135deg, var(--mid), var(--teal));
            border: none; color: white; font-size: 0.78rem !important;
        }
        .btn-view:hover { background: linear-gradient(135deg, var(--deep), var(--mid)); color: white; }
        .btn-reminder {
            background: linear-gradient(135deg, #ff9800, #e68900);
            border: none; color: white; font-size: 0.78rem !important;
        }
        .btn-reminder:hover { background: linear-gradient(135deg, #e68900, #cc7a00); color: white; }

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
            background: linear-gradient(135deg, rgba(44,83,100,0.08), rgba(255,152,0,0.08));
            border: 1px solid var(--border);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.6rem;
            color: rgba(44,83,100,0.3);
            margin: 0 auto 16px;
        }
        .empty-state p { font-size: 0.9rem; color: var(--text-muted); }

        /* ─── ALERTS ─────────────────────────────────────────── */
        .alert { border-radius: 14px; border: none; font-size: 0.9rem; }
        .alert-success { background: rgba(0,200,83,0.1); color: #00843a; border: 1px solid rgba(0,200,83,0.2); }
        .alert-danger  { background: rgba(220,53,69,0.1); color: #b02a37; border: 1px solid rgba(220,53,69,0.2); }

        /* ─── PROFILE MODAL ──────────────────────────────────── */
        .modal-content { border-radius: 20px; border: none; overflow: hidden; }
        .profile-modal-header {
            background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));
            padding: 30px 20px 20px;
            text-align: center;
        }
        .profile-modal-body { background: #f8fbfd; padding: 24px 28px 28px; }
        .profile-name {
            font-family: 'Syne', sans-serif;
            font-size: 1.15rem;
            font-weight: 800;
            color: var(--text-primary);
        }
        .profile-email { font-size: 0.88rem; color: var(--text-muted); }
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
        .profile-detail-value { font-size: 0.9rem; font-weight: 600; color: var(--text-primary); }
        .btn-logout {
            background: linear-gradient(135deg, #dc3545, #b02a37);
            color: white; border: none;
            padding: 11px 0; border-radius: 12px;
            font-weight: 700; font-size: 0.9rem;
            width: 100%; transition: all 0.3s;
        }
        .btn-logout:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(220,53,69,0.35); color: white; }

        /* ─── FOOTER ─────────────────────────────────────────── */
        footer {
            background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
            color: rgba(255,255,255,0.7);
            text-align: center;
            padding: 18px;
            font-size: 0.82rem;
            margin-top: auto;
        }
        footer span { color: var(--orange); font-weight: 600; }

        /* ─── MAIN CONTENT ───────────────────────────────────── */
        main { flex-grow: 1; padding-bottom: 50px; }

        /* ─── RESPONSIVE ─────────────────────────────────────── */
        @media (max-width: 768px) {
            .page-header { padding: 28px 0 24px; }
            .section-heading { font-size: 1.15rem; }
        }

        :root {
    --deep:    #0f2027;
    --mid:     #203a43;
    --teal:    #2c5364;
    --orange:  #ff9800;
    --green:   #00c853;
    --light-bg: #eef3f8;
    --card-bg: #ffffff;
    --text-primary: #1a2a35;
    --text-muted: #5f6f7f;
    --border: rgba(44,83,100,0.12);
}

/* RESET */
*, *::before, *::after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

html, body {
    height: 100%;
}

/* BODY */
body {
    font-family: 'Segoe UI', 'DM Sans', sans-serif;
    background: var(--light-bg);
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    overflow-x: hidden;
    color: var(--text-primary);
    letter-spacing: 0.3px;
}

/* BACKGROUND BLOBS */
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
    top: -160px;
    left: -160px;
    opacity: 0.14;
    animation: floatBlob 18s infinite alternate ease-in-out;
}

body::after {
    background: var(--mid);
    bottom: -160px;
    right: -160px;
    opacity: 0.14;
    animation: floatBlob 22s infinite alternate-reverse ease-in-out;
}

@keyframes floatBlob {
    0% { transform: translate(0,0) scale(1); }
    50% { transform: translate(50px,-35px) scale(1.1); }
    100% { transform: translate(-35px,35px) scale(1); }
}

/* NAVBAR */
.navbar {
    background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
    box-shadow: 0 4px 20px rgba(0,0,0,0.28);
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

.menu-btn {
    font-size: 20px;
    border: none;
    background: rgba(255,255,255,0.1);
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 10px;
    transition: 0.3s;
}

.menu-btn:hover {
    background: rgba(255,255,255,0.2);
    transform: scale(1.08);
}

/* SIDEBAR */
.offcanvas-body {
    background: white;
}

.sidebar-link {
    padding: 10px 15px;
    border-radius: 10px;
    transition: 0.25s;
}

.sidebar-link:hover {
    transform: translateX(4px);
    background: rgba(44,83,100,0.08);
}

/* HEADER */
.page-header {
    background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));
    padding: 35px 0;
    color: white;
}

.page-header h1 {
    font-family: 'Syne', sans-serif;
    font-size: 1.8rem;
    font-weight: 700;
    letter-spacing: 0.5px;
}

.page-header p {
    font-size: 0.85rem;
    color: rgba(255,255,255,0.65);
}

/* SECTION TITLE */
.section-heading {
    font-family: 'Syne', sans-serif;
    font-size: 1.25rem;
    font-weight: 700;
    margin: 45px 0 20px;
}

/* CARD */
.conf-card {
    background: var(--card-bg);
    border-radius: 16px;
    padding: 20px;
    min-height: 200px;
    box-shadow: 0 6px 24px rgba(44,83,100,0.10);
    border: 1px solid var(--border);
    border-left: 4px solid var(--teal);
    transition: 0.3s;
}

.conf-card:hover {
    transform: translateY(-6px) scale(1.01);
    box-shadow: 0 18px 35px rgba(44,83,100,0.18);
}

/* CARD TITLE */
.conf-card-topic {
    font-family: 'Syne', sans-serif;
    font-size: 0.95rem;
    font-weight: 600;
    color: var(--teal);
    margin-bottom: 10px;
}

/* CARD TEXT */
.conf-detail {
    font-size: 0.8rem;
    color: var(--text-muted);
    margin-bottom: 5px;
}

/* BUTTONS */
.conf-card .btn {
    font-size: 0.8rem;
    padding: 7px 12px;
    border-radius: 8px;
    transition: 0.3s;
}

.conf-card .btn:hover {
    transform: translateY(-2px);
}

/* BUTTON TYPES */
.btn-approve {
    background: linear-gradient(135deg, #00c853, #00a843);
    color: white;
    border: none;
}

.btn-send {
    background: linear-gradient(135deg, var(--mid), var(--teal));
    color: white;
    border: none;
}

.btn-view {
    background: linear-gradient(135deg, var(--mid), var(--teal));
    color: white;
    border: none;
}

.btn-reminder {
    background: linear-gradient(135deg, #ff9800, #e68900);
    color: white;
    border: none;
}

/* EMPTY STATE */
.empty-state {
    text-align: center;
    padding: 50px;
    color: var(--text-muted);
}

/* ALERT */
.alert {
    border-radius: 12px;
}

/* FOOTER */
footer {
    background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
    color: rgba(255,255,255,0.7);
    text-align: center;
    padding: 15px;
    font-size: 0.8rem;
    margin-top: auto;
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
                    data-bs-target="#adminSidebar"
                    aria-label="Open sidebar">
                <i class="fas fa-bars"></i>
            </button>
            <span class="navbar-brand-text">CRDMS</span>
            <span style="color:rgba(255,255,255,0.3);font-size:0.75rem;font-weight:500;letter-spacing:1px;">ADMIN</span>
        </div>

        <div class="ms-auto d-flex align-items-center gap-2">
            <button class="btn p-0 border-0 bg-transparent"
                    data-bs-toggle="modal"
                    data-bs-target="#adminProfileModal"
                    title="Profile">
                <img src="https://ui-avatars.com/api/?name=${sessionScope.admin}&background=ff9800&color=fff&size=40"
                     class="rounded-circle border border-2"
                     style="border-color:rgba(255,255,255,0.3) !important;"
                     width="40" height="40"
                     alt="Admin Avatar">
            </button>
        </div>

    </div>
</nav>

<!-- ═══════════════════════════════════════════════════
     SIDEBAR
════════════════════════════════════════════════════ -->
<div class="offcanvas offcanvas-start shadow" tabindex="-1" id="adminSidebar">

    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Admin Dashboard</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>

    <div class="offcanvas-body">

        <div class="sidebar-label">Manage Conferences</div>

        <a href="${pageContext.request.contextPath}/admin/dashboard?filter=all"
           class="sidebar-link">
            <span class="sidebar-icon icon-all"><i class="fas fa-th-large"></i></span>
            All Conferences
        </a>

        <a href="${pageContext.request.contextPath}/admin/dashboard?filter=pending"
           class="sidebar-link">
            <span class="sidebar-icon icon-pend"><i class="fas fa-hourglass-half"></i></span>
            Pending Approval
        </a>

        <a href="${pageContext.request.contextPath}/admin/dashboard?filter=approved"
           class="sidebar-link">
            <span class="sidebar-icon icon-appr"><i class="fas fa-check-circle"></i></span>
            Approved Conferences
        </a>

        <a href="${pageContext.request.contextPath}/admin/dashboard?filter=sent"
           class="sidebar-link">
            <span class="sidebar-icon icon-sent"><i class="fas fa-paper-plane"></i></span>
            Sent to Delegates
        </a>

        <hr class="sidebar-divider">

        <div class="sidebar-label">Account</div>

        <a href="${pageContext.request.contextPath}/logoutAdmin" class="sidebar-link" style="color:#dc3545;">
            <span class="sidebar-icon" style="background:rgba(220,53,69,0.1);color:#dc3545;"><i class="fas fa-sign-out-alt"></i></span>
            Logout
        </a>

    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     PAGE HEADER
════════════════════════════════════════════════════ -->
<div class="page-header">
    <div class="page-header-orb ph-orb-1"></div>
    <div class="page-header-orb ph-orb-2"></div>
    <div class="container">
        <div class="page-header-badge"><i class="fas fa-shield-alt me-1"></i>Secure Admin Portal</div>
        <h1>
            <c:choose>
                <c:when test="${showPending}"><i class="fas fa-hourglass-half me-2" style="color:var(--orange);"></i>Pending Approvals</c:when>
                <c:when test="${showApproved}"><i class="fas fa-check-circle me-2" style="color:var(--green);"></i>Approved Conferences</c:when>
                <c:when test="${showSent}"><i class="fas fa-paper-plane me-2" style="color:var(--orange);"></i>Sent to Delegates</c:when>
                <c:otherwise><i class="fas fa-th-large me-2" style="color:var(--orange);"></i>All Conferences</c:otherwise>
            </c:choose>
        </h1>
        <p>Welcome back, <strong style="color:rgba(255,255,255,0.9);">${sessionScope.admin}</strong> — manage your conferences below.</p>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     MAIN CONTENT
════════════════════════════════════════════════════ -->
<main>
    <div class="container">

        <!-- ── PENDING ───────────────────────────────── -->
        <c:if test="${showPending}">
            <div class="section-heading" data-aos="fade-right">
                Pending Conferences
                <span class="sh-badge sh-danger"><i class="fas fa-clock"></i> Awaiting Approval</span>
            </div>

            <div class="row g-4">
                <c:forEach var="conf" items="${conferenceList}">
                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                        <div class="conf-card">
                            <div>
                                <div class="conf-card-topic">${conf.conferenceTopic}</div>
                                <div class="conf-detail"><i class="fas fa-user"></i><span><strong>Host:</strong> ${conf.hostName}</span></div>
                                <div class="conf-detail"><i class="fas fa-envelope"></i><span><strong>Email:</strong> ${conf.email}</span></div>
                                <div class="conf-detail"><i class="fas fa-users"></i><span><strong>Audience:</strong> ${conf.targetedAudience}</span></div>
                                <div class="conf-detail"><i class="fas fa-calendar"></i><span><strong>Date:</strong> ${conf.date}</span></div>
                                <div class="conf-detail"><i class="fas fa-clock"></i><span><strong>Time:</strong> ${conf.time}</span></div>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/approve" method="post" style="margin-top:16px;">
                                <input type="hidden" name="id" value="${conf.id}">
                                <button class="btn btn-approve w-100">
                                    <i class="fas fa-check-circle me-2"></i>Approve Conference
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty conferenceList}">
                    <div class="empty-state">
                        <div class="empty-state-icon"><i class="fas fa-hourglass-end"></i></div>
                        <p>No pending conferences right now.</p>
                    </div>
                </c:if>
            </div>
        </c:if>

        <!-- ── APPROVED ──────────────────────────────── -->
        <c:if test="${showApproved}">
            <div class="section-heading" data-aos="fade-right">
                Approved Conferences
                <span class="sh-badge sh-success"><i class="fas fa-check-circle"></i> Ready to Send</span>
            </div>

            <c:if test="${not empty successMsg}">
                <div class="alert alert-success alert-dismissible fade show mb-4" role="alert" data-aos="fade-up">
                    <i class="fas fa-check-circle me-2"></i>${successMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" data-aos="fade-up">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="row g-4">
                <c:forEach var="conf" items="${conferenceList}">
                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                        <div class="conf-card">
                            <div>
                                <div class="conf-card-topic">${conf.conferenceTopic}</div>
                                <div class="conf-detail"><i class="fas fa-user"></i><span><strong>Host:</strong> ${conf.hostName}</span></div>
                                <div class="conf-detail"><i class="fas fa-envelope"></i><span><strong>Email:</strong> ${conf.email}</span></div>
                                <div class="conf-detail"><i class="fas fa-users"></i><span><strong>Audience:</strong> ${conf.targetedAudience}</span></div>
                                <div class="conf-detail"><i class="fas fa-calendar"></i><span><strong>Date:</strong> ${conf.date}</span></div>
                                <div class="conf-detail"><i class="fas fa-clock"></i><span><strong>Time:</strong> ${conf.time}</span></div>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/sendToDelegates" method="post" style="margin-top:16px;">
                                <input type="hidden" name="id" value="${conf.id}">
                                <button class="btn btn-send w-100">
                                    <i class="fas fa-paper-plane me-2"></i>Send To Delegates
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty conferenceList}">
                    <div class="empty-state">
                        <div class="empty-state-icon"><i class="fas fa-check-double"></i></div>
                        <p>No approved conferences yet.</p>
                    </div>
                </c:if>
            </div>
        </c:if>

        <!-- ── SENT ──────────────────────────────────── -->
        <c:if test="${showSent}">
            <div class="section-heading" data-aos="fade-right">
                Sent to Delegates
                <span class="sh-badge sh-orange"><i class="fas fa-paper-plane"></i> Dispatched</span>
            </div>

            <c:if test="${not empty successMsg}">
                <div class="alert alert-success alert-dismissible fade show mb-4" role="alert" data-aos="fade-up">
                    <i class="fas fa-check-circle me-2"></i>${successMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" data-aos="fade-up">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="row g-4">
                <c:forEach var="conf" items="${conferenceList}">
                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                        <div class="conf-card">
                            <div>
                                <div class="conf-card-topic">${conf.conferenceTopic}</div>
                                <div class="conf-detail">
                                    <i class="fas fa-calendar"></i>
                                    <span><strong>Date:</strong> ${conf.date}</span>
                                </div>
                                <div class="conf-detail" style="margin-top:8px;">
                                    <i class="fas fa-circle" style="font-size:0.5rem;"></i>
                                    <span>
                                        <strong>Status:</strong>&nbsp;
                                        <c:choose>
                                            <c:when test="${conf.emailSent}">
                                                <span class="status-badge" style="background:rgba(0,200,83,0.12);color:#00843a;border:1px solid rgba(0,200,83,0.25);">
                                                    <i class="fas fa-check-circle"></i> Sent
                                                </span>
                                            </c:when>
                                            <c:when test="${conf.active}">
                                                <span class="status-badge" style="background:rgba(44,83,100,0.1);color:var(--teal);border:1px solid rgba(44,83,100,0.2);">
                                                    <i class="fas fa-check"></i> Approved
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge" style="background:rgba(255,152,0,0.12);color:#e68900;border:1px solid rgba(255,152,0,0.25);">
                                                    <i class="fas fa-hourglass-half"></i> Pending
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                            <div class="d-flex gap-2 mt-3">
                                <form action="${pageContext.request.contextPath}/participantsAdmin" method="get" class="w-50">
                                    <input type="hidden" name="conferenceId" value="${conf.id}">
                                    <button class="btn btn-view w-100">
                                        <i class="fas fa-users me-1"></i>View
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/sendReminder" method="post" class="w-50">
                                    <input type="hidden" name="conferenceId" value="${conf.id}">
                                    <button class="btn btn-reminder w-100">
                                        <i class="fas fa-bell me-1"></i>Reminder
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty conferenceList}">
                    <div class="empty-state">
                        <div class="empty-state-icon"><i class="fas fa-paper-plane"></i></div>
                        <p>No Conferences Sent To Delegates Yet</p>
                    </div>
                </c:if>
            </div>
        </c:if>

        <!-- ── ALL ───────────────────────────────────── -->
        <c:if test="${showAll}">
            <div class="section-heading" data-aos="fade-right">
                All Conferences
                <span class="sh-badge sh-primary"><i class="fas fa-th-large"></i> Complete List</span>
            </div>

            <div class="row g-4">
                <c:forEach var="conf" items="${conferenceList}">
                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                        <div class="conf-card">
                            <div class="conf-card-topic">${conf.conferenceTopic}</div>
                            <div class="conf-detail"><i class="fas fa-user"></i><span><strong>Host:</strong> ${conf.hostName}</span></div>
                            <div class="conf-detail"><i class="fas fa-envelope"></i><span><strong>Email:</strong> ${conf.email}</span></div>
                            <div class="conf-detail"><i class="fas fa-users"></i><span><strong>Audience:</strong> ${conf.targetedAudience}</span></div>
                            <div class="conf-detail"><i class="fas fa-calendar"></i><span><strong>Date:</strong> ${conf.date}</span></div>
                            <div class="conf-detail"><i class="fas fa-clock"></i><span><strong>Time:</strong> ${conf.time}</span></div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty conferenceList}">
                    <div class="empty-state">
                        <div class="empty-state-icon"><i class="fas fa-folder-open"></i></div>
                        <p>No Conferences Available</p>
                    </div>
                </c:if>
            </div>
        </c:if>

    </div>
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
                <img src="https://ui-avatars.com/api/?name=${sessionScope.admin}&background=ff9800&color=fff&size=110"
                     class="rounded-circle shadow"
                     style="border:3px solid rgba(255,255,255,0.3);"
                     width="90" height="90" alt="Admin">
                <div style="color:rgba(255,255,255,0.5);font-size:0.7rem;letter-spacing:1.5px;text-transform:uppercase;margin-top:10px;">Admin Account</div>
            </div>

            <div class="profile-modal-body">
                <div class="profile-detail-row">
                    <div class="profile-detail-icon"><i class="fas fa-user"></i></div>
                    <div>
                        <div class="profile-detail-label">Username</div>
                        <div class="profile-detail-value">${sessionScope.admin}</div>
                    </div>
                </div>
                <div class="profile-detail-row">
                    <div class="profile-detail-icon"><i class="fas fa-shield-alt"></i></div>
                    <div>
                        <div class="profile-detail-label">Role</div>
                        <div class="profile-detail-value">Administrator</div>
                    </div>
                </div>
                <div class="profile-detail-row">
                    <div class="profile-detail-icon"><i class="fas fa-circle" style="font-size:0.6rem;color:var(--green);"></i></div>
                    <div>
                        <div class="profile-detail-label">Status</div>
                        <div class="profile-detail-value" style="color:var(--green);">Active Session</div>
                    </div>
                </div>
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/logoutAdmin" class="btn-logout text-decoration-none d-block text-center">
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
    © 2026 <span>CRDMS</span> Admin Dashboard &nbsp;|&nbsp; Secure Management Portal
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 900, once: true, offset: 50 });
</script>

</body>
</html>
