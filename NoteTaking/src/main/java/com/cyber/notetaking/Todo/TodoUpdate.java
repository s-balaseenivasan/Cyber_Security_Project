package com.cyber.notetaking.Todo;

import com.cyber.notetaking.Model.Todo;
import com.cyber.notetaking.Model.User;
import jakarta.annotation.Nonnull;
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

@WebServlet("/todo-update")
public class TodoUpdate extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int todoid = Integer.parseInt(req.getParameter("todoid"));
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        String task = req.getParameter("task");
        String status = req.getParameter("status");

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/note?useSSL=false","root","root");
            PreparedStatement ps=connection.prepareStatement("UPDATE todo SET description=?,status=? WHERE id=?");
            ps.setString(1,task);
            ps.setString(2, status);
            ps.setInt(3,todoid);
            int result = ps.executeUpdate();  // Execute the update
            if (result > 0) {
                req.setAttribute("UMsg", "Todo successfully updated");
                res.sendRedirect("Todo.jsp");
            } else {
                req.setAttribute("EMsg", "Todo not updated");
                res.sendRedirect("Todo.jsp");
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }


    }
}

