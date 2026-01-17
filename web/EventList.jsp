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
    <style>
    .page {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;   /* center toàn trang */
    }
    
    .welcome h1{
        display: flex;
        justify-content: center;
    }

    .search form{
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 15px;
    }
    
    .search button { 
        padding: 5px 10px; 
    }
    
    .search input.searchinput {
    width: 300px;
    box-sizing: border-box;
    }


    table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
    }

    th, td {
        border: 1px solid black;
        padding: 6px;
        text-align: center;
    }

    input[type="text"] {
        width: 100%;
        box-sizing: border-box;
    }
    </style>
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
    <div class="page">
    <div class="welcome">
    <h1>Welcome, <%= fullName %>!</h1>
    <div>
    <div class="search">
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="Logout">Logout</button>
            <input class="searchinput" type="text" name="search" placeholder="Search">
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
            <th>Feature</th>
            <th>Feature</th>
        </tr>
        <%
            int count = 0;
            for (Event event : list) {
                count++;
        %>
        <tr>
        <form action="MainController" method="POST">
            <td><%= count%></td>
            <td><%= event.getEventID()%></td>
            <input type="hidden" name="id" value="<%= event.getEventID()%>">
            <td><input type="text" name="name" value="<%= event.getName()%>"></td>
            <td><input type="text" name="location"  value="<%= event.getLocation()%>"></td>
            <td><input type="text" name="date" value="<%= event.getDate()%>"></td>
            <td><input type="text" name="price" value="<%= event.getPrice()%>"></td>
            <td><input type="text" name="availableSeats" value="<%= event.getAvailableSeats()%>"></td>
            <input type="hidden" name="id" value="<%= event.getEventID()%>">
            
            <td><button type="submit" name="action" value="Update">Update</button></td>
            <td>
                <button type="submit" name="action" value="Delete" class="btn-delete"onclick="return confirm('Delete this event?');">Delete</button>
            </td>
        </form>
        </tr>
        <%
            }
        %>                
    </table>
    </div>
    <%   
        }
    %>

</body>
</html>
