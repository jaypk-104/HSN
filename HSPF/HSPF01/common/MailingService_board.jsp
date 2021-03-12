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
		if (V_TYPE.equals("EMAIL_YN")) {
			String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM");
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_MAIL_YN(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, ""); //
			cs.setString(5, V_USR_ID); //
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);

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

		} 
		else if (V_TYPE.equals("RE_EMAIL_YN")) {
			String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM");
			String V_PARENT_REPLY_IDX = request.getParameter("V_PARENT_REPLY_IDX") == null ? "" : request.getParameter("V_PARENT_REPLY_IDX");
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_MAIL_YN(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, V_PARENT_REPLY_IDX); //
			cs.setString(5, V_USR_ID); //
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);

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

		} 
		else if (V_TYPE.equals("REQ_EMAIL_YN")) {
			String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM");
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_MAIL_YN(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, ""); //
			cs.setString(5, V_USR_ID); //
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);

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

		} 
		else if (V_TYPE.equals("REQ_RE_REPLY_EMAIL_YN")) {
			String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM");
			String V_PARENT_REPLY_IDX = request.getParameter("V_PARENT_REPLY_IDX") == null ? "" : request.getParameter("V_PARENT_REPLY_IDX");
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_MAIL_YN(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, V_PARENT_REPLY_IDX); //
			cs.setString(5, V_USR_ID); //
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);

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

		} 
		else if (V_TYPE.equals("TO_MANAGER_EMAIL_YN")) {
			String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM");
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_MAIL_YN(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, ""); //
			cs.setString(5, V_USR_ID); //
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);

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

		} 
		else if (V_TYPE.equals("EMAIL_SEND")) {

			String V_EMAIL = request.getParameter("V_EMAIL") == null ? "" : request.getParameter("V_EMAIL");

			if (!V_EMAIL.equals("")) {
				String V_TYPE2 = request.getParameter("V_TYPE2") == null ? "" : request.getParameter("V_TYPE2");
				String V_TITLE = request.getParameter("V_TITLE") == null ? "" : request.getParameter("V_TITLE");
				String V_TEXT = request.getParameter("V_TEXT") == null ? "" : request.getParameter("V_TEXT");
				String V_REPLY_TEXT = request.getParameter("V_REPLY_TEXT") == null ? "" : request.getParameter("V_REPLY_TEXT");
				String V_SYS_NM = request.getParameter("V_SYS_NM") == null ? "" : request.getParameter("V_SYS_NM");
				
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
				String V_USR_NM = request.getParameter("V_USR_NM") == null ? "" : request.getParameter("V_USR_NM");
				String sql = "";
				
				if(V_TYPE2.equals("REPLY")){
					subject = "댓글이 등록되었습니다"; //메일 제목 입력해주세요. 
					body = "제목 : "+ V_TITLE ;
					body += "<br><br>댓글내용 : "+ V_REPLY_TEXT ;
					body += "<br><br>자세한 내용은 사이트 게시판에서 확인해주세요." ;
				}
				else if(V_TYPE2.equals("REQ_SIGN")){
					subject = "문의가 접수되었습니다"; //메일 제목 입력해주세요. 
					body = "전산요청 문의가 접수되었습니다.";
					body += "<br><br>제목 : "+ V_TITLE ;
					body += "<br><br>접수자 : "+ V_USR_NM ;
					body += "<br><br>자세한 내용은 사이트 게시판에서 확인해주세요." ;
				}
				else if(V_TYPE2.equals("REQ_FINISH")){
					subject = "문의가 처리 완료되었습니다"; //메일 제목 입력해주세요. 
					body = "전산요청 처리가 완료되었습니다.";
					body += "<br><br>제목 : "+ V_TITLE ;
					body += "<br><br>접수자 : "+ V_USR_NM ;
					body += "<br><br>자세한 내용은 사이트 게시판에서 확인해주세요." ;
				}
				else if(V_TYPE2.equals("TO_MANAGER")){
					subject = "신규 전산요청문의(" + V_SYS_NM + ")가 등록되었습니다"; //메일 제목 입력해주세요. 
					body = "신규 전산요청문의가 등록되었습니다.";
					body += "<br><br>제목 : "+ V_TITLE  ;
					body += "<br><br>의뢰자 : "+ V_USR_NM ;
					body += "<br><br>내용 : "+ V_TEXT ;
					body += "<br><br>자세한 내용은 사이트 게시판에서 확인해주세요." ;
				}
				
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
