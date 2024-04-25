<%-- 
    Document   : register
    Created on : 13 Apr, 2024, 2:21:17 PM
    Author     : aksha
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>

<%
    // Handle form submission and database insertion
    if (request.getMethod().equals("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3307/socialmedia";
        String dbUsername = "root";
        String dbPassword = "";

        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, dbUsername, dbPassword);

            // Insert data into database
            String sql = "INSERT INTO admin (username, password, email) VALUES (?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, email);

            int rowsInserted = statement.executeUpdate();
            statement.close();
            connection.close();

            if (rowsInserted > 0) {
%>
                <script>
                    window.location.href = "home.jsp";
                    alert("Registered successfully");

                </script>
<%
            } else {
%>
                <script>
                    alert("Failed to register data");
                </script>
<%
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>
