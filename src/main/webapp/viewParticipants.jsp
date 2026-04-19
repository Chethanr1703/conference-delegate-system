<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" xmlns:c="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CRDMS | Conference Participants</title>

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
            opacity: 0.14;
            animation: floatBlob 18s infinite alternate ease-in-out;
        }
        body::after {
            background: var(--mid);
            bottom: -150px; right: -150px;
            opacity: 0.14;
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
            color: rgba(255,255,255,0.32);
            font-size: 0.72rem;
            font-weight: 500;
            letter-spacing: 1px;
        }
        .btn-back {
            background: rgba(255,255,255,0.1);
            color: white;
            border: 1px solid rgba(255,255,255,0.25);
            border-radius: 10px;
            padding: 7px 18px;
            font-size: 0.83rem;
            font-weight: 600;
            transition: all 0.25s;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 7px;
        }
        .btn-back:hover {
            background: rgba(255,255,255,0.2);
            color: white;
            border-color: rgba(255,255,255,0.5);
            transform: translateX(-2px);
        }

        /* ─── PAGE HEADER ────────────────────────────────────── */
        .page-header {
            background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));
            padding: 44px 0 40px;
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
        .page-header h3 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(1.5rem, 3vw, 2.1rem);
            font-weight: 800;
            color: white;
            line-height: 1.2;
        }
        .page-header h3 span {
            background: linear-gradient(90deg, var(--orange), #ffd54f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .page-header .sub {
            color: rgba(255,255,255,0.6);
            font-size: 0.9rem;
            margin-top: 8px;
        }

        /* ─── STATS STRIP ────────────────────────────────────── */
        .stats-strip {
            background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
            padding: 20px 0;
            border-top: 1px solid rgba(255,255,255,0.07);
        }
        .strip-stat {
            text-align: center;
            color: white;
            padding: 0 20px;
            border-right: 1px solid rgba(255,255,255,0.12);
        }
        .strip-stat:last-child { border-right: none; }
        .strip-stat-num {
            font-family: 'Syne', sans-serif;
            font-size: 1.6rem;
            font-weight: 800;
            background: linear-gradient(90deg, var(--orange), #ffd54f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1;
        }
        .strip-stat-label {
            font-size: 0.74rem;
            color: rgba(255,255,255,0.55);
            margin-top: 4px;
        }

        /* ─── TABLE CARD ─────────────────────────────────────── */
        .table-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 32px 30px;
            box-shadow: 0 8px 30px rgba(44,83,100,0.12);
            border: 1px solid var(--border);
            transition: box-shadow 0.3s;
        }
        .table-card:hover {
            box-shadow: 0 16px 45px rgba(44,83,100,0.17);
        }

        .table-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 14px;
            margin-bottom: 24px;
        }
        .table-card-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.15rem;
            font-weight: 800;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .title-icon {
            width: 38px; height: 38px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--deep), var(--teal));
            display: flex; align-items: center; justify-content: center;
            color: white; font-size: 0.85rem;
        }
        .count-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(44,83,100,0.08);
            border: 1px solid rgba(44,83,100,0.15);
            border-radius: 20px;
            padding: 5px 14px;
            font-size: 0.78rem;
            font-weight: 700;
            color: var(--teal);
        }

        /* ─── TABLE ──────────────────────────────────────────── */
        .table-wrapper {
            border-radius: 14px;
            overflow: hidden;
            border: 1px solid var(--border);
        }
        .table {
            margin: 0;
            font-size: 0.875rem;
        }
        .table thead tr {
            background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
        }
        .table thead th {
           color: black;
            font-family: 'Syne', sans-serif;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            padding: 14px 16px;
            border: none;
            white-space: nowrap;
        }
        .table tbody tr {
            border-bottom: 1px solid rgba(44,83,100,0.07);
            transition: background 0.2s;
        }
        .table tbody tr:last-child { border-bottom: none; }
        .table tbody tr:hover { background: rgba(44,83,100,0.04); }
        .table tbody td {
            padding: 14px 16px;
            vertical-align: middle;
            color: var(--text-primary);
            border: none;
        }

        /* Serial number */
        .serial-cell {
            font-family: 'Syne', sans-serif;
            font-weight: 700;
            color: var(--teal);
            font-size: 0.85rem;
        }

        /* Name with avatar */
        .participant-name {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .participant-avatar {
            width: 34px; height: 34px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--mid), var(--teal));
            display: flex; align-items: center; justify-content: center;
            color: white;
            font-family: 'Syne', sans-serif;
            font-size: 0.78rem;
            font-weight: 700;
            flex-shrink: 0;
        }
        .participant-name-text { font-weight: 500; }

        /* Email & org cells */
        .email-cell {
            color: var(--text-muted);
            font-size: 0.83rem;
        }
        .email-cell i { color: var(--teal); margin-right: 5px; opacity: 0.7; }

        .org-cell { font-size: 0.83rem; }
        .org-cell i { color: var(--teal); margin-right: 5px; opacity: 0.7; }

        /* ─── STATUS BADGES ──────────────────────────────────── */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
        }
        .status-attending {
            background: rgba(0,200,83,0.12);
            color: #00843a;
            border: 1px solid rgba(0,200,83,0.25);
        }
        .status-not-attending {
            background: rgba(90,112,128,0.1);
            color: var(--text-muted);
            border: 1px solid rgba(90,112,128,0.18);
        }

        /* ─── EMPTY STATE ────────────────────────────────────── */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
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

        main { flex-grow: 1; padding-bottom: 55px; }

        @media (max-width: 768px) {
            .table-card { padding: 20px 14px; }
            .page-header { padding: 30px 0 26px; }
            .stats-strip { display: none; }
        }
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
}

h1, h2, h3, h4, h5 {
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    letter-spacing: 0.4px;
}

/* ================= BACKGROUND BLOBS ================= */
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
    animation: floatBlob 18s infinite alternate ease-in-out;
}

body::after {
    background: var(--mid);
    bottom: -150px;
    right: -150px;
    opacity: 0.14;
    animation: floatBlob 22s infinite alternate-reverse ease-in-out;
}

@keyframes floatBlob {
    0% { transform: translate(0,0) scale(1); }
    50% { transform: translate(50px,-35px) scale(1.1); }
    100% { transform: translate(-35px,35px) scale(1); }
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
    transition: 0.3s;
}

.menu-btn:hover {
    background: rgba(255,255,255,0.2);
    transform: scale(1.08);
}

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
.page-header h3 {
    color: white;
    font-weight: 700;
}

.page-header .sub {
    color: rgba(255,255,255,0.65);
    font-size: 0.85rem;
}

/* ================= STATS ================= */
.stats-strip {
    background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
    padding: 20px 0;
}

.strip-stat {
    text-align: center;
    color: white;
}

.strip-stat-num {
    font-family: 'Syne', sans-serif;
    font-size: 1.4rem;
    font-weight: 700;
}

.strip-stat-label {
    font-size: 0.7rem;
    color: rgba(255,255,255,0.6);
}

/* ================= CARDS ================= */
.conf-card,
.table-card {
    background: var(--card-bg);
    border-radius: 18px;
    padding: 24px;
    box-shadow: 0 6px 24px rgba(44,83,100,0.10);
    border: 1px solid var(--border);
    transition: 0.3s;
}

.conf-card:hover,
.table-card:hover {
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
    color: black;
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

/* ================= PARTICIPANT ================= */
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
        <div class="page-header-badge"><i class="fas fa-users me-1"></i> TPO / HR Portal</div>
        <h3>Conference <span>Participants</span></h3>
        <p class="sub">List of all invited participants for this conference</p>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     STATS STRIP
════════════════════════════════════════════════════ -->
<div class="stats-strip">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-4 col-md-3">
                <div class="strip-stat">
                    <div class="strip-stat-num" id="totalCount">—</div>
                    <div class="strip-stat-label">Total Participants</div>
                </div>
            </div>
            <div class="col-4 col-md-3">
                <div class="strip-stat">
                    <div class="strip-stat-num" id="attendingCount">—</div>
                    <div class="strip-stat-label">Attending</div>
                </div>
            </div>
            <div class="col-4 col-md-3">
                <div class="strip-stat">
                    <div class="strip-stat-num" id="notAttendingCount">—</div>
                    <div class="strip-stat-label">Not Attending</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     MAIN CONTENT
════════════════════════════════════════════════════ -->
<main>
    <section class="container mt-5">

        <div class="table-card" data-aos="fade-up">

            <div class="table-card-header">
                <div class="table-card-title">
                    <div class="title-icon"><i class="fas fa-users"></i></div>
                    Participants
                </div>
                <div class="count-pill">
                    <i class="fas fa-list"></i>
                    <span id="countPill">Loading...</span>
                </div>
            </div>

            <div class="table-wrapper">
                <table class="table table-hover" id="participantsTable">

                    <thead>
                    <tr>
                        <th>#</th>
                        <th><i class="fas fa-user me-1" style="opacity:0.7;"></i>Name</th>
                        <th><i class="fas fa-envelope me-1" style="opacity:0.7;"></i>Email</th>
                        <th><i class="fas fa-building me-1" style="opacity:0.7;"></i>Organization</th>
                        <th><i class="fas fa-circle-check me-1" style="opacity:0.7;"></i>Status</th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:forEach var="p" items="${participantsList}" varStatus="loop">
                        <tr>

                            <td class="serial-cell">${loop.index + 1}</td>

                            <td>
                                <div class="participant-name">
                                    <div class="participant-avatar">
                                        ${fn:substring(p.fullName, 0, 1)}
                                    </div>
                                    <span class="participant-name-text">${p.fullName}</span>
                                </div>
                            </td>

                            <td class="email-cell">
                                <i class="fas fa-envelope"></i>${p.email}
                            </td>

                            <td class="org-cell">
                                <i class="fas fa-building"></i>${p.organization}
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${p.attending == 'yes'}">
                                            <span class="status-badge status-attending">
                                                <i class="fas fa-check-circle"></i> Attending
                                            </span>
                                    </c:when>
                                    <c:otherwise>
                                            <span class="status-badge status-not-attending">
                                                <i class="fas fa-times-circle"></i> Not Attending
                                            </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                        </tr>
                    </c:forEach>

                    <c:if test="${empty participantsList}">
                        <tr>
                            <td colspan="5">
                                <div class="empty-state">
                                    <div class="empty-state-icon"><i class="fas fa-users-slash"></i></div>
                                    <p>No Participants Found</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>

                    </tbody>
                </table>
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

    /* Dynamic stats from table rows */
    window.addEventListener("load", function () {
        const rows = document.querySelectorAll("#participantsTable tbody tr:not(:has(.empty-state))");
        let total = 0, attending = 0, notAttending = 0;

        rows.forEach(function (row) {
            const badge = row.querySelector(".status-badge");
            if (!badge) return;
            total++;
            if (badge.classList.contains("status-attending"))     attending++;
            if (badge.classList.contains("status-not-attending")) notAttending++;
        });

        document.getElementById("totalCount").textContent       = total       || "0";
        document.getElementById("attendingCount").textContent   = attending   || "0";
        document.getElementById("notAttendingCount").textContent = notAttending || "0";
        document.getElementById("countPill").textContent = total + " record" + (total !== 1 ? "s" : "");
    });
</script>

</body>
</html>
