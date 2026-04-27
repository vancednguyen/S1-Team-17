<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Your EV</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: Arial, sans-serif;
            background: #0a0a0a;
            color: #eee;
        }

        nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.2rem 2.5rem;
            border-bottom: 1px solid #1e1e1e;
            background: #0a0a0a;
        }

        .logo {
            font-size: 17px;
            font-weight: 600;
            color: #fff;
        }

        .logo span {
            color: #3dba6f;
        }

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

        .submit-btn:hover {
            background: #329a5b;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 25px;
            color: #aaa;
            text-decoration: none;
        }

        .back-link:hover {
            color: #fff;
        }
    </style>
</head>
<body>

<nav>
    <div class="logo">Ouroboros <span>EV</span></div>
</nav>

<div class="content">
    <a href="Owner-Cars" class="back-link">← Back to My EV Listings</a>

    <h1>Add Your <span>EV</span></h1>
    <% if (request.getAttribute("error") != null) { %>
    <p style="color: red; margin-bottom: 15px;">
        <%= request.getAttribute("error") %>
    </p>
    <% } %>

    <form action="Add-Car" method="post">
        <div class="form-row">
            <label for="manufacturer">Manufacturer:</label>
            <input type="text" id="manufacturer" name="manufacturer" required>
        </div>

        <div class="form-row">
            <label for="model">Model:</label>
            <input type="text" id="model" name="model" required>
        </div>

        <div class="form-row">
            <label for="year">Year:</label>
            <input type="number" id="year" name="year" required>
        </div>

        <div class="form-row">
            <label for="seats">Seats:</label>
            <input type="number" id="seats" name="seats" required>
        </div>

        <div class="form-row">
            <label for="bagCapacity">Bag Capacity:</label>
            <input type="number" id="bagCapacity" name="bagCapacity" required>
        </div>

        <div class="form-row">
            <label for="transmissionType">Transmission Type:</label>
            <input type="text" id="transmissionType" name="transmissionType" required>
        </div>

        <div class="form-row">
            <label for="carType">Car Type:</label>
            <input type="text" id="carType" name="carType" required>
        </div>

        <div class="form-row">
            <label for="features">Features:</label>
            <textarea id="features" name="features"></textarea>
        </div>

        <div class="form-row">
            <label for="availability">Availability:</label>
            <select id="availability" name="availability" required>
                <option value="Available">Available</option>
                <option value="Unavailable">Unavailable</option>
            </select>
        </div>

        <div class="form-row">
            <label for="price">Price ($/day):</label>
            <input type="number" step="0.01" id="price" name="price" required>
        </div>

        <button type="submit" class="submit-btn">Submit</button>
    </form>
</div>

</body>
</html>