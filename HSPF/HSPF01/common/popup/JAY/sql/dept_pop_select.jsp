<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="HSPLATFORM.HSCOMMON"%>
<%@page import="HSPLATFORM.DbConn"%>

<%
	DbConn dbcon = new DbConn();
	request.setCharacterEncoding("utf-8");
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String W_DEPT_CD = request.getParameter("W_DEPT_CD") == null ? "" : request.getParameter("W_DEPT_CD").toUpperCase();
	String W_DEPT_NM = request.getParameter("W_DEPT_NM") == null ? "" : request.getParameter("W_DEPT_NM").toUpperCase();
	String sql = "";

	sql = "SELECT DEPT_CD, DEPT_NM ";
	sql += "FROM B_DEPT_HSPF ";
	sql += "WHERE DEPT_CD LIKE '%" + W_DEPT_CD + "%' ";
	sql += "AND DEPT_NM LIKE '%" + W_DEPT_NM + "%';   ";

	String debug_yn = "N";
	String strField = "DEPT_CD|DEPT_NM"; //리턴필드 정의
	jsonArray = dbcon.select(sql, strField, debug_yn);

	jsonObject.put("success", true);
	jsonObject.put("resultList", jsonArray);

	response.setContentType("text/plain; charset=UTF-8");
	PrintWriter pw = response.getWriter();
	pw.print(jsonObject);
	pw.flush();
	pw.close();
%>

