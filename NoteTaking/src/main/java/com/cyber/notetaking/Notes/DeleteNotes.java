package com.cyber.notetaking.Notes;

import jakarta.servlet.RequestDispatcher;
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
import java.sql.SQLException;

@WebServlet("/delete")
public class DeleteNotes extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer noteId = Integer.parseInt(request.getParameter("noteid"));
        RequestDispatcher dispatcher=null;
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/note?useSSL=false", "root", "root");
            PreparedStatement ps = con.prepareStatement("delete from notes where id=?");
            ps.setInt(1, noteId);
            int n = ps.executeUpdate();
            HttpSession session = request.getSession();
            if (n > 0) {
                session.setAttribute("UMsg", "Delete Note Successfully");
            } else {
                session.setAttribute("EMsg", "Delete Note Failed");
            }
            dispatcher=request.getRequestDispatcher("shownotes.jsp");
            dispatcher.forward(request,response);
        } catch (Exception e) {
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
