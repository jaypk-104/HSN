<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="HSPLATFORM.HSCOMMON"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
	String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();

	try{
		
		
		String sql = "SELECT A.ITEM_CD, A.ITEM_NM, NVL (A.SPEC, '') SPEC, A.UNIT, NVL (A.AGENT, '') AGENT, NVL (A.MAKER, '') MAKER FROM B_ITEM_HSPF A "; 
				sql += "WHERE A.ITEM_CD LIKE '%" + V_ITEM_CD + "%' AND A.ITEM_NM LIKE '%" + V_ITEM_NM +"%'  ORDER BY A.ITEM_CD";
		rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			subObject = new JSONObject();
	
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("UNIT", rs.getString("UNIT"));
			subObject.put("AGENT", rs.getString("AGENT"));
			subObject.put("MAKER", rs.getString("MAKER"));
			jsonArray.add(subObject);
	
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
	
	
	// 	System.out.println(jsonObject);
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	}
	
	catch (Exception e) {

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

