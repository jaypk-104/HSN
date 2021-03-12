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

<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		
		String V_BAD_MGM_NO = "";
		String V_ITEM_CD = "";
		String V_ITEM_NM = "";
		String V_BAD_REASON = "";
		String V_BAD_QTY = "";
		String V_USR_NM = "";
		String V_EMAIL = "";
		
		String subject = "";
		String body = "";
		
		if (V_TYPE.equals("SEND")){
			cs = conn.prepareCall("call USP_003_M_GR_BAD_ITEM_MAIL(?,?,?)");
			cs.setString(1, "");//
			cs.setString(2, "SEND");//
			
			cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(3);
			
			while (rs.next()) {
				V_BAD_MGM_NO = rs.getString("BAD_MGM_NO");
				V_ITEM_CD = rs.getString("ITEM_CD");
				V_ITEM_NM = rs.getString("ITEM_NM");
				V_BAD_REASON = rs.getString("BAD_REASON");
				V_BAD_QTY = rs.getString("BAD_QTY");
				V_USR_NM = rs.getString("USR_NM");
				V_EMAIL = rs.getString("EMAIL");
				
				boolean err = false; 
				//올바른 메일 주소 형식인지 체크
				String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$"; 
				Pattern p = Pattern.compile(regex); 
				Matcher m = p.matcher(V_EMAIL); 
				if(m.matches()) { 
					err = true; 
				}
				
				if(err){
					subject = "불량자재 발생 안내";
					body = "관리번호 : " + V_BAD_MGM_NO;
					body += "<br>품목명 : " + V_ITEM_NM;
					body += "<br>품목코드 : " + V_ITEM_CD;
					body += "<br>불량수량 : " + V_BAD_QTY;
					body += "<br>불량사유 : " + V_BAD_REASON;
					body += "<br>화승플랫폼( <a href='http://hspf.hsnetw.com'>http://hspf.hsnetw.com</a> ) 에 접속하시어 확인 후 조치사항 기록 바랍니다.";
				}
				else{
					subject = "불량자재 메일 에러";
					body = V_BAD_MGM_NO + " 확인 요망";
				}

				
				String host = "123.142.124.146";
				int port = 25;

				final String username = "admin";
				final String password = "hsnadmin";

				String recipient = V_EMAIL.trim();

				
				Properties props = System.getProperties();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.port", port);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.ssl.enable", "false");
				props.put("mail.smtp.ssl.trust", host);

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
				
				
				
				cs = conn.prepareCall("call USP_003_M_GR_BAD_ITEM_MAIL(?,?,?)");
				cs.setString(1, V_BAD_MGM_NO);//
				cs.setString(2, "CFM");//
				cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				
				
			}
		}
		
		
		/*
		//메일 보내기.
		String host = "123.142.124.146";
		int port = 25;

		final String username = "admin";
		final String password = "hsnadmin";

		String recipient = V_EMAIL.trim();

		
		Properties props = System.getProperties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "false");
		props.put("mail.smtp.ssl.trust", host);

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
		*/
	
	} catch (Exception e) {
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strTime = dayTime.format(new Date(time));
		System.out.println(strTime);
		
		e.printStackTrace();
	} finally {
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
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
	