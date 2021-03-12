<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_PAL_QTY = request.getParameter("W_PAL_QTY") == null ? "" : request.getParameter("W_PAL_QTY").toUpperCase();
		String V_BOX_QTY = request.getParameter("W_BOX_QTY") == null ? "" : request.getParameter("W_BOX_QTY").toUpperCase();
		String V_LOT_QTY = request.getParameter("W_LOT_QTY") == null ? "" : request.getParameter("W_LOT_QTY").toUpperCase();

		cs = conn.prepareCall("call USP_003_SCM_BARCD_DIVISION_QTY_TOT_HSPF(?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);
		cs.setString(2, V_COMP_ID);
		cs.setString(3, V_ASN_NO);
		cs.setString(4, V_PAL_QTY); //V_PAL_QTY
		cs.setString(5, V_BOX_QTY); //V_BOX_QTY
		cs.setString(6, V_LOT_QTY); //V_LOT_QTY
		cs.setString(7, V_USR_ID); //V_USR_ID
		cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

	} catch (Exception e) {
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


