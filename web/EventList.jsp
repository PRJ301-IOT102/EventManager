<%-- 
    Document   : EventList
    Created on : Jan 16, 2026, 10:27:37 AM
    Author     : khoa9
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
<head>
    <title>Event List</title>
</head>
<body>
    <%
        User currentUser = (User) request.getAttribute("LOGGED_USER");
        User user = (User) session.getAttribute("USER");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String fullName = "";
        if (currentUser != null) {
            fullName = currentUser.getFullName();
        }
    %>
    <h1>Welcome, <%= fullName %>!</h1>
</body>
</html>
