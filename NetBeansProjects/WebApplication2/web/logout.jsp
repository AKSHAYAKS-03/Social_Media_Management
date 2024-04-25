<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*,javax.servlet.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Logout</title>
</head>
<body>

<%
try {
    // Get the login status of the user from the session
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");

    if (isLoggedIn != null && isLoggedIn) {
        // Get the username of the logged-in user from the session
        String username = (String) session.getAttribute("username");
%>
         <script>
            alert("Logged Out <%= username %>");
            window.location.href = "home.jsp"; // Redirect to the login page
        </script>
<%
        // Remove the session attribute indicating user is logged in
        session.removeAttribute("isLoggedIn");
    } else {
        // If the user is not logged in, redirect to the login page
        response.sendRedirect("home.jsp");
    }
} catch (Exception e) {
    // Handle any exceptions
    e.printStackTrace();
    // Redirect to an error page
    response.sendRedirect("error.jsp");
}
%>

</body>
</html>
