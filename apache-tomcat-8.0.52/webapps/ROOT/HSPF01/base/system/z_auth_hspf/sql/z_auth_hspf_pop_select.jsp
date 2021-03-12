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

	String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");

	if (V_TYPE.equals("P")) { //미등록팝업조회
		String V_ROLE_CD = request.getParameter("V_ROLE_CD") == null ? "^" : request.getParameter("V_ROLE_CD").toUpperCase();
		String V_P_PGM_ID = request.getParameter("V_P_PGM_ID") == null ? "^" : request.getParameter("V_P_PGM_ID").toUpperCase();
		String V_P_PGM_NM = request.getParameter("V_P_PGM_NM") == null ? "^" : request.getParameter("V_P_PGM_NM").toUpperCase();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID");

		String strSp = "USP_Z_AUTH_HSPF";
		String strRetField = "PGM_ID|PGM_NM"; //리턴 필드 정의
		String strParam = V_TYPE + "|" + V_COMP_ID + "|" + V_ROLE_CD + "|" + V_P_PGM_ID + "|" + V_P_PGM_NM + "|" + "^"; //파라미터 정의 : 필드 갯수와 순서를 맞춘다 문자가 공백일때 _ 사용
		int strOutNum = 7; //커서 RETURN 번호

		// 				String debug_yn = "Y"; //DEBUG Y/N
		String debug_yn = "N";
		jsonArray = dbcon.spSelect(strSp, strParam, strRetField, strOutNum, debug_yn);

	} else { //롤조회
		String V_P_ROLE_CD = request.getParameter("V_P_ROLE_CD") == null ? "" : request.getParameter("V_P_ROLE_CD").toUpperCase();
		String V_P_ROLE_NM = request.getParameter("V_P_ROLE_NM") == null ? "" : request.getParameter("V_P_ROLE_NM").toUpperCase();
		String sql = "";

		sql = "SELECT  ROLE_CD, ROLE_NM ";
		sql += "FROM    Z_ROLE_HSPF       ";
		sql += "WHERE   ROLE_CD LIKE '%" + V_P_ROLE_CD + "%' ";
		sql += "AND     ROLE_NM LIKE '%" + V_P_ROLE_NM + "%';";

		String debug_yn = "Y";
		String strField = "ROLE_CD|ROLE_NM"; //리턴필드 정의
		jsonArray = dbcon.select(sql, strField, debug_yn);
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		
	}

	jsonObject.put("success", true);
	jsonObject.put("resultList", jsonArray);

	response.setContentType("text/plain; charset=UTF-8");
	PrintWriter pw = response.getWriter();
	pw.print(jsonObject);
	pw.flush();
	pw.close();
%>

