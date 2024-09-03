package com.cyber.notetaking.Forgot;

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

import com.cyber.notetaking.Model.User;

@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {
	private static final String SMTP_HOST = "smtp.gmail.com";
	private static final String SMTP_PORT = "465";
	private static final String SMTP_USER = "mail.notetaking@gmail.com";
	private static final String SMTP_PASS = "jqrufnqlclptihqr";
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		RequestDispatcher dispatcher = null;
		HttpSession mySession = request.getSession();
		User user= (User) mySession.getAttribute("user");
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

			// Get the session object
			Session session = Session.getDefaultInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(SMTP_USER, SMTP_PASS);
				}
			});

			try {
				// Create and send email
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(SMTP_USER));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
				message.setSubject("Password Reset OTP");
				message.setText(name+"Your OTP is: " + otpvalue+". Use this code to Reset user Password.");
				Transport.send(message);
				System.out.println("Message sent successfully");

				// Forward to JSP
				dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
				request.setAttribute("message", "OTP has been sent to your email address.");
				mySession.setAttribute("otp", otpvalue);
				mySession.setAttribute("email", email);
				dispatcher.forward(request, response);

			} catch (MessagingException e) {
				throw new RuntimeException(e);     }
		}     }
}
