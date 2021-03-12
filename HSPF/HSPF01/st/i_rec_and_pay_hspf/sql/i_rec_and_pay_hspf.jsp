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
		String V_YYMM = request.getParameter("V_YYMM") == null ? "" : request.getParameter("V_YYMM").toString().substring(0,10);
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toString();
		cs = conn.prepareCall("call USP_I_STOCK_HSPF(?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_YYMM);//V_YYMM
		cs.setString(3, V_ITEM_CD);//V_ITEM_CD
		cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(4);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("BP_NM", rs.getString("BP_NM"));
			subObject.put("SL_NM", rs.getString("SL_NM"));
			subObject.put("STOCK_PRICE", rs.getString("STOCK_PRICE"));
			subObject.put("BF_QTY", rs.getString("BF_QTY"));
			subObject.put("BF_AMT", rs.getString("BF_AMT"));
			subObject.put("IN_QTY", rs.getString("IN_QTY"));
			subObject.put("IN_AMT", rs.getString("IN_AMT"));
			subObject.put("OUT_QTY", rs.getString("OUT_QTY"));
			subObject.put("OUT_AMT", rs.getString("OUT_AMT"));
			subObject.put("ET_QTY", rs.getString("ET_QTY"));
			subObject.put("ET_AMT", rs.getString("ET_AMT"));
			subObject.put("STOCK_QTY", rs.getString("STOCK_QTY"));
			subObject.put("STOCK_AMT", rs.getString("STOCK_AMT"));
			subObject.put("SPEC", rs.getString("SPEC"));

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
