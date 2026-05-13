<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>
<%@ page import="cmpe157.ouroboros.model.Review" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Vehicle details</title>
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
        .link-login { color: #ddd; padding: 7px 14px; border-radius: 7px; border: 1px solid #333; }
        .content { padding: 2rem 2.5rem; max-width: 900px; margin: 0 auto; }
        h1 { font-size: 24px; font-weight: 600; color: #fff; margin-bottom: 0.5rem; }
        .sub { color: #888; font-size: 14px; margin-bottom: 1.5rem; }
        .spec-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 12px;
            margin-bottom: 2rem;
        }
        .spec {
            background: #111;
            border: 1px solid #222;
            border-radius: 8px;
            padding: 12px 14px;
        }
        .spec .k { font-size: 11px; color: #666; text-transform: uppercase; letter-spacing: 0.04em; }
        .spec .v { font-size: 14px; color: #ddd; margin-top: 4px; }
        .avg { font-size: 16px; color: #3dba6f; margin-bottom: 1rem; }
        .section-title { font-size: 16px; font-weight: 600; color: #fff; padding-bottom: 8px; border-bottom: 1px solid #1e1e1e; margin-bottom: 1rem; }
        .review {
            background: #111;
            border: 1px solid #222;
            border-radius: 10px;
            padding: 1rem 1.25rem;
            margin-bottom: 12px;
        }
        .review .meta { font-size: 12px; color: #666; margin-bottom: 6px; }
        .review .meta strong { color: #3dba6f; }
        .review p { font-size: 14px; color: #ccc; line-height: 1.45; }
        .empty-reviews { color: #555; font-size: 14px; padding: 1.5rem; background: #111; border-radius: 10px; border: 1px solid #222; }
        .actions { margin-top: 1.5rem; display: flex; gap: 10px; flex-wrap: wrap; }
        .btn {
            display: inline-block;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
        }
        .btn-primary { background: #3dba6f; color: #fff; }
        .btn-primary:hover { background: #35a662; }
        .btn-secondary { background: transparent; color: #aaa; border: 1px solid #2a2a2a; }
        .back-btn {
            text-decoration: none;
            font-size: 15px;
            font-weight: 600;
            color: #ddd;
            border: 1px solid #2a2a2a;
            padding: 8px 18px;
            border-radius: 10px;
            background: transparent;
            transition: 0.2s ease;
        }
        .back-btn:hover { background: #111; }
    </style>
</head>
<body>

<%
    Car car = (Car) request.getAttribute("car");
    if (car == null) {
        response.sendRedirect("Browse-Cars");
        return;
    }
    @SuppressWarnings("unchecked")
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    Double avgRatingObj = (Double) request.getAttribute("avgRating");
    double avgRating = avgRatingObj != null ? avgRatingObj : 0.0;
%>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="Browse-Cars" class="link-plain">Browse cars</a>
        <a href="index.jsp" class="link-plain">Home</a>
        <% if ("renter".equals(session.getAttribute("userRole"))) { %>
            <a href="RenterDashboardServlet" class="link-plain">My reservations</a>
        <% } %>
        <% if (session.getAttribute("userEmail") != null) { %>
            <form action="LogoutServlet" method="get" style="display:inline;">
                <button type="submit" class="link-login" style="cursor:pointer; background:transparent;">Log out</button>
            </form>
        <% } else { %>
            <a href="login.jsp" class="link-login">Log in</a>
        <% } %>
    </div>
</nav>

<div class="content">
    <% if ("owner".equals(session.getAttribute("userRole"))) { %>
    <div style="display: flex; justify-content: flex-end; margin-bottom: 20px;">
        <a href="Owner-Cars" class="back-btn">Back to my Listing</a>
    </div>
    <% } %>
    <h1><%= car.getManufacturer() %> <%= car.getModel() %></h1>
    <div class="sub">Year <%= car.getYear() %> · <%= car.getCarType() %> · <%= car.getTransmissionType() %> · <%= car.getAvailability() %></div>

    <% if (avgRating > 0) { %>
        <div class="avg">Average rating: <%= String.format("%.1f", avgRating) %> / 5</div>
    <% } else { %>
        <div class="avg" style="color:#666;">No ratings yet</div>
    <% } %>

    <div class="spec-grid">
        <div class="spec"><div class="k">Price</div><div class="v">$<%= car.getPrice() %> / day</div></div>
        <div class="spec"><div class="k">Seats</div><div class="v"><%= car.getSeats() %></div></div>
        <div class="spec"><div class="k">Bag capacity</div><div class="v"><%= car.getBagCapacity() %></div></div>
        <div class="spec"><div class="k">Features</div><div class="v"><%= car.getFeatures() != null ? car.getFeatures() : "—" %></div></div>
    </div>

    <div class="actions">
        <% if (session.getAttribute("userEmail") != null && "renter".equals(session.getAttribute("userRole")) && "Available".equals(car.getAvailability())) { %>
            <a href="makeReservation.jsp?carId=<%= car.getCarId() %>" class="btn btn-primary">Rent this EV</a>
        <% } else if (session.getAttribute("userEmail") == null) { %>
            <a href="login.jsp" class="btn btn-secondary">Log in to rent</a>
        <% } %>
        <a href="Browse-Cars" class="btn btn-secondary">Back to browse</a>
    </div>

    <h2 class="section-title" style="margin-top:2rem;">Reviews</h2>
    <% if (reviews == null || reviews.isEmpty()) { %>
        <div class="empty-reviews">No reviews for this vehicle yet.</div>
    <% } else {
            for (Review rev : reviews) {
                String who = rev.getReviewerName();
                if (who == null || who.isEmpty()) who = "Guest";
    %>
        <div class="review">
            <div class="meta"><strong><%= who %></strong> · <%= rev.getRating() %> / 5</div>
            <p><%= rev.getComment() %></p>
        </div>
    <%      }
       } %>
</div>

</body>
</html>
