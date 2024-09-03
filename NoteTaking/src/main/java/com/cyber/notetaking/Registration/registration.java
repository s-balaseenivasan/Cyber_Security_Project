package com.cyber.notetaking.Registration;

import com.cyber.notetaking.Model.User;
import com.cyber.notetaking.Util;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebServlet("/register")
public class registration extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String pass = request.getParameter("pass");
        String pwd = request.getParameter("re_pass");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        HttpSession session = request.getSession();
        User user = new User();
        user.setFname(fname);
        user.setLname(lname);
        user.setPassword(pass);
        user.setPhone(phone);
        user.setEmail(email);
        try {
            user.setSecretKey(Util.generateKey());
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        session.setAttribute("User", user);
        RequestDispatcher dispatcher = null;
        if (pass == null || pass.isEmpty() ){
            request.setAttribute("status", "InvalidPassword");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
        } else if (!pass.equals(pwd)) {
            request.setAttribute("status", "PasswordMismatch");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);

        }
        if (email == null || email.isEmpty() ){
            request.setAttribute("status", "InvalidEmail");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
        } else if (emailExists(email)) {
            request.setAttribute("status", "EmailUse");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);

        }
        if (phone == null || phone.isEmpty()) {
            request.setAttribute("status", "InvalidPhone");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
        } else if (phone.length() != 10) {
            request.setAttribute("status", "InvalidPhoneLength");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);

        }
        response.sendRedirect("signup-validate?email=" + email);

    }
    public static boolean emailExists(String email) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/note?useSSL=false", "root", "root");
            PreparedStatement ps = con.prepareStatement("select * from user where email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return true;
            else
                return false;
        }
        catch (Exception e) {
            return false;
        }
        }
}

