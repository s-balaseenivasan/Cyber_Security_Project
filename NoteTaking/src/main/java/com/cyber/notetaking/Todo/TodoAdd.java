package com.cyber.notetaking.Todo;

import com.cyber.notetaking.Model.Todo;
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
import java.sql.ResultSet;

@WebServlet("/todo-add")
public class TodoAdd extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if(user == null) {
            res.sendRedirect("login.jsp");
        }
        String task = req.getParameter("task");
        String status = req.getParameter("status");
        Todo todo=new Todo();
        todo.setDescription(task);
        todo.setStatus(status);
        todo.setUserid(user.getId());
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/note?useSSL=false","root","root");
            PreparedStatement ps=connection.prepareStatement("INSERT INTO todo (description, status, userid) VALUES (?, ?, ?)");
            ps.setString(1,todo.getDescription());
            ps.setString(2, todo.getStatus());
            ps.setInt(3,todo.getUserid());
            int result = ps.executeUpdate();  // Execute the update
            if (result > 0) {
                req.setAttribute("Msg","Todo added successfully");
                res.sendRedirect("Todo.jsp");
            } else {
                req.setAttribute("Msg", "Todo Added Failed");
                res.sendRedirect("TodoAdd.jsp");
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }


    }
}
