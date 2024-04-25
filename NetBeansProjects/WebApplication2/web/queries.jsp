<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Query Page</title>
    <style>
        body {
            background-image: url('wallpaper/blue-purple-fluid-background_53876-127198.avif');
            background-repeat: no-repeat; 
            background-size: cover;
            font-family: Arial, sans-serif;
        }
        
        * {
            box-sizing: border-box;
        }

        .view {
            position: relative;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 50px;
            margin: 50px auto;
            width: 80%; 
            height:1050px;
            max-width: 800px;
            text-align: center;
            transition: .5s;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1), 0 0 30px rgba(0,0,0,.5);
            backdrop-filter: blur(50px);
        }

        .search-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        #searchInput {
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 5px;
            width: 60%;
            max-width: 300px;
            font-size: 16px;
        }

        #searchButton {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 10px;
            transition: background-color 0.3s ease;
        }

        #searchButton:hover {
            background-color: #45a049;
        }

        .ques {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            grid-gap: 20px;
            justify-content: center;
        }

        .q {
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
            cursor: pointer;
        }

        .q:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
        }

        #outputFrame {
            padding: 50px;
            width: 100%;
            height: 400px; /* Adjust height as needed */
            border: none;
            margin-top: 20px;
        }
        
    </style>
</head>
<body>
    <div class="view">
        <h1>Any Queries?</h1>
        
        <div class="search-container">
            <input type="text" id="searchInput" placeholder="Search...">
            <button type="submit" id="searchButton">Search</button>
        </div>

        <div class="ques">
            <div class="q" id="mostInactiveUser">Most Inactive User</div>
            <div class="q" id="mostLikedPosts">Most Liked Posts</div>
            <div class="q" id="averagePostsPerUser">Average Posts per User</div>
            <div class="q" id="userWhoLikedEverySinglePost">User Who Liked Every Single Post</div>
            <div class="q" id="userNeverCommented">User Never Commented</div>
            <div class="q" id="userNotFollowedByAnyone">User Not Followed by Anyone</div>
            <div class="q" id="userNotFollowingAnyone">User Not Following Anyone</div>
            
            <div class="q" id="postedMoreThanTimes">Posted More Than How many Times                
            <br>
            <form onsubmit="submitForm1(); return false;">
                Number: <input type="text" id="noo" name="no">
                <input type="submit" value="Search">
            </form>
            </div>
            
            <div class="q" id="followersGreaterThan">Followers Greater Than            
            <br>
            <form onsubmit="submitForm2(); return false;">
                Number: <input type="text" id="great" name="great">
                <input type="submit" value="Search">
            </form>
            </div>
            
            
            <div class="q" id="newFollowers">
            New Followers
            <br>
            <form onsubmit="submitForm(); return false;">
                Date 1: <input type="text" id="date1" name="date1">
                Date 2: <input type="text" id="date2" name="date2">
                <input type="submit" value="Search">
            </form>
        </div>
        </div>
        

        <iframe id="outputFrame" src="" frameborder="0"></iframe>
   </div>

   <script>
      document.getElementById("mostInactiveUser").addEventListener("click", function() {
        document.getElementById("outputFrame").src = "query.jsp?query=mostInactiveUser";
    });
        document.getElementById("mostLikedPosts").addEventListener("click", function() {
            document.getElementById("outputFrame").src = "query.jsp?query=mostLikedPosts";
        });
         document.getElementById("averagePostsPerUser").addEventListener("click", function() {
            document.getElementById("outputFrame").src = "query.jsp?query=averagePostsPerUser";
        });
         document.getElementById("userWhoLikedEverySinglePost").addEventListener("click", function() {
            document.getElementById("outputFrame").src = "query.jsp?query=userWhoLikedEverySinglePost";
        });
         document.getElementById("userNeverCommented").addEventListener("click", function() {
            document.getElementById("outputFrame").src = "query.jsp?query=userNeverCommented";
        });
         document.getElementById("userNotFollowedByAnyone").addEventListener("click", function() {
            document.getElementById("outputFrame").src = "query.jsp?query=userNotFollowedByAnyone";
        });
         document.getElementById("userNotFollowingAnyone").addEventListener("click", function() {
            document.getElementById("outputFrame").src = "query.jsp?query=userNotFollowingAnyone";
        });
       
        
  
    function submitForm2() {
        // Get the form data
        var number2 = document.getElementById('great').value;

        // Construct the query URL with form data
        var queryUrl2 = 'query.jsp?query=followersGreaterThan&great=' + number2;

        // Set the src attribute of the outputFrame iframe
        document.getElementById('outputFrame').src = queryUrl2;
    }

    function submitForm1() {
        // Get the form data
        var number = document.getElementById('noo').value;

        // Construct the query URL with form data
        var queryUrl1 = 'query.jsp?query=postedMoreThanTimes&no=' + number;

        // Set the src attribute of the outputFrame iframe
        document.getElementById('outputFrame').src = queryUrl1;
    }

    function submitForm() {
        // Get the form data
        var date1 = document.getElementById('date1').value;
        var date2 = document.getElementById('date2').value;

        // Construct the query URL with form data
        var queryUrl = 'query.jsp?query=newfollowers&date1=' + date1 + '&date2=' + date2;

        // Set the src attribute of the outputFrame iframe
        document.getElementById('outputFrame').src = queryUrl;
    }
</script>
   <a href="home.jsp">Home</a>

</body>
</html>
