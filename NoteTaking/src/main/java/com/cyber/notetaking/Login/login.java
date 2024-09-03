package com.cyber.notetaking.Login;

import com.cyber.notetaking.Model.User;
import com.cyber.notetaking.Util;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.crypto.SecretKey;
import java.io.IOException;
import java.sql.*;
@WebServlet("/login")
public class login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;
        Connection con = null;

        if (email == null || email.isEmpty()) {
            request.setAttribute("status", "invalidUsername");
            dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if (password == null || password.isEmpty()) {
            request.setAttribute("status", "invalidPassword");
            dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/note", "root", "root");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                    session.setAttribute("email", rs.getString("email"));
                    session.setAttribute("fname", rs.getString("first_name"));
                    session.setAttribute("lname", rs.getString("last_name"));
                    session.setAttribute("phone", rs.getString("phone"));

                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setEmail(rs.getString("email"));
                    user.setFname(rs.getString("first_name"));
                    user.setLname(rs.getString("last_name"));
                    user.setPassword(rs.getString("password"));
                    user.setPhone(rs.getString("phone"));
                    try {
                        SecretKey key = Util.stringToKey(rs.getString("key"));
                        user.setSecretKey(key);
                    }
                    catch (Exception e) {
                        e.printStackTrace();
                    }

                    session.setAttribute("user", user);

                    response.sendRedirect("login-validate");
            } else {
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
            dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

