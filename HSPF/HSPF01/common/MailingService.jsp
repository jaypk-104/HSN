<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
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
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;

	try {
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		System.out.println("V_TYPE" + V_TYPE);
		if (V_TYPE.equals("EMAIL_YN")) {

			String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");

			cs = conn.prepareCall("call USP_COMMON_MAIL_HSPF(?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_PO_NO);//V_PARAM1 - V_PO_NO
			cs.setString(3, "");//V_PARAM2
			cs.setString(4, "");//V_PARAM3
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();

				subObject.put("EMAIL", rs.getString("EMAIL"));
				subObject.put("EMAIL_YN", rs.getString("EMAIL_YN"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("EMAIL_SEND")) {

			String V_EMAIL = request.getParameter("V_EMAIL") == null ? "" : request.getParameter("V_EMAIL");

			if (!V_EMAIL.equals("")) {
				String V_TYPE2 = request.getParameter("V_TYPE2") == null ? "" : request.getParameter("V_TYPE2");
				long time = System.currentTimeMillis();
				SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat dayTime2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String today = dayTime.format(new Date(time));
				String now = dayTime2.format(new Date(time));

				System.out.println("V_EMAIL" + V_EMAIL);
				System.out.println("V_TYPE2" + V_TYPE2);

				String host = "123.142.124.146";
				int port = 25;

				final String username = "admin";
				final String password = "hsnadmin";

				String subject = "";
				String body = "";

				String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
				String sql = "";

				subject = "(주)화승네트웍스 발주건 [" + today + "]"; //메일 제목 입력해주세요. 
				body = "(주)화승네트웍스에서 발주서가 접수되었습니다.<br>보낸사람"+ V_USR_ID ;

				Properties props = System.getProperties();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.port", port);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.ssl.enable", "false");
				props.put("mail.smtp.ssl.trust", host);

				String[] V_EMAIL_arr = V_EMAIL.split(",");

				for (int i = 0; i < V_EMAIL_arr.length; i++) {
					String recipient = V_EMAIL_arr[i].trim();


					//Session Create
					Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
						String	un	= username;
						String	pw	= password;

						protected javax.mail.PasswordAuthentication getPasswordAuthentication()
						{
							return new javax.mail.PasswordAuthentication(un, pw);
						}
					});
					session2.setDebug(false); //for debug

					Message mimeMessage = new MimeMessage(session2); //MimeMessage 생성 
					mimeMessage.setFrom(new InternetAddress("admin@hsnetw.com"));
					mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

					BodyPart messageBodyPart = new MimeBodyPart();
					messageBodyPart.setContent(body, "text/html;charset=UTF-8");

					Multipart multipart = new MimeMultipart();
					multipart.addBodyPart(messageBodyPart);

					mimeMessage.setSubject(subject); //제목셋팅 
					mimeMessage.setContent(multipart);
					Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
				}
			}

		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>
