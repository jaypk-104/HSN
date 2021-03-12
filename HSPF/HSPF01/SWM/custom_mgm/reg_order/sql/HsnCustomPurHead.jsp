<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_SWM.jsp"%>

<%
	ResultSet rs = null;
	CallableStatement cs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		
		
		String crud = request.getParameter("crud");
		String s_req_no = request.getParameter("s_req_no");
		String bp_cd = request.getParameter("bp_cd");
		String bp_usr_id = request.getParameter("bp_usr_id");
		String so_dt = request.getParameter("so_dt");
		String dlvy_hop_dt = request.getParameter("dlvy_hop_dt");
		String usr_id = request.getParameter("usr_id");
		String remark = request.getParameter("remark");
		String goal_location = request.getParameter("goal_location");
		String ret_val = request.getParameter("ret_val");
		
		if(so_dt.length() > 10){
			so_dt = so_dt.substring(0,10);
		}
		if(dlvy_hop_dt.length() > 10){
			dlvy_hop_dt = dlvy_hop_dt.substring(0,10);
		}

		cs = conn.prepareCall("{call USP_S_REQ_HEADER_TRANS(?,?,?,?,?,?,?,?,?,?)}");

	   	cs.setString(1, crud);
	   	cs.setString(2, s_req_no);
	   	cs.setString(3,  bp_cd);
	   	cs.setString(4,  bp_usr_id);
	   	cs.setString(5,  so_dt);
	   	cs.setString(6,  dlvy_hop_dt);
	   	cs.setString(7,  usr_id);
	   	cs.setString(8,  remark);
	   	cs.setString(9,  goal_location);
	   	cs.registerOutParameter(10, Types.VARCHAR);
		
		cs.execute();
		
		subObject = new JSONObject();
		subObject.put("ret_val", cs.getString(10));
		
		jsonObject.put("success", true);
		jsonObject.put("resultList", subObject);
		
		
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
		if (rs != null) try {
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

