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
<%@ include file="/HSPF01/common/DB_Connection_ERP_TEMP.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		JSONObject jsonObject = new JSONObject();

		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");

		if (V_TYPE.equals("XCH_RT")) {
			String V_DATE = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE");
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR");
			String XCH_RATE = "";
			
			e_cs = e_conn.prepareCall("{call USP_HSPF_XCH_RATE_SELECT(?,?)}");
			e_cs.setString(1, V_DATE);
			e_cs.setString(2, V_CUR);

			e_rs = e_cs.executeQuery();

			while (e_rs.next()) {
				XCH_RATE = e_rs.getString("STD_RATE");
			}
			
			if(XCH_RATE.length() == 0) {
				XCH_RATE = "NODATA";
			} 
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(XCH_RATE);
			pw.flush();
			pw.close();
		}
		else if(V_TYPE.equals("FORWARD_XCH_RT_DISTR")){
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO");
			String XCH_RATE = "";
			
			e_cs = e_conn.prepareCall("{call USP_HSPF_XCH_RATE_SELECT_CC_DISTB(?)}");
			e_cs.setString(1, V_BL_DOC_NO);

			e_rs = e_cs.executeQuery();

			while (e_rs.next()) {
				XCH_RATE = e_rs.getString("FORWARD_XCH");
			}
			
			if(XCH_RATE.length() == 0) {
				XCH_RATE = "NODATA";
			} 
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(XCH_RATE);
			pw.flush();
			pw.close();
		}

		

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

		//MSSQL
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
