<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Your EVs</title>
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

        .nav-links {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .link-plain, .link-login {
            text-decoration: none;
            font-size: 14px;
            padding: 7px 14px;
            border-radius: 7px;
            border: 1px solid #2a2a2a;
            color: #ddd;
            background: transparent;
        }

        .content {
            padding: 2rem 2.5rem;
        }

        h1 {
            font-size: 32px;
            margin-bottom: 1.5rem;
        }

        h1 span {
            color: #3dba6f;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #2a2a2a;
            padding: 10px;
            text-align: left;
            font-size: 14px;
        }

        th { background-color: #161616; color: #aaa; }
        tr:nth-child(even) { background-color: #111; }

        .edit-btn, .delete-btn {
            text-decoration: none;
            border: none;
            padding: 8px 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 8px;
        }

        .edit-btn {
            background: #3dba6f;
            color: white;
        }

        .delete-btn {
            background: #8b2e2e;
            color: white;
        }

        .inline-form {
            display: inline;
        }
    </style>
</head>
<body>

<nav>
    <div class="logo">Ouroboros <span>EV</span></div>
    <div class="nav-links">
        <a href="index.jsp" class="link-plain">Home</a>
        <a href="Owner-Cars" class="link-plain">My EV Listings</a>
    </div>
</nav>

<div class="content">
    <h1>Edit Your <span>EVs</span></h1>

    <%
        List<Car> cars = (List<Car>) request.getAttribute("cars");
        if (cars == null || cars.isEmpty()) {
    %>
    <p>You have no EVs to edit.</p>
    <%
    } else {
    %>

    <table>
        <thead>
        <tr>
            <th>Manufacturer & Model</th>
            <th>Year</th>
            <th>Price</th>
            <th>Seats</th>
            <th>Bag Space</th>
            <th>Transmission</th>
            <th>Car Type</th>
            <th>Features</th>
            <th>Availability</th>
            <th>Actions</th>
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
            <td>
                <a href="Edit-Car-Form?carId=<%= car.getCarId() %>" class="edit-btn">Edit</a>

                <form action="Delete-Car" method="post" class="inline-form">
                    <input type="hidden" name="carId" value="<%= car.getCarId() %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
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