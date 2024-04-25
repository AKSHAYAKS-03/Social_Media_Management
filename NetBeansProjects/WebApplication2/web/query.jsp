<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Query Result</title>
    <style>
         table {
            width: 100%;
            border-collapse: collapse;
        }

        /* Style table headers */
        th {
            background-color: #f2f2f2;
            border: 1px solid #dddddd;
            padding: 8px;
            text-align: left;
        }

        /* Style table rows */
        td {
            border: 1px solid #dddddd;
            padding: 8px;
        }

        /* Style alternate rows */
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Style the table header for a specific column */
        th:nth-child(1) {
            background-color: #3399ff; /* blue */
            color: white;
        }
    </style>
</head>
<body>
<%
Connection connection = null;
PreparedStatement statement = null;
ResultSet resultSet = null;

try {
    // Establish database connection
    String url = "jdbc:mysql://localhost:3307/socialmedia";
    String username = "root";
    String password = "";
    
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.jdbc.Driver");
    // Establish database connection
    connection = DriverManager.getConnection(url, username, password);
    
    // Check if the query parameter exists
    String queryParam = request.getParameter("query");
    
    if (queryParam != null) {
        if (queryParam.equals("mostInactiveUser")) {
            // Execute SQL query to fetch data
            String sql = "SELECT user_id, user_name AS Most_Inactive_User FROM users WHERE user_id NOT IN (SELECT user_id FROM post)";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            // Display data in table rows
            %>
            <h2>Most Inactive User</h2>        
            <table border="1">
                <tr>
                    <th>User ID</th>
                    <th>Most Inactive User</th>
                </tr>
                <% while(resultSet.next()) { %>
                <tr>
                    <td><%= resultSet.getString("user_id") %></td>
                    <td><%= resultSet.getString("Most_Inactive_User") %></td>
                </tr>
                <% } %>
            </table>
            <%
        } else if (queryParam.equals("mostLikedPosts")) {
            // Execute SQL query to fetch data for most liked posts
            String sql = "SELECT post_likes.user_id, users.user_name AS Name, COUNT(post_likes.post_id) AS Most_Liked_Post FROM post_likes JOIN users ON users.user_id = post_likes.user_id JOIN post ON post.post_id = post_likes.post_id GROUP BY post_likes.user_id ORDER BY COUNT(post_likes.post_id) DESC"; 
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            // Display data in table rows
            %>
            <h2>Most Liked Posts</h2>
            <table border="1">
                <tr>
                    <th>User ID</th>
                    <th>User Name</th>
                    <th>Number of Liked Posts</th>
                </tr>
                <% while(resultSet.next()) { %>
                <tr>
                    <td><%= resultSet.getString("user_id") %></td>
                    <td><%= resultSet.getString("Name") %></td>
                    <td><%= resultSet.getString("Most_Liked_Post") %></td>
                </tr>
                <% } %>
            </table>
            <%
        } else if (queryParam.equals("averagePostsPerUser")) {
            // Execute SQL query to fetch data for average posts per user
            String sql = "SELECT ROUND((COUNT(post_id) / COUNT(DISTINCT user_id)), 2) AS Average_Post_per_User FROM post";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            // Display data in table rows
            %>
            <h2>Average Posts per User</h2>
            <table border="1">
                <tr>
                    <th>Average Posts Per User</th>
                </tr>
                <% while(resultSet.next()) { %>
                <tr>
                    <td><%= resultSet.getString("Average_Post_per_User") %></td>
                </tr>
                <% } %>
            </table>
            <%
        } else if (queryParam.equals("userWhoLikedEverySinglePost")) {
            // Execute SQL query to fetch data for users who liked every single post
            String sql = "SELECT users.user_id, user_name, COUNT(*) AS num_likes FROM users INNER JOIN post_likes ON users.user_id = post_likes.user_id GROUP BY post_likes.user_id HAVING num_likes = (SELECT COUNT(*) FROM post)";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            // Display data in table rows
            %>
            <h2>Users Who Liked Every Single Post</h2>
            <table border="1">
                <tr>
                    <th>User ID</th>
                    <th>User Name</th>
                    <th>Number of Liked Posts</th>
                </tr>
                <% while(resultSet.next()) { %>
                <tr>
                    <td><%= resultSet.getString("users.user_id") %></td>
                    <td><%= resultSet.getString("user_name") %></td>
                    <td><%= resultSet.getString("num_likes") %></td>
                </tr>
                <% } %>
            </table>
            <%
        } else if (queryParam.equals("userNeverCommented")) {
            // Execute SQL query to fetch data for users who never commented
            String sql = "SELECT user_id, user_name AS User_Never_Comment FROM users WHERE user_id NOT IN (SELECT user_id FROM comments)";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            // Display data in table rows
            %>
            <h2>User Never Commented</h2>        
            <table border="1">
                <tr>
                    <th>User ID</th>
                    <th>User Never Comment</th>
                </tr>
                <% while(resultSet.next()) { %>
                <tr>
                    <td><%= resultSet.getString("user_id") %></td>
                    <td><%= resultSet.getString("User_Never_Comment") %></td>
                </tr>
                <% } %>
            </table>
            <%
        }

 else if (queryParam.equals("userNotFollowedByAnyone")) {
            // Execute SQL query to fetch data for users who never commented
            String sql = "SELECT user_id, user_name AS User_Not_Followed_by_anyone FROM users WHERE user_id NOT IN (SELECT followee_id FROM follows)";

            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            // Display data in table rows
            %>
            <h2>User Not Followed by anyone</h2>        
            <table border="1">
                <tr>
                    <th>User ID</th>
                    <th>User Not Followed by anyone</th>
                </tr>
                <% while(resultSet.next()) { %>
                <tr>
                    <td><%= resultSet.getString("user_id") %></td>
                    <td><%= resultSet.getString("User_Not_Followed_by_anyone") %></td>
                </tr>
                <% } %>
            </table>
            <%
        }
else if (queryParam.equals("userNotFollowingAnyone")) {
            // Execute SQL query to fetch data for users who never commented
            String sql ="SELECT user_id, user_name AS User_Not_Following_Anyone FROM users WHERE user_id NOT IN (SELECT follower_id FROM follows)";
                statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            // Display data in table rows
            %>
            <h2>User Not Following Anyone</h2>        
            <table border="1">
                <tr>
                    <th>User ID</th>
                    <th>User Not Following Anyone</th>
                </tr>
                <% while(resultSet.next()) { %>
                <tr>
                    <td><%= resultSet.getString("user_id") %></td>
                    <td><%= resultSet.getString("User_Not_Following_Anyone") %></td>
                </tr>
                <% } %>
            </table>
            <%
        }
else if (queryParam.equals("postedMoreThanTimes")) {
    int number = Integer.parseInt(request.getParameter("no"));    
    if (number != -1) {
        // Execute SQL query to fetch data for users who posted more than a specified number of times
        String sql = "SELECT p.user_id, u.user_name, COUNT(p.user_id) AS post_count FROM post p JOIN users u ON p.user_id = u.user_id GROUP BY p.user_id, u.user_name HAVING COUNT(p.user_id) > ? ORDER BY post_count DESC";
        statement = connection.prepareStatement(sql);
        statement.setString(1, Integer.toString(number));
        resultSet = statement.executeQuery();
        // Display data in table rows
        %>
        <h2>Post Count</h2>        
        <table border="1">
            <tr>
                <th>User ID</th>
                <th>User Name</th>
                <th>Post Count</th>
            </tr>
            <% while(resultSet.next()) { %>
            <tr>
                <td><%= resultSet.getString("user_id") %></td>
                <td><%= resultSet.getString("user_name") %></td>
                <td><%= resultSet.getString("post_count") %></td>
            </tr>
            <% } %>
        </table>
        <%
    }
}

else if (queryParam.equals("followersGreaterThan")) {
    int number = Integer.parseInt(request.getParameter("great"));    
    if (number != -1) {
        // Execute SQL query to fetch data for users who posted more than a specified number of times
        String sql = "SELECT followee_id,user_name, COUNT(follower_id) AS follower_count FROM follows JOIN users ON users.user_id = follows.followee_id GROUP BY followee_id HAVING follower_count > ? ORDER BY COUNT(follower_id) DESC";
        statement = connection.prepareStatement(sql);
        statement.setString(1, Integer.toString(number));
        resultSet = statement.executeQuery();
        // Display data in table rows
        %>
        <h2>Post Count</h2>        
        <table border="1">
            <tr>
                <th>User ID</th>
                <th>User Name</th>
                <th>follower_count</th>
            </tr>
            <% while(resultSet.next()) { %>
            <tr>
                <td><%= resultSet.getString("followee_id") %></td>
                <td><%= resultSet.getString("user_name") %></td>
                <td><%= resultSet.getString("follower_count") %></td>
            </tr>
            <% } %>
        </table>
        <%
    }
}
else if (queryParam.equals("newfollowers")) {

   String date1 = request.getParameter("date1");
    String date2 = request.getParameter("date2");

    // Ensure that date1 and date2 are not null and not empty
    if (date1 != null && !date1.isEmpty() && date2 != null && !date2.isEmpty()) {
        // Construct your SQL query using the date range
        String sql = "SELECT DATE_FORMAT(created_at, '%Y-%m') AS month, COUNT(*) AS new_followers FROM follows WHERE created_at BETWEEN ? AND ? GROUP BY DATE_FORMAT(created_at, '%Y-%m')";

        // Set the parameters for the prepared statement
        statement = connection.prepareStatement(sql);
        statement.setString(1, date1);
        statement.setString(2, date2);

        // Execute the query and display the results
        resultSet = statement.executeQuery();

        // Display data in table rows
        %>
        <h2>New Followers</h2>        
        <table border="1">
            <tr>
                <th>Month</th>
                <th>New Followers Count</th>
            </tr>
            <% while(resultSet.next()) { %>
            <tr>
                <td><%= resultSet.getString("month") %></td>   
                <td><%= resultSet.getString("new_followers") %></td>
            </tr>
            <% } %>
        </table>
        <%
    } 
}

else {
            // If the query parameter is not supported, display an error message
            out.println("<h2>No query specified or invalid query</h2>");
        }

}
}catch (ClassNotFoundException e) {
    out.println("Error: MySQL JDBC driver not found");
    e.printStackTrace();
} catch (SQLException e) {
    out.println("Error executing SQL query");
    e.printStackTrace();
} finally {
    // Close the database connection and resources
    try {
        if (resultSet != null) resultSet.close();
        if (statement != null) statement.close();
        if (connection != null) connection.close();
    } catch (SQLException e) {
        out.println("Error closing database connection");
        e.printStackTrace();
    }
}
%>
</body>
</html>


