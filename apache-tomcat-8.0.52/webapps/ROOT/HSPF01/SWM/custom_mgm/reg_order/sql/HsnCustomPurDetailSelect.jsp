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

		String sql = " select a.s_req_no,s_req_seq,a.item_cd,b.item_nm, b.spec, b.maker, ";
		sql += " a.bp_item_cd,a.bp_item_nm,a.unit,a.so_qty,a.so_prc,a.so_amt,remark,dtl_location  ";
		sql += " ,to_char(dlvy_hope_dt,'YYYY-MM-DD') dlvy_hop_dt2  ";
		sql += "  from s_req_dtl_swm a inner join  b_item_swm b on a.item_cd=b.item_cd ";
		sql += " where 1=1  ";
		sql += " and s_req_no  = '" + s_req_no  +"' ";

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

