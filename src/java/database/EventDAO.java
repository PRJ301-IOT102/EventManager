/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import database.DBUtil;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Event;

public class EventDAO {
    private static final String SEARCH = "SELECT * FROM tblEvents WHERE name LIKE ?";
    private static final String UPDATE = "UPDATE tblEvents SET name = ?, location = ?, date = ?, price = ?, availableSeats = ? WHERE id = ?";
    private static final String DELETE = "DELETE FROM tblEvents WHERE id = ?";
    private static final String FILTER_BY_LOCATION = "SELECT * FROM tblEvents WHERE location = ?";
    //private static final String FILTER_BY_DATE = "SELECT * FROM tblEvents WHERE date >= ? AND date <= ?";
    private static final String FILTER_BY_PRICE = "SELECT * FROM tblEvents WHERE price BETWEEN ? AND ?";
    private static final String FILTER_BY_SEATS = "SELECT * FROM tblEvents WHERE availableSeats >= ?";      
  
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

    // Update Feature
    public boolean update(Event event) throws SQLException {
        boolean checkUpdate = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(UPDATE);
                ps.setString(1, event.getName());
                ps.setString(2, event.getLocation());
                ps.setString(3, event.getDate());
                ps.setFloat(4, event.getPrice());
                ps.setInt(5, event.getAvailableSeats());
                ps.setString(6, event.getEventID());
                
                checkUpdate = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            throw new SQLException(e);
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return checkUpdate;
    }

    // Delete Feature
    public boolean delete(String id) throws SQLException {
        boolean checkDelete = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(DELETE);
                ps.setString(1, id);
                checkDelete = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            throw new SQLException(e);
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ps != null) {
                ps.close();
            }
        }

        return checkDelete;
    }

    // Filter Features
    // Filter by Location
    public ArrayList<Event> filterByLocation(String location) throws SQLException {
        ArrayList<Event> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(FILTER_BY_LOCATION);
                ps.setString(1, location);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    String date = rs.getString("date");
                    float price = rs.getFloat("price");
                    int availableSeats = rs.getInt("availableSeats");
                    list.add(new Event(id, name, location, date, price, availableSeats));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException(e);
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // Filter by Date


    // Filter by Price
    public ArrayList<Event> filterByPrice(double min, double max) throws SQLException {
        ArrayList<Event> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(FILTER_BY_PRICE);
                ps.setDouble(1, min);
                ps.setDouble(2, max);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    String location = rs.getString("location");
                    String date = rs.getString("date");
                    float price = rs.getFloat("price");
                    int availableSeats = rs.getInt("availableSeats");
                    list.add(new Event(id, name, location, date, price, availableSeats));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException(e);
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // Filter by Available Seats
    public ArrayList<Event> filterBySeats(int seats) throws SQLException {
        ArrayList<Event> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(FILTER_BY_SEATS);
                ps.setInt(1, seats);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    String location = rs.getString("location");
                    String date = rs.getString("date");
                    float price = rs.getFloat("price");
                    int availableSeats = rs.getInt("availableSeats");
                    list.add(new Event(id, name, location, date, price, availableSeats));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException(e);
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

}
