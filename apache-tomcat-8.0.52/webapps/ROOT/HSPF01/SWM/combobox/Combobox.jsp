<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%-- <%@ include file="/HSPF01/common/DB_SWM.jsp"%> --%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
//     System.out.println("combobox jsp 타기 ");
    request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		JSONObject jsonObject = new JSONObject();

		String sql = "";
		String V_MAST_CD = request.getParameter("V_MAST_CD") == null ? "" : request.getParameter("V_MAST_CD");
		String V_PARAM1 = request.getParameter("V_PARAM1") == null ? "" : request.getParameter("V_PARAM1");
		String V_PARAM2 = request.getParameter("V_PARAM2") == null ? "" : request.getParameter("V_PARAM2");
		String V_GRID = request.getParameter("V_GRID") == null ? "" : request.getParameter("V_GRID");
		
// 		System.out.println("v_mast_cd : " + V_MAST_CD );
		
		if (!V_MAST_CD.equals("")) {
// 			if (V_MAST_CD.equals("C01")) {
			
				sql +=  "SELECT DTL_CD, DTL_NM FROM B_DTL_INFO WHERE MAST_CD = '" + V_MAST_CD + "' ORDER BY PRINT_SEQ";
				
// 			}
			rs = stmt.executeQuery(sql);
			
		}
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("DTL_CD", rs.getString("DTL_CD"));
			subObject.put("DTL_NM", rs.getString("DTL_NM"));
			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

//			System.out.println(sql);
//			System.out.println(jsonObject);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
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
