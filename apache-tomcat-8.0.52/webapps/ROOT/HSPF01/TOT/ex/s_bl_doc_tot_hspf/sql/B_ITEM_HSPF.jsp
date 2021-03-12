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
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
	String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
	
	try {
		String sql = ""; 
		sql += " SELECT A.ITEM_CD, A.ITEM_ENG_NM ITEM_NM, A.UNIT, A.HS_CD, A.ORIGIN, ";
		sql += " A.ITEM_CD || ' (' || A.ITEM_ENG_NM || ')' ITEM_DESC, ";
		sql += " CASE WHEN UPPER(A.UNIT)='KG' THEN 1 ELSE NVL(A.UNIT_WGT,0) END UNIT_WGT, ";
		sql += " A.PILAMENT_CD, B.PRICE ";
		sql += " FROM B_ITEM_HSPF A LEFT OUTER JOIN M_BP_ITEM_HSPF B ";
		sql += " ON A.ITEM_CD = B.ITEM_CD ";
		sql += " WHERE A.ITEM_CD LIKE '%' || '" + V_ITEM_CD + "' || '%' " ;
		sql += " AND A.USE_YN = 'Y' " ;
		
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("UNIT", rs.getString("UNIT"));
			subObject.put("HS_CD", rs.getString("HS_CD"));
			subObject.put("ORIGIN", rs.getString("ORIGIN"));
			subObject.put("UNIT_WGT", rs.getString("UNIT_WGT"));
			subObject.put("PILAMENT_CD", rs.getString("PILAMENT_CD"));
			subObject.put("PRICE", rs.getString("PRICE"));
			subObject.put("ITEM_DESC", rs.getString("ITEM_DESC"));
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

	} catch (Exception e) {

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

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


