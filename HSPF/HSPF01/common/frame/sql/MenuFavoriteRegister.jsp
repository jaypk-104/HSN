<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		ResultSet rs = null;
		CallableStatement cs = null;
		ResultSet pre_rs = null;
		JSONObject jsonTreeRootObject = new JSONObject();
		JSONObject jsonTreeObject = null;
		JSONArray jsonTreeChildrenArray = new JSONArray();
		JSONObject jsonTreeChildrenObject = null;
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		JSONObject jsonObject = new JSONObject();
		try {
			

			jsonTreeObject = new JSONObject();

			String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
			String V_PGM_ID = request.getParameter("V_PGM_ID") == null ? "" : request.getParameter("V_PGM_ID").toUpperCase();
			String V_IDX = request.getParameter("V_IDX") == null ? "" : request.getParameter("V_IDX").toUpperCase();
			String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toUpperCase();

// 			System.out.println("V_COMP_ID : " + V_COMP_ID);
// 			System.out.println("V_USR_ID : " + V_USR_ID);
// 			System.out.println("V_PGM_ID : " + V_PGM_ID);
// 			System.out.println("V_IDX : " + V_IDX);
// 			System.out.println("V_TYPE : " + V_TYPE);
			
			
			cs = conn.prepareCall("call USP_MENU_FAVORITE_REGISTER(?,?,?,?,?)");

			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_USR_ID);//V_USR_ID
			cs.setString(4, V_PGM_ID);//V_PGM_ID
			cs.setString(5, V_IDX);//V_IDX

			cs.executeQuery();
			

			jsonObject.put("success", true);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			

		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("success", false);
			jsonObject.put("resultList", e.toString());
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		} finally {
			if (rs != null) try {
				rs.close();
			} catch (SQLException ex) {}
			if (pre_rs != null) try {
				pre_rs.close();
			} catch (SQLException ex) {}
			if (stmt != null) try {
				stmt.close();
			} catch (SQLException ex) {}
			if (conn != null) try {
				conn.close();
			} catch (SQLException ex) {}
		}
	%>


</body>
</html>