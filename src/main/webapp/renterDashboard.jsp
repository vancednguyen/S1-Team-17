<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="cmpe157.ouroboros.model.Reservation" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - My Reservations</title>
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
        .link-danger { color: #e05555; padding: 7px 14px; border-radius: 7px; border: 1px solid #3a1a1a; }
        .content { padding: 2rem 2.5rem; }
        .welcome { font-size: 22px; font-weight: 600; color: #fff; margin-bottom: 0.5rem; }
        .welcome span { color: #3dba6f; }
        .sub { font-size: 14px; color: #666; margin-bottom: 2rem; }
        .top-bar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.5rem; }
        .section-title { font-size: 16px; font-weight: 600; color: #fff; padding-bottom: 8px; border-bottom: 1px solid #1e1e1e; margin-bottom: 1rem; }
        .btn-browse {
            background: #3dba6f;
            color: #fff;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
        }
        .btn-browse:hover { background: #35a662; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 2rem; }
        th, td { border: 1px solid #2a2a2a; padding: 10px 14px; text-align: left; font-size: 13px; }
        th { background: #161616; color: #aaa; }
        tr:hover { background: #161616; }
        td { color: #ddd; }
        .badge {
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-booked { background: #1a2a3a; color: #4a9eda; }
        .badge-completed { background: #1a3a1a; color: #3dba6f; }
        .badge-cancelled { background: #3a1a1a; color: #e05555; }
        .btn-cancel {
            background: #3a1a1a;
            color: #e05555;
            border: none;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
        }
        .btn-cancel:hover { background: #e05555; color: #fff; }
        .btn-review {
            background: #1a3a2a;
            color: #3dba6f;
            border: none;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-review:hover { background: #3dba6f; color: #fff; }
        .muted-done { color: #555; font-size: 12px; }
        .flash-ok { color: #3dba6f; font-size: 14px; margin-bottom: 1rem; padding: 10px 14px; background: #1a2a1a; border-radius: 8px; border: 1px solid #2a4a2a; }
        .flash-err { color: #e05555; font-size: 14px; margin-bottom: 1rem; padding: 10px 14px; background: #2a1a1a; border-radius: 8px; border: 1px solid #3a1a1a; }
        .empty { color: #555; font-size: 15px; text-align: center; padding: 3rem; background: #111; border-radius: 12px; border: 1px solid #222; }
        .no-access { text-align: center; padding: 80px 2rem; color: #555; font-size: 15px; }
        .no-access a { color: #3dba6f; text-decoration: none; }
    </style>
</head>
<body>

<%-- Security check — only renters can access this --%>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !role.equals("renter")) {
%>
    <div class="no-access">
        <p>Access denied. <a href="login.jsp">Log in as a renter</a></p>
    </div>
<%
    return;
    }
%>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="Browse-Cars" class="link-plain">Browse Cars</a>
        <a href="index.jsp" class="link-plain">Home</a>
        <form action="LogoutServlet" method="get" style="display:inline;">
            <button type="submit" class="link-danger"
                style="cursor:pointer; background:transparent; border:1px solid #3a1a1a; color:#e05555; padding:7px 14px; border-radius:7px; font-size:14px;">
                Log out
            </button>
        </form>
    </div>
</nav>

<div class="content">
    <div class="welcome">Welcome back, <span><%= session.getAttribute("userName") %></span></div>
    <div class="sub">Here are your current and past reservations</div>

    <% if (request.getAttribute("reviewMessage") != null) { %>
        <div class="flash-ok"><%= request.getAttribute("reviewMessage") %></div>
    <% } %>
    <% if (request.getAttribute("reviewErrorFlash") != null) { %>
        <div class="flash-err"><%= request.getAttribute("reviewErrorFlash") %></div>
    <% } %>

    <div class="top-bar">
        <div class="section-title">My Reservations</div>
        <a href="Browse-Cars" class="btn-browse">+ Browse Cars</a>
    </div>

    <%
        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
        @SuppressWarnings("unchecked")
        Set<String> reviewedReservationIds = (Set<String>) request.getAttribute("reviewedReservationIds");
        if (reviewedReservationIds == null) {
            reviewedReservationIds = java.util.Collections.emptySet();
        }
        if (reservations == null || reservations.isEmpty()) {
    %>
        <div class="empty">
            <p>You have no reservations yet.</p>
            <br/>
            <a href="Browse-Cars" style="color:#3dba6f; text-decoration:none;">Browse available cars →</a>
        </div>
    <%
        } else {
    %>
    <table>
        <thead>
            <tr>
                <th>Reservation ID</th>
                <th>Car ID</th>
                <th>Pickup</th>
                <th>Return</th>
                <th>Total Cost</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% for (Reservation r : reservations) { %>
            <tr>
                <td><%= r.getReservationId() %></td>
                <td><%= r.getCarId() %></td>
                <td><%= r.getPickupTime() %></td>
                <td><%= r.getReturnTime() %></td>
                <td>$<%= r.getTotalCost() %></td>
                <td>
                    <span class="badge
                        <%= "Booked".equals(r.getReservationStatus()) ? "badge-booked" :
                            "Completed".equals(r.getReservationStatus()) ? "badge-completed" :
                            "badge-cancelled" %>">
                        <%= r.getReservationStatus() %>
                    </span>
                </td>
                <td>
                    <% if ("Booked".equals(r.getReservationStatus())) { %>
                        <form action="CancelReservationServlet" method="post" style="display:inline;">
                            <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>" />
                            <button type="submit" class="btn-cancel"
                                onclick="return confirm('Cancel this reservation?')">Cancel</button>
                        </form>
                    <% } else if ("Completed".equals(r.getReservationStatus())) {
                           boolean already = reviewedReservationIds.contains(r.getReservationId());
                           if (!already) { %>
                        <a href="ReviewServlet?reservationId=<%= java.net.URLEncoder.encode(r.getReservationId(), java.nio.charset.StandardCharsets.UTF_8) %>"
                           class="btn-review">Review</a>
                    <%     } else { %>
                        <span class="muted-done">Reviewed</span>
                    <%     }
                       } %>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>

</body>
</html>