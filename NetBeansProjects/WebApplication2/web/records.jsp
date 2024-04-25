<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Users</title>    
    
    <style>
         body {
            background-image: url('wallpaper/blue-purple-fluid-background_53876-127198.avif');
            background-repeat: no-repeat; 
            background-size: 100%;
        }
        * {
            box-sizing: border-box;
        }
        .row {
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
            transition: .5s;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(50px);
            box-shadow: 0 0 30px rgba(0,0,0,.5);
        }
        .user-card:hover {
            transform: scaleY(1.1);
        }      
        .user-card .user_image {
            width: 70px;
            height: 70px;
            border-radius: 50%;
        }
        .options {
            display: flex;
            margin-bottom: 10px;
            background: transparent;
        }
        .optimg {
            background: transparent;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            cursor: pointer;
            margin: 0 5px; /* Adjust margin as needed */
        }
        .plusimg {
            margin-top: -50px;
            float: right;
            width:30px;
            border-radius: 5px;
        }
        /* Sidebar styles */
        .sidebar {
    position: fixed;
    top: 40px;
    right: -350px; /* Initially hide the sidebar */
    width: 300px; /* Adjust the width as needed */
    height: 550px;
    color:whitesmoke;
    background-color: #65647C;
    padding: 50px;
    transition: right 0.3s ease; /* Add transition effect */
}

.closebtn {
    position: absolute;
    top: 20px;
    right: 20px;
    font-size: 24px;
    cursor: pointer;
}

form {
    padding: 20px;
}

label {
    margin-bottom: 10px;
    display: block;
}

input[type="text"],
input[type="email"],
textarea,
input[type="file"],
button {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

button[type="submit"] {
    background-color: #4CAF50;
    color: white;
    border: none;
    cursor: pointer;
}

button[type="submit"]:hover {
    background-color: #45a049;
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
    <span class="icon-add" onclick="toggleSidebar()">
        <img src="images/plus.jpg" class="plusimg">
    </span>
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

                <div class="user-card">
                  
                   <div class="options">
                    <span class="icon-add"><img src="images/edit.jpg" class="optimg" id="add" onclick= "editUser(<%= resultSet.getInt("user_id") %>)"></span>
                    <span class="icon-close"><img src="images/del.jpg" class="optimg" id="close" onclick="deleteUser(<%= resultSet.getInt("user_id") %>)"></span>
                    </div>
                    
                   <div onclick= "window.location.href = 'single_view.jsp?userId=<%= resultSet.getInt("user_id") %>'">
                    <% String pic =  resultSet.getString("user_photo"); 
                    String imagePath = "images/" + pic; %>
                    <img src="<%= imagePath %>" alt="No Pic"class="user_image">

                    <div>

                        <%= resultSet.getString("user_name") %><br>                        
                        <%= resultSet.getString("email") %><br>
                        <%= resultSet.getString("bio") %>
                    </div>
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
  <div class="sidebar" id="sidebar">
        <!-- Close button -->
        <span class="closebtn" onclick="toggleSidebar()">×</span>
     
        <form method="post">
            <label for="name">Name:</label><br>
            <input type="text" id="name" name="name" required><br>
            
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required><br>
            
            <label for="bio">Bio:</label><br>
            <textarea id="bio" name="bio" required></textarea><br>
            
            <label for="photo">Photo:</label><br>
            <input type="file" id="photo" name="photo"><br>
                   
            <button type="submit" style="margin-top: 20px;">Add User</button>
        </form>
    </div>
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
                      %>
                    <script>
                    alert("Data inserted successfully.");
                  </script>
              <%
                    // Save the uploaded file
                } else {
 %>
               <script>
                   alert("Failed to insert data.");
                   </script>
                  <%                }
            }
        } catch (Exception e) {
            %>       
            <script>

            alert("Error: " + e.getMessage());
          </script>

<%
        }
    }
    %>
                                                               


 <script>
    function toggleSidebar() {
        var sidebar = document.getElementById("sidebar");
        if (sidebar.style.right === "-350px") {
            sidebar.style.right = "0";
        } else {
            sidebar.style.right = "-350px";
        }
    }
    function deleteUser(userId) {
            var confirmation = confirm("Are you sure you want to delete this user?");
            if (confirmation) {
                window.location.href = 'deleteUser.jsp?userId=' + userId;
            }
        }
   function editUser(userId) {  
        var confirmation = confirm("Are you sure you want to edit this user?");
            if (confirmation) {
                window.location.href = 'edituser.jsp?userId=' + userId;
            }        
        }
   
</script>
<a href="home.jsp">Home</a>

</body>
</html>
