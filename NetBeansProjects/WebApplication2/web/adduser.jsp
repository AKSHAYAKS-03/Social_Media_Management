<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        *{
            margin: 0;
            padding: 0;
            text-decoration: none;            
        }
        .sidebar{
            position: fixed;
            right:0;
            width: 250px;
            height:100%;
        }
        .sidebar header{
            
        }
        form {
            margin: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        label {
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
        }
        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #45a049;
        }
        #check{
            display: none
        }
        
        
        
    </style>
</head>
<body>
    <h1>Add User</h1>
    <input type="checkbox" id="check">
    <label for="check">
        <i class="fas fas-bars" id="btn"></i>
        <i class="fas fas-times" id="cancel"></i>
    </label>
           
    <div class="sidebar">
    <form method="post">
     
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br>
        
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br>
        
        <label for="bio">Bio:</label><br>
        <textarea id="bio" name="bio" required></textarea><br>
        
        <label for="photo">Photo:</label><br>
        <input type="file" id="photo" name="photo"><br>
               
        
        <button type="submit">Add User</button>
    </form>
    
    </div>    
    <% 
   
    if (request.getMethod().equalsIgnoreCase("post")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String bio = request.getParameter("bio");
        
        // Get the uploaded file
        String photo = request.getParameter("photo");
        
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3307/socialmedia";
        String dbUsername = "root";
        String dbPassword = "";                     
            
        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, dbUsername, dbPassword);

            // Check if the username already exists
            String checkQuery = "SELECT user_name FROM users WHERE user_name = ?";
            PreparedStatement checkStatement = connection.prepareStatement(checkQuery);
            checkStatement.setString(1, name);
            ResultSet resultSet = checkStatement.executeQuery();

            if (resultSet.next()) {
                // Username already exists, do not insert
                %>
                <script>
                alert("Username already exists");
                </script>
                      <%
            } 
            else {
                // Username does not exist, proceed with insertion
                String insertQuery = "INSERT INTO users (user_name, email, bio, user_photo) VALUES (?, ?, ?, ?)";
                PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
                insertStatement.setString(1, name);
                insertStatement.setString(2, email);
                insertStatement.setString(3, bio);
                insertStatement.setString(4, photo); // Store file name in database

                int rowsInserted = insertStatement.executeUpdate();
                insertStatement.close();

                if (rowsInserted > 0) {
                    out.println("<br><br><p>Data inserted successfully.</p>");

                    // Save the uploaded file
                } else {
                    out.println("<br><br><p>Failed to insert data.</p>");
                }
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
    %>
    <a href="home.jsp">Home</a>
   

</body>
</html>