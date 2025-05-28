package com.IoTBay.model.dao;

import com.IoTBay.model.Product;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ProductDBManagerTest {

    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;
    private ProductDBManager productDBManager;

    @BeforeEach
    void setUp() throws SQLException {
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);

        productDBManager = new ProductDBManager(mockConnection);

        when(mockConnection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS))).thenReturn(mockStatement);
        when(mockStatement.executeUpdate()).thenReturn(1);
        when(mockStatement.getGeneratedKeys()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getInt(1)).thenReturn(123);
    }

    @Test
    void testAddProductStoresCorrectly() throws SQLException {
        Product newProduct = new Product("Smart Light", 29.99f, "WiFi-enabled smart bulb", "images/light.png", 50);

        Product returnedProduct = productDBManager.addProduct(newProduct);

        assertEquals(123, returnedProduct.getProductID());

        verify(mockStatement).setString(1, newProduct.getProductName());
        verify(mockStatement).setFloat(2, newProduct.getPrice());
        verify(mockStatement).setString(3, newProduct.getProductDescription());
        verify(mockStatement).setString(4, newProduct.getProductImageAddress());

        verify(mockStatement).executeUpdate();
        verify(mockStatement).getGeneratedKeys();
    }
}
