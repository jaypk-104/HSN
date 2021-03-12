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

		
		if (V_TYPE.equals("S")) {
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM").toUpperCase();
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_REPLY_MGM(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, ""); //
			cs.setString(9, ""); //
			cs.setString(10, V_USR_ID); //
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(11);
			while (rs.next()) {
				subObject = new JSONObject();
				String TEXT = "";
				for(int i = 0 ; i < rs.getInt("REPLY_LEVEL") ; i ++){
					TEXT += "&nbsp;&nbsp;";
				}
				if(rs.getInt("REPLY_LEVEL") >= 1){
					TEXT += "└" ;					
				}
				TEXT += rs.getString("TEXT");					
				subObject.put("TEXT", TEXT);
// 				System.out.println("TEXT : " + rs.getString("TEXT"));
				subObject.put("REPLY_IDX", rs.getString("REPLY_IDX"));
				subObject.put("REF_IDX", rs.getString("REF_IDX"));
				subObject.put("PARENT_REPLY_IDX", rs.getString("PARENT_REPLY_IDX"));
				subObject.put("REPLY_LEVEL", rs.getString("REPLY_LEVEL"));
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
		
		else if (V_TYPE.equals("I")) {
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM").toUpperCase();
			String V_REPLY_TEXT = request.getParameter("V_REPLY_TEXT") == null ? "" : request.getParameter("V_REPLY_TEXT").toString();
			String V_HIDDEN_YN = request.getParameter("V_HIDDEN_YN") == null ? "" : request.getParameter("V_HIDDEN_YN").toString();
			
			if(V_HIDDEN_YN.equals("true")){
				V_HIDDEN_YN = "Y";
			}
			else{
				V_HIDDEN_YN = "N";
			}
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_REPLY_MGM(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, V_REPLY_TEXT); //			
			cs.setString(9, V_HIDDEN_YN); //
			cs.setString(10, V_USR_ID); //
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
		}
		else if (V_TYPE.equals("RE_I")) {
			String V_IDX_NUM = request.getParameter("V_IDX_NUM") == null ? "" : request.getParameter("V_IDX_NUM").toUpperCase();
			String V_REPLY_TEXT = request.getParameter("V_REPLY_TEXT") == null ? "" : request.getParameter("V_REPLY_TEXT").toString();
			String V_REF_IDX = request.getParameter("V_REF_IDX") == null ? "" : request.getParameter("V_REF_IDX").toString();
			String V_PARENT_REPLY_IDX = request.getParameter("V_PARENT_REPLY_IDX") == null ? "" : request.getParameter("V_PARENT_REPLY_IDX").toString();
			String V_REPLY_LEVEL = request.getParameter("V_REPLY_LEVEL") == null ? "" : request.getParameter("V_REPLY_LEVEL").toString();
			
			/*
			String V_HIDDEN_YN = request.getParameter("V_HIDDEN_YN") == null ? "" : request.getParameter("V_HIDDEN_YN").toString();
			
			if(V_HIDDEN_YN.equals("true")){
				V_HIDDEN_YN = "Y";
			}
			else{
				V_HIDDEN_YN = "N";
			}
			*/
			
// 			System.out.println("V_IDX_NUM : " + V_IDX_NUM);
// 			System.out.println("V_REPLY_TEXT : " + V_REPLY_TEXT);
// 			System.out.println("V_REF_IDX : " + V_REF_IDX);
// 			System.out.println("V_PARENT_REPLY_IDX : " + V_PARENT_REPLY_IDX);
// 			System.out.println("V_REPLY_LEVEL : " + V_REPLY_LEVEL);
			
			cs = conn.prepareCall("call USP_Z_TOTAL_BOARD_REPLY_MGM(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //
			cs.setString(2, V_TYPE); //
			cs.setString(3, V_IDX_NUM); //
			cs.setString(4, ""); //
			cs.setString(5, V_REF_IDX); //
			cs.setString(6, V_PARENT_REPLY_IDX); //
			cs.setString(7, V_REPLY_LEVEL); //
			cs.setString(8, V_REPLY_TEXT); //			
			cs.setString(9, "N"); //
			cs.setString(10, V_USR_ID); //
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
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


