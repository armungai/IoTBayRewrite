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

@WebServlet("/FilterLogsServlet")
public class FilterLogsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        HttpSession session = req.getSession();
        String selectedDate = req.getParameter("selectedDate"); // Format: YYYY-MM-DD
        session.setAttribute("selectedDate", selectedDate);
        req.getRequestDispatcher("AccountPages/userLog.jsp").forward(req, resp);



    }
}
