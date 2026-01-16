<%-- 
    Document   : user.jsp
    Created on : Jan 16, 2026, 1:02:54 PM
    Author     : thanh
--%>

<%@page import="model.User"%>
<%@page import="model.Event"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <style>
            .search {
                    display: flex;
                    justify-content: center;
            }
            .search input[type="text"] {
                width: 300px;
                padding: 5px;
                margin-right: 10px;
            }
            .search button {
                padding: 5px 10px;
            }
            body {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            table, td, th {
                width: 100%;
                max-width: 1000px;
                text-align: center;
                table-layout: fixed;
                border-collapse: collapse;
                border: 1px solid black;
            }
        </style>
        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        %>
        <h1>Welcome: <%= user.getFullName()%>  </h1>
        <div class="search">
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="Logout">Logout</button>
            <input type="text" name="search" placeholder="Search">
            <button type="submit" name="action" value="Search">Search</button>
        </form>
        </div>
        <%
            String MSG = (String) request.getAttribute("MSG");
            if(MSG!=null) {
            %>
            <h3> <%= MSG %> </h3>
        <%
            }
            ArrayList<Event> list = (ArrayList<Event>) request.getAttribute("list");
            if (list!=null) {
        %>
        <table>
            <tr>
                <th>No</th>
                <th>ID</th>
                <th>Event Name</th>
                <th>Location</th>
                <th>Date</th>
                <th>Price</th>
                <th>Available Seats</th>
                <th>Update</th>
                <th>Delete</th>
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
                <td><input type="text" name="eventName" value="<%= event.getName()%>"></td>
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
            <% }
            %>
        </table>
        <%
            }
        %>
    </body>
</html>
