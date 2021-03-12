<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
 <%@ include file="/HSPF01/common/DB_SWM.jsp"%>

<%

	 request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		 	 System.out.println("품목정보등록SQL");
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

/*
		String V_TYPE = request.getParameter("V_TYPE");
		String u_item_cd = request.getParameter("u_item_cd");
		String u_item_nm = request.getParameter("u_item_nm");
		String u_m_bp_cd = request.getParameter("u_m_bp_cd");
		
		if(V_TYPE == "I"){
			cs = conn.prepareCall("call USP_AD_ITEM_REGISTER(?,?,?,?)");
			cs.setString(1, "I");
			cs.setString(2, V_BP_ITEM_CD);
			cs.setString(3, V_ITEM_CD);
			cs.setString(4, V_S_BP_CD);
			cs.setString(5, V_M_BP_CD);
			cs.setString(6, V_UNIT);
			cs.setString(7, V_SPEC);
			cs.setString(8, V_MID_QTY);
			cs.setString(9, V_MAX_QTY);
			cs.setString(10, V_S_PIRCE);
			cs.setString(11), V_M_PRICE);
			cs.setString(12, V_HSCODE);
			cs.setString(13, V_WEIGHT);
			cs.setString(14, V_USR_ID);
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			

			cs.execute();

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
		} */
		if(V_TYPE == "S"){
		
		//SQL 박혀있는것 SP로 수정.
		cs = conn.prepareCall("call USP_AD_ITEM_REGISTER(?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, u_item_cd);
		cs.setString(3, u_item_nm);
		cs.setString(4, u_m_bp_cd);
		cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(5);
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("u_item_cd", rs.getString("u_item_cd"));
			subObject.put("u_item_nm", rs.getString("u_item_nm"));
			subObject.put("u_m_bp_cd", rs.getString("u_m_bp_cd"));
			
			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close(); 
		}
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








