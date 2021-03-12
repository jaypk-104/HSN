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
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@ include file="/HSPF01/common/DB_Connection_ERP_TEMP.jsp"%>
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
		
		
		if (V_TYPE.equals("WS")) {
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			String V_VESSEL_NM = request.getParameter("V_VESSEL_NM") == null ? "" : request.getParameter("V_VESSEL_NM").toUpperCase();
			String V_IN_NO = request.getParameter("V_IN_NO") == null ? "" : request.getParameter("V_IN_NO").toUpperCase();
			String V_TAX_DT = request.getParameter("V_TAX_DT") == null ? "" : request.getParameter("V_TAX_DT");
			String V_IN_DT = request.getParameter("V_IN_DT") == null ? "" : request.getParameter("V_IN_DT");
			String V_ACCEPT_DT = request.getParameter("V_ACCEPT_DT") == null ? "" : request.getParameter("V_ACCEPT_DT");
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD");
			
			if(V_TAX_DT.length() > 10){
				V_TAX_DT = V_TAX_DT.substring(0,10);
			}
			if(V_IN_DT.length() > 10){
				V_IN_DT = V_IN_DT.substring(0,10);
			}
			if(V_ACCEPT_DT.length() > 10){
				V_ACCEPT_DT = V_ACCEPT_DT.substring(0,10);
			}
			cs = conn.prepareCall("{call USP_M_BP_DUTY_CHARGE_H_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, V_VESSEL_NM); //
			cs.setString(4, V_IN_DT); //
			cs.setString(5, V_ITEM_NM); //
			cs.setString(6, ""); //
			cs.setString(7, V_BL_DOC_NO); //
			cs.setString(8, ""); //
			cs.setString(9, V_IN_NO); //
			cs.setString(10,V_TAX_DT ); //
			cs.setString(11,V_ACCEPT_DT ); //
			cs.setString(12, "" ); // 
			cs.setString(13, "" ); // 
			cs.setString(14, "00074" ); // 황보 BP_CD 고정
			cs.setString(15, "" ); // 
			cs.setString(16, V_USR_ID ); // 
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(17);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("TAX_DT", rs.getString("TAX_DT"));
				subObject.put("IN_NO", rs.getString("IN_NO"));
				subObject.put("TEMP_SL_NM", rs.getString("TEMP_SL_NM"));
				subObject.put("ACCEPT_DT", rs.getString("ACCEPT_DT"));
				subObject.put("ERP_YN", rs.getString("ERP_YN"));
				subObject.put("PAY_YN", rs.getString("PAY_YN"));
				
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
		else if (V_TYPE.equals("BPS")) {
			String G_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
			
			
			String sql = "select A.BP_CD, A.BP_NM, A.BP_RGST_NO REG_NO, replace(A.BP_RGST_NO,'-','') REG_NO2 from B_BIZ_PARTNER A ";
				sql += " where len(REPLACE(A.BP_RGST_NO, '-', '')) = 10 ";
// 				   sql += " LEFT OUTER JOIN M_BP_CHARGE_PARTNER B ON A.BP_CD = B.SELECT_BP_CD ";
// 				   sql += " where B.MAST_BP_CD = '"  + G_BP_CD +   "'  order by A.BP_NM";
			e_cs = e_conn.prepareCall("{call dbo.getData(?)}");
			e_cs.setString(1, sql); 
			
			rs = e_cs.executeQuery();
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DTL_CD", rs.getString("BP_CD"));
				subObject.put("DTL_NM", rs.getString("BP_NM"));
				subObject.put("REG_NO", rs.getString("REG_NO"));
				subObject.put("REG_NO2", rs.getString("REG_NO2"));
				
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


