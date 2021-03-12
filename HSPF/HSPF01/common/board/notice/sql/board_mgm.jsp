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
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_SELECT(?,?,?,?,?,?,?,?)");
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
		else if (V_TYPE.equals("I") || V_TYPE.equals("U") || V_TYPE.equals("D")) {
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM").toUpperCase();
			String V_WRITE_TITLE = request.getParameter("V_WRITE_TITLE") == null ? "" : request.getParameter("V_WRITE_TITLE").toString();
			String V_WRITE_CONTENT = request.getParameter("V_WRITE_CONTENT") == null ? "" : request.getParameter("V_WRITE_CONTENT").toString();
			String V_WRITE_IMP_YN = request.getParameter("V_WRITE_IMP_YN") == null ? "" : request.getParameter("V_WRITE_IMP_YN").toUpperCase();
			String V_WRITE_SHOW_DT_ALL = request.getParameter("V_WRITE_SHOW_DT_ALL") == null ? "" : request.getParameter("V_WRITE_SHOW_DT_ALL").toUpperCase();
			String V_WRITE_SHOW_DT_FR = request.getParameter("V_WRITE_SHOW_DT_FR") == null ? "" : request.getParameter("V_WRITE_SHOW_DT_FR").toUpperCase();
			String V_WRITE_SHOW_DT_TO = request.getParameter("V_WRITE_SHOW_DT_TO") == null ? "" : request.getParameter("V_WRITE_SHOW_DT_TO").toUpperCase();
			
			
			if(V_WRITE_IMP_YN.equals("TRUE")){
				V_WRITE_IMP_YN = "Y";
			}
			else{
				V_WRITE_IMP_YN = "N";
			}
			
			if(V_WRITE_SHOW_DT_ALL.equals("TRUE")){
				V_WRITE_SHOW_DT_FR = "2019-01-01";
				V_WRITE_SHOW_DT_TO = "2119-01-01";
			}
			else{
				if(V_WRITE_SHOW_DT_FR.length() > 10){
					V_WRITE_SHOW_DT_FR = V_WRITE_SHOW_DT_FR.substring(0,10);
				}
				if(V_WRITE_SHOW_DT_TO.length() > 10){
					V_WRITE_SHOW_DT_TO = V_WRITE_SHOW_DT_TO.substring(0,10);
				}
			}
			
// 			System.out.println("V_WRITE_TITLE : " + V_WRITE_TITLE);
// 			System.out.println("V_WRITE_CONTENT : " + V_WRITE_CONTENT);
// 			System.out.println("V_WRITE_IMP_YN : " + V_WRITE_IMP_YN);
// 			System.out.println("V_WRITE_SHOW_DT_ALL : " + V_WRITE_SHOW_DT_ALL);
// 			System.out.println("V_WRITE_SHOW_DT_FR : " + V_WRITE_SHOW_DT_FR);
// 			System.out.println("V_WRITE_SHOW_DT_TO : " + V_WRITE_SHOW_DT_TO);
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, V_WRITE_TITLE); //
			cs.setString(5, V_WRITE_CONTENT); //
			cs.setString(6, "A"); //
			cs.setString(7, V_WRITE_SHOW_DT_FR); //
			cs.setString(8, V_WRITE_SHOW_DT_TO); //
			cs.setString(9, V_WRITE_IMP_YN); //
			cs.setString(10, ""); //
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


