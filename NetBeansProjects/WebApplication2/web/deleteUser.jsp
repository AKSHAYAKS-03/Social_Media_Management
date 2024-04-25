<%@page import="java.sql.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete User</title>
</head>
<body>

<%
String userId = request.getParameter("userId");

if (userId != null && !userId.isEmpty()) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3307/socialmedia";
        String username = "root";
        String password = "";
        Connection connection = DriverManager.getConnection(url, username, password);
        
        // Disable foreign key checks
        String disableFKChecksSQL = "SET FOREIGN_KEY_CHECKS=0;";
        PreparedStatement disableFKChecksStatement = connection.prepareStatement(disableFKChecksSQL);
        disableFKChecksStatement.executeUpdate();
        disableFKChecksStatement.close();
        
        // Delete the user
        String deleteUserSQL = "DELETE FROM users WHERE user_id = ?";
        PreparedStatement deleteUserStatement = connection.prepareStatement(deleteUserSQL);
        deleteUserStatement.setString(1, userId);
        int userDeleted = deleteUserStatement.executeUpdate();
        deleteUserStatement.close();
        
        // Enable foreign key checks
        String enableFKChecksSQL = "SET FOREIGN_KEY_CHECKS=1;";
        PreparedStatement enableFKChecksStatement = connection.prepareStatement(enableFKChecksSQL);
        enableFKChecksStatement.executeUpdate();
        enableFKChecksStatement.close();
        
        connection.close();
        
        if (userDeleted > 0) {
            %>
            <script>
                alert("User deleted successfully");
                window.location.href = 'records.jsp';
            </script>
            <%
        } else {
            %>
            <script>
                alert("No user found with the given ID");
                window.location.href = 'records.jsp';
            </script>
            <%
        }
    } catch (Exception e) {
        out.println("Exception: " + e.getMessage());
    }
} else {
    %>
    <script>
        alert("No user ID provided");
        window.location.href = 'records.jsp';
    </script>
    <%
}
%>

</body>
</html>