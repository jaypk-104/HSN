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
	JSONArray jsonArray = null;
	JSONObject subObject = null;
	JSONParser parser = new JSONParser();
	ResultSet rs = null;
	String sql = null;

	try {

		String V_COMP_ID = "HSN";
		String V_TYPE = request.getParameter("V_TYPE");
		String V_USR_ID = request.getParameter("V_USR_ID");
		
		if (V_TYPE.equals("I") || V_TYPE.equals("D")) {
			String V_BILL_NO = request.getParameter("V_BILL_NO");
			String V_BC_NO = request.getParameter("V_BC_NO");
			
			cs = conn.prepareCall("call USP_A_MS_TO_AR_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, V_BC_NO);//V_BC_NO
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
		}
	} catch (Exception e) {
		e.printStackTrace();
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