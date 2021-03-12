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
		String V_TITLE = request.getParameter("V_TITLE") == null ? "" : request.getParameter("V_TITLE").toUpperCase();
		
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		String total = "";
		
// 		System.out.println("V_COMP_ID : " + V_COMP_ID);
// 		System.out.println("start : " + start);
// 		System.out.println("limit : " + limit);
		
		int start_num = Integer.parseInt(start) * Integer.parseInt(limit);
		int end = Integer.parseInt(start) + Integer.parseInt(limit) ;
		
		cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_SELECT(?,?,?,?,?,?,?,?)");
		cs.setString(1, V_COMP_ID); //
		cs.setString(2, "HS"); //
		cs.setString(3, ""); //
		cs.setString(4, V_TITLE); //
		cs.setString(5, ""); //
		cs.setString(6, start); //
		cs.setString(7, String.valueOf(end)); //
		cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(8);
		while (rs.next()) {
			subObject = new JSONObject();
			if(rs.getString("RNUM").equals("0")){
				subObject.put("NO", "공지");
			}
			else{
				subObject.put("NO", Integer.parseInt(rs.getString("V_TOTAL_CNT")) - Integer.parseInt(rs.getString("RNUM")) + 1);
			}
			if(rs.getInt("REPLY_COUNT") >= 1){
				subObject.put("TITLE", rs.getString("TITLE") + "<span style=\'color:blue\'> [" + rs.getString("REPLY_COUNT") +"]</span>" );
			}
			else{
				subObject.put("TITLE", rs.getString("TITLE"));
			}
			subObject.put("TITLE2", rs.getString("TITLE"));
// 			subObject.put("CONTENT", rs.getString("CONTENT"));
			subObject.put("INSRT_DT", rs.getString("INSRT_DT"));
			subObject.put("IDX_NUM", rs.getString("IDX_NUM"));
			subObject.put("total", rs.getString("V_TOTAL_CNT"));
			subObject.put("SHOW_DT_FR", rs.getString("SHOW_DT_FR"));
			subObject.put("SHOW_DT_TO", rs.getString("SHOW_DT_TO"));
			subObject.put("IMP_YN", rs.getString("IMP_YN"));
			subObject.put("INSRT_USR_ID", rs.getString("INSRT_USR_ID"));
			subObject.put("USR_NM", rs.getString("USR_NM"));
			total =  rs.getString("V_TOTAL_CNT");
			jsonArray.add(subObject);
		}
		jsonObject.put("total", total);
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


