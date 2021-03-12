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
	String V_USER_ID = request.getParameter("V_USER_ID") == null ? "^" : request.getParameter("V_USER_ID");
	String V_ROLE_CD = request.getParameter("V_ROLE_CD").equals("T") ? "" : request.getParameter("V_ROLE_CD");
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID");

	String strSp = "USP_Z_USR_INFO_HSPF";
	String strRetField = "COMP_ID|USR_ID|PASSWORD|USR_NM|BP_CD|BP_NM|DEPT_CD|DEPT_NM|";
		   strRetField += "POSIT_CD|POSIT_NM|ADDRESS|TEL_NO|FAX_NO|HAND_TEL|EMAIL|ROLE_CD|ROLE_NM|USE_YN";
		   strRetField += "|QUERY_ALL_YN|PRINT_YN|INSRT_YN"; //리턴 필드 정의
	String strParam = V_TYPE + "|" + V_COMP_ID + "|" + V_USER_ID + "|^|^|^|^|^|^|^|^|^|"+V_ROLE_CD+"|^|^|^|^|^|"; //파라미터 정의 : 필드 갯수와 순서를 맞춘다 문자가 공백일때 _ 사용
	int strOutNum = 19; //커서 RETURN 번호

// 	String debug_yn = "Y"; //DEBUG Y/N
	String debug_yn = "N"; //DEBUG Y/N
	jsonArray = dbcon.spSelect(strSp, strParam, strRetField, strOutNum, debug_yn);

	jsonObject.put("success", true);
	jsonObject.put("resultList", jsonArray);
	
// 	System.out.println(jsonObject);

	response.setContentType("text/plain; charset=UTF-8");
	PrintWriter pw = response.getWriter();
	pw.print(jsonObject);
	pw.flush();
	pw.close();
%>

