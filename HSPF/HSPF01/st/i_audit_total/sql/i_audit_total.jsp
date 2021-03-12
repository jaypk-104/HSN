<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_AUDIT_DT = request.getParameter("V_AUDIT_DT") == null ? "" : request.getParameter("V_AUDIT_DT").substring(0, 10);
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");
		if(V_SL_CD.equals("T")) {
			V_SL_CD = "";
		}
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
		String V_CHK = request.getParameter("V_CHK") == null ? "" : request.getParameter("V_CHK");

		if(V_CHK.equals("true")) {
			V_CHK = "N";
		} else {
			V_CHK = "";
		}
		
		cs = conn.prepareCall("call USP_I_AUDIT_TOTAL_HSPF(?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_COMP_ID);//V_COMP_ID
		cs.setString(3, V_AUDIT_DT);//V_AUDIT_DT
		cs.setString(4, V_ITEM_CD);//V_M_BP_NM
		cs.setString(5, V_ITEM_NM);//V_ITEM_NM
		cs.setString(6, V_SL_CD);//V_SL_CD
		cs.setString(7, V_CHK);//V_CHK
		cs.setString(8, V_USR_ID);//V_USR_ID
		cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(9);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SL_NM", rs.getString("SL_NM"));
			subObject.put("LOC_NM", rs.getString("LOC_NM"));
			subObject.put("RACK_NM", rs.getString("RACK_NM"));
			subObject.put("SYS_QTY", rs.getString("SYS_QTY"));
			subObject.put("AUDIT_QTY", rs.getString("AUDIT_QTY"));
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

// 		System.out.println(jsonObject);

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



