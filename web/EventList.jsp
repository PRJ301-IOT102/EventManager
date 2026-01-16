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
        User currentUser = (User) session.getAttribute("USER");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String fullName = "";
        if (currentUser != null) {
            fullName = currentUser.getFullName();
        }
    %>
    <h1>Welcome, <%= fullName %>!</h1>
    <form action="MainController" method="POST">
        <button type="submit" name="action" value="Logout">Logout</button> </br>
        <input type="text" name="search" placeholder="Search">
         <button type="submit" name="action" value="Search">Search</button>
    </form>

</body>
</html>
