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
	String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toUpperCase();
	String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
	
	try {
		String sql = "";
		
		if(V_TYPE.equals("COST")){
			sql += " SELECT COST_CD, COST_NM FROM B_COST_CENTER@HSN_LINK ";
			sql += " WHERE DEPT_CD LIKE '%'|| '" + V_DEPT_CD + "' ||'%' ORDER BY COST_CD ";
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				jsonArray.add(subObject);
			}	
		} else if(V_TYPE.equals("DEPT")){
			sql += " SELECT DEPT_CD, DEPT_NM FROM B_DEPT_HSPF ";
			sql += " WHERE DEPT_CD >= 1000 ORDER BY DEPT_CD ";
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				jsonArray.add(subObject);
			}	
		} else {
			
			if(V_TYPE.equals("BANK")){
				sql += " SELECT BANK_CD DTL_CD, BANK_NM DTL_NM FROM B_BANK ";
				sql += " ORDER BY BANK_CD ";
				
			} else if(V_TYPE.equals("CUR")){
				sql += " SELECT DTL_CD, DTL_NM FROM B_DTL_INFO ";
				sql += " WHERE MAST_CD = 'BA04' ";
				sql += " ORDER BY PRINT_SEQ ";
				
			}
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DTL_CD", rs.getString("DTL_CD"));
				subObject.put("DTL_NM", rs.getString("DTL_NM"));
				jsonArray.add(subObject);
			}	
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


