
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
<style>
   body {
    background-image: url('wallpaper/blue-purple-fluid-background_53876-127198.avif');
    background-repeat: no-repeat; 
    background-size: 100%;
    font-family: Arial, sans-serif;
    
}

.view {
    position: relative;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 50px;
    margin-left: 400px;
    width: 800px; 
    height: 700px;
    text-align: center;
    transition: .5s;
    background-color: white;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1), 0 0 30px rgba(0,0,0,.5);
    backdrop-filter: blur(50px);
}

.view img {
    float: left;
}

.view .data {
    float: left;
}

.top {
    font-family: #POUND, sans-serif;
    margin-left: 20px;
    color: white;
}

.follow {
   
    position: absolute;
    display: flex;
    align-items: center;
    margin-left: 500px;
    top: 20px;
    right:60px;
}

.f {
    margin-top: 10px;
    margin-left: 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    height: 50px;
    width: 100px;
}

.p_count {
    margin-top: 10px;
    margin-left: 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    height: 50px;
    width: 100px;
}

.post {
    width: 300px;
    height: 300px;
    background-color: white;
}

.user_media {
    top:0;
    left:0;
    width: 350px;
    height: 400px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    backdrop-filter: blur(50px);
    box-shadow: 0 0 30px rgba(0,0,0,.5);
}
.vdt{
    height:200px;
    
}
.bottom{
    position: relative;
    display: inline-block;
    align-items: center;    
}
.bottom p{
    margin-left: 10px;
}

</style>
</head>
<body>
    
<%
    // Retrieve userId parameter from the request
    String userId = request.getParameter("userId");
    String sql = "SELECT * FROM users WHERE user_id = ?";
    String sql1 = "SELECT followee_id, COUNT(follower_id) AS follower_count FROM follows WHERE followee_id = ?";
    String sql2 = "SELECT follower_id, COUNT(followee_id) AS following_count FROM follows WHERE follower_id = ?";

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish database connection
        String url = "jdbc:mysql://localhost:3307/socialmedia";
        String username = "root";
        String password = "";
        Connection connection = DriverManager.getConnection(url, username, password);

        // Prepare statement for the user details query
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, userId);

        // Execute the user details query
        ResultSet resultSet = preparedStatement.executeQuery();

        // Iterate over the result set and display user details
        while(resultSet.next()) {
%>
<div class='top'><h1><%= resultSet.getString("user_name") %></h1></div>
<%
            String pic = resultSet.getString("user_photo");
            String imagePath = "images/" + pic;
%>
<div class="view">
    <div class="anotherview">
    <img src="<%= imagePath %>" alt="No Pic" width="70" height="70">
    <br><br><br>
    </div>
    <br><div class="data"><%= resultSet.getInt("user_id") %></div><br>
    <div class="data"><%= resultSet.getString("user_name") %></div><br>
    <div class="data"><%= resultSet.getString("email") %></div><br>
    <div class="data"><%= resultSet.getString("bio") %></div><br>
    <div class='follow'>
        <%
            // Prepare statement for the follower count
            String sql5 = " SELECT user_id, COUNT(*) AS post_count FROM post where user_id = ?";
            PreparedStatement preparedStatement1 = connection.prepareStatement(sql1);
            preparedStatement1.setString(1, userId);
            ResultSet resultSet1 = preparedStatement1.executeQuery();

            // Check if there are any results for follower count
            if (resultSet1.next()) {
                out.println("<div class='f'>Followers<br>" + resultSet1.getInt("follower_count")+"</div>");
            } else {
                out.println("Followers: 0");
            }
            resultSet1.close();
            preparedStatement1.close();

            // Prepare statement for the following count
            PreparedStatement preparedStatement2 = connection.prepareStatement(sql2);
            preparedStatement2.setString(1, userId);
            ResultSet resultSet2 = preparedStatement2.executeQuery();

            // Check if there are any results for following count
            if (resultSet2.next()) {
                out.println("<div class ='f'>Following<br>" + resultSet2.getInt("following_count")+"</div>");
            } else {
                out.println("Following: 0");
            }
            
            PreparedStatement ps2 = connection.prepareStatement(sql5);
            ps2.setString(1, userId);
            ResultSet rs2 = ps2.executeQuery();

            // Check if there are any results for following count
            if (rs2.next()) {
                out.println("<div class ='p_count'>Posts<br>" + rs2.getInt("post_count")+"</div>");
            } else {
                out.println("Following: 0");
            }
        %>
    </div> 
        
<div class='post'>
    <h3>Posts</h3>
    <%              
        String sql3 = "SELECT p.photo_url AS Photo FROM photos p JOIN post po ON p.post_id = po.post_id JOIN users u ON po.user_id = u.user_id WHERE u.user_id = ?";

        // Prepare statement for the photos query
        PreparedStatement ps = connection.prepareStatement(sql3);
        ps.setString(1, userId);
        ResultSet rs = ps.executeQuery();

        // Check if there are any photos available
        while (rs.next()) {
            String picc = rs.getString("Photo"); 
            String imagePathPost = "posts/" + picc; 
    %>
    
    <div class='pht'>
        <img src="<%= imagePathPost %>" alt="No Pic" class="user_media">
    </div>
    <%
        }

        rs.close();
        ps.close();
        
        // If no photos are available, display videos
    String sql4 = "SELECT v.video_url AS Video FROM videos v JOIN post po ON v.post_id = po.post_id JOIN users u ON po.user_id = u.user_id WHERE u.user_id = ?";

            PreparedStatement ps1 = connection.prepareStatement(sql4);
            ps1.setString(1, userId);
            ResultSet rs1 = ps1.executeQuery();

            // Display videos if available
            while (rs1.next()) {
                String vd = rs1.getString("Video"); 
                // Check if the video URL is from YouTube
    %>
     <div class='vdt'>
        <div width="350" height="400" src="<%= vd %>" ></div>
    </div>
    <%     
                
            }
            rs1.close();
            ps1.close();

            // Display

    %>
    <%
    String sql7 ="SELECT COUNT(*) AS likes FROM post_likes v JOIN post po ON v.post_id = po.post_id JOIN users u ON po.user_id = u.user_id WHERE u.user_id = ?";
    PreparedStatement ps4 = connection.prepareStatement(sql7);
    ps4.setString(1, userId);
    ResultSet rs4 = ps4.executeQuery();

    // Display comments if available
    while (rs4.next()) {
        String like = rs4.getString("likes"); 
%>
<br><br><br><div class="bottom">
        <p>Likes:<%=like%></p>
    </div>
<%
    }

    // Close result set and prepared statement
    rs4.close();
    ps4.close();
%>
  <br>  
   <%
    String sql6 = "SELECT v.comment_text AS comment FROM comments v JOIN post po ON v.post_id = po.post_id JOIN users u ON po.user_id = u.user_id WHERE u.user_id = ?";
    
    PreparedStatement ps3 = connection.prepareStatement(sql6);
    ps3.setString(1, userId);
    ResultSet rs3 = ps3.executeQuery();

    // Display comments if available
    while (rs3.next()) {
        String comment = rs3.getString("comment"); 
%>
<div class="bottom">
        <p><%= comment%></p>
    </div>
<%
    }

    // Close result set and prepared statement
    rs3.close();
    ps3.close();
%>
   <%
       }
        connection.close();
        resultSet.close();
        preparedStatement.close();
        connection.close();
    
}
    catch (Exception e) {
        out.println("Exception: " + e.getMessage());
    }
%>
<br>
<br>
<a href="home.jsp">Home</a>

</body>
</html>


