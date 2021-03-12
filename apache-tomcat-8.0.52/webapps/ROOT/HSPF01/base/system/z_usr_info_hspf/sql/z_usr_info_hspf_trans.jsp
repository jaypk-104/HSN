<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.HSCOMMON"%>
<%@page import="HSPLATFORM.DbSpConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>

<%
	DbSpConn dbcon = new DbSpConn();
	HSCOMMON dbcomm = new HSCOMMON();
	request.setCharacterEncoding("utf-8");
	String data = request.getParameter("data");

	String S_TYPE = request.getParameter("S_TYPE") == null ? "^" : request.getParameter("S_TYPE").toUpperCase();
	String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID").toUpperCase();
	String V_ROLE_CD = request.getParameter("V_ROLE_CD") == null ? "^" : request.getParameter("V_ROLE_CD").toUpperCase();
	
	String strArrayField = "";
	String strField = "";
	String strSp = "USP_Z_USR_INFO_HSPF";
	String jsondata = URLDecoder.decode(data, "UTF-8");
	if(S_TYPE.equals("U")) {
		strArrayField = V_USR_ID + "~17|";
		strField = "V_TYPE|COMP_ID|USR_ID|PASSWORD|BP_CD|DEPT_CD|POST_CD|"; //^AUTH
		strField += "ADDRESS|TEL_NO|FAX_NO|HAND_TEL|EMAIL|ROLE_CD|USE_YN|QUERY_ALL_YN|";
		strField += "PRINT_YN|INSRT_YN";
	} else if (S_TYPE.equals("P")) {
		String V_USER_ID = request.getParameter("V_USER_ID") == null ? "^" : request.getParameter("V_USER_ID").toUpperCase();
		String PASSWORD = dbcomm.encrypt(V_USER_ID + 1234);
		
		strArrayField = PASSWORD + "~4|" +V_USR_ID + "~17|";
		strField = "V_TYPE|COMP_ID|USR_ID|BP_CD|DEPT_CD|POST_CD|"; 
		strField += "ADDRESS|TEL_NO|FAX_NO|HAND_TEL|EMAIL|ROLE_CD|USE_YN|QUERY_ALL_YN|";
		strField += "PRINT_YN|INSRT_YN";
	}
	int fieldCnt = 18; //저장 할 필드 갯수
	int strOutNum = 19; //out param 순번

// 	String debugYn = "T"; //디버그 Y/N
	String debugYn="N"; //디버그 Y/N
	String retVal = dbcon.spTrans(strSp, strField, strArrayField, jsondata, fieldCnt, strOutNum, debugYn);
%>