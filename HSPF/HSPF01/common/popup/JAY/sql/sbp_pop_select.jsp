<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		/* 고객사검색 */
		String V_TYPE = "SBP";
		String V_BP_CD = request.getParameter("W_S_BP_CD") == null ? "" : request.getParameter("W_S_BP_CD").toUpperCase();
		String V_BP_NM = request.getParameter("W_S_BP_NM") == null ? "" : request.getParameter("W_S_BP_NM").toUpperCase();

		System.out.println("SBP");
		
		cs = conn.prepareCall("call USP_B_POPUP_HSPF(?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, "");//V_COMP_ID
		cs.setString(3, V_BP_CD);//V_BP_CD
		cs.setString(4, V_BP_NM);//V_BP_NM
		cs.setString(5, "");//V_ITEM_CD
		cs.setString(6, "");//V_ITEM_NM
		cs.setString(7, "");//V_DEPT_CD
		cs.setString(8, "");//V_DEPT_NM
		cs.setString(9, "");//V_USR_ID
		cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(10);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
			subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>

