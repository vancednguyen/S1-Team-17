    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Ouroboros EV - Account Details</title>
        <style>
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
            .success { background: #1a3a1a; color: #3dba6f; padding: 12px 20px; border-radius: 8px; font-size: 14px; margin-bottom: 2rem; }
        </style>
    </head>
    <body>

    <nav>
        <div class="logo">Ouroboros<span> EV</span></div>
        <div class="nav-links">
            <a href="index.jsp" class="link-plain">Home</a>
            <form action="LogoutServlet" method="get" style="display: inline;">
                <button type="submit" class="link-plain" style="cursor: pointer; background: transparent;">Log out</button>
            </form>
        </div>
    </nav>

    <div class="page">
        <% if ("success".equals(request.getParameter("update"))) { %>
        <div class="success">Account details updated!</div>
        <% } %>

        <div class="form-card">
            <h1>Account Details</h1>

            <%
                if (session.getAttribute("userEmail") != null) {
            %>

            <div class="field">
                <label>Id</label>
                <span class="info-value"><%= session.getAttribute("userId") %></span>
            </div>

            <div class="field">
                <label>Username</label>
                <span class="info-value"><%= session.getAttribute("userName") %></span>
            </div>

            <div class="field">
                <label>Email</label>
                <span class="info-value"><%= session.getAttribute("userEmail") %></span>
            </div>

            <div class="field">
                <label>Phone Number</label>
                <span class="info-value"><%= session.getAttribute("userPhoneNumber") %></span>
            </div>

            <div class="field">
                <label>Account Role</label>
                <span class="info-value"><%= session.getAttribute("userRole") %></span>
            </div>

            <a href="accountEdit.jsp" class="link-plain">Edit Account</a>
            <%
                } else {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>
        </div>
    </div>


    </body>
    </html>