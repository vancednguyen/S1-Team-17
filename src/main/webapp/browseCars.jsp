<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Browse Cars</title>
    <link rel="stylesheet" href="styles/search_bar.css">
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
        .link-started { background: #3dba6f; color: #fff; padding: 7px 16px; border-radius: 7px; font-weight: 500; }
        .content { padding: 2rem 2.5rem; }
        h1 { font-size: 24px; font-weight: 600; color: #fff; margin-bottom: 1rem; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #2a2a2a; padding: 10px; text-align: left; font-size: 14px; }
        th { background-color: #161616; color: #aaa; }
        tr:nth-child(even) { background-color: #111; }
        tr:hover { background-color: #161616; }
        td { color: #ddd; }
        p { color: #777; font-size: 15px; margin-top: 1rem; }
    </style>
</head>
<body>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="index.jsp" class="link-plain">Home</a>

        <% if (session.getAttribute("userEmail") != null) { %>

        <span class="link-plain" style="border: none;">
                Welcome, <%= session.getAttribute("userName") %>
            </span>

        <form action="LogoutServlet" method="get" style="display: inline;">
            <button type="submit" class="link-login"
                    style="cursor: pointer; background: transparent;">
                Log out
            </button>
        </form>

        <% } else { %>

        <a href="login.jsp" class="link-login">Log in</a>
        <a href="register.jsp" class="link-started">Get started</a>

        <% } %>
    </div>
</nav>
<form action="Browse-Cars" method="get" class="search-form">

    <input type="text" name="keyword" placeholder="Search make, model, features..."
           value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" />

    <input type="number" name="year" placeholder="Year"
           value="<%= request.getParameter("year") != null ? request.getParameter("year") : "" %>" />

    <input type="number" step="0.01" name="minPrice" placeholder="Min Price"
           value="<%= request.getParameter("minPrice") != null ? request.getParameter("minPrice") : "" %>" />

    <input type="number" step="0.01" name="maxPrice" placeholder="Max Price"
           value="<%= request.getParameter("maxPrice") != null ? request.getParameter("maxPrice") : "" %>" />

    <input type="number" name="seats" placeholder="Seats"
           value="<%= request.getParameter("seats") != null ? request.getParameter("seats") : "" %>" />

    <button type="submit">Search</button>
    <a href="Browse-Cars" class="clear-btn">Clear</a>
</form>
<div class="content">
    <h1>Available EV Cars</h1>

    <%
        List<Car> cars = (List<Car>) request.getAttribute("cars");
        if (cars == null || cars.isEmpty()) {
    %>
    <p>No cars available right now.</p>
    <%
    } else {
    %>

    <table>
        <thead>
        <tr>
            <th>Manufacturer &amp; Model</th>
            <th>Year</th>
            <th>Price ($/day)</th>
            <th>Seats</th>
            <th>Bag Space</th>
            <th>Transmission</th>
            <th>Car Type</th>
            <th>Features</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Car car : cars) {
        %>
        <tr>
            <td><%= car.getManufacturer() %> <%= car.getModel() %></td>
            <td><%= car.getYear() %></td>
            <td>$<%= car.getPrice() %></td>
            <td><%= car.getSeats() %></td>
            <td><%= car.getBagCapacity() %></td>
            <td><%= car.getTransmissionType() %></td>
            <td><%= car.getCarType() %></td>
            <td><%= car.getFeatures() %></td>
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