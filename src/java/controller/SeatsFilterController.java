/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import database.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import static java.util.Collections.list;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Event;

/**
 *
 * @author THAO VAN
 */
@WebServlet("/SeatsFilterController")
public class SeatsFilterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        response.setContentType("text/html;charset=UTF-8");
            String seatsParam = request.getParameter("minSeats");
            System.out.println("DEBUG SeatsFilter - minSeats param: " + seatsParam);
            int minSeats = 0;
            
            if (seatsParam == null || seatsParam.trim().isEmpty()) {
                try {
                    minSeats = Integer.parseInt(seatsParam.trim());
                } catch (NumberFormatException e) {
                    minSeats = 0;
                }
            }
            
            
            System.out.println("DEBUG: minSeats parsed: " + minSeats);

            EventDAO dao = new EventDAO();
            ArrayList<Event> list = dao.filterBySeats(minSeats);
            System.out.println("DEBUG: filtered list size: " + (list != null ? list.size() : 0));
                for (Event e : list) {
                System.out.println(e.getEventID() + " | "
                    + e.getName() + " | "
                    + e.getLocation() + " | "
                    + e.getDate() + " | "
                    + e.getPrice() + " | "
                    + e.getAvailableSeats());
                }


            request.setAttribute("list", list);
            request.getRequestDispatcher("EventList.jsp").forward(request, response);
            

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SeatsFilterController.class.getName()).log(Level.SEVERE, null, ex);
            try {
                request.getRequestDispatcher("EventList.jsp").forward(request, response);
            } catch (ServletException | IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SeatsFilterController.class.getName()).log(Level.SEVERE, null, ex);
            try {
                request.getRequestDispatcher("EventList.jsp").forward(request, response);
            } catch (ServletException | IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
