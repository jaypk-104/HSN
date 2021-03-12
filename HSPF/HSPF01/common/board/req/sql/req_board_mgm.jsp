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

		
		if (V_TYPE.equals("DS")) {
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM").toUpperCase();
			
			cs = conn.prepareCall("call USP_Z_REQ_BOARD_SELECT(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CONTENT", rs.getString("CONTENT"));
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
		else if (V_TYPE.equals("I") || V_TYPE.equals("U")) {
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM").toUpperCase();
			String V_WRITE_TITLE = request.getParameter("V_WRITE_TITLE") == null ? "" : request.getParameter("V_WRITE_TITLE").toString();
			String V_WRITE_CONTENT = request.getParameter("V_WRITE_CONTENT") == null ? "" : request.getParameter("V_WRITE_CONTENT").toString();
			String V_WRITE_END_REQ_DT = request.getParameter("V_WRITE_END_REQ_DT") == null ? "" : request.getParameter("V_WRITE_END_REQ_DT").toUpperCase();
			String V_WRITE_SYS_ID = request.getParameter("V_WRITE_SYS_ID") == null ? "" : request.getParameter("V_WRITE_SYS_ID").toUpperCase();
			String V_WRITE_REQ_TYPE = request.getParameter("V_WRITE_REQ_TYPE") == null ? "" : request.getParameter("V_WRITE_REQ_TYPE").toUpperCase();
			
			if(V_WRITE_END_REQ_DT.length() > 10){
				V_WRITE_END_REQ_DT = V_WRITE_END_REQ_DT.substring(0,10);
			}
			
// 			System.out.println("V_WRITE_TITLE : " + V_WRITE_TITLE);
// 			System.out.println("V_WRITE_CONTENT : " + V_WRITE_CONTENT);
// 			System.out.println("V_WRITE_IMP_YN : " + V_WRITE_IMP_YN);
// 			System.out.println("V_WRITE_SHOW_DT_ALL : " + V_WRITE_SHOW_DT_ALL);
// 			System.out.println("V_WRITE_SHOW_DT_FR : " + V_WRITE_SHOW_DT_FR);
// 			System.out.println("V_WRITE_SHOW_DT_TO : " + V_WRITE_SHOW_DT_TO);
			
			cs = conn.prepareCall("call USP_Z_REQ_BOARD_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, V_WRITE_SYS_ID); //
			cs.setString(5, V_WRITE_TITLE); //
			cs.setString(6, V_WRITE_CONTENT); //
			cs.setString(7, "A"); //
			cs.setString(8, V_WRITE_REQ_TYPE); //
			cs.setString(9, V_WRITE_END_REQ_DT); //
			cs.setString(10, V_WRITE_END_REQ_DT); //
			cs.setString(11, ""); //
			cs.setString(12, ""); //
			cs.setString(13, V_USR_ID); //
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			
			rs = cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(14);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IDX_NUM", rs.getString("IDX_NUM"));
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
		else if (V_TYPE.equals("D") || V_TYPE.equals("SIGN") || V_TYPE.equals("FINISH")){
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM").toUpperCase();
			
			cs = conn.prepareCall("call USP_Z_REQ_BOARD_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, ""); //
			cs.setString(9, ""); //
			cs.setString(10, ""); //
			cs.setString(11, ""); //
			cs.setString(12, ""); //
			cs.setString(13, V_USR_ID); //
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			
			rs = cs.executeQuery();
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
		
	}
%>


