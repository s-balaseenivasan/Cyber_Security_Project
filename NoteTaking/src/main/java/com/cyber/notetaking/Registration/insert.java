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
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/insert")
public class insert extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");
        Connection con=null;
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con= DriverManager.getConnection("jdbc:mysql://localhost:3306/note?useSSL=false","root","root");
            PreparedStatement ps=con.prepareStatement("insert into user(first_name,last_name,email,password,phone,`key`) values(?,?,?,?,?,?);");
            ps.setString(1, user.getFname());
            ps.setString(2, user.getLname());
            ps.setString(4, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(5, user.getPhone());
            String key=Util.keyToString(user.getSecretKey());
            ps.setString(6,key);
            int rowcount=ps.executeUpdate();

            if(rowcount>0) {
                request.setAttribute("status", "success");
                response.sendRedirect("login.jsp");
            }
            else {
                request.setAttribute("status", "failed");
                response.sendRedirect("registration.jsp");
            }

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally {
            try
            {
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        }

    }
}
