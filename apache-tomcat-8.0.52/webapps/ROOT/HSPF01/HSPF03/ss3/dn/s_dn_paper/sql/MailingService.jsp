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

		String V_EMAIL = request.getParameter("V_EMAIL") == null ? "" : request.getParameter("V_EMAIL");

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

			String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

// 			String sql = "";
// 			sql = "SELECT B.ITEM_CD, C.ITEM_NM, B.PO_QTY, B.DLVY_HOPE_DT ";
// 			sql += "FROM M_PO_HDR_HSPF A LEFT OUTER JOIN M_PO_DTL_HSPF B              ";
// 			sql += "ON A.PO_NO = B.PO_NO                                              ";
// 			sql += "LEFT OUTER JOIN B_ITEM_HSPF C                                     ";
// 			sql += "ON B.ITEM_CD = C.ITEM_CD                                          ";
// 			sql += "WHERE A.PO_NO = '" + V_PO_NO + "';                                ";

// 			rs = stmt.executeQuery(sql);

			subject = "(주)화승네트웍스 발주건 [" + today + "]"; //메일 제목 입력해주세요. 
// 			body += "안녕하십니까.<br><br>";
// 			body += "화승플랫폼으로 아래와 같이 P/O가 등록되었습니다.<br>";
// 			body += "화승플랫폼에 접속하시어 납품진행 바랍니다. <br><br>";
// 			body += "[ 자재코드 / 품 명 / 수 량 / 납품요청일 ]<br><br>";

			body += "<SPAN style=\"FONT-SIZE: 14pt\">출하요청서 승인 부탁드립니다.</SPAN>";
			body += "<DIV><SPAN style=\"FONT-SIZE: 10pt\"><SPAN 9pt>※출하요청서 승인은 출하요청서보기에서 할수있습니다.</SPAN></SPAN></DIV>";
			body += "<DIV>&nbsp;</DIV>";
			body += "<STRONG><SPAN style=\"FONT-SIZE: 20pt\"><A href=\"http://gw.hsnetw.com/info/DnReq.asp?PRINT_NO= + PrintNo + &target=\"_blank\">출하요청서보기</A>&nbsp;<BR></SPAN></STRONG><BR><BR><BR>※바로가기를 통하여 출하요청서를 확인 할 수 없으신분은 화승네트웍스 그룹웨어에 로그인<BR>하신 후 확인 할 수 있습니다.";


			int j = 1;
// 			while (rs.next()) {
// 				body += j + ". " + rs.getString("ITEM_CD") + " / " + rs.getString("ITEM_NM") + " / " + rs.getString("PO_QTY") + " / " + rs.getString("DLVY_HOPE_DT").substring(0, 10) + "<br> ";
// 				j++;
// 			}
			body += "<br><br>감사합니다.";

			Properties props = System.getProperties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", port);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.enable", "false");
			props.put("mail.smtp.ssl.trust", host);

			String recipient = V_EMAIL;
			
			
			Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
				String	un	= username;
				String	pw	= password;

				protected javax.mail.PasswordAuthentication getPasswordAuthentication()
				{
					return new javax.mail.PasswordAuthentication(un, pw);
				}
			});
			session2.setDebug(true); //for debug

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
			
			
// 			String[] V_EMAIL_arr = V_EMAIL.split(",");
// 			for (int i = 0; i < V_EMAIL_arr.length; i++) {
// 				String recipient = V_EMAIL_arr[i].trim();

// 				// 					System.out.println("*********************************");
// 				// 					System.out.println("recipient" + recipient);
// 				// 					System.out.println("now" + now);
// 				// 					System.out.println("*********************************");

// 				//Session 생성 
// 				Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
// 					String	un	= username;
// 					String	pw	= password;

// 					protected javax.mail.PasswordAuthentication getPasswordAuthentication()
// 					{
// 						return new javax.mail.PasswordAuthentication(un, pw);
// 					}
// 				});
// 				session2.setDebug(false); //for debug

// 				Message mimeMessage = new MimeMessage(session2); //MimeMessage 생성 
// 				mimeMessage.setFrom(new InternetAddress("admin@hsnetw.com"));
// 				mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

// 				BodyPart messageBodyPart = new MimeBodyPart();
// 				messageBodyPart.setContent(body, "text/html;charset=UTF-8");

// 				Multipart multipart = new MimeMultipart();
// 				multipart.addBodyPart(messageBodyPart);

// 				mimeMessage.setSubject(subject); //제목셋팅 
// 				mimeMessage.setContent(multipart);
// 				Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
// 			}
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
