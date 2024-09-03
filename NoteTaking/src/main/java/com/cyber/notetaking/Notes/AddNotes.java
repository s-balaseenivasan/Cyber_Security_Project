package com.cyber.notetaking.Notes;

import com.cyber.notetaking.Model.Notes;
import com.cyber.notetaking.Model.User;
import com.cyber.notetaking.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/add-notes")
public class AddNotes extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/note?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int userId = (int) request.getSession().getAttribute("uid");

        User user = (User) request.getSession().getAttribute("user");
        Notes note = new Notes();
        note.setId(userId); // This is unusual; typically note IDs are unique and auto-generated.
        note.setTitle(title);
        String encrycontent=null;
        try {
            encrycontent = Util.encrypt(content, user.getSecretKey());
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        note.setContent(encrycontent);
        note.setUser(user);

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO notes (title, content, uid) VALUES (?, ?, ?)")) {

            ps.setString(1, title);
            ps.setString(2, encrycontent);
            ps.setInt(3, userId);

            int result = ps.executeUpdate();  // Execute the update
            if (result > 0) {
                request.getSession().setAttribute("note", note);
                response.sendRedirect("shownotes.jsp");
            } else {
                request.setAttribute("status", "failed");
                request.getRequestDispatcher("addnotes.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
            request.getRequestDispatcher("addnotes.jsp").forward(request, response);
        }
    }

    public List<Notes> getData(int userId) {
        List<Notes> notes = new ArrayList<>();
        String sql = "SELECT * FROM notes WHERE uid = ? ORDER BY id DESC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Notes note = new Notes();
                    note.setUserId(rs.getInt("uid"));
                    note.setId(rs.getInt("id"));
                    note.setTitle(rs.getString("title"));
                    note.setContent(rs.getString("content"));
                    note.setTimestamp(rs.getTimestamp("date"));
                    notes.add(note);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notes;
    }

    public Notes getNote(int noteId) {
        Notes note = null;
        String sql = "SELECT * FROM notes WHERE id = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, noteId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    note = new Notes();
                    note.setId(rs.getInt("id"));
                    note.setTitle(rs.getString("title"));
                    note.setContent(rs.getString("content"));
                    note.setUserId(rs.getInt("uid"));
                    note.setTimestamp(rs.getTimestamp("date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return note;
    }
}
