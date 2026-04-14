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
        .success { background: #1a3a1a; color: #3dba6f; padding: 12px 20px; border-radius: 8px; font-size: 14px; margin-bottom: 2rem; }
        h1 { font-size: 22px; color: #fff; margin-bottom: 8px; }
        p { color: #666; font-size: 14px; }
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
        <div class="success">Account created successfully!</div>
    <% } %>
    <h1>Login</h1>
    <p>Coming soon!</p>
</div>

</body>
</html>