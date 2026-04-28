<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Ouroboros EV - Account Edit</title>
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
      max-width: 480px;
    }
    .form-card h1 { font-size: 22px; font-weight: 700; color: #fff; margin-bottom: 6px; }
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
    .already a { color: #3dba6f; text-decoration: none; }
  </style>
</head>
<body>

<nav>
  <div class="logo">Ouroboros<span> EV</span></div>
  <div class="nav-links">
    <a href="index.jsp" class="link-plain">Home</a>
  </div>
</nav>

<div class="page">
  <div class="form-card">
    <h1>Account Details</h1>

    <% String error = (String) request.getAttribute("error");
      if (error != null) { %>
    <div class="error"><%= error %></div>
    <% } %>

    <form action="AccountEditServlet" method="post">
      <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>">
      <div class="field">
        <label>Email *</label>
        <input type="email" name="email" placeholder= <%= session.getAttribute("userEmail")%> required />
        <div class="hint">Used for account notifications</div>
      </div>
      <div class="field">
        <label>Phone number *</label>
        <input type="tel" name="phone" placeholder= <%= session.getAttribute("userPhoneNumber")%> required />
        <div class="hint">Shared with renters for coordination</div>
      </div>
      <div class="field">
        <label>Username *</label>
        <input type="text" name="username" placeholder=<%= session.getAttribute("userName")%> required />
      </div>
      <button type="submit" class="btn-submit">Update Account</button>
    </form>
  </div>
</div>

</body>
</html>