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
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	CallableStatement cs = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_PUR_SEQ = request.getParameter("V_PUR_SEQ") == null ? "" : request.getParameter("V_PUR_SEQ").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_PUR_FR_DT = request.getParameter("V_PUR_FR_DT") == null ? "" : request.getParameter("V_PUR_FR_DT").substring(0, 10);
		String V_PUR_TO_DT = request.getParameter("V_PUR_TO_DT") == null ? "" : request.getParameter("V_PUR_TO_DT").substring(0, 10);
		String V_PO_STS = request.getParameter("V_PO_STS") == "" ? "" : request.getParameter("V_PO_STS").toUpperCase();

		// 		System.out.println("V_PUR_FR_DT" + V_PUR_FR_DT);
		// 		System.out.println("V_PUR_TO_DT" + V_PUR_TO_DT);

		cs = conn.prepareCall("call USP_M_PUR_HSPF(?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_COMP_ID);//V_COMP_ID
		cs.setString(3, V_PUR_SEQ);//V_PUR_SEQ
		cs.setString(4, V_ITEM_CD);//V_ITEM_CD
		cs.setString(5, V_S_BP_NM);//V_S_BP_NM
		cs.setString(6, V_M_BP_NM);//V_M_BP_NM
		cs.setString(7, V_PUR_FR_DT);//V_PUR_FR_DT
		cs.setString(8, V_PUR_TO_DT);//V_PUR_TO_DT
		cs.setString(9, V_PO_STS);//V_PO_STS
		cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(10);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("PUR_NO", rs.getString("PUR_NO"));
			subObject.put("PUR_SEQ", rs.getString("PUR_SEQ"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
			subObject.put("BP_ITEM_NM", rs.getString("BP_ITEM_NM"));
			subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
			subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
			subObject.put("FR_TYPE", rs.getString("FR_TYPE"));
			subObject.put("FR_TYPE_NM", rs.getString("FR_TYPE_NM"));
			subObject.put("PUR_DT", rs.getString("PUR_DT"));
			subObject.put("PUR_QTY", rs.getString("PUR_QTY"));
// 			subObject.put("PO_NO", rs.getString("PO_NO"));
			subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
			subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
// 			subObject.put("PO_DT", rs.getString("PO_DT"));
			subObject.put("PO_QTY", rs.getString("PO_QTY"));
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

