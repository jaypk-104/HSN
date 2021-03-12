<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/HSPF01/common/DB_Connection_ERP_KLNET.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		
		
		if (V_TYPE.equals("S")) {
			String V_CONTAINER_NO = request.getParameter("V_CONTAINER_NO") == null ? "" : request.getParameter("V_CONTAINER_NO");
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO");
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM");
			
			e_cs = e_conn.prepareCall("{call USP_CONTAINER_TRACKING_SELECT(?,?,?,?)}");
			e_cs.setString(1, V_TYPE); //
			e_cs.setString(2, V_CONTAINER_NO); //
			e_cs.setString(3, V_BL_DOC_NO); //
			e_cs.setString(4, V_M_BP_NM); //
			
			rs = e_cs.executeQuery();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("DOCK_YN", rs.getString("DOCK_YN"));
				subObject.put("BEEF_GR_YN", rs.getString("BEEF_GR_YN"));
				subObject.put("ERP_CC_YN", rs.getString("ERP_CC_YN"));
				subObject.put("ERP_GR_YN", rs.getString("ERP_GR_YN"));
				subObject.put("RETURN_DT", rs.getString("RETURN_DT"));
				subObject.put("CARRYOUT_DT", rs.getString("CARRYOUT_DT"));
				subObject.put("ACTUAL_RETURN_DT", rs.getString("ACTUAL_RETURN_DT"));
				subObject.put("ACTUAL_CARRYOUT_DT", rs.getString("ACTUAL_CARRYOUT_DT"));
				subObject.put("CONTAINER_NO", rs.getString("CONTAINER_NO"));
				
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
		else if (V_TYPE.equals("WS")) {
			String V_CONTAINER_NO = request.getParameter("V_CONTAINER_NO") == null ? "" : request.getParameter("V_CONTAINER_NO");
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO");
			
			e_cs = e_conn.prepareCall("{call USP_CONTAINER_TRACKING_SELECT(?,?,?,?)}");
			e_cs.setString(1, V_TYPE); //
			e_cs.setString(2, V_CONTAINER_NO); //
			e_cs.setString(3, V_BL_DOC_NO); //
			e_cs.setString(4, ""); //
			
			rs = e_cs.executeQuery();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CONTAINER_NO", rs.getString("CONTAINER_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("INOUTBOUND", rs.getString("INOUTBOUND"));
				subObject.put("DROP_TYPE", rs.getString("DROP_TYPE"));
				subObject.put("FULL_YN", rs.getString("FULL_YN"));
				subObject.put("MOTHER_SHIP", rs.getString("MOTHER_SHIP"));
				subObject.put("MV_DT", rs.getString("MV_DT"));
				subObject.put("SHIP_BP", rs.getString("SHIP_BP"));
				subObject.put("LOAD_PORT", rs.getString("LOAD_PORT"));
				subObject.put("LOAD_TERMINAL", rs.getString("LOAD_TERMINAL"));
				subObject.put("UNLOAD_PORT", rs.getString("UNLOAD_PORT"));
				subObject.put("UNLOAD_TERMINAL", rs.getString("UNLOAD_TERMINAL"));
				subObject.put("CAR_NO", rs.getString("CAR_NO"));
				subObject.put("RETURN_DT", rs.getString("RETURN_DT"));
				subObject.put("CARRYOUT_DT", rs.getString("CARRYOUT_DT"));
				
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
// 		jsonObject.put("success", false);
// 		jsonObject.put("resultList", e.printStackTrace());

// 		response.setContentType("text/plain; charset=UTF-8");
// 		PrintWriter pw = response.getWriter();
// 		pw.print(jsonObject);
// 		pw.flush();
// 		pw.close();
		
		
	} finally {
		
		//MSSQL
		if (e_cs != null) try {
			e_cs.close();
		} catch (SQLException ex) {}
		if (e_rs != null) try {
			e_rs.close();
		} catch (SQLException ex) {}
		if (e_stmt != null) try {
			e_stmt.close();
		} catch (SQLException ex) {}
		if (e_conn != null) try {
			e_conn.close();
		} catch (SQLException ex) {}
	}
%>


