<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
 <%@ include file="/HSPF01/common/DB_Connection.jsp"%>


<%
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		// 	 System.out.println("납품예정하단저장SQL");

		String V_TYPE = request.getParameter("V_TYPE");
		String V_MAST_PO_NO = request.getParameter("V_MAST_PO_NO");
		String V_MAST_PO_SEQ = request.getParameter("V_MAST_PO_SEQ");
		String V_MAST_PO_SEQ_NO = request.getParameter("V_MAST_PO_SEQ_NO");
		String V_ASN_NO = request.getParameter("V_ASN_NO");
		String V_ASN_STS = (request.getParameter("V_ASN_STS") == null ? "" : request.getParameter("V_ASN_STS").toString());
		String V_ITEM_CD = request.getParameter("V_ITEM_CD");
		String V_DLV_AVL_DT = request.getParameter("V_DLV_AVL_DT").substring(0, 10);
		String V_DLV_AVL_QTY = request.getParameter("V_DLV_AVL_QTY");
		String V_USR_ID = request.getParameter("V_USR_ID");

		// 	 System.out.println("V_TYPE" + V_TYPE);
		// 	 System.out.println("V_MAST_PO_NO" + V_MAST_PO_NO);
		// 	 System.out.println("V_MAST_PO_SEQ" + V_MAST_PO_SEQ);
		// 	 System.out.println("V_MAST_PO_SEQ_NO" + V_MAST_PO_SEQ_NO);
		// 	 System.out.println("V_ASN_NO" + V_ASN_NO);
		// 	 System.out.println("V_ASN_STS" + V_ASN_STS);
		// 	 System.out.println("V_ITEM_CD" + V_ITEM_CD);
		// 	 System.out.println("V_DLV_AVL_DT" + V_DLV_AVL_DT);
		// 	 System.out.println("V_DLV_AVL_QTY" + V_DLV_AVL_QTY);
		// 	 System.out.println("V_USR_ID" + V_USR_ID);

		cs = conn.prepareCall("{call USP_SUPP_ASN_MST_INSRT(?,?,?,?,?,?,?,?,?,?,?)}");
		cs.setString(1, V_TYPE);
		cs.setString(2, V_MAST_PO_NO);
		cs.setString(3, V_MAST_PO_SEQ);
		cs.setString(4, V_MAST_PO_SEQ_NO);
		cs.setString(5, V_ASN_NO);
		cs.setString(6, V_ASN_STS);
		cs.setString(7, V_ITEM_CD);
		//  	cs.setString(8, (V_DLV_AVL_DT==null?"":V_DLV_AVL_DT.substring(0, 10)));
		cs.setString(8, V_DLV_AVL_DT);
		cs.setString(9, V_DLV_AVL_QTY);
		cs.setString(10, V_USR_ID);
		cs.registerOutParameter(11, Types.VARCHAR);

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
	}
%>
