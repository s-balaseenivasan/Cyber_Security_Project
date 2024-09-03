package com.cyber.notetaking.Registration;

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
import java.util.Properties;
import java.util.Random;

@WebServlet("/signup-validate")
public class signupvalidatation extends HttpServlet {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "465";
    private static final String SMTP_USER = "mail.notetaking@gmail.com";
    private static final String SMTP_PASS = "jqrufnqlclptihqr";

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        HttpSession mysession = request.getSession();
        User user = (User) mysession.getAttribute("User");
        if(user == null) {
            response.sendRedirect("registration.jsp");
        }

        String name= user.getFname() + " " + user.getLname();
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
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SMTP_USER, SMTP_PASS);
                }
            });

            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(SMTP_USER));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("Email  Verification OTP");
                message.setText("Hello "+name+"\nYour OTP code is: " + otpvalue + ". Use this code to verify your email address.");
                Transport.send(message);

                // Set session attributes
                System.out.println("Email: "+email+"\nOTP: "+otpvalue);
                mysession.setAttribute("otp", otpvalue);
                mysession.setAttribute("email", email);

                // Forward to JSP
                RequestDispatcher dispatcher = request.getRequestDispatcher("SignupOTP.jsp");
                dispatcher.forward(request, response);

            } catch (MessagingException e) {
                throw new ServletException("Error sending email", e);
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
