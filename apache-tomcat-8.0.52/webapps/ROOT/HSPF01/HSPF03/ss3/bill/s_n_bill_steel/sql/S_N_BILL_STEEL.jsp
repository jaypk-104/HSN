<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").toUpperCase().substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase().substring(0, 10);
		String V_ITS_NO = request.getParameter("V_ITS_NO") == null ? "" : request.getParameter("V_ITS_NO").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_001_S_N_BILL_STEEL(?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DN_DT_FR);//V_DN_DT_FR
			cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO 
			cs.setString(5, V_ITS_NO);//V_ITS_NO 
			cs.setString(6, V_S_BP_NM);//V_S_BP_NM
			cs.setString(7, V_ITEM_CD);//V_ITEM_CD 
			cs.setString(8, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(9);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("ITS_NO", rs.getString("ITS_NO"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("N_BILL_QTY", rs.getString("N_BILL_QTY"));
				subObject.put("REMARK", rs.getString("REMARK"));

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
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

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


