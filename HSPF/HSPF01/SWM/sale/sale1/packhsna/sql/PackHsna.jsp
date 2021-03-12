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

		//MyViewport
		String u_lading_from_dt = request.getParameter("u_lading_from_dt").substring(0, 10);
		String u_lading_to_dt = request.getParameter("u_lading_to_dt").substring(0, 10);

		/*
		String sql = "SELECT INV_MGM_NO,INV_NO,VESSEL_NM,LOAD_DT,CFM_YN FROM S_INVOICE_HSNA_HDR ";
				sql += "WHERE LOAD_DT>='"+u_lading_from_dt+"' AND LOAD_DT<='"+u_lading_to_dt+"'";
				sql += "ORDER BY LOAD_DT,INV_MGM_NO";
		rs = stmt.executeQuery(sql);
		 */

		cs = conn.prepareCall("call USP_S_INV_SELECT(?,?,?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, "");
		cs.setString(3, u_lading_from_dt);
		cs.setString(4, u_lading_to_dt);
		cs.setString(5, "");
		cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);

		cs.executeQuery();
		rs = (ResultSet) cs.getObject(6);

		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("INV_MGM_NO", rs.getString("INV_MGM_NO"));
			subObject.put("INV_NO", rs.getString("INV_NO"));
			subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
			subObject.put("LOAD_DT", (rs.getString("LOAD_DT") == null ? "" : rs.getString("LOAD_DT").substring(0, 10)));
			subObject.put("CFM_YN", rs.getString("CFM_YN"));
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
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>
