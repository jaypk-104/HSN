<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		JSONObject jsonObject = new JSONObject();

		String sql = "";
		String V_MAST_CD = request.getParameter("V_MAST_CD") == null ? "" : request.getParameter("V_MAST_CD");
		String V_PARAM1 = request.getParameter("V_PARAM1") == null ? "" : request.getParameter("V_PARAM1");
		String V_PARAM2 = request.getParameter("V_PARAM2") == null ? "" : request.getParameter("V_PARAM2");
		String V_GRID = request.getParameter("V_GRID") == null ? "" : request.getParameter("V_GRID");

// 		System.out.println("V_GRID" + V_GRID);
// 		System.out.println("V_MAST_CD" + V_MAST_CD);

		sql = "SELECT PDATE, PRICE, CASE WHEN SUBSTR(RATE,1,1) = '-' THEN '-' || DIF ELSE DIF END DIF, RATE FROM RPA_NAVER_WTI ";
		
		
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("PDATE", rs.getString("PDATE"));
			subObject.put("PRICE", rs.getString("PRICE"));
			subObject.put("DIF", rs.getString("DIF"));
			subObject.put("RATE", rs.getString("RATE"));
			jsonArray.add(subObject);
		}
		
		
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonArray);
		pw.flush();
		pw.close();
			

	} 
	catch (Exception e) {
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
