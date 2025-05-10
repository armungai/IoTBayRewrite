package com.IoTBay.controller;

import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        DAO db = (DAO) req.getSession().getAttribute("db");
        if (session != null) {

            String logoutTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

            try {
                db.Users().addLogout(logoutTime);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            session.removeAttribute("loggedInUser");
        }

        resp.sendRedirect("index.jsp?logout=success");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
