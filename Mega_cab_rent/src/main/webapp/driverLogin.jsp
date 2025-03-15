<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Login</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #2980b9, #8e44ad);
            margin: 0;
            padding: 0;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-box {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        .login-box h2 {
            margin-bottom: 20px;
            font-size: 28px;
            color: #333;
            font-weight: bold;
        }

        form {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .input-field {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .input-field:focus {
            border-color: #3498db;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: white;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin: 10px 0;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .footer {
            font-size: 14px;
            color: #777;
            margin-top: 20px;
        }

        .footer a {
            color: #3498db;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: #2980b9;
        }

        @media (max-width: 500px) {
            .login-box {
                width: 90%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h2>Driver Login</h2>
            <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
                <input type="email" name="email" class="input-field" placeholder="Email" required>
                <input type="password" name="password" class="input-field" placeholder="Password" required>
                <button type="submit" class="btn">Login</button>
            </form>
            <div class="footer">
                <p>Don't have an account? <a href="<%= request.getContextPath() %>/register.jsp">Sign Up</a></p>
            </div>

            <div>
                <%
                    String status = (String) request.getAttribute("status");
                    if ("failed".equals(status)) {
                %>
                    <p style="color: red;">Invalid email or password, please try again.</p>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</body>
</html>
