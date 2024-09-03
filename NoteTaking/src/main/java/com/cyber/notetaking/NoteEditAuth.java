package com.cyber.notetaking;

import com.cyber.notetaking.Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/note-edit")
public class NoteEditAuth extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession mysession = request.getSession();
        User user = (User) mysession.getAttribute("user");

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

                    response.sendRedirect("editnotes.jsp?noteid=" + noteId);
                } catch (NumberFormatException e) {
                    response.sendRedirect("shownotes.jsp?error=Invalid Note ID");
                }
            } else {
                mysession.setAttribute("error", "email and password is missing match");
                response.sendRedirect("shownotes.jsp");
            }
        } else {
            mysession.setAttribute("error", "Wrong email or password");
            response.sendRedirect("shownotes.jsp");
        }
    }
}
