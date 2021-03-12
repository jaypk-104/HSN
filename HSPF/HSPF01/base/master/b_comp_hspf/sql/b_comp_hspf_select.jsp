<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;

	try {
		request.setCharacterEncoding("utf-8");

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		String V_TYPE = request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_COMP_NM = request.getParameter("V_COMP_NM") == null ? "" : request.getParameter("V_COMP_NM");

// 		System.out.println("V_TYPE" + V_TYPE);
// 		System.out.println("V_COMP_ID" + V_COMP_ID);
// 		System.out.println("V_COMP_NM" + V_COMP_NM);

		cs = conn.prepareCall("call USP_B_COMP_HSPF(?,?,?,?,?,?)");
		cs.setString(1, V_TYPE); 
		cs.setString(2, V_COMP_ID); 
		cs.setString(3, V_COMP_NM); 
		cs.setString(4, ""); 
		cs.setString(5, ""); 
		cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(6);

		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("COMP_ID", rs.getString("COMP_ID"));
			subObject.put("COMP_NM", rs.getString("COMP_NM"));
			subObject.put("COMP_TYPE", rs.getString("COMP_TYPE"));
			subObject.put("COMP_TYPE_NM", rs.getString("COMP_TYPE_NM"));

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

