<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


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
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
            color: #fff;
        }

        #topbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 20px 100px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 99;
        }

        #topbar .imglogo {
            font-size: 2em;
            user-select: none;
        }

        #topbar .loginbut,
        #topbar #logout {
            width: 100px;
            height: 50px;
            margin-left: 40px;
            font-size: 1.1em;
            font-weight: 500;
            color: #fff;
            background: transparent;
            border-radius: 10px;
            border-color: #fff;
            cursor: pointer;
        }

        #topbar .loginbut:hover,
        #topbar #logout:hover {
            background: #716f81;
            color: #fff;
        }

        .nav a {
            position: relative;
            font-size: 1.1em;
            font-weight: 500;
            color: #fff;
            text-decoration: none;
            margin-left: 40px;
            transition: color 0.3s ease;
        }

        .nav a::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: -2px;
            width: 0;
            height: 2px;
            background: #fff;
            border-radius: 5px;
            transition: width 0.3s ease;
            transform: translateX(-50%);
        }

        .nav a:hover::after {
            width: 100%;
        }

        .container {
            position: relative;
            height: 400px;
            width: 400px;
            background: transparent;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-left: 500px;
            margin-top: 150px;
            backdrop-filter: blur(50px);
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            transform: scale(0);
            transition: transform 0.5s ease, height 0.2s ease;
        }

        .container .form-box {
            width: 100%;
            padding: 40px;
        }

        .form-box h2 {
            font-size: 2em;
            text-align: center;
        }

        .container .form-box.login {
            transition: transform 0.18s ease;
            transform: translateX(0);
        }

        .container.active .form-box.login {
            transition: absolute;
            transform: translateX(-400px);
        }

        .container .form-box.register {
            position: absolute;
            transition: none;
            padding: 40px;
            transform: translateX(400px);
        }

        .container.active .form-box.register {
            transition: transform 0.18s ease;
            transform: translateX(0);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            background: transparent;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .form-group button {
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            border: none;
            border-radius: 10px;
            background: transparent;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #716f81;
            color: #fff;
        }

        .remember-forgot {
            font-weight: 500;
            display: flex;
            justify-content: space-between;
        }

        .remember-forgot a {
            text-decoration: none;
        }

        .remember-forgot a:hover {
            color: #716f81;
        }

        .login-register {
            font-weight: 500;
            text-align: center;
            font-weight: 500;
        }

        .login-register p a {
            text-decoration: none;
        }

        .login-register p a:hover {
            color: #716f81;
        }

        .container .icon-close {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 20px;
            height: 20px;
            background: #716f81;
            font-size: 1.5em;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            border-radius: 50%;
            z-index: 1;
        }

        .container.active-popup {
            transform: scale(1);
        }
        
            #topbar .others,
            #topbar #logout
            {
                display: none;
            }
    </style>
</head>

<body>
    

<div id="topbar">
    <h2 class="imglogo">SM</h2>
    <div class="nav">
        <a href="records.jsp" class='others'>Records</a>
        <a href="Admin.jsp"class='others'>Admin</a>
        <a href="queries.jsp" class='others'>Queries</a>
        <button class="loginbut">Login</button>
        <button id="logout">Logout</button>
    </div>
</div>

 
<div class="container">
    <span class="icon-close"><ion-icon name="close"></ion-icon></span>
    <div class="form-box login">
        <h2>Login</h2>
        <form action="login.jsp" method="post">
            <div class="form-group">
                <label for="username">Name</label>
                <input type="text" id="username" name="name" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="pass" required>
            </div>
            <div class="remember-forgot">
                <label>
                    <input type="checkbox">Remember Me
                </label>
                <a href="#">Forgot Password?</a>
            </div>
            <div class="form-group">
                <button type="submit">Login</button>
            </div>
            <div class="login-register">
                <p>Not Admin?
                    <a href="#" class="register-link">Register</a>
                </p>
            </div>
        </form>
    </div>
    <div class="form-box register">
        <h2>Registration</h2>
        <form action="register.jsp" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="remember-forgot">
                <label>
                    <input type="checkbox"> I agree to the terms and conditions
                </label>
            </div>
            <div class="form-group">
                <button type="submit">Register</button>
            </div>
            <div class="login-register">
                <p>Already an Admin?
                    <a href="#" class="login-link">Login</a>
                </p>
            </div>
        </form>
    </div>
</div>
  

<script>
    // Add event listener for login button
    const container = document.querySelector('.container');
    const loginLink = document.querySelector('.login-link');
    const registerLink = document.querySelector('.register-link');
    const btpopup = document.querySelector('.loginbut');
    const iconClose = document.querySelector('.icon-close');

    registerLink.addEventListener('click', () => {
        container.classList.add('active');
    });

    loginLink.addEventListener('click', () => {
        container.classList.remove('active');
    });
    btpopup.addEventListener('click', () => {
        container.classList.add('active-popup');
    });

    iconClose.addEventListener('click', () => {
        container.classList.remove('active-popup');
    });

    // Check if user is logged in
    const logout = document.getElementById("logout");
    logout.addEventListener("click", function() {
        window.location.href = "logout.jsp";
    });

    <% HttpSession s = request.getSession();
    Boolean isLoggedIn = (Boolean) s.getAttribute("isLoggedIn");

    if (isLoggedIn != null && isLoggedIn) { %>
        const others = document.querySelectorAll("#topbar .others");
        const logoutButton = document.querySelector("#topbar #logout");

        others.forEach(link => {
            link.style.display = "inline-block";
        });

        logoutButton.style.display = "inline-block";
    <% } %>
</script>

</body>
</html>
