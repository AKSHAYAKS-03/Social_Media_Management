<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Users</title>
    
    <style>
        *{
            box-sizing: border-box;
        }
        .row{
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }
        .user-card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin: 10px;
            width: calc(25% - 20px); /* Adjust as per your need */
            text-align: center;
            cursor: pointer;
        }
        .user-card img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
        }
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }
        .form-container {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            z-index: 2;
        }
        .close {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<center>
    <h1>USERS TABLE</h1>
    <div class="row">
        <% 
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            
            // Establish database connection
            String url = "jdbc:mysql://localhost:3307/socialmedia";
            String username = "root";
            String password = "";
            Connection connection = DriverManager.getConnection(url, username, password);
            
            // Execute SQL query to fetch data
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM users");
            
            // Iterate over the result set and display data in table rows
            while(resultSet.next()) {
                %>  
                <div class="user-card" onclick="showForm('<%= resultSet.getInt("user_id") %>')">
                    <% String pic =  resultSet.getString("user_photo"); 
                    String imagePath = "images/" + pic; %>
                    <img src="<%= imagePath %>" alt="No Pic">
                    <div>
                        <%= resultSet.getInt("user_id") %><br>
                        <%= resultSet.getString("user_name") %><br>                        
                        <%= resultSet.getString("email") %><br>
                        <%= resultSet.getString("bio") %>
                    </div>
                </div>
                <%
            }
            
            // Close database resources
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            out.println("Exception: " + e.getMessage());
        }
        %>
    </div>
</center>

<div class="overlay" id="overlay">
    <div class="form-container" id="form-container">
        <span class="close" onclick="closeForm()">&times;</span>
        <h2>Popup Form</h2>
        <form action="submit.jsp" method="post">
            <!-- Your form fields here -->
        </form>
    </div>
</div>

<script>
    function showForm(userId) {
        document.getElementById('overlay').style.display = 'block';
        // You can populate the form with user-specific data using AJAX if needed
    }

    function closeForm() {
        document.getElementById('overlay').style.display = 'none';
    }
</script>
<a href="home.jsp">Home</a>

</body>
</html>
