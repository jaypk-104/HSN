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

		String V_TYPE = request.getParameter("V_TYPE");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD");
		String V_ITEM_NM = request.getParameter("V_ITEM_NM");
		String V_M_BP_NM = request.getParameter("V_M_BP_NM");

// 		System.out.println("v_type : " + V_TYPE);
// 		System.out.println("V_ITEM_CD : " + V_ITEM_CD);
		
		
		
		cs = conn.prepareCall("call USP_SWM_ITEM_SELECT(?,?,?,?)");
		cs.setString(1, V_ITEM_CD);
		cs.setString(2, V_ITEM_NM);
		cs.setString(3, V_M_BP_NM);
		cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
				
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(4);
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("UNIT", rs.getString("UNIT"));
			subObject.put("MID_PACK_QTY", rs.getString("MID_PACK_QTY"));
			subObject.put("MAX_PACK_QTY", rs.getString("MAX_PACK_QTY"));
			subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
			subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
			subObject.put("M_PRICE", rs.getString("M_PRICE"));
			subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
			subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
			subObject.put("S_PRICE", rs.getString("S_PRICE"));
			subObject.put("WEIGHT", rs.getString("WEIGHT"));
			subObject.put("PAL_QTY", rs.getString("PAL_QTY"));
			
			
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








