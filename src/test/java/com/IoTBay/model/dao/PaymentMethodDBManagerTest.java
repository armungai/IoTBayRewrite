package com.IoTBay.model.dao;

import com.IoTBay.model.PaymentMethod;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class PaymentMethodDBManagerTest {

    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;
    private PaymentMethodDBManager dbManager;

    @BeforeEach
    void setUp() throws SQLException {
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);

        dbManager = new PaymentMethodDBManager(mockConnection);

        when(mockConnection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS))).thenReturn(mockStatement);
        when(mockStatement.executeUpdate()).thenReturn(1);
        when(mockStatement.getGeneratedKeys()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getInt(1)).thenReturn(101);  // Mocked generated ID
    }

    @Test
    void testAddPaymentMethodStoresCorrectly() throws SQLException {
        PaymentMethod method = new PaymentMethod(
                10,                      // userId
                "Visa",                 // type
                "4111111111111111",     // cardNumber
                "John Doe",             // nameOnCard
                "12/25",                // expiry
                "123"                   // cvv
        );

        PaymentMethod returnedMethod = dbManager.add(method);

        assertEquals(101, returnedMethod.getMethodId());
        verify(mockStatement, times(1)).setInt(1, method.getUserId());
        verify(mockStatement, times(1)).setString(2, method.getType());
        verify(mockStatement, times(1)).setString(3, method.getCardNumber());
        verify(mockStatement, times(1)).setString(4, method.getNameOnCard());
        verify(mockStatement, times(1)).setString(5, method.getExpiry());
        verify(mockStatement, times(1)).setString(6, method.getCvv());

        verify(mockStatement, times(1)).executeUpdate();
        verify(mockStatement, times(1)).getGeneratedKeys();
    }
}