<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/HSPF01/common/DB_Connection_GW.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	ResultSet rs = null;
	CallableStatement cs = null;

	try {
		String V_USR_ID = request.getParameter("V_USR_ID") == null || request.getParameter("V_USR_ID") == ""  ? "" : request.getParameter("V_USR_ID");
		String V_DATE = request.getParameter("V_DATE") == null || request.getParameter("V_DATE") == ""  ? "" : request.getParameter("V_DATE");
		String sql = "select COUNT(*) from COVID_CHECK where USR_ID = " + V_USR_ID + " and YYYYMMDD = " + V_DATE + "";
		
		
		e_cs = e_conn.prepareCall("{call dbo.USP_COVID_CHECK_BF_SAVE(?,?)}");
		e_cs.setString(1, V_USR_ID); 
		e_cs.setString(2, V_DATE); // 
		
		rs = e_cs.executeQuery();
		while (rs.next()) {
			subObject = new JSONObject();
			
			subObject.put("V_RESULT", rs.getString("V_RESULT")); // 
			subObject.put("V_RESULT_MSG", rs.getString("V_RESULT_MSG")); // 
			jsonArray.add(subObject);
		}
		
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

	} catch (

	Exception e) {
		e.printStackTrace();
	} finally {
		if (e_cs != null) try {
			e_cs.close();
		} catch (SQLException ex) {}
		if (e_rs != null) try {
			e_rs.close();
		} catch (SQLException ex) {}
		if (e_stmt != null) try {
			e_stmt.close();
		} catch (SQLException ex) {}
		if (e_conn != null) try {
			e_conn.close();
		} catch (SQLException ex) {}
	}
%>


