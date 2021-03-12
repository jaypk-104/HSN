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
	ResultSet rs1 = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		//MyViewport

		String u_lading_from_dt = request.getParameter("u_lading_from_dt");
		String u_lading_to_dt = request.getParameter("u_lading_to_dt");
		u_lading_from_dt = (u_lading_from_dt == null || u_lading_from_dt.equals("") ? "" : u_lading_from_dt.substring(0, 10));
		u_lading_to_dt = (u_lading_to_dt == null || u_lading_to_dt.equals("") ? "" : u_lading_to_dt.substring(0, 10));
		
		/*
		String sql = "SELECT BL_MGM_NO, BL_DOC_NO, BL_LOADING_DT, XCH_RT, CFM_YN, CC_DOC_NO ";
		sql += " FROM S_BL_HSNA_HDR ";
		sql += " WHERE BL_LOADING_DT>= '" + u_lading_from_dt + "' ";
		sql += " AND   BL_LOADING_DT<= '" + u_lading_to_dt + "' ";
		sql += " ORDER BY BL_LOADING_DT, BL_MGM_NO";

		rs = stmt.executeQuery(sql);
		*/
		
		cs = conn.prepareCall("call USP_S_BL_SELECT(?,?,?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, "");
		cs.setString(3, "");
		cs.setString(4, u_lading_from_dt);
		cs.setString(5, u_lading_to_dt);
		cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);

		cs.executeQuery();
		rs = (ResultSet) cs.getObject(6);
		
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("BL_MGM_NO", rs.getString("BL_MGM_NO"));
			subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
			subObject.put("BL_LOADING_DT", rs.getString("BL_LOADING_DT"));
			subObject.put("XCH_RT", rs.getString("XCH_RT"));
			subObject.put("CFM_YN", rs.getString("CFM_YN"));
			subObject.put("CC_DOC_NO", rs.getString("CC_DOC_NO"));
			subObject.put("SEND_YN", rs.getString("SEND_YN"));
			
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		// 	  System.out.println(jsonObject);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		
		if (rs1 != null) try {
			rs1.close();
		} catch (SQLException ex) {}
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
