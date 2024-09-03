package com.cyber.notetaking.Login;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login-otp")
public class LoginvalidateOtp extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userOtp = Integer.parseInt((String)request.getParameter("otp").trim());
        HttpSession session = request.getSession();
        int sessionOtp = (int) session.getAttribute("otp");
        RequestDispatcher dispatcher = null;

        if (userOtp == sessionOtp) {
            request.setAttribute("email", session.getAttribute("email"));
            request.setAttribute("status", "success");
            dispatcher = request.getRequestDispatcher("index.jsp");
        } else {
            request.setAttribute("message", "Incorrect OTP");
            dispatcher = request.getRequestDispatcher("LoginOTP.jsp");
        }
        dispatcher.forward(request, response);
    }
}

