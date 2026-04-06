<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Home</title>
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
<div class="car-grid">
    <%
        for (Car car : cars) {
    %>
    <div class="car-card">
        <h3><%= car.getManufacturer() %> <%= car.getModel() %></h3>
        <p><strong>Year:</strong> <%= car.getYear() %></p>
        <p><strong>Type:</strong> <%= car.getCarType() %></p>
        <p><strong>Transmission:</strong> <%= car.getTransmissionType() %></p>
        <p><strong>Seats:</strong> <%= car.getSeats() %></p>
        <p><strong>Bag Capacity:</strong> <%= car.getBagCapacity() %></p>
        <p><strong>Features:</strong> <%= car.getFeatures() %></p>
        <p><strong>Status:</strong> <%= car.getAvailability() %></p>
        <p><strong>Price:</strong> $<%= car.getPrice() %> / day</p>
    </div>
    <%
        }
    %>
</div>
<%
    }
%>

</body>
</html>