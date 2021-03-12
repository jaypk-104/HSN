<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>


<%
	//DbConn dbcon = new DbConn();
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	
	try{
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		String V_TYPE = request.getParameter("V_TYPE") == null ? "^" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "^" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		
		cs = conn.prepareCall("call USP_B_ITEM_SALE_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE); 
		cs.setString(2, V_COMP_ID); 
		cs.setString(3, V_ITEM_CD); 
		cs.setString(4, V_ITEM_NM); 
		cs.setString(5, V_BP_CD); 
		cs.setString(6, ""); 
		cs.setString(7, ""); 
		cs.setString(8, ""); 
		cs.setString(9, ""); 
		cs.setString(10, ""); 
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();
		
		rs = (ResultSet) cs.getObject(11);

		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("COMP_ID", rs.getString("COMP_ID"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
			subObject.put("BP_ITEM_NM", rs.getString("BP_ITEM_NM"));
			subObject.put("BP_CD", rs.getString("BP_CD"));
			subObject.put("BP_NM", rs.getString("BP_NM"));
			subObject.put("VALID_DT", rs.getString("VALID_DT"));
			subObject.put("S_PRICE", rs.getString("S_PRICE"));

			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		
		/*

		String strSp = "USP_B_ITEM_SALE_HSPF";
		String strRetField = "COMP_ID|ITEM_CD|ITEM_NM|BP_ITEM_CD|BP_ITEM_NM|BP_CD|BP_NM|VALID_DT|S_PRICE|";
		String strParam = V_TYPE + "|" + V_COMP_ID + "|" + V_ITEM_CD + "|" + V_ITEM_NM + "|" + V_BP_CD + "|^|^|^|^|^|";
		int strOutNum = 11; //커서 RETURN 번호

		// 	String debug_yn = "Y"; //DEBUG Y/N
		String debug_yn = "N"; //DEBUG Y/N
		jsonArray = dbcon.spSelect(strSp, strParam, strRetField, strOutNum, debug_yn);

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		// 	System.out.println(jsonObject);
		*/
		
		
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
		
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

