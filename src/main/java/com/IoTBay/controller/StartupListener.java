package com.IoTBay.controller;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import com.IoTBay.model.dao.DAO;
import java.sql.SQLException;

@WebListener
public class StartupListener implements ServletContextListener, HttpSessionListener {
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Server Started");
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        try {
            DAO dao = new DAO();
            session.setAttribute("db", dao);
        } catch (SQLException e) {
            System.out.println("Could not connect to database");
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Server Stopped");
    }
}
