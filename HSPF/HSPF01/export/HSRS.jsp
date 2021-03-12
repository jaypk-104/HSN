<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@ page import="java.util.Enumeration"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@page import="java.net.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	if (conn == null) {
		System.out.println("Tibero DBConnection Fail");
		System.exit(-1);
	}
	stmt = conn.createStatement();
	CallableStatement cs = null;
	JSONObject jsonObject = null;
	JSONParser parser = new JSONParser();
	ResultSet rs = null;
	String sql = null;
	String B_TYPE = "";
	String data = "";
	/*B_TYPE INFO
	SI : 서버정보확인
	
	*/
	try {

		B_TYPE = request.getParameter("B_TYPE");
		if (B_TYPE.equals("SI")) {
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_IP = j.get("IP").toString().toUpperCase();
			String STATUS = "";
			String END_TIME = "";
			
			sql = "SELECT 'NO' STATUS,'15:27:00' END_TIME FROM DUAL;";
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				STATUS = rs.getString("STATUS");
				END_TIME = rs.getString("END_TIME");
			}
			
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String today = formatter.format(new java.util.Date());
			
			jsonObject = new JSONObject();
			jsonObject.put("TODAY", today);
			jsonObject.put("BASE_END_TIME", "17:00:00");
			jsonObject.put("STATUS", STATUS);
			jsonObject.put("TODAY_END_TIME", END_TIME);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		}
	} catch (Exception e) {
		e.printStackTrace();
		System.out.println(data);
		System.out.println(B_TYPE);
		out.println("{\"RESULT\": \"ERROR\"}");
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (pstmt != null) try {
			pstmt.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>
