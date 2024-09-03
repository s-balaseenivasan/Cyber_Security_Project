package com.cyber.notetaking.Login;

import com.cyber.notetaking.Model.User;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;

@WebServlet("/login-validate")
public class Loginvalidate extends HttpServlet {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "465";
    private static final String SMTP_USER = "mail.notetaking@gmail.com";
    private static final String SMTP_PASS = "jqrufnqlclptihqr";
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = null;
        HttpSession mySession = request.getSession();
        User user= (User) mySession.getAttribute("user");
        String email= user.getEmail();
        String name= user.getFname()+" "+user.getLname();
        if (email != null && !email.isEmpty()) {
            // Generate OTP
            Random rand = new Random();
            int otpvalue = rand.nextInt(1000000); // OTP between 0 and 999999
            // Set up mail server properties
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.socketFactory.port", SMTP_PORT);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", SMTP_PORT);

            Session session = Session.getDefaultInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication()
                {
                    return new PasswordAuthentication(SMTP_USER, SMTP_PASS);
                }
            });
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(SMTP_USER));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("Email Verification OTP");
                message.setText("Hi "+name+"\nYour OTP code is: " + otpvalue + ". Use this code to verify your email address.");
                Transport.send(message);
                System.out.println("Message sent successfully");

                // Forward to JSP

                System.out.println("Email: "+email+"\nOTP: "+otpvalue);
                request.setAttribute("message", "OTP has been sent to your email address.");
                mySession.setAttribute("otp", otpvalue);
                mySession.setAttribute("email", email);
                response.sendRedirect("LoginOTP.jsp");

            } catch (MessagingException e)
            {
                response.sendRedirect("login.jsp");
                throw new RuntimeException(e);
            }
        }
    }
}
