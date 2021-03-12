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
		if (V_TYPE.equals("EMAIL_SEND")) {

			String V_EMAIL = "jww0228@hsnetw.com,heyj9012@hsnetw.com,cmg0616@hsnetw.com";
// 			String V_EMAIL = "jaypk104@hsnetw.com";

			if (!V_EMAIL.equals("")) {
				String V_TYPE2 = request.getParameter("V_TYPE2") == null ? "" : request.getParameter("V_TYPE2");
				long time = System.currentTimeMillis();
				SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat dayTime2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String today = dayTime.format(new Date(time));
				String now = dayTime2.format(new Date(time));

				String host = "123.142.124.146";
				int port = 25;

				final String username = "admin";
				final String password = "hsnadmin";

				String subject = "";
				String body = "";

				String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
				String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO");
				String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
				String V_PO_SEQ = request.getParameter("V_PO_SEQ") == null ? "" : request.getParameter("V_PO_SEQ");
				String V_BP_CD = "";
				String V_BP_NM = "";
				String sql = "";

				sql = "SELECT A.BP_CD, B.BP_NM                            ";
				sql += "FROM M_PO_HDR_HSPF A LEFT OUTER JOIN B_BIZ_HSPF B ";
				sql += "ON A.BP_CD = B.BP_CD                               ";
				sql += "WHERE PO_NO = '" + V_PO_NO + "' ";

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					V_BP_CD = rs.getString("BP_CD");
					V_BP_NM = rs.getString("BP_NM");
				}

				subject = "[화승플랫폼] 확정취소요청 - " + V_BP_NM + " (" + V_BP_CD + ") [" + now + "]"; //메일 제목 입력해주세요. 
				body = "[화승플랫폼] 확정취소요청이 접수되었습니다. 납품현황등록에서 아래 정보를 확인하세요.";
				body += " <br><br>공급사 : " + V_BP_NM + " (" + V_BP_CD + ")";
				body += " <br>ASN번호 : " + V_ASN_NO;
				body += " <br>발주번호 : " + V_PO_NO;
				body += " <br>발주순번 : " + V_PO_SEQ;

				body += " <br><br>요청자ID : " + V_USR_ID;
				body += " <br>요청일시 : " + now;

				Properties props = System.getProperties();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.port", port);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.ssl.enable", "false");
				props.put("mail.smtp.ssl.trust", host);

				String[] V_EMAIL_arr = V_EMAIL.split(",");

				for (int i = 0; i < V_EMAIL_arr.length; i++) {
					String recipient = V_EMAIL_arr[i].trim();

					// 					System.out.println("*********************************");
					// 					System.out.println("recipient" + recipient);
					// 					System.out.println("now" + now);
					// 					System.out.println("*********************************");

					//Session 생성 
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
