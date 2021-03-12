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
	DbConn dbcon = new DbConn();
	request.setCharacterEncoding("utf-8");
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	ResultSet rs = null;

	try {
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String W_PO_NO1 = request.getParameter("W_PO_NO1") == null ? "" : request.getParameter("W_PO_NO1").toUpperCase();
		String W_M_BP_CD_PO = request.getParameter("W_M_BP_CD_PO") == null ? "" : request.getParameter("W_M_BP_CD_PO").toUpperCase();
		String W_PO_DT_FROM = request.getParameter("W_PO_DT_FROM") == null ? "" : request.getParameter("W_PO_DT_FROM").substring(0, 10);
		String W_PO_DT_TO = request.getParameter("W_PO_DT_TO") == null ? "" : request.getParameter("W_PO_DT_TO").substring(0, 10);

		String sql = "";
		sql += "SELECT A.COMP_ID, A.PO_NO, TO_CHAR(PO_DT, 'YYYY-MM-DD') PO_DT, A.BP_CD M_BP_CD, AX.BP_NM M_BP_NM, PO_TYPE, B.DTL_NM PO_TYPE_NM,   ";
		sql += "A.PAY_METH, D.DTL_NM PAY_METH_NM, IN_TERMS, C.DTL_NM IN_TERMS_NM, CUR, XCH_RATE, APPROV_NO, PO_CFM ";
		sql += "FROM M_PO_HDR_HSPF A                                                                               ";
		sql += "LEFT OUTER JOIN B_BIZ_HSPF AX ON A.BP_CD = AX.BP_CD                                                ";
		sql += "LEFT OUTER JOIN B_DTL_INFO B ON B.MAST_CD = 'MA02' AND A.PO_TYPE = B.DTL_CD                        ";
		sql += "LEFT OUTER JOIN B_DTL_INFO C ON C.MAST_CD = 'MA04' AND A.IN_TERMS = C.DTL_CD                       ";
		sql += "LEFT OUTER JOIN B_DTL_INFO D ON D.MAST_CD = 'MA03' AND A.PAY_METH = D.DTL_CD                       ";
		sql += "WHERE A.COMP_ID = '" + V_COMP_ID + "'                                                                                 ";
		sql += "AND A.PO_NO LIKE '%" + W_PO_NO1 + "%'                                                                              ";
		sql += "AND A.BP_CD LIKE '%" + W_M_BP_CD_PO + "%'                                                                              ";
		sql += "AND A.PO_DT >=  '" + W_PO_DT_FROM + "'                                                                        ";
		sql += "AND A.PO_DT <=  '" + W_PO_DT_TO + "'                                                                         ";
		sql += "ORDER BY A.PO_NO ";

		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			subObject = new JSONObject();
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
		// 		if (cs != null) try {
		// 			cs.close();
		// 		} catch (SQLException ex) {}
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

