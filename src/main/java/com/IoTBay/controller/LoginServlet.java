package com.IoTBay.controller;

import com.IoTBay.model.User;
import com.IoTBay.model.dao.DAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.IoTBay.model.dao.DBManager;
import jakarta.servlet.http.HttpSession;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DAO db = (DAO) req.getSession().getAttribute("db");
        HttpSession session = req.getSession();

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            User user = db.Users().findByEmailAndPassword(email, password);
            String loginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            System.out.println(loginTime);
            if (user != null) {
                try {
                    db.Users().addnNewLogin(user.getId(),loginTime);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                session.setAttribute("loggedInUser", user);
                session.setAttribute("loginTime", loginTime);
                resp.sendRedirect("home.jsp");

            } else {
                session.setAttribute("loginError", "Invalid email or password");
                resp.sendRedirect("login.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
