<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
 <%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		// 		 System.out.println("바코드입고전송SQL");
		String sql = null;

		String V_TYPE = request.getParameter("V_TYPE");
		String V_BC_NO = request.getParameter("V_BC_NO");
		String V_USR = request.getParameter("V_USR");
		String V_GR_DT = request.getParameter("V_GR_DT");

		// 		 System.out.println("V_TYPE:"+V_TYPE);
		// 		 System.out.println("V_BC_NO:"+V_BC_NO);
		// 		 System.out.println("V_USR:"+V_USR);
		// 		 System.out.println("V_GR_DT:"+V_GR_DT);

		cs = conn.prepareCall("{call USP_SUPP_TO_GR_INSERT(?,?,?,?)}");
		cs.setString(1, V_TYPE);
		cs.setString(2, V_BC_NO);
		cs.setString(3, V_USR);
		cs.setString(4, V_GR_DT);

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

