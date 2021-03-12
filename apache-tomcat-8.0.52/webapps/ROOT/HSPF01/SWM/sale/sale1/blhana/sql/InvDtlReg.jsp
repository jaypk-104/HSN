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
		String V_BL_MGM_NO = request.getParameter("V_BL_MGM_NO");
		/*
		String sql = "SELECT DISTINCT A.INV_MGM_NO, B.INV_NO, B.VESSEL_NM, B.LOAD_DT ";
		sql += " FROM S_BL_HSNA_DTL A, S_INVOICE_HSNA_HDR B ";
		sql += " WHERE A.INV_MGM_NO = B.INV_MGM_NO ";
		sql += " AND A.BL_MGM_NO ='" + V_BL_MGM_NO + "'";
		
		rs = stmt.executeQuery(sql);
		*/
		
		cs = conn.prepareCall("call USP_S_BL_SELECT(?,?,?,?,?,?)");
		cs.setString(1, "S_REG_DTL");
		cs.setString(2, V_BL_MGM_NO);
		cs.setString(3, "");
		cs.setString(4, "");
		cs.setString(5, "");
		cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);

		cs.executeQuery();
		rs = (ResultSet) cs.getObject(6);
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("INV_MGM_NO", rs.getString("INV_MGM_NO"));
			subObject.put("INV_NO", rs.getString("INV_NO"));
			subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
 			subObject.put("LOAD_DT", rs.getString("LOAD_DT") == null || rs.getString("LOAD_DT").equals("") ? "" : rs.getString("LOAD_DT").substring(0, 10));
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
