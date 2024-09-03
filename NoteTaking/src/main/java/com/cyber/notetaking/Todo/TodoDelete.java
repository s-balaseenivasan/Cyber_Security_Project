package com.cyber.notetaking.Todo;

import com.cyber.notetaking.Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/todo-delete")
public class TodoDelete extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        TodoView todoView=new TodoView();
        User user = (User) req.getSession().getAttribute("user");
        if(user == null) {
            res.sendRedirect("login.jsp");
        }
        int id=Integer.parseInt(req.getParameter("id"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/note?useSSL=false", "root", "root");
            PreparedStatement ps = connection.prepareStatement("delete from todo where id=?");
            ps.setInt(1, id);
            int n = ps.executeUpdate();
            HttpSession session = req.getSession();
            if (n > 0) {
                session.setAttribute("UMsg", "Delete Note Successfully");

            } else {
                session.setAttribute("EMsg", "Delete Note Failed");
            }
            res.sendRedirect("Todo.jsp");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
