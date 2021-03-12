<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
 <%@ include file="/HSPF01/common/DB_Connection.jsp"%>


<%
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		//System.out.println("바코드생성SQL");
		String V_TYPE = request.getParameter("V_TYPE");
		String V_ASN_NO = request.getParameter("V_ASN_NO");
		String V_USR_ID = request.getParameter("V_USR_ID");

		// 	 System.out.println(V_TYPE);
		// 	 System.out.println(V_ASN_NO);
		// 	 System.out.println(V_USR_ID);

		cs = conn.prepareCall("{call USP_SUPP_BC_DEPLOY(?,?,?)}");
		cs.setString(1, V_TYPE);
		cs.setString(2, V_ASN_NO);
		cs.setString(3, V_USR_ID);

		cs.executeUpdate();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>








