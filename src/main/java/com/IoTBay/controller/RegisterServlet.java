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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        DAO db = ((DAO)req.getSession().getAttribute("db"));
        HttpSession session = req.getSession();

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String firstName = req.getParameter("firstname");
        String lastName = req.getParameter("lastname");
        String phoneNumber = req.getParameter("mobile");
        String street = req.getParameter("street");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        String address = street + "," + city + "," + state;

        User user = new User(firstName, lastName, email, password, address, phoneNumber, city, state);
        session.setAttribute("loggedInUser", user);
        try{
            db.Users().add(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        resp.sendRedirect("home.jsp");


    }
}
