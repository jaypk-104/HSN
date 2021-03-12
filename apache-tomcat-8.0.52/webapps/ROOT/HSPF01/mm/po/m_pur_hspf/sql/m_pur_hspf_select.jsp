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
	String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID").toUpperCase();
	String V_PO_FR_DT = request.getParameter("V_PO_FR_DT") == null ? "^" : request.getParameter("V_PO_FR_DT").substring(0, 10);
	String V_PO_TO_DT = request.getParameter("V_PO_TO_DT") == null ? "^" : request.getParameter("V_PO_TO_DT").substring(0, 10);
	String V_PO_STS = request.getParameter("V_PO_STS") == "" ? "^" : request.getParameter("V_PO_STS").toUpperCase();
	String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "^" : request.getParameter("V_ITEM_CD").toUpperCase();
	String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "^" : request.getParameter("V_S_BP_CD").toUpperCase();
	String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "^" : request.getParameter("V_M_BP_CD").toUpperCase();

// 	System.out.println("V_PO_STS" + V_PO_STS);

	String strSp = "USP_M_PUR_HSPF";
	String strRetField = "PUR_NO|PUR_SEQ|ITEM_CD|ITEM_NM|BP_ITEM_CD|BP_ITEM_NM|S_BP_CD|S_BP_NM|";
	strRetField += "FR_TYPE|FR_TYPE_NM|PUR_DT|PUR_QTY|PO_NO|M_BP_CD|M_BP_NM|PO_DT|PO_QTY";
	String strParam = V_TYPE + "|" + V_COMP_ID + "|^|" + V_ITEM_CD + "|" + V_S_BP_CD + "|" + V_M_BP_CD;
	strParam += "|" + V_PO_FR_DT + "|" + V_PO_TO_DT + "|" + V_PO_STS + "|";
	int strOutNum = 10; //커서 RETURN 번호

	// 		String debug_yn = "Y"; //DEBUG Y/N
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

