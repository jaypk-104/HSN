<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="javax.activation.DataHandler"%>
<%@page import="javax.activation.FileDataSource"%>
<%@page import="javax.mail.internet.MimeUtility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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

<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>

<%@ page import="java.nio.file.Path"%>
<%@ page import="java.io.*"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>




<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	CallableStatement cs3 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {

		String V_URL = request.getParameter("V_URL");
		String V_MAST_PO_NO = request.getParameter("V_MAST_PO_NO");
		String V_EMAIL = "";
		System.out.println(V_URL);

		cs = conn.prepareCall("call USP_003_M_PO_TOT_MAST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "MAIL");//V_COMP_ID
		cs.setString(2, "");//
		cs.setString(3, "");//V_PUR_NO
		cs.setString(4, "");//V_PUR_SEQ
		cs.setString(5, "");//V_PUR_DT_FR
		cs.setString(6, "");//V_PUR_DT_TO
		cs.setString(7, V_MAST_PO_NO);//V_PO_NO
		cs.setString(8, "");//V_M_BP_CD
		cs.setString(9, "");//V_M_BP_NM
		cs.setString(10, "");//V_PO_DT
		cs.setString(11, "");//V_PO_TYPE
		cs.setString(12, "");//V_IN_TERMS
		cs.setString(13, "");//V_PAY_METH
		cs.setString(14, "");//V_CUR
		cs.setString(15, "");//V_XCHG_RATE
		cs.setString(16, "");//V_REMARK
		cs.setString(17, "");//V_PO_USR_ID
		cs.setString(18, "");//V_COMM_NO
		cs.setString(19, "");//V_ITEM_CD
		cs.setString(20, "");//V_PO_CFM
		cs.setString(21, "");//V_SYS_TYPE
		cs.setString(22, "");//V_DLV_TYPE
		cs.setString(23, "");//V_GR_TYPE
		cs.setString(24, "");//V_VAT_TYPE
		cs.setString(25, "");//V_DN_DT_TO
		cs.registerOutParameter(26, com.tmax.tibero.TbTypes.CURSOR);
		cs.setString(27, "");//V_S_BP_CD
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(26);

		while (rs.next()) {
			V_EMAIL = rs.getString("EMAIL");
		}
		
		System.out.println("V_EMAIL: " + V_EMAIL);

		long time = System.currentTimeMillis();
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dayTime2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = dayTime.format(new Date(time));
		String now = dayTime2.format(new Date(time));

		BufferedReader b_in = null;

		URL obj = new URL(V_URL + "&reportMode=PDF&clientURIEncoding=UTF-8&reportParams=pdfserversave:true,savename:/data/apache/webapps/ROOT/aireport/tot_pdf/" + V_MAST_PO_NO); // 호출할 url 
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		b_in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));

		System.out.println("url request");

		String line;

		while ((line = b_in.readLine()) != null) { // response를 차례대로 출력 
			System.out.println(line);
		}

		String savePath = "\\\\123.142.124.161\\data\\tot_pdf\\";
		String filename = V_MAST_PO_NO + ".pdf";

		InputStream in = null;
		OutputStream os = null;
		File file = null;
		boolean skip = false;
		String client = "";

		file = new File(savePath, filename);
		System.out.println("파일명: " + file.getName());

		String subject = "파일첨부테스트1_" + now;
		String body = "";

		body += "<SPAN style=\"FONT-SIZE: 14pt\">파일첨부테스트</SPAN>";
		body += "<DIV>&nbsp;</DIV>";

		int j = 1;

		String host = "123.142.124.146";
		int port = 25;

		final String username = "admin";
		final String password = "hsnadmin";

		Properties props = System.getProperties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "false");
		props.put("mail.smtp.ssl.trust", host);

		String recipient = V_EMAIL;
		System.out.println("*********************************");
		System.out.println("recipient" + recipient);
		System.out.println("now" + now);
		System.out.println("*********************************");

		Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
			String un = username;
			String pw = password;

			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		session2.setDebug(true); //for debug

		MimeMessage message = new MimeMessage(session2);
		message.setFrom(new InternetAddress("admin@hsnetw.com"));
				
		InternetAddress[] address = { new InternetAddress(V_EMAIL) };
		message.setRecipients(Message.RecipientType.TO, address);
		message.setSubject(subject);
		

		MimeBodyPart mbp1 = new MimeBodyPart();
		mbp1.setText("test_한글111");

		MimeBodyPart mbp2 = new MimeBodyPart();
		// 		FileDataSource fds = new FileDataSource("\\\\123.142.124.161\\data\\tot_pdf\\TEST200305.pdf"); //파일 읽어오기
		FileDataSource fds = new FileDataSource("/data/tot_pdf/" + file.getName()); //파일 읽어오기
		mbp2.setDataHandler(new DataHandler(fds)); //파일 첨부
		mbp2.setFileName(fds.getName());

		message.setSubject(MimeUtility.encodeText(subject, "EUC-KR", "B"));
		message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

		// 		message.setContent(content, "text/html; charset=UTF-8");
		// 		message.setContent(content, "text/html; charset=EUC-KR");

		Multipart mp = new MimeMultipart();
		mp.addBodyPart(mbp1);
		mp.addBodyPart(mbp2);

		message.setContent(mp);

		Transport.send(message);

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

		e.printStackTrace();
	} finally {
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (cs2 != null)
			try {
				cs2.close();
			} catch (SQLException ex) {
			}
		if (cs3 != null)
			try {
				cs3.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>


