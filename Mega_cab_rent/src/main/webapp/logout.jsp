<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session != null) {  // Use the implicit 'session' object
        session.invalidate(); // Invalidate the session
    }
    response.sendRedirect("adminlogin.jsp"); // Redirect to admin login page
%>
