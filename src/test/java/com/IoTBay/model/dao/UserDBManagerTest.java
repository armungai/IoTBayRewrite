package com.IoTBay.model.dao;

import com.IoTBay.model.User;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.ArgumentCaptor;

import java.sql.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import static org.junit.jupiter.api.Assertions.*;
class UserDBManagerTest {
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;
    private UserDBManager userDao;

    @BeforeEach
    void setUp() throws SQLException {
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
        userDao = new UserDBManager(mockConnection);
    }

    @Test
    void add() throws Exception {
        User user = new User("test@example.com","password","John","Doe", "1234567890", "123 Main St", "Test", "NSW");

        // Mock for INSERT
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
        when(mockStatement.executeUpdate()).thenReturn(1);

        // Mock for SELECT MAX(UserId)
        when(mockStatement.executeQuery()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getInt(1)).thenReturn(42);

        User addedUser = userDao.add(user);

        assertEquals(42, addedUser.getId());

        // Optional: Verify the correct values were set in the PreparedStatement
        verify(mockStatement, times(8)).setString(anyInt(), anyString());
        verify(mockStatement, times(1)).executeUpdate();
        verify(mockStatement, times(1)).executeQuery();
    }
}