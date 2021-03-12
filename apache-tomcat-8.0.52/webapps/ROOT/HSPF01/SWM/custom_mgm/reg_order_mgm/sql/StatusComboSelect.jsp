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
		
		
		String bp_cd = request.getParameter("bp_cd");
		String bp_item_cd = request.getParameter("bp_item_cd");
		String item_cd = request.getParameter("item_cd");
		String item_nm = request.getParameter("item_nm");
		String spec = request.getParameter("spec");
		String maker = request.getParameter("maker");
		String bp_item_nm = request.getParameter("bp_item_nm");
		String s_req_no = request.getParameter("s_req_no");
		String status = request.getParameter("status");
		String cmf_yn = request.getParameter("cmf_yn");
		String dlvy_hop_dt_fr = request.getParameter("dlvy_hop_dt_fr");
		String dlvy_hop_dt_to = request.getParameter("dlvy_hop_dt_to");
		
		if(dlvy_hop_dt_fr.length() > 10){
			dlvy_hop_dt_fr = dlvy_hop_dt_fr.substring(0,10);
		}
		if(dlvy_hop_dt_to.length() > 10){
			dlvy_hop_dt_to = dlvy_hop_dt_to.substring(0,10);
		}

		String sql = " SELECT '' crud_flag, ";
		sql += " MAST_CD MAST_CD, ";
		sql += " DTL_CD DTL_CD,  ";
		sql += " DTL_NM DTL_NM, ";
		sql += " DTL_NM_ENG DTL_NM_ENG  ";
		sql += " FROM B_DTL_INFO ";
		sql += " where 1=1  ";
		sql += "   ";


// 		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("s_req_no", rs.getString("s_req_no"));
			subObject.put("s_req_seq", rs.getString("s_req_seq"));
			subObject.put("item_cd", rs.getString("item_cd"));
			subObject.put("item_nm", rs.getString("item_nm"));
			subObject.put("bp_item_cd", rs.getString("bp_item_cd"));
			subObject.put("bp_item_nm", rs.getString("bp_item_nm"));
			subObject.put("spec", rs.getString("spec"));
			subObject.put("maker", rs.getString("maker"));
			subObject.put("unit", rs.getString("unit"));
			subObject.put("so_qty", rs.getString("so_qty"));
			subObject.put("so_prc", rs.getString("so_prc"));
			subObject.put("so_amt", rs.getString("so_amt"));
			subObject.put("dlvy_hop_dt2", rs.getString("dlvy_hop_dt2"));
			
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

