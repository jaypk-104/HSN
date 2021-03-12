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
	//CREATE
	DbSpConn dbcon = new DbSpConn();
	HSCOMMON dbcomm = new HSCOMMON();
	request.setCharacterEncoding("utf-8");
	String data = request.getParameter("data");
	String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID").toUpperCase();
	String Q_TYPE = request.getParameter("Q_TYPE") == null ? "" : request.getParameter("Q_TYPE").toUpperCase();

	String strArrayField = "";
	String strField = "";
	String strSp = "USP_B_ITEM_SUPP_HSPF";
	String jsondata = URLDecoder.decode(data, "UTF-8");

	// 	System.out.println("CREATE");
	if (Q_TYPE.equals("D")) {
		strArrayField = "D" + "~1|" + V_COMP_ID + "~2|" + V_USR_ID + "~8|";
	} else {
		strArrayField = "I" + "~1|" + V_COMP_ID + "~2|" + V_USR_ID + "~8|";
	}
	strField = "ITEM_CD|ITEM_NM|BP_CD|VALID_DT|M_PRICE";

	int fieldCnt = 8; //저장 할 필드 갯수
	int strOutNum = 9; //out param 순번

	// 		String debugYn = "T"; //디버그 Y/N
	// 	String debugYn = "Y"; //디버그 Y/N
	String debugYn = "N"; //디버그 Y/N
	String retVal = dbcon.spTrans(strSp, strField, strArrayField, jsondata, fieldCnt, strOutNum, debugYn);
%>