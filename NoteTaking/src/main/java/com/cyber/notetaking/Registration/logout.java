package com.cyber.notetaking.Registration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
@WebServlet("/logout")
public class logout extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException , ServletException
    {
        try
        {
            HttpSession session = req.getSession();
            session.removeAttribute("user");
            session.invalidate();
            res.sendRedirect("login.jsp");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }
}
