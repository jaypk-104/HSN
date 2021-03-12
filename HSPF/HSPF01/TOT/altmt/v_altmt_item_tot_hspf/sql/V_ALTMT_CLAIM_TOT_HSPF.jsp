<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

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
		String V_BS_YEAR = request.getParameter("V_YEAR") == null ? "" : request.getParameter("V_YEAR").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_SEQ = request.getParameter("V_SEQ") == null ? "" : request.getParameter("V_SEQ").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_V_ALTMT_CLAIM(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 			
			cs.setString(2, V_TYPE); //V_TYPE 				
			cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
			cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
			cs.setString(5, V_SEQ); //V_SEQ 			
			cs.setString(6, ""); //V_CM_SEQ 	
			cs.setString(7, ""); //V_OCCUR_TM 			
			cs.setString(8, ""); //V_BAD_TEXT			
			cs.setString(9, ""); //V_BAD_REASON 			
			cs.setString(10, ""); //V_IMPROV_TEXT 		
			cs.setString(11, V_USR_ID); //V_USR_ID 	
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("CM_SEQ", rs.getString("CM_SEQ"));
				subObject.put("OCCUR_TM", rs.getString("OCCUR_TM"));
				subObject.put("BAD_TEXT", rs.getString("BAD_TEXT"));
				subObject.put("BAD_REASON", rs.getString("BAD_REASON"));
				subObject.put("IMPROV_TEXT", rs.getString("IMPROV_TEXT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_CM_SEQ = hashMap.get("CM_SEQ") == null ? "" : hashMap.get("CM_SEQ").toString();
					String V_OCCUR_TM = hashMap.get("OCCUR_TM") == null ? "" : hashMap.get("OCCUR_TM").toString();
					String V_BAD_TEXT = hashMap.get("BAD_TEXT") == null ? "" : hashMap.get("BAD_TEXT").toString();
					String V_BAD_REASON = hashMap.get("BAD_REASON") == null ? "" : hashMap.get("BAD_REASON").toString();
					String V_IMPROV_TEXT = hashMap.get("IMPROV_TEXT") == null ? "" : hashMap.get("IMPROV_TEXT").toString();

					cs = conn.prepareCall("call USP_V_ALTMT_CLAIM(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID); //V_COMP_ID 			
					cs.setString(2, V_TYPE); //V_TYPE 				
					cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
					cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
					cs.setString(5, V_SEQ); //V_SEQ 			
					cs.setString(6, V_CM_SEQ); //V_CM_SEQ 	
					cs.setString(7, V_OCCUR_TM); //V_OCCUR_TM 			
					cs.setString(8, V_BAD_TEXT); //V_BAD_TEXT			
					cs.setString(9, V_BAD_REASON); //V_BAD_REASON 			
					cs.setString(10, V_IMPROV_TEXT); //V_IMPROV_TEXT 			
					cs.setString(11, V_USR_ID); //V_USR_ID 	
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_CM_SEQ = jsondata.get("CM_SEQ") == null ? "" : jsondata.get("CM_SEQ").toString();
				String V_OCCUR_TM = jsondata.get("OCCUR_TM") == null ? "" : jsondata.get("OCCUR_TM").toString();
				String V_BAD_TEXT = jsondata.get("BAD_TEXT") == null ? "" : jsondata.get("BAD_TEXT").toString();
				String V_BAD_REASON = jsondata.get("BAD_REASON") == null ? "" : jsondata.get("BAD_REASON").toString();
				String V_IMPROV_TEXT = jsondata.get("IMPROV_TEXT") == null ? "" : jsondata.get("IMPROV_TEXT").toString();
				
				cs = conn.prepareCall("call USP_V_ALTMT_CLAIM(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID); //V_COMP_ID 			
				cs.setString(2, V_TYPE); //V_TYPE 				
				cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
				cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
				cs.setString(5, V_SEQ); //V_SEQ 			
				cs.setString(6, V_CM_SEQ); //V_CM_SEQ 	
				cs.setString(7, V_OCCUR_TM); //V_OCCUR_TM 			
				cs.setString(8, V_BAD_TEXT); //V_BAD_TEXT			
				cs.setString(9, V_BAD_REASON); //V_BAD_REASON 			
				cs.setString(10, V_IMPROV_TEXT); //V_IMPROV_TEXT 
				cs.setString(11, V_USR_ID); //V_USR_ID 	
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
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

<%!

%>


