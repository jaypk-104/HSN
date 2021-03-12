<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_SWM.jsp"%>

<%
	ResultSet rs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		
		
		String s_req_no = request.getParameter("s_req_no");

		String sql = " select S_REQ_NO,TO_CHAR(DLVY_HOP_DT,'YYYY-MM-DD') AS DLVY_HOP_DT,TO_CHAR(DLVY_CFM_DT,'YYYY-MM-DD') AS DLVY_CFM_DT,CMF_YN,REMARK,GOAL_LOCATION from s_req_hdr_swm  ";
		sql += " where 1=1  ";
		sql += " and s_req_no  = '" + s_req_no  +"' ";

// 		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("dlvy_hop_dt", rs.getString("DLVY_HOP_DT"));
			subObject.put("remark", rs.getString("REMARK"));
			subObject.put("dlvy_cfm_dt", rs.getString("DLVY_CFM_DT"));
			subObject.put("cmf_yn", rs.getString("CMF_YN"));
			subObject.put("goal_location", rs.getString("GOAL_LOCATION"));
			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		

		// 		System.out.println(jsonString);

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
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>

