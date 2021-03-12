<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toString();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toString();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toString();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toString();
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toString();
		

		System.out.println("V_TYPE : " + V_TYPE);
		System.out.println("V_COMP_ID : " + V_COMP_ID);
		System.out.println("V_ITEM_CD : " + V_ITEM_CD);
		System.out.println("V_ITEM_NM : " + V_ITEM_NM);
		System.out.println("V_SL_CD : " + V_SL_CD);

		cs = conn.prepareCall("call USP_I_STOCK_HSPF(?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);
		cs.setString(2, V_COMP_ID);
		cs.setString(3, V_ITEM_CD);
		cs.setString(4, V_ITEM_NM);
		cs.setString(5, V_SL_CD);
		cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(6);
		while (rs.next()) {
			subObject = new JSONObject();
// 			System.out.println(rs.getString("ITEM_CD"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SL_CD", rs.getString("SL_CD"));
			subObject.put("SL_NM", rs.getString("SL_NM"));
			subObject.put("QTY", rs.getString("ST_QTY"));
// 			subObject.put("PRICE", rs.getString("PRICE"));
			subObject.put("AMOUNT", rs.getString("ST_AMT"));
// 			subObject.put("BAR_YN", rs.getString("BAR_YN"));
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		System.out.println(jsonObject);

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
