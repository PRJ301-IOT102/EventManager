/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import database.DBUtil;
import model.Event;

/**
 *
 * @author thanh
 */

public class EventDAO {
    private static final String UPDATE = "UPDATE tblEvents SET name = ?, location = ?, date = ?, price = ?, availableSeats = ? WHERE id = ?";
    private static final String DELETE = "DELETE tblEvents WHERE id = ?";

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
}

