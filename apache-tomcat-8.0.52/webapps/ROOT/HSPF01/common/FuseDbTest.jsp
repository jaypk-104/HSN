<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
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
<%@ page import="org.apache.commons.io.IOUtils"%>
<%@ include file="/HSPF01/common/DB_Connection_HSNA.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	System.out.println("DB START >> ");

	BufferedReader reader = request.getReader();
	StringBuffer jb = new StringBuffer();
	String line = null;
	String V_TYPE = "";
	String V_USR_ID = "";
	String V_BAR_NO = "";
	
	JSONObject jsonObject = null;
	JSONArray jsonArray = null;
	JSONObject subObject = null;

	while ((line = reader.readLine()) != null) {
		jb.append(line);
		System.out.println("JSON DATA : " + line);
		
		JSONParser jP = new JSONParser();
		JSONObject jObj = (JSONObject)jP.parse(line);
		
		V_TYPE = jObj.get("type").toString();
		V_USR_ID = jObj.get("userid").toString();
		V_BAR_NO = jObj.get("barno").toString();
		
		System.out.println("V_TYPE >> " + V_TYPE);
		System.out.println("V_USR_ID >> " + V_USR_ID);
		System.out.println("V_BAR_NO >> " + V_BAR_NO);
	}
	try {

		if(V_TYPE.equals("LOGIN")) {
			System.out.println(">> LOGIN");
			
			/* 로그인 */
			
			cs = conn.prepareCall("{call USP_BARCODE_INFO(?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE);/* B_TYPE */
			cs.setString(2, "");/* COMP_CD */
			cs.setString(3, "");/* BAR_NO 바코드 */
			cs.setString(4, "");/* MVMT_DT 입고일 */
			cs.setString(5, "");/* STS 전체,미입고 */
			cs.setString(6, V_USR_ID);/* USR_ID */
			rs = cs.executeQuery();
			
			jsonArray = new JSONArray();
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STS", rs.getString("STS"));
				subObject.put("MSG_TEXT", rs.getString("MSG_TEXT"));
				subObject.put("COMP_CODE", rs.getString("COMP_CODE"));
				subObject.put("USER_NAME", rs.getString("USER_NAME"));
				subObject.put("SCM_YN", rs.getString("SCM_YN"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				
				jsonArray.add(subObject);
			}
			
// 			jsonObject = new JSONObject();
// 			jsonObject.put("RESULT", "YES");
// 			jsonObject.put("resultList", jsonArray);
			
			System.out.println(subObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();
		
		} else if(V_TYPE.equals("INFO")) {
			System.out.println(">> INFO");
			/* 바코드정보 */
			
			cs = conn.prepareCall("{call USP_BARCODE_INFO(?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE);/* B_TYPE */
			cs.setString(2, "");/* COMP_CD */
			cs.setString(3, V_BAR_NO);/* BAR_NO 바코드 */
			cs.setString(4, "");/* MVMT_DT 입고일 */
			cs.setString(5, "");/* STS 전체,미입고 */
			cs.setString(6, V_USR_ID);/* USR_ID */
			rs = cs.executeQuery();
			
			jsonArray = new JSONArray();
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STS", rs.getString("STS"));
				subObject.put("ITEM_CODE", rs.getString("ITEM_CODE"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT"));
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
// 				subObject.put("COMP_CODE", rs.getString("COMP_CODE"));
// 				subObject.put("USER_NAME", rs.getString("USER_NAME"));
// 				subObject.put("SCM_YN", rs.getString("SCM_YN"));
// 				subObject.put("SL_CD", rs.getString("SL_CD"));
				
				jsonArray.add(subObject);
			}
			
// 			jsonObject = new JSONObject();
// 			jsonObject.put("RESULT", "YES");
// 			jsonObject.put("resultList", jsonArray);
			
			System.out.println(subObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();
		
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
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
