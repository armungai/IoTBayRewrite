package com.IoTBay.model.dao;

import java.sql.SQLException;

import com.IoTBay.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

        // Get the auto-generated user ID
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

    public void update(User oldUser, User newUser) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE USERS SET Email = ?, Password = ? WHERE UserId = ?");
        preparedStatement.setString(1, newUser.getEmail());
        preparedStatement.setString(2, newUser.getPassword());
        preparedStatement.executeUpdate();
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
            return new User(
                    rs.getInt("userID"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("address"),
                    rs.getString("mobile"),
                    rs.getString("city"),
                    rs.getString("state")
            );
        } else {
            return null;
        }
    }


}
