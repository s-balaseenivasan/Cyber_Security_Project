package com.cyber.notetaking;

import com.cyber.notetaking.Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/original")
public class Original extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(2 * 60);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String noteIdStr = request.getParameter("noteId");

        if (email.equals(user.getEmail()) && password.equals(user.getPassword())) {
            if (noteIdStr != null) {
                try {
                    int noteId = Integer.parseInt(noteIdStr);
                    // Add logic to handle noteId, e.g., decrypt the note
                    // Redirect to the desired page
                    response.sendRedirect("Original.jsp?noteId=" + noteId);
                } catch (NumberFormatException e) {
                    // Handle invalid noteId
                    response.sendRedirect("shownotes.jsp?error=Invalid Note ID");
                }
            } else {
                response.sendRedirect("shownotes.jsp?error=Note ID is missing");
            }
        } else {
            session.setAttribute("error", "Wrong email or password");
            response.sendRedirect("shownotes.jsp");
        }
    }
}
