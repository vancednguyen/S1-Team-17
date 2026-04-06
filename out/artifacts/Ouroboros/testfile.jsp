<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Three Tier Architecture Demo</title>
</head>
<body>
<h1>3-Tier Architecture -- JDBC Connection Example</h1>

<table border="1">
    <tr>
        <td>SJSU ID</td>
        <td>Name</td>
        <td>Major</td>
    </tr>
        <%
     String db = "jdbc:mysql://localhost:3306/ouroboro_ev";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "4200";
        try {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nguyen?autoReconnect=true&useSSL=false",user, password);

            out.println(db + " database successfully opened.<br/><br/>");

            out.println("Initial entries in table \"Student\": <br/>");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM user");

            while (rs.next()) {
         out.println("<tr>" + "<td>" +  rs.getInt(1) + "</td>"+ "<td>" +    rs.getString(2) + "</td>"+   "<td>" + rs.getString(3) + "</td>"  + "</tr>");
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) {
            out.println("SQLException caught: " + e.getMessage());
        }
    %>
</body>
</html>