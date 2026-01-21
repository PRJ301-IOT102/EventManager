<%-- 
    Document   : add
    Created on : Jan 19, 2026, 1:31:59 PM
    Author     : THAO VAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Event</title>
    </head>
    <body>
        <h2>Add New Event</h2>
        <form action="MainController" method="POST">
        ID: <input type="text" name="eventID" required> <br>
        Name: <input type="text" name="eventName" required> <br>
        Location: <input type="text" name="location" required> <br>
        Date: <input type="text" name="date" required> <br>
        Price: <input type="text" name="price" required> <br>
        Available Seats: <input type="text" name="availableSeats" required> <br>
        <button type="submit" name="action" value="Add">Add</button>
    </form>
    </body>
</html>
