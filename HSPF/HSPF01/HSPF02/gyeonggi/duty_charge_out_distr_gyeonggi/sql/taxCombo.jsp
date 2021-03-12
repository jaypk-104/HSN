<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		String V_MAST_CD = request.getParameter("V_MAST_CD") == null ? "" : request.getParameter("V_MAST_CD").toUpperCase();
		
		
		String sql = "select B.VAT_CD DTL_CD, B.VAT_NAME DTL_NM from M_BP_CHARGE_VAT_H_INFO A ";
			sql += "LEFT OUTER JOIN M_BP_CHARGE_VAT_D_INFO B ON A.VAT_CD = B.VAT_CD ";
			sql += "where A.MAST_CD = 'DUTY_CHARGE_OUT_DISTR_GYEONGGI' ";
		
// 		e_cs = e_conn.prepareCall("{call dbo.getData(?)}");
// 		e_cs.setString(1, sql); 
// 		rs = e_cs.executeQuery();

		rs = stmt.executeQuery(sql);
		
		
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("DTL_CD", rs.getString("DTL_CD"));
			subObject.put("DTL_NM", rs.getString("DTL_NM"));
			
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


