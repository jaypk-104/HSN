<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>

<%
	DbConn dbcon = new DbConn();
	request.setCharacterEncoding("utf-8");
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String V_TYPE = request.getParameter("V_TYPE") == null ? "^" : request.getParameter("V_TYPE");
	String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID");
	String V_ROLE_CD = request.getParameter("V_ROLE_CD") == null ? "^" : request.getParameter("V_ROLE_CD");
	String V_PGM_ID = request.getParameter("V_PGM_ID") == null ? "^" : request.getParameter("V_PGM_ID");
	String V_PGM_NM = request.getParameter("V_PGM_NM") == null ? "^" : request.getParameter("V_PGM_NM");
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID");

	String strSp = "USP_Z_AUTH_HSPF";
	String strRetField = "ROLE_CD|ROLE_NM|PGM_ID|PGM_NM"; //리턴 필드 정의
	String strParam = V_TYPE + "|" + V_COMP_ID + "|" + V_ROLE_CD + "|" + V_PGM_ID + "|" + V_PGM_NM + "|" + V_USR_ID; //파라미터 정의 : 필드 갯수와 순서를 맞춘다 문자가 공백일때 _ 사용
	int strOutNum = 7; //커서 RETURN 번호

// 	String debug_yn = "Y"; //DEBUG Y/N
	String debug_yn = "N"; //DEBUG Y/N
	jsonArray = dbcon.spSelect(strSp, strParam, strRetField, strOutNum, debug_yn);
	response.setContentType("text/plain; charset=UTF-8");
// 	System.out.println(jsonArray);

	jsonObject.put("success", true);
	jsonObject.put("resultList", jsonArray);
	
// 	System.out.println(jsonObject);

	response.setContentType("text/plain; charset=UTF-8");
	PrintWriter pw = response.getWriter();
	pw.print(jsonObject);
	pw.flush();
	pw.close();
%>

