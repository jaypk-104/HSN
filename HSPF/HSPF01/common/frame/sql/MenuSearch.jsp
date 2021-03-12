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
		try {
			JSONObject jsonTreeRootObject = new JSONObject();
			JSONObject jsonTreeObject = null;
			JSONArray jsonTreeChildrenArray = new JSONArray();
			JSONObject jsonTreeChildrenObject = null;
			JSONArray jsonArray = new JSONArray();
			JSONObject subObject = null;
			JSONObject jsonObject = new JSONObject();

			jsonTreeObject = new JSONObject();

			String user_id = session.getAttribute("user_id") == null ? "" : (String) session.getAttribute("user_id");
			String comp_id = session.getAttribute("comp_id") == null ? "" : (String) session.getAttribute("comp_id");
			String role_cd = "";
			
			
			
			
// 			user_id = "PEB7986";

			String pre_sql = "select ROLE_CD from Z_USR_INFO_HSPF WHERE UPPER(USR_ID) = '" + user_id.toUpperCase() + "' ";
			pre_rs = stmt.executeQuery(pre_sql);

			while (pre_rs.next()) {
				role_cd = pre_rs.getString("ROLE_CD");
			}
// 			role_cd = "PEB";
			
	%>
	<%
		if (comp_id.equals("") || user_id.equals("")) {
				// 			response.sendRedirect("/HSPF01/common/login/login.jsp");
				// 			RequestDispatcher rd = request.getRequestDispatcher("/HSPF01/common/login/login.jsp");
				// 			rd.forward(request, response);
				// 				out.println("<Script language='JavaScript'>top.document.location.reload();</Script>");
				// 			return;
			} 
		else {
			
				String click_node = request.getParameter("node");
				
				cs = conn.prepareCall("call USP_MENU_SEARCH(?,?,?,?)");
				cs.setString(1, comp_id);//
				cs.setString(2, role_cd);//
				cs.setString(3, user_id);//
				cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(4);
				

				while (rs.next()) {
					subObject = new JSONObject();
					
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					subObject.put("DTL_CD", rs.getString("DTL_CD"));

					jsonArray.add(subObject);
				}
				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);
				
// 				System.out.println(jsonObject);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
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