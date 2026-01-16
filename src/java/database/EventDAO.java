/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Event;

/**
 *
 * @author THAO VAN
 */
public class EventDAO {
    
    private static final String SEARCH = "SELECT * FROM tblEvents WHERE name LIKE ?";
    
    public ArrayList<Event> searchByName(String search) throws SQLException{
        ArrayList<Event> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if(conn != null) {
                ps = conn.prepareStatement(SEARCH);
                ps.setString(1, "%" + search + "%");
                rs = ps.executeQuery();
                while(rs.next()) {
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    String location = rs.getString("location");
                    String date = rs.getString("date");
                    float price = rs.getFloat("price");
                    int availableSeats = rs.getInt("availableSeats");
                    list.add(new Event(id, name, location, date, price, availableSeats));
                }
            }
        }catch(ClassNotFoundException | SQLException e) {
            throw new SQLException(e);
        }finally{
            if(rs != null) rs.close();
            if(ps != null) ps.close(); 
            if(conn != null) conn.close();
        }
        return list;
    }
}
