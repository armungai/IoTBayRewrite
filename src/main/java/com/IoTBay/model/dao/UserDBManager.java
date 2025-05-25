package com.IoTBay.model.dao;

import java.sql.SQLException;

import com.IoTBay.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDBManager extends DBManager<User> {
    // dont need a get user count

    public UserDBManager(Connection conn) throws SQLException {
        super(conn);
    }

    public User add(User user) throws SQLException {
        String sql = "INSERT INTO USERS (Email, Password, FirstName, LastName, mobile, address, City, State) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, user.getEmail());
        preparedStatement.setString(2, user.getPassword());
        preparedStatement.setString(3, user.getFName());
        preparedStatement.setString(4, user.getLName());
        preparedStatement.setString(5, user.getPhone());
        preparedStatement.setString(6, user.getAddress());
        preparedStatement.setString(7, user.getCity());
        preparedStatement.setString(8, user.getState());

        preparedStatement.executeUpdate();

        preparedStatement = connection.prepareStatement("SELECT MAX(UserId) FROM USERS");
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            int id = rs.getInt(1);
            user.setId(id);
        }

        return user;
    }


    public User get(User user) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM USERS WHERE UserId = ?");
        preparedStatement.setInt(1, user.getId());
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        return new User(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3), resultSet.getString(4), resultSet.getString(5), resultSet.getString(6), resultSet.getString(7), resultSet.getString(8), resultSet.getString(9));
    }

    @Override
    public void update(User oldUser, User newUser) throws SQLException {
        String sql =
                "UPDATE USERS " +
                        "  SET Email     = ?, " +
                        "      Password  = ?, " +
                        "      FirstName = ?, " +
                        "      LastName  = ?, " +
                        "      mobile    = ?, " +
                        "      address   = ?, " +
                        "      City      = ?, " +
                        "      State     = ? " +
                        "WHERE UserId    = ?";

        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, newUser.getEmail());
        ps.setString(2, newUser.getPassword());
        ps.setString(3, newUser.getFName());
        ps.setString(4, newUser.getLName());
        ps.setString(5, newUser.getPhone());
        ps.setString(6, newUser.getAddress());
        ps.setString(7, newUser.getCity());
        ps.setString(8, newUser.getState());
        ps.setInt   (9, oldUser.getId());

        ps.executeUpdate();
        ps.close();
    }


    public void delete(User user) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM USERS WHERE UserId = ?");
        preparedStatement.setInt(1, user.getId());
        preparedStatement.executeUpdate();
    }

    public User findByEmailAndPassword(String email, String password) throws SQLException {
        PreparedStatement stmt = connection.prepareStatement(
                "SELECT * FROM users WHERE email = ? AND password = ?"
        );
        stmt.setString(1, email);
        stmt.setString(2, password);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            boolean adminFlag = rs.getInt("isAdmin") == 1;
            return new User(
                    rs.getInt("userID"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("address"),
                    rs.getString("mobile"),
                    rs.getString("city"),
                    rs.getString("state"),
                    adminFlag
            );
        } else {
            return null;
        }
    }

    public void updateAccessLog(int id, String loginTime, String logoutTime) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO websiteAccessLog (userID,loginTime, logoutTime) VALUES (?, ?, ?)"
        );

        statement.setInt(1, id);
        statement.setString(2, loginTime);
        statement.setString(3, logoutTime);
        statement.executeUpdate();

    }

    public void addnNewLogin(int id, String loginTime) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO websiteAccessLog (userID,loginTime) VALUES (?, ?)"
        );

        statement.setInt(1, id);
        statement.setString(2, loginTime);
        statement.executeUpdate();

    }

    public void addLogout(String logoutTime) throws SQLException {
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM websiteAccessLog WHERE logID = (SELECT MAX(logID) FROM websiteAccessLog)");

        ResultSet rs = statement.executeQuery();

        if (rs.next()) {
            int logID = rs.getInt("logID");
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE websiteAccessLog SET logoutTime = ? where logID = ?");
            preparedStatement.setString(1, logoutTime);
            preparedStatement.setInt(2, logID);
            preparedStatement.executeUpdate();
        }

    }

    public List<Map<String,String>> getUserLoginTimesByUserID(int userID) throws SQLException {
        List<Map<String,String>> entries = new ArrayList<>();
        String sql = "SELECT * FROM websiteAccessLog WHERE userID = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, userID);
        ResultSet rs = preparedStatement.executeQuery();

        while (rs.next()) {
            Map<String, String> map = new HashMap<>();
            map.put("loginTime", rs.getString("loginTime"));
            map.put("logoutTime", rs.getString("logoutTime"));

            entries.add(map);

        }

        return entries;
    }

    public List<Map<String,String>> getAllWebsiteLogins() throws SQLException {
        List<Map<String,String>> entries = new ArrayList<>();
        String sql = "SELECT * FROM websiteAccessLog";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet rs = preparedStatement.executeQuery();

        while (rs.next()) {
            Map<String, String> map = new HashMap<>();
            map.put("userID", rs.getString("userID"));
            map.put("loginTime", rs.getString("loginTime"));
            map.put("logoutTime", rs.getString("logoutTime"));

            entries.add(map);
        }

        return entries;
    }
}
