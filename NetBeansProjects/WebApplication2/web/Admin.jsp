<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ADMINS</title>
     <style>
          body {
         padding:50px;
            background-image: url('wallpaper/blue-purple-fluid-background_53876-127198.avif');
            background-repeat: no-repeat; 
            background-size:100%;
        }
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
            color: white;

        }
         table {
             border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
             padding:20px;
             margin: 30px;
            width: 700px;
            border-collapse: collapse;
        }

        /* Style table headers */
        th {
            background-color: lightblue;
            border: 1px solid black;
            padding: 8px;
            text-align: left;
            
        }

        /* Style table rows */
        td {
            border: 1px solid black;
            padding: 8px;
        }

        /* Style alternate rows */
        
    </style>
</head>
<body>
<center>
    <h1>ADMIN TABLE</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ADMIN ID</th>
                <th>Name</th>
                <th>ON</th>

            </tr>
        </thead>
        <tbody>
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
                ResultSet resultSet = statement.executeQuery("SELECT * FROM admin");
                
                // Iterate over the result set and display data in table rows
                while(resultSet.next()) {
                    %>  
                        <td ><%= resultSet.getInt("admin_id") %></td>
                        <td><%= resultSet.getString("username") %></td>
                        <td><%= resultSet.getString("created_at") %></td>

                    </tr>
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
        </tbody>
    </table>
</center>

<script>

</script>
<a href="home.jsp">Home</a>

</body>
</html>
