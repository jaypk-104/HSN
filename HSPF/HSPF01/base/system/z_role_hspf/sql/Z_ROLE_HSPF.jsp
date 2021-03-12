<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONValue"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;

	try {
		request.setCharacterEncoding("utf-8");

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_ROLE_CD = request.getParameter("V_ROLE_CD") == null ? "" : request.getParameter("V_ROLE_CD");
		String V_ROLE_NM = request.getParameter("V_ROLE_NM") == null ? "" : request.getParameter("V_ROLE_NM");

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_Z_ROLE_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_COMP_ID); //
			cs.setString(3, V_ROLE_CD); //
			cs.setString(4, V_ROLE_NM); //
			cs.setString(5, ""); //
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);

			while (rs.next()) {
				subObject = new JSONObject();

				subObject.put("ROLE_CD", rs.getString("ROLE_CD"));
				subObject.put("ROLE_NM", rs.getString("ROLE_NM"));
				subObject.put("PGM_CNT", rs.getString("PGM_CNT"));
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
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) {
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString().toUpperCase();
					V_ROLE_CD = hashMap.get("ROLE_CD") == null ? "" : hashMap.get("ROLE_CD").toString().toUpperCase();
					V_ROLE_NM = hashMap.get("ROLE_NM") == null ? "" : hashMap.get("ROLE_NM").toString().toUpperCase();

					cs = conn.prepareCall("call USP_Z_ROLE_HSPF(?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_COMP_ID);
					cs.setString(3, V_ROLE_CD);
					cs.setString(4, V_ROLE_NM);
					cs.setString(5, V_USR_ID);
					cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else { // 배열이아닐경우
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString().toUpperCase();
				V_ROLE_CD = jsondata.get("ROLE_CD") == null ? "" : jsondata.get("ROLE_CD").toString().toUpperCase();
				V_ROLE_NM = jsondata.get("ROLE_NM") == null ? "" : jsondata.get("ROLE_NM").toString().toUpperCase();

				cs = conn.prepareCall("call USP_Z_ROLE_HSPF(?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_ROLE_CD);
				cs.setString(4, V_ROLE_NM);
				cs.setString(5, V_USR_ID);
				cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
		}

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

