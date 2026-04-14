<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Login</title>
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
        .nav-links a { text-decoration: none; font-size: 14px; color: #aaa; padding: 7px 14px; border-radius: 7px; border: 1px solid #2a2a2a; }
        .page { display: flex; flex-direction: column; align-items: center; padding: 80px 2rem; text-align: center; }
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
        .success { background: #1a3a1a; color: #3dba6f; padding: 12px 20px; border-radius: 8px; font-size: 14px; margin-bottom: 2rem; }
        h1 { font-size: 22px; color: #fff; margin-bottom: 8px; }
        p { color: #666; font-size: 14px; }
        .already { margin-top: 2rem; font-size: 14px; color: #555; }
        .already a { color: #3dba6f; text-decoration: none; }
    </style>
</head>
<body>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
    </div>
</nav>

<div class="page">
    <% String registered = request.getParameter("registered");
        if ("true".equals(registered)) { %>
    <div class="success-message">Account created successfully! Please log in.</div>
    <% } %>

    <% if ("success".equals(request.getParameter("logout"))) { %>
    <div class="success">You have been successfully logged out.</div>
    <% } %>

    <% String error = request.getParameter("error");
        if ("invalid".equals(error)) { %>
    <div class="error-message" style="color: #d9534f; background: #f2dede; padding: 10px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #ebccd1;">
        Invalid email or password.
    </div>
    <% } %>


    <div class="form-card">
        <h1>Login</h1>
        <form action="LoginServlet" method="post">
            <div class="field">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required/>
            </div>

            <div class="field">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required/>
            </div>

            <button type="submit" class="btn-submit">Login</button>
        </form>
    </div>

    <div class="already">
        Don't have an account? <a href="register.jsp">Register here</a>
    </div>

</div>

</body>
</html>