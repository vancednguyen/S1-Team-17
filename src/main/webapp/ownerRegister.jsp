<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Owner Registration</title>
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
        .page { display: flex; flex-direction: column; align-items: center; padding: 60px 2rem; }
        .form-card {
            background: #111;
            border: 1px solid #222;
            border-radius: 12px;
            padding: 2.5rem;
            width: 100%;
            max-width: 480px;
        }
        .form-card h1 { font-size: 22px; font-weight: 700; color: #fff; margin-bottom: 6px; }
        .form-card .sub { font-size: 14px; color: #666; margin-bottom: 2rem; }
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
        .error { color: #e05555; font-size: 13px; margin-bottom: 1rem; }
        .already { margin-top: 1.5rem; font-size: 14px; color: #555; text-align: center; }
        .already a { color: #3dba6f; text-decoration: none; }
    </style>
</head>
<body>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="index.jsp" class="link-plain">Home</a>
        <a href="login.jsp" class="link-login">Log in</a>
    </div>
</nav>

<div class="page">
    <div class="form-card">
        <h1>Owner registration</h1>
        <div class="sub">Create your owner account to list your EV</div>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <form action="OwnerRegisterServlet" method="post">
            <div class="field">
                <label>Email *</label>
                <input type="email" name="email" placeholder="you@example.com" required />
                <div class="hint">Used for account notifications</div>
            </div>
            <div class="field">
                <label>Phone number *</label>
                <input type="tel" name="phone" placeholder="(555) 555-5555" required />
                <div class="hint">Shared with renters for coordination</div>
            </div>
            <div class="field">
                <label>Username *</label>
                <input type="text" name="username" placeholder="Choose a username" required />
            </div>
            <div class="field">
                <label>Password *</label>
                <input type="password" name="password" placeholder="Create a password" required />
            </div>
            <div class="field">
                <label>Driver's license number *</label>
                <input type="text" name="licenseNumber" placeholder="e.g. D1234567" required />
            </div>
            <div class="field">
                <label>License expiration date *</label>
                <input type="date" name="licenseExpiration" required />
            </div>
            <div class="field">
                <label>Location *</label>
                <input type="text" name="location" placeholder="e.g. San Jose, CA" required />
                <div class="hint">Your general area helps renters find your vehicle</div>
            </div>
            <button type="submit" class="btn-submit">Create owner account</button>
        </form>

        <div class="already">Already have an account? <a href="login.jsp">Log in</a></div>
        <div class="already" style="margin-top:8px;">Not an owner? <a href="renterRegister.jsp">Register as renter</a></div>
    </div>
</div>

</body>
</html>