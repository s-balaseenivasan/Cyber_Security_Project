package com.cyber.notetaking.Todo;

import com.cyber.notetaking.Model.Notes;
import com.cyber.notetaking.Model.Todo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class TodoView {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/note?";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
    public Todo getTodo(int todoId) {
        Todo todo = null;
        String sql = "SELECT * FROM todo WHERE id = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, todoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    todo= new Todo();
                    todo.setId(rs.getInt("id"));
                    todo.setDescription(rs.getString("description"));
                    todo.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return todo;
    }
    public List<Todo> getData(int userId) {
        List<Todo> todos = new ArrayList<>();
        String sql = "SELECT * FROM todo WHERE userid = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Todo todo = new Todo();
                    todo.setUserid(rs.getInt("userid"));
                    todo.setId(rs.getInt("id"));
                    todo.setDescription(rs.getString("description"));
                    todo.setStatus(rs.getString("status"));
                    todos.add(todo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return todos;
    }
}
