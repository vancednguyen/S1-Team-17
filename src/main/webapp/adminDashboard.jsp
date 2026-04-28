<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="cmpe157.ouroboros.model.User" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Admin Dashboard</title>
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
        .welcome { font-size: 20px; font-weight: 600; color: #fff; margin-bottom: 2rem; }
        .welcome span { color: #3dba6f; }
        .section-title { font-size: 16px; font-weight: 600; color: #fff; margin-bottom: 1rem; padding-bottom: 8px; border-bottom: 1px solid #1e1e1e; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 3rem; }
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
        .badge-owner { background: #1a2a3a; color: #4a9eda; }
        .badge-renter { background: #1a3a1a; color: #3dba6f; }
        .badge-available { background: #1a3a1a; color: #3dba6f; }
        .badge-unavailable { background: #3a1a1a; color: #e05555; }
        .btn-delete {
            background: #3a1a1a;
            color: #e05555;
            border: none;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
        }
        .btn-delete:hover { background: #e05555; color: #fff; }
        .btn-suspend {
            background: #2a2a1a;
            color: #e0a055;
            border: none;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
            margin-right: 4px;
        }
        .btn-suspend:hover { background: #e0a055; color: #fff; }
        .no-access {
            text-align: center;
            padding: 80px 2rem;
            color: #555;
            font-size: 15px;
        }
        .no-access a { color: #3dba6f; text-decoration: none; }
    </style>
</head>
<body>

<%-- Security check — redirect if not admin --%>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !role.equals("admin")) {
%>
    <div class="no-access">
        <p>Access denied. <a href="login.jsp">Log in as admin</a></p>
    </div>
<%
    return;
    }
%>

<nav>
    <div class="logo">Ouroboros<span> EV</span> <span style="font-size:12px; color:#555; font-weight:400;">Admin</span></div>
    <div class="nav-links">
        <a href="index.jsp" class="link-plain">Home</a>
        <a href="LogoutServlet" class="link-danger">Log out</a>
    </div>
</nav>

<div class="content">
    <div class="welcome">Admin Dashboard <span>#<%= session.getAttribute("adminId") %></span></div>

    <%-- Users Table --%>
    <div class="section-title">All Users</div>
    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users == null || users.isEmpty()) {
    %>
        <p style="color:#555; margin-bottom:2rem;">No users found.</p>
    <%
        } else {
    %>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% for (User user : users) { %>
            <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getPhoneNumber() %></td>
                <td>
                    <span class="badge <%= user.getRole().equals("owner") ? "badge-owner" : "badge-renter" %>">
                        <%= user.getRole() %>
                    </span>
                </td>
                <td>
                    <form action="AdminActionServlet" method="post" style="display:inline;">
                        <input type="hidden" name="userId" value="<%= user.getUserId() %>" />
                        <input type="hidden" name="action" value="delete" />
                        <button type="submit" class="btn-delete"
                            onclick="return confirm('Delete this user?')">Delete</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>

    <%-- Cars Table --%>
    <div class="section-title">All Vehicle Listings</div>
    <%
        List<Car> cars = (List<Car>) request.getAttribute("cars");
        if (cars == null || cars.isEmpty()) {
    %>
        <p style="color:#555;">No vehicles found.</p>
    <%
        } else {
    %>
    <table>
        <thead>
            <tr>
                <th>Car ID</th>
                <th>Manufacturer</th>
                <th>Model</th>
                <th>Year</th>
                <th>Price/day</th>
                <th>Seats</th>
                <th>Availability</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% for (Car car : cars) { %>
            <tr>
                <td><%= car.getCarId() %></td>
                <td><%= car.getManufacturer() %></td>
                <td><%= car.getModel() %></td>
                <td><%= car.getYear() %></td>
                <td>$<%= car.getPrice() %></td>
                <td><%= car.getSeats() %></td>
                <td>
                    <span class="badge <%= car.getAvailability().equals("Available") ? "badge-available" : "badge-unavailable" %>">
                        <%= car.getAvailability() %>
                    </span>
                </td>
                <td>
                    <form action="AdminActionServlet" method="post" style="display:inline;">
                        <input type="hidden" name="carId" value="<%= car.getCarId() %>" />
                        <input type="hidden" name="action" value="deleteCar" />
                        <button type="submit" class="btn-delete"
                            onclick="return confirm('Remove this listing?')">Remove</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>

</body>
</html>