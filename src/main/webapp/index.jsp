<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
<%
    String message;

    String url = "jdbc:mysql://localhost:3306/ouroboro_ev";
    String user = "root";
    String password = "4200";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);
        message = "Connected successfully!";
        conn.close();
    } catch (Exception e) {
        message = "Error: " + e.toString();
    }
%>

<p><%= message %></p>

</body>
</html>