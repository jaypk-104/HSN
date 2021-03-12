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
	//UPDATE
	//DbSpConn dbcon = new DbSpConn();
	//HSCOMMON dbcomm = new HSCOMMON();
	ResultSet rs = null;
	CallableStatement cs = null;
	
	
	try{
		request.setCharacterEncoding("utf-8");
		String data = request.getParameter("data");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null
				? "^"
				: request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null
				? "^"
				: request.getParameter("V_USR_ID").toUpperCase();

		String Q_TYPE = request.getParameter("Q_TYPE") == null ? "" : request.getParameter("Q_TYPE").toUpperCase();
		String V_TYPE = "";
		
		if (Q_TYPE.equals("D")) {
			V_TYPE = "D";
		}
		else{
			V_TYPE = "U";
		}
		
		cs = conn.prepareCall("call USP_B_ITEM_SALE_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE); 
		cs.setString(2, V_COMP_ID); 
		cs.setString(3, ""); 
		cs.setString(4, ""); 
		cs.setString(5, ""); 
		cs.setString(6, ""); 
		cs.setString(7, ""); 
		cs.setString(8, ""); 
		cs.setString(9, ""); 
		cs.setString(10, V_USR_ID); 
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();

		
		/*
		String strArrayField = "";
		String strField = "";
		String strSp = "USP_B_ITEM_SALE_HSPF";
		String jsondata = URLDecoder.decode(data, "UTF-8");

		if (Q_TYPE.equals("D")) {
			strArrayField = "D" + "~1|" + V_COMP_ID + "~2|" + V_USR_ID + "~10|";
		} else {
			strArrayField = "U" + "~1|" + V_COMP_ID + "~2|" + V_USR_ID + "~10|";
		}
		strField = "ITEM_CD|ITEM_NM|BP_CD|BP_ITEM_CD|BP_ITEM_NM|VALID_DT|S_PRICE";

		int fieldCnt = 10; //저장 할 필드 갯수
		int strOutNum = 11; //out param 순번

		// 		String debugYn = "T"; //디버그 Y/N
		String debugYn = "Y"; //디버그 Y/N
		// 	String debugYn = "N"; //디버그 Y/N
		String retVal = dbcon.spTrans(strSp, strField, strArrayField, jsondata, fieldCnt, strOutNum, debugYn);
		*/
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
	
	
%>