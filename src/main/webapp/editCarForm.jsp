<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit EV</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #0a0a0a; color: #eee; }

        .content {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h1 {
            font-size: 32px;
            margin-bottom: 30px;
        }

        h1 span {
            color: #3dba6f;
        }

        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 18px;
            gap: 20px;
        }

        .form-row label {
            width: 180px;
            font-size: 18px;
            font-weight: 600;
        }

        .form-row input,
        .form-row select,
        .form-row textarea {
            flex: 1;
            background: #111;
            color: #fff;
            border: 1px solid #2a2a2a;
            border-radius: 8px;
            padding: 12px 14px;
            font-size: 16px;
        }

        .form-row textarea {
            min-height: 100px;
            resize: vertical;
        }

        .submit-btn {
            margin-top: 15px;
            background: #3dba6f;
            color: white;
            border: none;
            padding: 14px 22px;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="content">
    <%
        Car car = (Car) request.getAttribute("car");
    %>

    <h1>Edit Your <span>EV</span></h1>

    <form action="Update-Car" method="post">
        <input type="hidden" name="carId" value="<%= car.getCarId() %>">

        <div class="form-row">
            <label>Manufacturer:</label>
            <input type="text" name="manufacturer" value="<%= car.getManufacturer() %>" required>
        </div>

        <div class="form-row">
            <label>Model:</label>
            <input type="text" name="model" value="<%= car.getModel() %>" required>
        </div>

        <div class="form-row">
            <label>Year:</label>
            <input type="number" name="year" value="<%= car.getYear() %>" required>
        </div>

        <div class="form-row">
            <label>Seats:</label>
            <input type="number" name="seats" value="<%= car.getSeats() %>" required>
        </div>

        <div class="form-row">
            <label>Bag Capacity:</label>
            <input type="number" name="bagCapacity" value="<%= car.getBagCapacity() %>" required>
        </div>

        <div class="form-row">
            <label>Transmission Type:</label>
            <input type="text" name="transmissionType" value="<%= car.getTransmissionType() %>" required>
        </div>

        <div class="form-row">
            <label>Car Type:</label>
            <input type="text" name="carType" value="<%= car.getCarType() %>" required>
        </div>

        <div class="form-row">
            <label>Features:</label>
            <textarea name="features"><%= car.getFeatures() %></textarea>
        </div>

        <div class="form-row">
            <label>Availability:</label>
            <select name="availability" required>
                <option value="Available" <%= "Available".equals(car.getAvailability()) ? "selected" : "" %>>Available</option>
                <option value="Unavailable" <%= "Unavailable".equals(car.getAvailability()) ? "selected" : "" %>>Unavailable</option>
            </select>
        </div>

        <div class="form-row">
            <label>Price:</label>
            <input type="number" step="0.01" name="price" value="<%= car.getPrice() %>" required>
        </div>

        <button type="submit" class="submit-btn">Update EV</button>
    </form>
</div>

</body>
</html>