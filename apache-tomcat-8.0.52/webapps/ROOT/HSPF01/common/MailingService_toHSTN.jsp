<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.internet.MimeBodyPart"%>
<%@ page import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.mail.BodyPart"%>
<%@ page import="javax.mail.Multipart"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("utf-8");

	try {

		/*1. MAIL HOST SERVER, PORT INFORMATION*/
		String host = "123.142.124.146";
		int port = 25;

		/*2. MAIL ID, PASSWORD*/
		final String username = "from_user_id";
		final String password = "from_user_pw";

		String recipient = "to_user";

		/*3. MAIL SUBJECT, BODY*/
		String subject = "";
		String body = "";

		subject = "MAIL SUBJECT SAMPLE";
		body = "MAIL BODY SAMPLE";

		Properties props = System.getProperties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "false");
		props.put("mail.smtp.ssl.trust", host);

		/*4. Session Create */
		Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
			String	un	= username;
			String	pw	= password;

			protected javax.mail.PasswordAuthentication getPasswordAuthentication()
			{
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});

		/*5. CONSOLE DEBUG Y/N */
		session2.setDebug(false);

		Message mimeMessage = new MimeMessage(session2);
		mimeMessage.setFrom(new InternetAddress("admin@hsnetw.com"));
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

		BodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(body, "text/html;charset=UTF-8");

		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messageBodyPart);

		mimeMessage.setSubject(subject);
		mimeMessage.setContent(multipart);
		Transport.send(mimeMessage); //javax.mail.Transport.send() 

	} catch (Exception e) {
		e.printStackTrace();
	} finally {}
%>
