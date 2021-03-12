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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_MAST_CD = request.getParameter("V_MAST_CD") == null ? "" : request.getParameter("V_MAST_CD").toUpperCase();
		String V_DTL_CD = request.getParameter("V_DTL_CD") == null ? "" : request.getParameter("V_DTL_CD").toUpperCase();
		String V_DTL_NM = request.getParameter("V_DTL_NM") == null ? "" : request.getParameter("V_DTL_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_V_ALTMT_CODE_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_MAST_CD);//V_MAST_CD
			cs.setString(4, V_DTL_CD);//V_DTL_CD 
			cs.setString(5, V_DTL_NM);//V_DTL_NM 
			cs.setString(6, "");//V_PRINT_SEQ
			cs.setString(7, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_CD", rs.getString("MAST_CD"));
				subObject.put("DTL_CD", rs.getString("DTL_CD"));
				subObject.put("DTL_NM", rs.getString("DTL_NM"));
				subObject.put("PRINT_SEQ", rs.getString("PRINT_SEQ"));
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
					V_MAST_CD = hashMap.get("MAST_CD") == null ? "" : hashMap.get("MAST_CD").toString();
					V_DTL_CD = hashMap.get("DTL_CD") == null ? "" : hashMap.get("DTL_CD").toString();
					V_DTL_NM = hashMap.get("DTL_NM") == null ? "" : hashMap.get("DTL_NM").toString();
					String V_PRINT_SEQ = hashMap.get("PRINT_SEQ") == null ? "" : hashMap.get("PRINT_SEQ").toString();

					cs = conn.prepareCall("call USP_003_V_ALTMT_CODE_TOT_HSPF(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_MAST_CD);//V_MAST_CD
					cs.setString(4, V_DTL_CD);//V_DTL_CD 
					cs.setString(5, V_DTL_NM);//V_DTL_NM 
					cs.setString(6, V_PRINT_SEQ);//V_PRINT_SEQ
					cs.setString(7, V_USR_ID);//V_USR_ID 
					cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {

				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_MAST_CD = jsondata.get("MAST_CD") == null ? "" : jsondata.get("MAST_CD").toString();
				V_DTL_CD = jsondata.get("DTL_CD") == null ? "" : jsondata.get("DTL_CD").toString();
				V_DTL_NM = jsondata.get("DTL_NM") == null ? "" : jsondata.get("DTL_NM").toString();
				String V_PRINT_SEQ = jsondata.get("PRINT_SEQ") == null ? "" : jsondata.get("PRINT_SEQ").toString();
				
				cs = conn.prepareCall("call USP_003_V_ALTMT_CODE_TOT_HSPF(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_MAST_CD);//V_MAST_CD
				cs.setString(4, V_DTL_CD);//V_DTL_CD 
				cs.setString(5, V_DTL_NM);//V_DTL_NM 
				cs.setString(6, V_PRINT_SEQ);//V_PRINT_SEQ
				cs.setString(7, V_USR_ID);//V_USR_ID 
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
		}

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

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


