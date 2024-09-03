package com.cyber.notetaking.Registration;

import com.cyber.notetaking.Model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/signup-otp")
public class signupOTP extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        int value=Integer.parseInt(request.getParameter("otp"));
        HttpSession session=request.getSession();
        User user = (User) session.getAttribute("User");
        System.out.println("\nfname: " + user.getFname() + "\nlname: " + user.getLname() +"\nemail: "+user.getEmail()+ "\npass: " + user.getPassword() + "\nphone: " + user.getPhone());
        int otp = (int)session.getAttribute("otp");
        RequestDispatcher dispatcher=null;

        if (value==otp)
        {

            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("status", "success");
            request.setAttribute("update", "yes");
            response.sendRedirect("insert");

        }
        else
        {
            request.setAttribute("message","wrong otp");
            dispatcher=request.getRequestDispatcher("SignupOTP.jsp");
            dispatcher.forward(request, response);

        }

    }
}
