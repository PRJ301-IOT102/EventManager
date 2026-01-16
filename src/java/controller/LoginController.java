/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
/**
 *
 * @author khoa9
 */
public class LoginController extends HttpServlet{
    
    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

       String userID = request.getParameter("userID");
       String password = request.getParameter("password");
       String url = "login.jsp";
       final String ERROR_MESSAGE = "Incorrect UserID or Password";

       try {
           database.UserDAO dao = new database.UserDAO();
           model.User user = dao.checkLogin(userID, password);

           if (user != null) {
               request.setAttribute("LOGGED_USER", user);
               url = "EventList.jsp";
           } else {
               request.setAttribute("ERROR", ERROR_MESSAGE);
           }
       } catch (Exception e) {
           log("Login error: " + e.getMessage());
           request.setAttribute("ERROR", "System error. Please try again.");
       }

       request.getRequestDispatcher(url).forward(request, response);
   }
    
}
