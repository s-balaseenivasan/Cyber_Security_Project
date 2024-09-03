package com.cyber.notetaking.Notes;

import com.cyber.notetaking.Model.User;
import com.cyber.notetaking.Util;
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

@WebServlet("/update_note")
public class UpdateNotes extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noteId = Integer.parseInt(request.getParameter("noteid"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/note?useSSL=false", "root", "root");
            PreparedStatement ps = con.prepareStatement("UPDATE notes SET title=?, content=? WHERE id=?");
            ps.setString(1, title);
            String encrycontent=null;
            try {
                encrycontent = Util.encrypt(content, user.getSecretKey());
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            ps.setString(2, encrycontent);
            ps.setInt(3, noteId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                session.setAttribute("UMsg", "Update Note Successfully");
            } else {
                session.setAttribute("EMsg", "Update Note Failed");
            }

            response.sendRedirect("shownotes.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("EMsg", "Update Note Failed due to an error.");
            response.sendRedirect("shownotes.jsp");
        } finally {
            try {
                if (con != null && !con.isClosed()) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
