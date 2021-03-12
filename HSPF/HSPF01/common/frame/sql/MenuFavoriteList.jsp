<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.Enumeration"%>
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
// 			Enumeration params = request.getParameterNames();
// 		 	System.out.println("------------넘어온데이터확인----------------");
// 		 	while (params.hasMoreElements()){
// 		 	    String name = (String)params.nextElement();
// 		 	    System.out.println(name + " : " +request.getParameter(name));
// 		 	}
// 		 	System.out.println("----------------------------");
		 	
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
				String V_TYPE = request.getParameter("V_TYPE");
				
// 				System.out.println("comp_id : " + comp_id);
// 				System.out.println("role_cd : " + role_cd);
// 				System.out.println("click_node : " + click_node);
// 				System.out.println("user_id : " + user_id);
// 				System.out.println("V_TYPE : " + V_TYPE);

				if (click_node.equals("root")){
					click_node = "0";
				}
				
				cs = conn.prepareCall("call USP_MENU_FAVORITE_LIST(?,?,?,?,?)");
				cs.setString(1, comp_id);//
				cs.setString(2, role_cd);//
				cs.setString(3, click_node);//
				cs.setString(4, user_id);//
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);
				
// 				System.out.println(sql2);
// 				System.out.println("=======================================================");
// 				System.out.println(sql3);

				while (rs.next()) {
					subObject = new JSONObject();
					
					subObject.put("id", rs.getInt("IDX"));
					subObject.put("text", rs.getString("PGM_NM"));
					subObject.put("url", rs.getString("PGM_PATH"));
					subObject.put("pgm_id", rs.getString("PGM_ID"));
					subObject.put("parent_idx", rs.getString("PARENT_IDX"));
					//아이콘추가
					if (rs.getString("PGM_ID").equals("BB")) {
						subObject.put("iconCls", "fa-list-ol");
					} else if (rs.getString("PGM_ID").equals("MM")) {
						subObject.put("iconCls", "fa-shopping-cart");
					} else if (rs.getString("PGM_ID").equals("SL")) {
						subObject.put("iconCls", "fa-archive");
					} else if (rs.getString("PGM_ID").equals("SP")) {
						subObject.put("iconCls", "fa-truck");
					} else if (rs.getString("PGM_ID").equals("SS")) {
						subObject.put("iconCls", "fa-handshake-o");
					} else if (rs.getString("PGM_ID").equals("QQ")) {
						subObject.put("iconCls", "fa-search");
					} else if (rs.getString("PGM_ID").equals("END")) {
						subObject.put("iconCls", "fa-calculator");
					} else if (rs.getString("PGM_ID").equals("YY")) {
						subObject.put("iconCls", "fa-clipboard");
					} else if (rs.getString("PGM_ID").equals("ST")) { 
						subObject.put("iconCls", "fa-stack-overflow");
					} else if (rs.getInt("IDX") < 0){
						subObject.put("iconCls", "fas fa-folder");
					}
					if (rs.getInt("count") > 0) {
						subObject.put("expanded", false);
					} else {
						subObject.put("leaf", true);
					}
					jsonArray.add(subObject);
				}
// 				jsonObject.put("success", true);
				jsonObject.put("children", jsonArray);
				
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