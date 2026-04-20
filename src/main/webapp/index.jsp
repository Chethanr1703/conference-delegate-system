<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <title>Conference Registration & Delegate System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Outfit:wght@500;600;700&display=swap" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

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

        html { scroll-behavior: smooth; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--light-bg);
            color: var(--text-primary);
            overflow-x: hidden;
        }

        /* ─── ANIMATED BACKGROUND BLOBS ─────────────────────── */
        body::before, body::after {
            content: "";
            position: fixed;
            width: 520px; height: 520px;
            border-radius: 50%;
            filter: blur(130px);
            z-index: -1;
            pointer-events: none;
        }
        body::before {
            background: var(--teal);
            top: -150px; left: -150px;
            opacity: 0.18;
            animation: floatBlob 18s infinite alternate ease-in-out;
        }
        body::after {
            background: var(--mid);
            bottom: -150px; right: -150px;
            opacity: 0.18;
            animation: floatBlob 22s infinite alternate-reverse ease-in-out;
        }
        @keyframes floatBlob {
            0%   { transform: translate(0,0) scale(1); }
            50%  { transform: translate(60px,-40px) scale(1.12); }
            100% { transform: translate(-40px,40px) scale(1); }
        }

        /* ─── NAVBAR ─────────────────────────────────────────── */
        .navbar {
            padding: 18px 0;
            transition: background 0.4s, padding 0.4s, box-shadow 0.4s;
            background: transparent;
        }
        .navbar.scrolled {
            background: rgba(15,32,39,0.97) !important;
            padding: 10px 0;
            box-shadow: 0 4px 30px rgba(0,0,0,0.25);
        }
        .navbar-brand {
            font-family: 'Syne', sans-serif;
            font-size: 1.6rem;
            font-weight: 800;
            letter-spacing: 2px;
            background: linear-gradient(90deg, #fff 30%, var(--orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .nav-link {
            font-size: 0.88rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            color: rgba(255,255,255,0.82) !important;
            padding: 6px 14px !important;
            border-radius: 6px;
            transition: color 0.25s, background 0.25s;
        }
        .nav-link:hover { color: #fff !important; background: rgba(255,255,255,0.1); }
        .nav-cta {
            background: var(--orange);
            color: #fff !important;
            border-radius: 25px !important;
            padding: 7px 20px !important;
            font-weight: 600 !important;
        }
        .nav-cta:hover { background: #e68900; color: #fff !important; }

        /* ─── HERO ──────────────────────────────────────────── */
        .hero {
            background: linear-gradient(135deg, var(--deep) 0%, var(--mid) 50%, var(--teal) 100%);
            color: white;
            padding: 160px 0 110px;
            position: relative;
            overflow: hidden;
        }
        .hero::before {
            content: "";
            position: absolute;
            inset: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }
        /* Floating orbs */
        .hero-orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(60px);
            pointer-events: none;
        }
        .hero-orb-1 { width:300px; height:300px; background:rgba(255,152,0,0.15); top:10%; right:8%; animation: orbFloat 8s infinite ease-in-out; }
        .hero-orb-2 { width:200px; height:200px; background:rgba(0,200,83,0.1); bottom:15%; left:5%; animation: orbFloat 11s infinite ease-in-out reverse; }
        @keyframes orbFloat {
            0%,100% { transform: translateY(0px); }
            50%      { transform: translateY(-30px); }
        }

        .hero-badge {
            display: inline-block;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.25);
            backdrop-filter: blur(8px);
            border-radius: 30px;
            padding: 6px 18px;
            font-size: 0.78rem;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--orange);
            margin-bottom: 22px;
        }
        .hero h1 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(2.2rem, 5vw, 3.6rem);
            font-weight: 800;
            line-height: 1.15;
            margin-bottom: 20px;
        }
        .hero h1 span {
            background: linear-gradient(90deg, var(--orange), #ffd54f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .hero .lead {
            font-size: 1.1rem;
            color: rgba(255,255,255,0.75);
            font-weight: 300;
            max-width: 580px;
            margin: 0 auto 36px;
            line-height: 1.7;
        }
        .hero-tags {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin-bottom: 40px;
        }
        .hero-tag {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 20px;
            padding: 5px 14px;
            font-size: 0.8rem;
            color: rgba(255,255,255,0.7);
        }
        .hero-tag i { color: var(--orange); margin-right: 5px; }

        .btn-hero-host {
            background: var(--orange);
            color: #fff;
            border: none;
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.95rem;
            letter-spacing: 0.3px;
            transition: all 0.3s;
            box-shadow: 0 8px 25px rgba(255,152,0,0.35);
        }
        .btn-hero-host:hover {
            background: #e68900;
            transform: translateY(-3px);
            box-shadow: 0 14px 35px rgba(255,152,0,0.45);
            color: #fff;
        }
        .btn-hero-admin {
            background: rgba(255,255,255,0.1);
            color: #fff;
            border: 1.5px solid rgba(255,255,255,0.35);
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            backdrop-filter: blur(6px);
            transition: all 0.3s;
        }
        .btn-hero-admin:hover {
            background: rgba(255,255,255,0.22);
            color: #fff;
            transform: translateY(-3px);
            border-color: rgba(255,255,255,0.6);
        }

        /* Scroll indicator */
        .scroll-hint {
            position: absolute;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 6px;
            color: rgba(255,255,255,0.4);
            font-size: 0.72rem;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        .scroll-dot {
            width: 24px; height: 38px;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 14px;
            position: relative;
        }
        .scroll-dot::after {
            content:"";
            width: 4px; height: 8px;
            background: rgba(255,255,255,0.6);
            border-radius: 2px;
            position: absolute;
            top: 5px; left: 50%;
            transform: translateX(-50%);
            animation: scrollBounce 1.8s infinite;
        }
        @keyframes scrollBounce {
            0%,100% { top: 5px; opacity:1; }
            80%      { top: 18px; opacity:0.3; }
        }

        /* ─── STATS BAR ──────────────────────────────────────── */
        .stats-bar {
            background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal));
            padding: 32px 0;
        }
        .stat-item {
            text-align: center;
            color: white;
            padding: 0 20px;
            border-right: 1px solid rgba(255,255,255,0.15);
        }
        .stat-item:last-child { border-right: none; }
        .stat-number {
            font-family: 'Syne', sans-serif;
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(90deg, var(--orange), #ffd54f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .stat-label {
            font-size: 0.8rem;
            color: rgba(255,255,255,0.65);
            letter-spacing: 0.5px;
            margin-top: 3px;
        }

        /* ─── SECTION BASE ───────────────────────────────────── */
        .section { padding: 90px 0; }
        .section-label {
            display: inline-block;
            background: linear-gradient(90deg, rgba(44,83,100,0.12), rgba(255,152,0,0.12));
            border: 1px solid rgba(44,83,100,0.2);
            border-radius: 20px;
            padding: 5px 16px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--teal);
            margin-bottom: 14px;
        }
        .section-title {
            font-family: 'Syne', sans-serif;
            font-size: clamp(1.8rem, 3.5vw, 2.5rem);
            font-weight: 800;
            color: var(--text-primary);
            line-height: 1.2;
        }
        .section-title span {
            background: linear-gradient(90deg, var(--mid), var(--teal));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .section-sub {
            font-size: 1rem;
            color: var(--text-muted);
            max-width: 540px;
            margin: 12px auto 0;
            line-height: 1.7;
        }

        /* ─── FEATURES ───────────────────────────────────────── */
        .feature-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 36px 30px;
            height: 100%;
            transition: all 0.35s cubic-bezier(0.23,1,0.32,1);
            position: relative;
            overflow: hidden;
        }
        .feature-card::before {
            content:"";
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--teal), var(--orange));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }
        .feature-card:hover { transform: translateY(-10px); box-shadow: 0 20px 50px rgba(44,83,100,0.15); }
        .feature-card:hover::before { transform: scaleX(1); }
        .feature-icon {
            width: 58px; height: 58px;
            border-radius: 16px;
            background: linear-gradient(135deg, var(--deep), var(--teal));
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem;
            color: white;
            margin-bottom: 22px;
            box-shadow: 0 6px 20px rgba(44,83,100,0.25);
        }
        .feature-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 10px;
        }
        .feature-desc { font-size: 0.88rem; color: var(--text-muted); line-height: 1.7; }

        /* ─── AUTO SLIDER ────────────────────────────────────── */
        .slider-section { background: linear-gradient(180deg, #f4f8fb 0%, #eef3f8 100%); }
        .auto-slider { overflow: hidden; position: relative; padding: 10px 0 20px; }
        .auto-slider::before, .auto-slider::after {
            content: "";
            position: absolute;
            top: 0; bottom: 0;
            width: 80px;
            z-index: 2;
            pointer-events: none;
        }
        .auto-slider::before { left: 0; background: linear-gradient(to right, #f4f8fb, transparent); }
        .auto-slider::after  { right: 0; background: linear-gradient(to left,  #f4f8fb, transparent); }

        .auto-slide-track {
            display: flex;
            width: max-content;
            animation: scrollLeft 28s linear infinite;
        }
        .auto-slide-track.reverse { animation: scrollRight 28s linear infinite; }
        .auto-slider:hover .auto-slide-track { animation-play-state: paused; }

        @keyframes scrollLeft {
            from { transform: translateX(0); }
            to   { transform: translateX(-50%); }
        }
        @keyframes scrollRight {
            from { transform: translateX(-50%); }
            to   { transform: translateX(0); }
        }

        .slide-card { width: 300px; margin-right: 22px; flex-shrink: 0; }
        .conf-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 28px 26px;
            height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .conf-card::after {
            content: "";
            position: absolute;
            bottom: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--orange), var(--green));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.35s;
        }
        .conf-card:hover { transform: scale(1.04); box-shadow: 0 16px 40px rgba(44,83,100,0.18); }
        .conf-card:hover::after { transform: scaleX(1); }
        .conf-card-icon {
            width: 38px; height: 38px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--deep), var(--teal));
            display: flex; align-items: center; justify-content: center;
            font-size: 0.9rem; color: white;
            margin-bottom: 14px;
        }
        .conf-card h5 {
            font-family: 'Syne', sans-serif;
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 8px;
        }
        .conf-card p { font-size: 0.8rem; color: var(--text-muted); margin: 2px 0; line-height: 1.5; }
        .conf-card .badge-upcoming {
            display: inline-block;
            background: rgba(0,200,83,0.12);
            color: var(--green);
            border: 1px solid rgba(0,200,83,0.3);
            border-radius: 20px;
            padding: 3px 10px;
            font-size: 0.7rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        /* ─── HOW IT WORKS ───────────────────────────────────── */
        .works-section { background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal)); color: white; }
        .works-section .section-title { color: white; }
        .works-section .section-title span { background: linear-gradient(90deg,var(--orange),#ffd54f); -webkit-background-clip: text; -webkit-text-fill-color:transparent; }
        .works-section .section-sub { color: rgba(255,255,255,0.6); }
        .works-section .section-label { background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.2); color: rgba(255,255,255,0.8); }

        .step-card {
            background: rgba(255,255,255,0.06);
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            transition: all 0.35s;
            backdrop-filter: blur(6px);
            height: 100%;
            position: relative;
            overflow: hidden;
        }
        .step-card:hover { background: rgba(255,255,255,0.1); transform: translateY(-8px); box-shadow: 0 20px 50px rgba(0,0,0,0.2); }
        .step-number {
            font-family: 'Syne', sans-serif;
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1;
            background: linear-gradient(90deg, var(--orange), #ffd54f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 16px;
        }
        .step-icon {
            width: 64px; height: 64px;
            border-radius: 18px;
            background: linear-gradient(135deg, var(--orange), #e68900);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin: 0 auto 20px;
            box-shadow: 0 8px 24px rgba(255,152,0,0.35);
        }
        .step-title { font-family:'Syne',sans-serif; font-size: 1.1rem; font-weight: 700; color: white; margin-bottom: 10px; }
        .step-desc { font-size: 0.88rem; color: rgba(255,255,255,0.65); line-height: 1.7; }
        .step-connector {
            display: flex; align-items: center; justify-content: center;
            color: rgba(255,255,255,0.25);
            font-size: 1.5rem;
            padding-top: 60px;
        }

        /* ─── ABOUT ──────────────────────────────────────────── */
        .about-section { background: #fff; }
        .about-visual {
            background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));
            border-radius: 24px;
            padding: 50px 40px;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .about-visual::before {
            content:"";
            position:absolute; inset:0;
            background: url("data:image/svg+xml,%3Csvg width='40' height='40' viewBox='0 0 40 40' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%23ffffff' fill-opacity='0.04' fill-rule='evenodd'%3E%3Cpath d='M0 40L40 0H20L0 20M40 40V20L20 40'/%3E%3C/g%3E%3C/svg%3E");
        }
        .about-stat-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 30px; }
        .about-stat {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 16px;
            padding: 22px 18px;
            text-align: center;
            transition: background 0.3s;
        }
        .about-stat:hover { background: rgba(255,255,255,0.14); }
        .about-stat-num {
            font-family: 'Syne', sans-serif;
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(90deg, var(--orange), #ffd54f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .about-stat-label { font-size: 0.78rem; color: rgba(255,255,255,0.6); margin-top: 4px; }

        .about-text-side { padding: 20px 0; }
        .about-feature-list { list-style: none; margin-top: 24px; }
        .about-feature-list li {
            display: flex; align-items: flex-start; gap: 14px;
            margin-bottom: 18px;
            font-size: 0.92rem;
            color: var(--text-primary);
            line-height: 1.6;
        }
        .about-feature-list .check {
            width: 24px; height: 24px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--mid), var(--teal));
            display: flex; align-items: center; justify-content: center;
            color: white;
            font-size: 0.7rem;
            flex-shrink: 0;
            margin-top: 1px;
        }

        /* ─── CTA BANNER ─────────────────────────────────────── */
        .cta-section {
            background: linear-gradient(135deg, var(--deep), var(--mid), var(--teal));
            padding: 80px 0;
            position: relative;
            overflow: hidden;
        }
        .cta-section::before {
            content:"";
            position:absolute; inset:0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.025'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }
        .cta-orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            pointer-events: none;
        }
        .cta-orb-1 { width:260px; height:260px; background:rgba(255,152,0,0.18); top:-80px; right:10%; }
        .cta-orb-2 { width:180px; height:180px; background:rgba(0,200,83,0.12); bottom:-60px; left:8%; }
        .cta-section h2 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(1.8rem, 3.5vw, 2.6rem);
            font-weight: 800;
            color: white;
            line-height: 1.25;
        }
        .cta-section p { color: rgba(255,255,255,0.68); font-size: 1rem; line-height: 1.7; max-width: 520px; margin: 0 auto 36px; }
        .btn-cta-primary {
            background: var(--orange);
            color: white;
            padding: 14px 36px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.95rem;
            border: none;
            box-shadow: 0 8px 28px rgba(255,152,0,0.4);
            transition: all 0.3s;
        }
        .btn-cta-primary:hover {
            background: #e68900; color: white;
            transform: translateY(-3px);
            box-shadow: 0 14px 40px rgba(255,152,0,0.5);
        }
        .btn-cta-secondary {
            background: transparent;
            color: white;
            padding: 14px 36px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            border: 1.5px solid rgba(255,255,255,0.4);
            transition: all 0.3s;
        }
        .btn-cta-secondary:hover {
            background: rgba(255,255,255,0.1); color: white;
            transform: translateY(-3px);
            border-color: rgba(255,255,255,0.7);
        }

        /* ─── FOOTER ─────────────────────────────────────────── */
        footer {
            background: #0d1a1f;
            color: white;
            padding: 50px 0 24px;
        }
        .footer-brand {
            font-family: 'Syne', sans-serif;
            font-size: 1.6rem;
            font-weight: 800;
            letter-spacing: 2px;
            background: linear-gradient(90deg, #fff 30%, var(--orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }
        .footer-desc { font-size: 0.85rem; color: rgba(255,255,255,0.45); line-height: 1.7; max-width: 260px; }
        .footer-heading { font-family:'Syne',sans-serif; font-size: 0.78rem; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase; color: rgba(255,255,255,0.45); margin-bottom: 16px; }
        .footer-links { list-style: none; }
        .footer-links li { margin-bottom: 10px; }
        .footer-links a { font-size: 0.88rem; color: rgba(255,255,255,0.6); text-decoration: none; transition: color 0.25s; }
        .footer-links a:hover { color: var(--orange); }
        .footer-contact-item { display: flex; align-items: center; gap: 10px; font-size: 0.88rem; color: rgba(255,255,255,0.6); margin-bottom: 10px; }
        .footer-contact-item i { color: var(--orange); width: 16px; }
        .footer-divider { border-color: rgba(255,255,255,0.08); margin: 30px 0 20px; }
        .footer-bottom { font-size: 0.8rem; color: rgba(255,255,255,0.35); }

        /* ─── MODAL ──────────────────────────────────────────── */
        .modal-content { border-radius: 20px; border: none; overflow: hidden; }
        .modal-header { background: linear-gradient(90deg, var(--deep), var(--mid), var(--teal)); color: white; border: none; padding: 20px 26px; }
        .modal-body { padding: 28px 26px; background: #f8fbfd; }
        .modal-detail {
            display: flex; align-items: center; gap: 14px;
            padding: 14px 18px;
            background: white;
            border: 1px solid var(--border);
            border-radius: 12px;
            margin-bottom: 12px;
        }
        .modal-detail-icon {
            width: 38px; height: 38px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--deep), var(--teal));
            display: flex; align-items: center; justify-content: center;
            color: white; font-size: 0.85rem; flex-shrink: 0;
        }
        .modal-detail-label { font-size: 0.72rem; font-weight: 700; letter-spacing: 0.5px; text-transform: uppercase; color: var(--text-muted); margin-bottom: 2px; }
        .modal-detail-value { font-size: 0.92rem; font-weight: 600; color: var(--text-primary); }
        .modal-footer { background: #f8fbfd; border: none; padding: 16px 26px 22px; }
        .btn-register {
            background: var(--orange); color: white; border: none;
            padding: 10px 28px; border-radius: 50px;
            font-weight: 700; font-size: 0.9rem; transition: all 0.3s;
        }
        .btn-register:hover { background: #e68900; transform: translateY(-2px); }

        /* ─── EMPTY STATE ────────────────────────────────────── */
        .empty-state {
            text-align: center;
            padding: 50px 30px;
            color: var(--text-muted);
        }
        .empty-state i { font-size: 2.5rem; color: rgba(44,83,100,0.2); margin-bottom: 14px; }
        .empty-state p { font-size: 0.9rem; }

        /* ─── RESPONSIVE ─────────────────────────────────────── */
        @media (max-width: 768px) {
            .hero { padding: 120px 0 80px; }
            .step-connector { display: none; }
            .about-visual { margin-bottom: 30px; }
        }

        .hero h1 {
    letter-spacing: 1.5px;
}

.section-title {
    letter-spacing: 1.2px;
}

.conf-card h5 {
    letter-spacing: 0.8px;
}body {
    font-family: 'Poppins', sans-serif;
    font-weight: 400;
    letter-spacing: 0.3px;
    color: var(--text-primary);
}

/* HEADINGS (Modern Clean Look) */

h1, h2, h3, h4, h5, h6 {
    font-family: 'Outfit', sans-serif;
    font-weight: 600;
    letter-spacing: 0.8px;
}

/* NAVBAR BRAND */

.navbar-brand {
    font-family: 'Outfit', sans-serif;
    font-weight: 700;
    letter-spacing: 2px;
}

/* HERO TITLE */

.hero h1 {
    font-family: 'Outfit', sans-serif;
    font-weight: 700;
    letter-spacing: 1.2px;
}

/* SECTION TITLES */

.section-title {
    font-family: 'Outfit', sans-serif;
    font-weight: 600;
    letter-spacing: 1px;
}

/* CARD TITLES */

.conf-card h5,
.feature-title,
.step-title {
    font-family: 'Outfit', sans-serif;
    font-weight: 600;
    letter-spacing: 0.6px;
}

/* SMALL TEXT / LABELS */

.section-label,
.stat-label,
.modal-detail-label {
    font-family: 'Poppins', sans-serif;
    font-weight: 500;
    letter-spacing: 1.2px;
}

/* BUTTON TEXT */

button,
.btn {
    font-family: 'Poppins', sans-serif;
    font-weight: 500;
    letter-spacing: 0.5px;
}



input,
textarea,
select {
    font-family: 'Poppins', sans-serif;
    font-size: 14px;
}

/* FOOTER */

.footer-heading {
    font-family: 'Outfit', sans-serif;
    font-weight: 600;
    letter-spacing: 1px;
}

.footer-desc,
.footer-links a {
    font-family: 'Poppins', sans-serif;
}
        .cta-section .container {
    position: relative;
    z-index: 2;
}

.cta-orb {
    z-index: 0;
    pointer-events: none;
}
    </style>
</head>

<body>

<!-- ═══════════════════════════════════════════════════
     NAVBAR
════════════════════════════════════════════════════ -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">CRDMS</a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center gap-1">
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#works">Previous Conferences</a></li>
                <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                <li class="nav-item"><a class="nav-link" href="registerConference">Register Conference</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogin">Admin Login</a></li>
                <li class="nav-item"><a class="nav-link nav-cta ms-2" href="delegateLogin"><i class="fas fa-user me-1"></i>Delegate Login</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- ═══════════════════════════════════════════════════
     HERO
════════════════════════════════════════════════════ -->
<section class="hero text-center">
    <div class="hero-orb hero-orb-1"></div>
    <div class="hero-orb hero-orb-2"></div>

    <div class="container" data-aos="fade-up" data-aos-duration="900">
        <div class="hero-badge"><i class="fas fa-star me-1"></i> Professional Event Management Platform</div>
        <h1>Conference Registration &<br><span>Delegate Management</span></h1>
        <p class="lead">
            Seamlessly host conferences, invite delegates, track responses, and generate insightful reports — all in one platform.
        </p>

        <div class="hero-tags" data-aos="fade-up" data-aos-delay="200">
            <span class="hero-tag"><i class="fas fa-calendar-check"></i> Event Scheduling</span>
            <span class="hero-tag"><i class="fas fa-users"></i> Delegate Management</span>
            <span class="hero-tag"><i class="fas fa-chart-bar"></i> Analytics & Reports</span>
            <span class="hero-tag"><i class="fas fa-bell"></i> Instant Notifications</span>
        </div>

        <div class="d-flex flex-wrap gap-3 justify-content-center" data-aos="fade-up" data-aos-delay="350">
            <a href="registerConference" class="btn btn-hero-host">
                <i class="fas fa-microphone me-2"></i>Host a Conference
            </a>
            <a href="adminLogin" class="btn btn-hero-admin">
                <i class="fas fa-user-shield me-2"></i>Admin Login
            </a>
        </div>
    </div>

    <div class="scroll-hint">
        <div class="scroll-dot"></div>
        <span>Scroll</span>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════
     STATS BAR
════════════════════════════════════════════════════ -->
<div class="stats-bar" data-aos="fade-up">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-6 col-md-3"><div class="stat-item"><div class="stat-number">50+</div><div class="stat-label">Conferences Hosted</div></div></div>
            <div class="col-6 col-md-3"><div class="stat-item"><div class="stat-number">12+</div><div class="stat-label">Delegates Registered</div></div></div>
            <div class="col-6 col-md-3"><div class="stat-item"><div class="stat-number">98%</div><div class="stat-label">Satisfaction Rate</div></div></div>
            <div class="col-6 col-md-3"><div class="stat-item"><div class="stat-number">1+</div><div class="stat-label">Years Experience</div></div></div>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════
     FEATURES
════════════════════════════════════════════════════ -->
<section id="features" class="section">
    <div class="container">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="section-label">What We Offer</span>
            <h2 class="section-title">Everything You Need to Run<br><span>World-Class Conferences</span></h2>
            <p class="section-sub">A complete suite of tools to manage every aspect of your conference from planning to reporting.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="0">
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-calendar-plus"></i></div>
                    <div class="feature-title">Easy Registration</div>
                    <p class="feature-desc">Organizers can register conferences in minutes with a streamlined, intuitive setup process.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="100">
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-user-plus"></i></div>
                    <div class="feature-title">Delegate Invitations</div>
                    <p class="feature-desc">Send targeted invitations and manage RSVPs with real-time delegate tracking and status updates.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="200">
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-chart-line"></i></div>
                    <div class="feature-title">Live Analytics</div>
                    <p class="feature-desc">Monitor conference performance, delegate engagement, and attendance stats in real time.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="300">
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-file-alt"></i></div>
                    <div class="feature-title">Report Generation</div>
                    <p class="feature-desc">Generate comprehensive reports and export delegate data for post-conference analysis.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════
     UPCOMING CONFERENCES
════════════════════════════════════════════════════ -->
<section id="future" class="section slider-section">
    <div class="container">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="section-label">What's Coming</span>
            <h2 class="section-title">Upcoming <span>Conferences</span></h2>
            <p class="section-sub">Don't miss out — register now for our upcoming events and secure your spot.</p>
        </div>
    </div>
    <div class="auto-slider" id="upcomingSliderWrapper">
        <div class="auto-slide-track" id="upcomingTrack"></div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════
     PREVIOUS CONFERENCES
════════════════════════════════════════════════════ -->
<section id="works" class="section">
    <div class="container">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="section-label">Our Track Record</span>
            <h2 class="section-title">Previous <span>Conferences</span></h2>
            <p class="section-sub">A glimpse into the successful events we've powered over the years.</p>
        </div>
    </div>
    <div class="auto-slider">
        <div class="auto-slide-track reverse" id="previousTrack">
            <!-- ORIGINAL -->
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-robot"></i></div>
                    <h5>AI Summit 2025</h5>
                    <p>Focused on Artificial Intelligence trends and innovations.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fab fa-java"></i></div>
                    <h5>Java Conference</h5>
                    <p>Spring Boot, Microservices & Enterprise application deep dive.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-cloud"></i></div>
                    <h5>Cloud Expo</h5>
                    <p>Exploring AWS, Azure, DevOps & Cloud Infrastructure tools.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-shield-alt"></i></div>
                    <h5>CyberSec Forum</h5>
                    <p>Network security, ethical hacking & zero-trust architectures.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-mobile-alt"></i></div>
                    <h5>Mobile Dev Con</h5>
                    <p>Flutter, React Native & cross-platform mobile development.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-database"></i></div>
                    <h5>Data Engineering Summit</h5>
                    <p>Big Data, ETL pipelines, Kafka & real-time processing.</p>
                </div>
            </div>
            <!-- Duplicates for infinite scroll -->
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-robot"></i></div>
                    <h5>AI Summit 2025</h5>
                    <p>Focused on Artificial Intelligence trends and innovations.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fab fa-java"></i></div>
                    <h5>Java Conference</h5>
                    <p>Spring Boot, Microservices & Enterprise application deep dive.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-cloud"></i></div>
                    <h5>Cloud Expo</h5>
                    <p>Exploring AWS, Azure, DevOps & Cloud Infrastructure tools.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-shield-alt"></i></div>
                    <h5>CyberSec Forum</h5>
                    <p>Network security, ethical hacking & zero-trust architectures.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-mobile-alt"></i></div>
                    <h5>Mobile Dev Con</h5>
                    <p>Flutter, React Native & cross-platform mobile development.</p>
                </div>
            </div>
            <div class="slide-card">
                <div class="conf-card">
                    <div class="conf-card-icon"><i class="fas fa-database"></i></div>
                    <h5>Data Engineering Summit</h5>
                    <p>Big Data, ETL pipelines, Kafka & real-time processing.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════
     HOW IT WORKS
════════════════════════════════════════════════════ -->
<section class="section works-section">
    <div class="container">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="section-label">Simple Process</span>
            <h2 class="section-title">How It <span>Works</span></h2>
            <p class="section-sub">Get your conference up and running in three simple steps.</p>
        </div>

        <div class="row align-items-stretch g-4">
            <div class="col-md-4 col-lg" data-aos="fade-up" data-aos-delay="0">
                <div class="step-card">
                    <div class="step-number">01</div>
                    <div class="step-icon"><i class="fas fa-calendar-plus"></i></div>
                    <div class="step-title">Register Your Conference</div>
                    <p class="step-desc">Fill in the conference details — topic, date, time, and target audience — through our simple registration form.</p>
                </div>
            </div>
            <div class="col-auto d-none d-lg-flex step-connector" data-aos="fade-in" data-aos-delay="150">
                <i class="fas fa-chevron-right"></i>
            </div>
            <div class="col-md-4 col-lg" data-aos="fade-up" data-aos-delay="200">
                <div class="step-card">
                    <div class="step-number">02</div>
                    <div class="step-icon"><i class="fas fa-envelope-open-text"></i></div>
                    <div class="step-title">Invite Delegates</div>
                    <p class="step-desc">Send invitations to delegates. They receive personalised links to register and confirm their attendance instantly.</p>
                </div>
            </div>
            <div class="col-auto d-none d-lg-flex step-connector" data-aos="fade-in" data-aos-delay="350">
                <i class="fas fa-chevron-right"></i>
            </div>
            <div class="col-md-4 col-lg" data-aos="fade-up" data-aos-delay="400">
                <div class="step-card">
                    <div class="step-number">03</div>
                    <div class="step-icon"><i class="fas fa-chart-bar"></i></div>
                    <div class="step-title">Track & Report</div>
                    <p class="step-desc">Monitor registrations, track delegate responses, and generate detailed reports from the admin dashboard.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════
     ABOUT
════════════════════════════════════════════════════ -->
<section id="about" class="section about-section">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-5" data-aos="fade-right">
                <div class="about-visual">
                    <div class="section-label" style="background:rgba(255,255,255,0.1);border-color:rgba(255,255,255,0.2);color:rgba(255,255,255,0.8);">Who We Are</div>
                    <h3 style="font-family:'Syne',sans-serif;font-size:1.8rem;font-weight:800;color:white;margin:12px 0;">Built for Event<br>Professionals</h3>
                    <p style="color:rgba(255,255,255,0.65);font-size:0.9rem;line-height:1.7;">CRDMS was designed to remove the complexity from conference management — so organizers can focus on delivering exceptional experiences.</p>
                    <div class="about-stat-grid">
                        <div class="about-stat"><div class="about-stat-num">50+</div><div class="about-stat-label">Conferences</div></div>
                        <div class="about-stat"><div class="about-stat-num">12+</div><div class="about-stat-label">Delegates</div></div>
                        <div class="about-stat"><div class="about-stat-num">98%</div><div class="about-stat-label">Satisfaction</div></div>
                        <div class="about-stat"><div class="about-stat-num">1+</div><div class="about-stat-label">Years</div></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-7" data-aos="fade-left">
                <div class="about-text-side">
                    <span class="section-label">Our Mission</span>
                    <h2 class="section-title mt-2">Empowering Organizers,<br><span>Connecting Professionals</span></h2>
                    <p style="color:var(--text-muted);line-height:1.8;margin-top:16px;">
                        This platform helps organizers manage conferences efficiently from end to end. Delegates can register easily, and admins can track and manage every event in real time — with zero friction.
                    </p>
                    <ul class="about-feature-list mt-4">
                        <li>
                            <span class="check"><i class="fas fa-check"></i></span>
                            <span><strong>Centralised Dashboard</strong> — Manage all your conferences, delegates, and data from a single, powerful admin interface.</span>
                        </li>
                        <li>
                            <span class="check"><i class="fas fa-check"></i></span>
                            <span><strong>Real-Time Tracking</strong> — Monitor delegate registrations and attendance status as they happen, live.</span>
                        </li>
                        <li>
                            <span class="check"><i class="fas fa-check"></i></span>
                            <span><strong>Automated Communication</strong> — Send invites, confirmations, and reminders automatically — saving your team hours of manual work.</span>
                        </li>
                        <li>
                            <span class="check"><i class="fas fa-check"></i></span>
                            <span><strong>Detailed Reporting</strong> — Export comprehensive reports to analyse delegate data and measure conference success.</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════
     CTA BANNER
════════════════════════════════════════════════════ -->
<section class="cta-section text-center" data-aos="fade-up">
    <div class="cta-orb cta-orb-1"></div>
    <div class="cta-orb cta-orb-2"></div>
    <div class="container">
        <h2>Ready to Host Your Next<br>Conference?</h2>
        <p class="mt-3">Join hundreds of organizers who trust CRDMS to manage their conferences and delight their delegates.</p>
        <div class="d-flex flex-wrap gap-3 justify-content-center">
            <a href="registerConference"
               class="btn btn-cta-primary">
                <i class="fas fa-rocket me-2"></i>Get Started Now
            </a>

            <a href="delegateLogin"
               class="btn btn-cta-secondary">
                <i class="fas fa-user me-2"></i>Delegate Login
            </a>  </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════
     FOOTER
════════════════════════════════════════════════════ -->
<footer>
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="footer-brand">CRDMS</div>
                <p class="footer-desc">Conference Registration & Delegate Management System — your end-to-end event management solution.</p>
            </div>
            <div class="col-md-2 offset-md-1">
                <div class="footer-heading">Navigation</div>
                <ul class="footer-links">
                    <li><a href="#about">About</a></li>
                    <li><a href="#features">Features</a></li>
                    <li><a href="#works">Previous Conferences</a></li>
                    <li><a href="#future">Upcoming Conferences</a></li>
                </ul>
            </div>
            <div class="col-md-2">
                <div class="footer-heading">Access</div>
                <ul class="footer-links">
                    <li><a href="registerConference">Register Conference</a></li>
                    <li><a href="adminLogin">Admin Login</a></li>
                    <li><a href="delegateLogin">Delegate Login</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <div class="footer-heading">Contact</div>
                <div class="footer-contact-item"><i class="fas fa-envelope"></i> support@crdms.com or chethanr1703@gmail.com</div>
                <div class="footer-contact-item"><i class="fas fa-map-marker-alt"></i> Bengaluru, India</div>
                <div class="footer-contact-item"><i class="fas fa-clock"></i> Mon–Fri, 9am–6pm IST</div>
            </div>
        </div>
        <hr class="footer-divider">
        <div class="text-center footer-bottom">
            <p>© 2026 Conference Registration & Delegate Management System. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- ═══════════════════════════════════════════════════
     EVENT MODAL
════════════════════════════════════════════════════ -->
<div class="modal fade" id="eventModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle"></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="modal-detail">
                    <div class="modal-detail-icon"><i class="fas fa-calendar"></i></div>
                    <div><div class="modal-detail-label">Date</div><div class="modal-detail-value" id="modalDate"></div></div>
                </div>
                <div class="modal-detail">
                    <div class="modal-detail-icon"><i class="fas fa-clock"></i></div>
                    <div><div class="modal-detail-label">Time</div><div class="modal-detail-value" id="modalTime"></div></div>
                </div>
                <div class="modal-detail">
                    <div class="modal-detail-icon"><i class="fas fa-users"></i></div>
                    <div><div class="modal-detail-label">Audience</div><div class="modal-detail-value" id="modalAudience"></div></div>
                </div>
            </div>
            <div class="modal-footer">
                <a id="registerBtn" href="#" class="btn btn-register">
                    <i class="fas fa-pen me-2"></i>Register for this Event
                </a>
                <button type="button" class="btn btn-outline-secondary" style="border-radius:50px;padding:10px 22px;font-size:0.88rem;" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
    AOS.init({ duration: 900, once: true, offset: 60 });

    /* Navbar scroll effect */
    window.addEventListener("scroll", function () {
        document.querySelector(".navbar").classList.toggle("scrolled", window.scrollY > 50);
    });

    /* AUTO CLONE FOR INFINITE SLIDER (NO BACKEND CHANGE) */
    function createInfiniteSlider(trackId) {
        const track = document.getElementById(trackId);
        if (!track) return;
        const items = track.innerHTML;
        track.innerHTML += items;
    }

    /* LOAD UPCOMING CONFERENCES FROM API */
    window.addEventListener("load", function () {

        console.log("PAGE LOADED ");

        axios.get("/api/upcoming")
            .then(function (response) {

                console.log("API RESPONSE:", response);
                console.log("DATA:", response.data);

                const data = response.data;
                const track = document.getElementById("upcomingTrack");

                console.log("TRACK:", track);

                let html = "";

                if (!data || data.length === 0) {
                    document.getElementById("upcomingSliderWrapper").innerHTML = `
                        <div class="container">
                            <div class="empty-state">
                                <i class="fas fa-calendar-times d-block"></i>
                                <p>No Upcoming Conferences Available</p>
                            </div>
                        </div>`;
                    return;
                }

               data.forEach(function(conf) {
    html += '<div class="slide-card" onclick="openEventModal(\''
        + conf.conferenceTopic + '\', \''
        + conf.date + '\', \''
        + conf.time + '\', \''
        + conf.targetedAudience + '\', \''
        + conf.id + '\')">'
        + '<div class="conf-card">'
        + '<span class="badge-upcoming"><i class="fas fa-circle me-1" style="font-size:0.5rem;"></i>Upcoming</span>'
        + '<div class="conf-card-icon"><i class="fas fa-microphone-alt"></i></div>'
        + '<h5>' + conf.conferenceTopic + '</h5>'
        + '<p><i class="fas fa-calendar-alt me-1" style="color:var(--orange);"></i>' + conf.date + '</p>'
        + '<p><i class="fas fa-clock me-1" style="color:var(--orange);"></i>' + conf.time + '</p>'
        + '<p><i class="fas fa-users me-1" style="color:var(--orange);"></i>' + conf.targetedAudience + '</p>'
        + '</div></div>';
});

                track.innerHTML = html;
                createInfiniteSlider("upcomingTrack");

            })
            .catch(function (error) {
                console.error("ERROR:", error);
            });

    });

function openEventModal(title, date, time, audience, confId) {

    document.getElementById("modalTitle").innerText = title;
    document.getElementById("modalDate").innerText = date;
    document.getElementById("modalTime").innerText = time;
    document.getElementById("modalAudience").innerText = audience;

    //   HERE
    document.getElementById("registerBtn").href =
        "onlineParticipants?confId=" + confId;

    const modal = new bootstrap.Modal(document.getElementById('eventModal'));
    modal.show();
}
</script>

</body>
</html>
