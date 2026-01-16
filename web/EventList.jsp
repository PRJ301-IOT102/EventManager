<%-- 
    Document   : EventList
    Created on : Jan 16, 2026, 10:27:37 AM
    Author     : khoa9
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Event"%>
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
        <input type="text" name="search" placeholder="Search" value="${search}">
         <button type="submit" name="action" value="Search">Search</button>
    </form>
    <% 
        ArrayList<Event> list = (ArrayList<Event>) request.getAttribute("list");
        if(list != null) {
    %>
    <table>
        <tr>
            <th>No</th>
            <th>ID</th>
            <th>Name</th>
            <th>Location</th>
            <th>Date</th>
            <th>Price</th>
            <th>Available Seats</th>
        </tr>
        <%
            int count = 0;
            for(Event event: list) {
                count++;
        %>
                <tr>
                    <td><%= count%></td>
                    <td><%= event.getEventID()%></td>
                    <td><%= event.getName()%></td>
                    <td><%= event.getLocation()%></td>
                    <td><%= event.getDate()%></td>
                    <td><%= event.getPrice()%></td>
                    <td><%= event.getAvailableSeats()%></td>
                </tr>
        <%
            }
        %>                
    </table>
    <%   
        }
    %>

</body>
</html>
