<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Reservation Confirmed</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #0a0a0a; color: #eee; }
        nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.2rem 2.5rem;
            border-bottom: 1px solid #1e1e1e;
            background: #0a0a0a;
        }
        .logo { font-size: 17px; font-weight: 600; color: #fff; }
        .logo span { color: #3dba6f; }
        .nav-links a { text-decoration: none; font-size: 14px; color: #aaa; padding: 7px 14px; border-radius: 7px; border: 1px solid #2a2a2a; }
        .page { display: flex; flex-direction: column; align-items: center; padding: 80px 2rem; text-align: center; }
        .card {
            background: #111;
            border: 1px solid #222;
            border-radius: 12px;
            padding: 2.5rem;
            max-width: 480px;
            width: 100%;
        }
        .icon { font-size: 48px; margin-bottom: 1rem; }
        h1 { font-size: 24px; font-weight: 700; color: #fff; margin-bottom: 8px; }
        .sub { font-size: 14px; color: #666; margin-bottom: 2rem; }
        .detail { background: #1a1a1a; border-radius: 8px; padding: 1rem; margin-bottom: 1rem; font-size: 14px; color: #aaa; text-align: left; }
        .detail span { color: #3dba6f; font-weight: 600; }
        .btn-primary { background: #3dba6f; color: #fff; padding: 12px 28px; border-radius: 8px; font-size: 15px; font-weight: 500; text-decoration: none; display: inline-block; margin-top: 1rem; }
        .btn-secondary { background: transparent; color: #aaa; border: 1px solid #2a2a2a; padding: 12px 28px; border-radius: 8px; font-size: 15px; text-decoration: none; display: inline-block; margin-top: 8px; }
        .btn-row { display: flex; gap: 12px; justify-content: center; flex-wrap: wrap; margin-top: 1rem; }
    </style>
</head>
<body>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
		<a href="RenterDashboardServlet" style="color:#aaa; padding:7px 14px; border-radius:7px; border:1px solid #2a2a2a; text-decoration:none; font-size:14px;">My Reservations</a>
    </div>
</nav>

<div class="page">
    <div class="card">
        <div class="icon">✅</div>
        <h1>Reservation confirmed!</h1>
        <div class="sub">Your booking has been successfully placed.</div>

        <div class="detail">
            Car ID: <span><%= session.getAttribute("lastReservationCar") %></span>
        </div>
        <div class="detail">
            Total cost: <span>$<%= session.getAttribute("lastReservationCost") %></span>
        </div>

        <div class="btn-row">
            <a href="Browse-Cars" class="btn-primary">Browse more cars</a>
            <a href="index.jsp" class="btn-secondary">Go home</a>
        </div>
    </div>
</div>

</body>
</html>