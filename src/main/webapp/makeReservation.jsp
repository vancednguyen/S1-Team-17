<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="cmpe157.ouroboros.dao.ReservationDao" %>
<%@ page import="cmpe157.ouroboros.model.Car" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Make Reservation</title>
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
        .page { display: flex; flex-direction: column; align-items: center; padding: 60px 2rem; }
        .form-card {
            background: #111;
            border: 1px solid #222;
            border-radius: 12px;
            padding: 2.5rem;
            width: 100%;
            max-width: 500px;
        }
        .form-card h1 { font-size: 22px; font-weight: 700; color: #fff; margin-bottom: 6px; }
        .form-card .sub { font-size: 14px; color: #666; margin-bottom: 2rem; }
        .car-info {
            background: #1a1a1a;
            border: 1px solid #2a2a2a;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            font-size: 14px;
            color: #aaa;
        }
        .car-info span { color: #3dba6f; font-weight: 600; }
        .field { margin-bottom: 1.2rem; }
        .field label { display: block; font-size: 13px; color: #aaa; margin-bottom: 6px; }
        .field input {
            width: 100%;
            background: #1a1a1a;
            border: 1px solid #2a2a2a;
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 14px;
            color: #eee;
            outline: none;
        }
        .field input:focus { border-color: #3dba6f; }
        .field .hint { font-size: 12px; color: #555; margin-top: 4px; }
        .btn-submit {
            width: 100%;
            background: #3dba6f;
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 0.5rem;
        }
        .btn-submit:hover { background: #35a662; }
        .btn-back {
            width: 100%;
            background: transparent;
            color: #aaa;
            border: 1px solid #2a2a2a;
            padding: 12px;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            margin-top: 8px;
            text-align: center;
            text-decoration: none;
            display: block;
        }
        .error { color: #e05555; font-size: 13px; margin-bottom: 1rem; background: #2a1a1a; padding: 10px; border-radius: 8px; }
        .success { color: #3dba6f; font-size: 13px; margin-bottom: 1rem; background: #1a3a1a; padding: 10px; border-radius: 8px; }
    </style>
</head>
<body>

<%-- Redirect if not logged in or not a renter --%>
<%
    String userRole = (String) session.getAttribute("userRole");
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null || !"renter".equals(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="Browse-Cars" class="link-plain">Browse Cars</a>
        <a href="index.jsp" class="link-plain">Home</a>
    </div>
</nav>

<div class="page">
    <div class="form-card">
        <h1>Make a reservation</h1>
        <div class="sub">Select your pickup and return date and time</div>

        <%-- Show error or success messages --%>
        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <% String success = (String) request.getAttribute("success");
           if (success != null) { %>
            <div class="success"><%= success %></div>
        <% } %>

        <%-- Fetch and show car info --%>
        <%
            String carId = request.getParameter("carId");
            if (carId == null) carId = (String) request.getAttribute("carId");

            ReservationDao resDao = new ReservationDao();
            Car selectedCar = resDao.getCarById(carId);
        %>

        <div class="car-info">
            <% if (selectedCar != null) { %>
                You are reserving a <span><%= selectedCar.getYear() %> <%= selectedCar.getManufacturer() %> <%= selectedCar.getModel() %></span>
                <br/>
                <span style="color:#aaa; font-size:13px;">$<%= selectedCar.getPrice() %>/day</span>
            <% } else { %>
                Reserving car: <span><%= carId %></span>
            <% } %>
        </div>

        <form action="ReservationServlet" method="post">
            <input type="hidden" name="carId" value="<%= carId %>" />

            <div class="field">
                <label>Pickup date and time *</label>
                <input type="datetime-local" name="pickupTime" required />
                <div class="hint">Select when you want to pick up the car</div>
            </div>

            <div class="field">
                <label>Return date and time *</label>
                <input type="datetime-local" name="returnTime" required />
                <div class="hint">Select when you will return the car</div>
            </div>

            <button type="submit" class="btn-submit">Confirm reservation</button>
        </form>

        <a href="Browse-Cars" class="btn-back">Back to browse</a>
    </div>
</div>

</body>
</html>