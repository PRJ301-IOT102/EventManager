package database;

import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private static final String LOGIN_QUERY = 
        "SELECT fullName FROM tblUsers WHERE userID = ? AND password = ?";

    public User checkLogin(String userID, String password) throws SQLException {
        User user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            ptm = conn.prepareStatement(LOGIN_QUERY);
            ptm.setString(1, userID);
            ptm.setString(2, password);
            rs = ptm.executeQuery();

            if (rs.next()) {
                String fullName = rs.getString("fullName");
                user = new User(userID, fullName, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();  
            if (ptm != null) ptm.close();
            if (conn != null) conn.close();
        }
        return user;
    }    
}