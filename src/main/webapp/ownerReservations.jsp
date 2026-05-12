<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="cmpe157.ouroboros.model.Reservation" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Reservations</title>
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
        .link-plain, .link-login {
            text-decoration: none;
            font-size: 14px;
            padding: 7px 14px;
            border-radius: 7px;
            border: 1px solid #2a2a2a;
            color: #ddd;
            background: transparent;
        }
        .content { padding: 2rem 2.5rem; }
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }
        .page-header h1 { font-size: 24px; margin: 0; }
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
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #2a2a2a; padding: 10px; text-align: left; font-size: 14px; }
        th { background-color: #161616; color: #aaa; }
        tr:nth-child(even) { background-color: #111; }
        td { color: #ddd; }
        p { color: #777; margin-top: 1rem; }

        /* Status badge */
        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-booked    { background: #1a3a5c; color: #5bb8f5; }
        .badge-completed { background: #1a3a1a; color: #3dba6f; }
        .badge-cancelled { background: #3a1a1a; color: #e05c5c; }

        /* Action buttons */
        .action-cell { display: flex; gap: 8px; flex-wrap: wrap; }
        .btn-cancel {
            background: #3a1a1a;
            color: #e05c5c;
            border: 1px solid #5a2a2a;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            font-weight: 600;
        }
        .btn-cancel:hover { background: #5a1a1a; }
        .btn-complete {
            background: #1a3a1a;
            color: #3dba6f;
            border: 1px solid #2a5a2a;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            font-weight: 600;
        }
        .btn-complete:hover { background: #1a5a1a; }
        .action-done { color: #555; font-size: 13px; font-style: italic; }
    </style>
</head>
<body>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="index.jsp" class="link-plain">Home</a>
        <a href="Browse-Cars" class="link-plain">Browse cars</a>
        <span class="link-plain" style="border:none;">Welcome, <%= session.getAttribute("userName") %></span>
        <form action="LogoutServlet" method="get" style="display:inline;">
            <button type="submit" class="link-login" style="cursor:pointer;">Log out</button>
        </form>
    </div>
</nav>

<div class="content">
    <div class="page-header">
        <h1>My Reservations</h1>
        <a href="Owner-Cars" class="back-btn">&#8592; Back to My Listings</a>
    </div>

    <%
        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
        if (reservations == null || reservations.isEmpty()) {
    %>
    <p>No reservations found for your cars.</p>
    <%
    } else {
    %>

    <table>
        <thead>
        <tr>
            <th>Reservation ID</th>
            <th>Renter</th>
            <th>Car</th>
            <th>Pickup</th>
            <th>Return</th>
            <th>Total Cost</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Reservation res : reservations) {
                String status = res.getReservationStatus();
                String badgeClass = "badge-booked";
                if ("Completed".equals(status)) badgeClass = "badge-completed";
                else if ("Cancelled".equals(status)) badgeClass = "badge-cancelled";
                boolean isActive = "Booked".equals(status);
        %>
        <tr>
            <td><%= res.getReservationId() %></td>
            <td><%= res.getRenterName() %></td>
            <td><%= res.getCarName() %></td>
            <td><%= res.getPickupTime() %></td>
            <td><%= res.getReturnTime() %></td>
            <td>$<%= String.format("%.2f", res.getTotalCost()) %></td>
            <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
            <td>
                <% if (isActive) { %>
                <div class="action-cell">
                    <form action="OwnerActionServlet" method="post" style="margin:0;">
                        <input type="hidden" name="reservationId" value="<%= res.getReservationId() %>">
                        <input type="hidden" name="action" value="Complete">
                        <button type="submit" class="btn-complete">Complete</button>
                    </form>
                    <form action="OwnerActionServlet" method="post" style="margin:0;">
                        <input type="hidden" name="reservationId" value="<%= res.getReservationId() %>">
                        <input type="hidden" name="action" value="Cancel">
                        <button type="submit" class="btn-cancel">Cancel</button>
                    </form>
                </div>
                <% } else { %>
                <span class="action-done">No actions available</span>
                <% } %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <%
        }
    %>
</div>

</body>
</html>
