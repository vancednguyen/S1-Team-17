<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Leave a review</title>
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
        .nav-links { display: flex; align-items: center; gap: 10px; }
        .nav-links a { text-decoration: none; font-size: 14px; }
        .link-plain { color: #aaa; padding: 7px 14px; border-radius: 7px; border: 1px solid #2a2a2a; }
        .page { display: flex; flex-direction: column; align-items: center; padding: 60px 2rem; }
        .form-card {
            background: #111;
            border: 1px solid #222;
            border-radius: 12px;
            padding: 2.5rem;
            width: 100%;
            max-width: 500px;
        }
        .form-card h1 { font-size: 22px; font-weight: 700; color: #fff; margin-bottom: 6px; }
        .form-card .sub { font-size: 14px; color: #666; margin-bottom: 2rem; }
        .car-info {
            background: #1a1a1a;
            border: 1px solid #2a2a2a;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            font-size: 14px;
            color: #aaa;
        }
        .car-info span { color: #3dba6f; font-weight: 600; }
        .field { margin-bottom: 1.2rem; }
        .field label { display: block; font-size: 13px; color: #aaa; margin-bottom: 6px; }
        .field textarea {
            width: 100%;
            min-height: 120px;
            background: #1a1a1a;
            border: 1px solid #2a2a2a;
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 14px;
            color: #eee;
            outline: none;
            resize: vertical;
        }
        .field textarea:focus { border-color: #3dba6f; }
        .stars label { display: inline-block; margin-right: 8px; cursor: pointer; color: #ddd; font-size: 15px; }
        .stars input { margin-right: 4px; }
        .btn-submit {
            width: 100%;
            background: #3dba6f;
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 0.5rem;
        }
        .btn-submit:hover { background: #35a662; }
        .btn-back {
            width: 100%;
            background: transparent;
            color: #aaa;
            border: 1px solid #2a2a2a;
            padding: 12px;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            margin-top: 8px;
            text-align: center;
            text-decoration: none;
            display: block;
        }
        .error { color: #e05555; font-size: 13px; margin-bottom: 1rem; background: #2a1a1a; padding: 10px; border-radius: 8px; }
    </style>
</head>
<body>

<%
    String userRole = (String) session.getAttribute("userRole");
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null || !"renter".equals(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }
    Car car = (Car) request.getAttribute("car");
    String reservationId = (String) request.getAttribute("reservationId");
    if (car == null || reservationId == null) {
        response.sendRedirect("RenterDashboardServlet");
        return;
    }
%>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="RenterDashboardServlet" class="link-plain">My reservations</a>
        <a href="Browse-Cars" class="link-plain">Browse cars</a>
    </div>
</nav>

<div class="page">
    <div class="form-card">
        <h1>Leave a review</h1>
        <div class="sub">Share your experience after your completed trip</div>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <div class="car-info">
            <span><%= car.getYear() %> <%= car.getManufacturer() %> <%= car.getModel() %></span>
            <br/>
            <span style="color:#aaa; font-size:13px;">Reservation <%= reservationId %> · $<%= car.getPrice() %>/day</span>
        </div>

        <form action="ReviewServlet" method="post">
            <input type="hidden" name="reservationId" value="<%= reservationId %>" />

            <div class="field">
                <label>Rating *</label>
                <div class="stars">
                    <% for (int s = 1; s <= 5; s++) { %>
                        <label><input type="radio" name="rating" value="<%= s %>" required /> <%= s %> star<%= s > 1 ? "s" : "" %></label>
                    <% } %>
                </div>
            </div>

            <div class="field">
                <label for="comment">Comment *</label>
                <textarea id="comment" name="comment" required maxlength="2000" placeholder="What did you like? Any tips for future renters?"></textarea>
            </div>

            <button type="submit" class="btn-submit">Submit review</button>
        </form>

        <a href="RenterDashboardServlet" class="btn-back">Cancel</a>
    </div>
</div>

</body>
</html>
