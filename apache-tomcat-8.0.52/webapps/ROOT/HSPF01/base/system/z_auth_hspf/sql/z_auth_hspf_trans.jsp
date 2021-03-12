<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbSpConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>

<%
	DbSpConn dbcon = new DbSpConn();
	request.setCharacterEncoding("utf-8");
	String data = request.getParameter("data");

	String S_TYPE = request.getParameter("S_TYPE") == null ? "^" : request.getParameter("S_TYPE").toUpperCase();
	String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID").toUpperCase();
	String V_ROLE_CD = request.getParameter("V_ROLE_CD") == null ? "^" : request.getParameter("V_ROLE_CD").toUpperCase();
	
	String strArrayField = "";
	String strField = "";
	String strSp = "USP_Z_AUTH_HSPF";
	String jsondata = URLDecoder.decode(data, "UTF-8");
	if(S_TYPE.equals("I")) {
		strArrayField = V_COMP_ID + "~2|" + V_ROLE_CD + "~3|" + V_USR_ID + "~6|";
		strField = "V_TYPE|PGM_ID|PGM_NM";
	} else if (S_TYPE.equals("D")) {
		strArrayField = V_COMP_ID + "~2|" + V_USR_ID + "~6|";
		strField = "V_TYPE|ROLE_CD|PGM_ID|PGM_NM";
	}
	int fieldCnt = 6; //저장 할 필드 갯수
	int strOutNum = 7; //out param 순번

	String debugYn = "Y"; //디버그 Y/N
	//String debugYn="N"; //디버그 Y/N
	String retVal = dbcon.spTrans(strSp, strField, strArrayField, jsondata, fieldCnt, strOutNum, debugYn);
%>