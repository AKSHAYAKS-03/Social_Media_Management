<%@page import="java.util.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.sql.*" %>

<%
// Handle form submission and database insertion
if (request.getMethod().equals("POST")) {
    String username = request.getParameter("name");
    String password = request.getParameter("pass");

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3307/socialmedia";
    String dbUsername = "root";
    String dbPassword = "";

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(url, dbUsername, dbPassword);

        // Check if the entered username and password match a record in the database
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            // Set session attribute indicating user is logged in
            HttpSession s = request.getSession();
            s.setAttribute("isLoggedIn", true);
            
            // Add the username to the session
            s.setAttribute("username", username);

            // Redirect the user to the home page upon successful login
            response.sendRedirect("home.jsp");
        } else {
            // Invalid username or password, redirect back to the login page
            response.sendRedirect("home.jsp");
        }

        statement.close();
        connection.close();
    } catch (ClassNotFoundException e) {
%>
        <p>Error: JDBC driver not found. Make sure it's included in your project.</p>
<%
    } catch (SQLException e) {
%>
        <p>Error: <%= e.getMessage() %></p>
<%
    }
}
%>
