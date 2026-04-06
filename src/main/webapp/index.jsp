<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Home</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        tr:nth-child(even) {
            background-color: #fafafa;
        }
    </style>
</head>
<body>

<h1>Available EV Cars</h1>

<%
    List<Car> cars = (List<Car>) request.getAttribute("cars");
    if (cars == null || cars.isEmpty()) {
%>
<p>No Cars available right now.</p>
<%
} else {
%>

<table>
    <thead>
    <tr>
        <th>Manufacturer & Model</th>
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

</body>
</html>