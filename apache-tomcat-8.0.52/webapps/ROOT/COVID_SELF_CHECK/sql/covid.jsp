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
		String V_EXOTHERMIC = request.getParameter("V_EXOTHERMIC") == null || request.getParameter("V_EXOTHERMIC") == ""  ? "N" : "Y";
		String V_COUGH = request.getParameter("V_COUGH") == null || request.getParameter("V_COUGH") == ""  ? "N" : "Y"; //request.getParameter("V_COUGH").toUpperCase();
		String V_THOAT = request.getParameter("V_THOAT") == null || request.getParameter("V_THOAT") == ""  ? "N" : "Y"; //request.getParameter("V_THOAT").toUpperCase();
		String V_MORVE = request.getParameter("V_MORVE") == null || request.getParameter("V_MORVE") == ""  ? "N" : "Y"; //request.getParameter("V_MORVE").toUpperCase();
		String V_PHLEGM = request.getParameter("V_PHLEGM") == null || request.getParameter("V_PHLEGM") == ""  ? "N" : "Y"; //request.getParameter("V_PHLEGM").toUpperCase();
		String V_BREATHING = request.getParameter("V_BREATHING") == null || request.getParameter("V_BREATHING") == ""  ? "N" : "Y"; //request.getParameter("V_BREATHING").toUpperCase();
		String V_CONTACT_MAN = request.getParameter("V_CONTACT_MAN") == null || request.getParameter("V_CONTACT_MAN") == ""  ? "N" : "Y"; //request.getParameter("V_CONTACT_MAN").toUpperCase();
		String sql = "";
		
// 		System.out.println("V_EXOTHERMIC : " + V_EXOTHERMIC);
// 		System.out.println("V_COUGH : " + V_COUGH);
// 		System.out.println("V_THOAT : " + V_THOAT);
// 		System.out.println("V_MORVE : " + V_MORVE);
// 		System.out.println("V_PHLEGM : " + V_PHLEGM);
// 		System.out.println("V_BREATHING : " + V_BREATHING);
// 		System.out.println("V_CONTACT_MAN : " + V_CONTACT_MAN);

		
		e_cs = e_conn.prepareCall("{call dbo.USP_COVID_CHECK(?,?,?,?,?,?,?,?,?,?)}");
		e_cs.setString(1, V_USR_ID); //발행일
		e_cs.setString(2, V_DATE); // 
		e_cs.setString(3, ""); // 
		e_cs.setString(4, V_EXOTHERMIC); // 
		e_cs.setString(5, V_COUGH); // 
		e_cs.setString(6, V_THOAT); // 
		e_cs.setString(7, V_MORVE); // 
		e_cs.setString(8, V_PHLEGM); // 
		e_cs.setString(9, V_BREATHING); //
		e_cs.setString(10, V_CONTACT_MAN); //
		
		e_cs.executeUpdate();
		

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


