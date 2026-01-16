
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login Information</h1>
        <form action="LoginController" method="POST">
            User ID:<input type="text" name="userID" required="" /> <br><!-- comment -->
            Password:<input type="password" name="password" required="" /> <br><!-- comment -->
            <input type="submit" name="action" value="Login"/>
            <input type="reset" value="Reset"/>
        </form>
        <%
            String error = (String) request.getAttribute("ERROR");
            if (error == null) error = "";
        %>
        <%= error %>
    </body>
</html>