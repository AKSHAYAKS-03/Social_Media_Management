<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;  
            background-image: url('wallpaper/blue-purple-fluid-background_53876-127198.avif');
            background-repeat: no-repeat; 
            background-size: 100%;
        
        }
        .container {
            
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-top: 0;
        }
        form {
            padding: 50px;

            margin-left: 400px;
            width: 500px;
            height: 400px;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(50px);
            box-shadow: 0 0 30px rgba(0,0,0,.5);
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<%
// Retrieve the user ID from the request parameter
String userId = request.getParameter("userId");

try {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.jdbc.Driver");
    
    // Establish database connection
    String url = "jdbc:mysql://localhost:3307/socialmedia";
    String username = "root";
    String password = "";
    Connection connection = DriverManager.getConnection(url, username, password);

    // Prepare SQL statement to fetch user details
    String selectUserSQL = "SELECT * FROM users WHERE user_id = ?";
    PreparedStatement selectUserStatement = connection.prepareStatement(selectUserSQL);
    selectUserStatement.setString(1, userId);
    
    // Execute the query
    ResultSet resultSet = selectUserStatement.executeQuery();
    
    // Check if user exists
    if(resultSet.next()) {
        // Retrieve user details from the result set
        String userName = resultSet.getString("user_name");
        String userPhoto = resultSet.getString("user_photo");
        String email = resultSet.getString("email");
        String bio = resultSet.getString("bio");
%>

    <h2>Edit User</h2>
    <form action="" method="post">
        <!-- Hidden field to store user ID -->
        <input type="hidden" name="userId" value="<%= userId %>">
        
        <!-- Display current user details in input fields for editing -->
        <label for="userName">Name:</label><br>
        <input type="text" id="userName" name="userName" value="<%= userName %>" required><br>
        
        <label for="userPhoto">Photo:</label><br>
        <input type="text" id="userPhoto" name="userPhoto" value="<%= userPhoto %>" required><br>
        
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" value="<%= email %>" required><br>
        
        <label for="bio">Bio:</label><br>
        <textarea id="bio" name="bio" required><%= bio %></textarea><br>
        
        <button type="submit">Update</button>
    </form>

<%
    // Check if the form is submitted
    if (request.getMethod().equalsIgnoreCase("post")) {
        // Retrieve form data
        String newUserName = request.getParameter("userName");
        String newUserPhoto = request.getParameter("userPhoto");
        String newEmail = request.getParameter("email");
        String newBio = request.getParameter("bio");
        
        // Prepare SQL statement to update user details
        String updateUserSQL = "UPDATE users SET user_name=?, user_photo=?, email=?, bio=? WHERE user_id=?";
        PreparedStatement updateUserStatement = connection.prepareStatement(updateUserSQL);
        updateUserStatement.setString(1, newUserName);
        updateUserStatement.setString(2, newUserPhoto);
        updateUserStatement.setString(3, newEmail);
        updateUserStatement.setString(4, newBio);
        updateUserStatement.setString(5, userId);
        
        // Execute the update
        int rowsUpdated = updateUserStatement.executeUpdate();
        
        // Check if update was successful
        if (rowsUpdated > 0) {
            out.println("<script>alert('User details updated successfully.'); window.location.href = 'records.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to update user details.'); window.location.href = 'records.jsp';</script>");
        }
        
        // Close prepared statement
        updateUserStatement.close();
    }
%>

<%
    } else {
%>
    <script> 
    alert("User not found.");
    window.location.href = 'records.jsp'; // Redirect to records.jsp
    </script>
<%
    }

    // Close prepared statement and database connection
    selectUserStatement.close();
    connection.close();
%>

<%
} catch (Exception e) {
    // Handle any exceptions
    out.println("Exception: " + e.getMessage());
}
%>
<a href="home.jsp">Home</a>

</body>
</html>
