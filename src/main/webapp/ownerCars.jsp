<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>
<!DOCTYPE html>
<html>
<head>
    <title>My EV Listings</title>
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
        h1 { font-size: 24px; margin-bottom: 1rem; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td {
            border: 1px solid #2a2a2a;
            padding: 10px;
            text-align: left;
            font-size: 14px;
        }
        th { background-color: #161616; color: #aaa; }
        tr:nth-child(even) { background-color: #111; }
        td { color: #ddd; }
        p { color: #777; margin-top: 1rem; }
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .page-header h1 {
            font-size: 24px;
            margin: 0;
        }

        .add-ev-btn {
            text-decoration: none;
            font-size: 24px;
            font-weight: 700;
            color: #fff;
            border: 1px solid #2a2a2a;
            padding: 10px 18px;
            border-radius: 10px;
            background: transparent;
            transition: 0.2s ease;
        }

        .add-ev-btn span {
            color: #3dba6f;
        }

        .add-ev-btn:hover {
            background: #111;
        }
        .action-buttons {
            display: flex;
            gap: 14px;
        }

        .edit-ev-btn {
            text-decoration: none;
            font-size: 24px;
            font-weight: 700;
            color: #fff;
            border: 1px solid #2a2a2a;
            padding: 10px 18px;
            border-radius: 10px;
            background: transparent;
            transition: 0.2s ease;
        }

        .edit-ev-btn span {
            color: #3dba6f;
        }

        .edit-ev-btn:hover {
            background: #111;
        }
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
        <h1>My EV Listings</h1>
        <a href="Add-Car" class="add-ev-btn">Add Your <span>EV</span></a>
        <a href="Edit-Cars" class="edit-ev-btn">Edit Your <span>EV</span></a>
    </div>

    <%
        List<Car> cars = (List<Car>) request.getAttribute("cars");
        if (cars == null || cars.isEmpty()) {
    %>
    <p>You have no listed cars yet.</p>
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
            <th>Availability</th>
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
            <td><%= car.getAvailability() %></td>
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