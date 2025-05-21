package com.IoTBay.model.dao;


import java.io.File;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {
    private Connection connection;

    public DBConnector() {
        System.setProperty("org.sqlite.lib.verbose", "true");
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String url ="jdbc:sqlite:/Users/andrewmungai/.SmartTomcat/IOTBAYFINAL/IoTBay-Rewrite/IoTBayNEWSATABASE.db";

        System.out.println("Absolute DB Path: " + new File("IoTBayNEWSATABASE.db").getAbsolutePath());
        try {
            connection = DriverManager.getConnection(url);
            connection.setAutoCommit(true);
            System.out.println("Connected to database");
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public void closeConnection() {
        try {
            if (connection != null) {
                connection.close();
                System.out.println("Connection closed");
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
