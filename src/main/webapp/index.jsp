<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #0a0a0a; color: #eee; }
        nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.2rem 2.5rem;
            border-bottom: 1px solid #1e1e1e;
        }
        .logo { font-size: 17px; font-weight: 600; color: #fff; }
        .logo span { color: #3dba6f; }
        .nav-links { display: flex; align-items: center; gap: 10px; }
        .nav-links a { text-decoration: none; font-size: 14px; }
        .link-plain { color: #aaa; padding: 7px 14px; border-radius: 7px; border: 1px solid #2a2a2a; }
        .link-login { color: #ddd; padding: 7px 14px; border-radius: 7px; border: 1px solid #333; }
        .link-started { background: #3dba6f; color: #fff; padding: 7px 16px; border-radius: 7px; font-weight: 500; }
        .hero {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 100px 2rem 90px;
        }
        .hero h1 { font-size: 52px; font-weight: 700; color: #fff; line-height: 1.15; letter-spacing: -1px; margin-bottom: 1rem; }
        .hero h1 span { color: #3dba6f; }
        .hero p { font-size: 17px; color: #777; max-width: 420px; line-height: 1.65; margin-bottom: 2.2rem; }
        .hero-btns { display: flex; gap: 12px; }
        .btn-rent { background: #3dba6f; color: #fff; padding: 13px 28px; border-radius: 8px; font-size: 15px; font-weight: 500; text-decoration: none; }
        .btn-list { background: transparent; color: #ccc; padding: 13px 28px; border-radius: 8px; font-size: 15px; border: 1px solid #2e2e2e; text-decoration: none; }
    </style>
</head>
<body>

<nav>
    <div class="logo">Ouroboros<span> EV</span></div>
    <div class="nav-links">
        <a href="Browse-Cars" class="link-plain">Browse cars</a>
        <%-- Checks if user is logged in --%>
        <% if (session.getAttribute("userEmail") != null) { %>

        <%-- Shows username if logged in --%>
        <span class="link-plain" style="border: none;">Welcome, <%= session.getAttribute("userName") %></span>

        <%-- Shows logout button if logged in --%>
        <form action="LogoutServlet" method="get" style="display: inline;">
            <button type="submit" class="link-login" style="cursor: pointer; background: transparent;">Log out</button>
        </form>

        <% } else { %>

        <%-- Shows login and register buttons if not logged in --%>
        <a href="login.jsp" class="link-login">Log in</a>
        <a href="register.jsp" class="link-started">Get started</a>

        <% } %>
    </div>
</nav>

<div class="hero">
    <h1>Rent electric.<br><span>Drive sustainable.</span></h1>
    <p>A peer-to-peer EV marketplace connecting owners and renters across California.</p>
    <div class="hero-btns">
        <a href="Browse-Cars" class="btn-rent">Rent a car</a>
        <a href="register.jsp?type=owner" class="btn-list">List your EV</a>
    </div>
</div>

</body>
</html>