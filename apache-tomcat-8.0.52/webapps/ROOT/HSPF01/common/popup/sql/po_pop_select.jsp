<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="HSPLATFORM.HSCOMMON"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	ResultSet rs = null;
	CallableStatement cs = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toUpperCase();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String W_PO_NO1 = request.getParameter("W_PO_NO1") == null ? "" : request.getParameter("W_PO_NO1").toUpperCase();
		String V_BP_CD = request.getParameter("W_M_BP_CD_PO") == null ? "" : request.getParameter("W_M_BP_CD_PO").toUpperCase();
		String V_BP_NM = request.getParameter("W_M_BP_NM_PO") == null ? "" : request.getParameter("W_M_BP_NM_PO").toUpperCase();
		String W_PO_DT_FROM = request.getParameter("W_PO_DT_FROM") == null ? "" : request.getParameter("W_PO_DT_FROM").substring(0, 10);
		String W_PO_DT_TO = request.getParameter("W_PO_DT_TO") == null ? "" : request.getParameter("W_PO_DT_TO").substring(0, 10);

		// 		System.out.println("W_PO_NO1" + W_PO_NO1);
		// 		System.out.println("V_TYPE" + V_TYPE);
		// 		System.out.println("V_BP_NM" + V_BP_NM);
		// 		System.out.println("W_PO_DT_FROM" + W_PO_DT_FROM);
		// 		System.out.println("W_PO_DT_TO" + W_PO_DT_TO);

		cs = conn.prepareCall("call USP_B_POPUP_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_COMP_ID);//V_COMP_ID
		cs.setString(3, V_BP_CD);//V_BP_CD
		cs.setString(4, V_BP_NM);//V_BP_NM
		cs.setString(5, "");//V_ITEM_CD
		cs.setString(6, "");//V_ITEM_NM
		cs.setString(7, "");//V_DEPT_CD
		cs.setString(8, "");//V_DEPT_NM
		cs.setString(9, W_PO_DT_FROM);//V_DATE1
		cs.setString(10, W_PO_DT_TO);//V_DATE2
		cs.setString(11, W_PO_NO1);//V_PARAM1
		cs.setString(12, "");//V_PARAM2
		cs.setString(13, "");//V_PARAM3
		cs.setString(14, "");//V_PARAM4
		cs.setString(15, "");//V_USR_ID
		cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(16);

		while (rs.next()) {
			subObject = new JSONObject();
			if (V_TYPE.equals("PO")) {
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("PO_CFM", rs.getString("PO_CFM"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
			} else {
				subObject.put("PO_DESC", rs.getString("PO_DESC"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("COUNT", rs.getString("COUNT"));
				subObject.put("PO_CFM", rs.getString("PO_CFM"));
				subObject.put("USR_NM", rs.getString("USR_NM"));
			}
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		// 		System.out.println(jsonObject);

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

