<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Admin Dashboard</title>
   <style>
      * {
         margin: 0;
         padding: 0;
         box-sizing: border-box;
         font-family: 'Poppins', sans-serif;
      }
      body {
         background-color: #121212;
         color: #fff;
         display: flex;
         justify-content: center;
         align-items: center;
         height: 100vh;
         padding: 20px;
      }
      .container {
         width: 90%;
         max-width: 900px;
         background: #1e1e1e;
         padding: 30px;
         border-radius: 12px;
         box-shadow: 0px 8px 20px rgba(255, 193, 7, 0.3);
         text-align: center;
      }
      .header {
         background-color: #FFC107;
         padding: 15px;
         border-radius: 8px;
         margin-bottom: 20px;
         color: #000;
      }
      .header h1 {
         font-size: 26px;
         font-weight: bold;
      }
      .content h1 {
         font-size: 22px;
         margin-bottom: 10px;
         color: #FFC107;
      }
      .btn-container {
         display: grid;
         grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
         gap: 15px;
         margin-top: 20px;
      }
      .btn {
         display: block;
         padding: 12px;
         background-color: #FFC107;
         color: #121212;
         text-decoration: none;
         font-size: 16px;
         font-weight: bold;
         border-radius: 6px;
         transition: all 0.3s ease;
         text-align: center;
         box-shadow: 0 4px 8px rgba(255, 193, 7, 0.3);
      }
      .btn:hover {
         background-color: #FFA000;
         transform: scale(1.05);
      }
   </style>
</head>
<body>
   <% 
      HttpSession adminSession = request.getSession(false);
      if (adminSession == null || adminSession.getAttribute("adminName") == null) {
         response.sendRedirect("adminLogin.jsp");
         return;
      }
   %>
   <div class="container">
      <div class="header">
         <h1>Current Admin - <%= adminSession.getAttribute("adminName") %></h1>
      </div>
      <div class="content">
         <h1>Dashboard</h1>
         <p>Manage your cab system efficiently.</p>
         <div class="btn-container">
            <a href="viewUsers" class="btn">View Users</a>
            <a href="manageUsers" class="btn">Manage Users</a>
            <a href="viewBookings" class="btn">View Bookings</a>
            <a href="update_booking.jsp" class="btn">Manage Bookings</a>
            <a href="viewDriver" class="btn">View Drivers</a>
            <a href="add_driver.jsp" class="btn">Add Driver</a>
			<a href="manage_drivers.jsp" class="btn">Manage Drivers</a>
            <a href="logout.jsp" class="btn">Logout</a>
         </div>
      </div>
   </div>
</body>
</html>