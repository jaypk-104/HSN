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
<%@page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	//DbSpConn dbcon = new DbSpConn();
	//HSCOMMON dbcomm = new HSCOMMON();
	ResultSet rs = null;
	CallableStatement cs = null;
	
	
	request.setCharacterEncoding("utf-8");
	String data = request.getParameter("data");

	String S_TYPE = request.getParameter("S_TYPE") == null ? "^" : request.getParameter("S_TYPE").toUpperCase();
	String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID").toUpperCase();
	
	cs = conn.prepareCall("call USP_B_BIZ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	cs.setString(1, ""); 
	cs.setString(2, ""); 
	cs.setString(3, ""); 
	cs.setString(4, ""); 
	cs.setString(5, ""); 
	cs.setString(6, ""); 
	cs.setString(7, ""); 
	cs.setString(8, ""); 
	cs.setString(9, V_USR_ID); 
	cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);

	cs.executeQuery();

	
	/*
	String strArrayField = "";
	String strField = "";
	String strSp = "USP_B_BIZ_HSPF";
	String jsondata = URLDecoder.decode(data, "UTF-8");

	strArrayField = V_USR_ID + "~9|";
	strField = "V_TYPE|BP_CD|BP_NM|ADDRESS|TEL_NO|FAX_NO|EMAIL|BIZ_TYPE";

	int fieldCnt = 9; //저장 할 필드 갯수
	int strOutNum = 10; //out param 순번

	// 	String debugYn = "T"; //디버그 Y/N
	String debugYn = "N"; //디버그 Y/N
	String retVal = dbcon.spTrans(strSp, strField, strArrayField, jsondata, fieldCnt, strOutNum, debugYn);
	*/
	
%>