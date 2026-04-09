<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ouroboros EV - Get Started</title>
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
        .page {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 80px 2rem;
            text-align: center;
        }
        h1 { font-size: 28px; font-weight: 700; color: #fff; margin-bottom: 10px; }
        p { color: #777; font-size: 15px; margin-bottom: 2.5rem; }
        .cards { display: flex; gap: 20px; flex-wrap: wrap; justify-content: center; }
        .card {
            background: #111;
            border: 1px solid #222;
            border-radius: 12px;
            padding: 2.5rem 2rem;
            width: 220px;
            text-decoration: none;
            transition: border-color 0.2s;
        }
        .card:hover { border-color: #3dba6f; }
        .card-icon { font-size: 36px; margin-bottom: 1rem; }
        .card h2 { font-size: 18px; font-weight: 600; color: #fff; margin-bottom: 8px; }
        .card p { font-size: 13px; color: #777; margin: 0; }
        .already { margin-top: 2rem; font-size: 14px; color: #555; }
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
    <h1>Create an account</h1>
    <p>Choose how you want to use Ouroboros EV</p>
    <div class="cards">
        <a href="ownerRegister.jsp" class="card">
            <h2>I'm an Owner</h2>
            <p>List your EV and earn income from rentals</p>
        </a>
        <a href="renterRegister.jsp" class="card">
            <h2>I'm a Renter</h2>
            <p>Browse and book EVs near you</p>
        </a>
    </div>
    <div class="already">Already have an account? <a href="login.jsp">Log in</a></div>
</div>

</body>
</html>