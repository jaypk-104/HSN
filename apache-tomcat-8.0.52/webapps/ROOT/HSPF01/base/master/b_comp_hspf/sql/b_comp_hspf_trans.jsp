<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="java.util.HashMap"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;

	try {
		request.setCharacterEncoding("utf-8");

		String data = request.getParameter("data");
		String jsonData = URLDecoder.decode(data, "UTF-8");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

// 		System.out.println("V_USR_ID" + V_USR_ID);

		if (jsonData.lastIndexOf("},{") > 0) {
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);
				String V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
				String V_COMP_ID = hashMap.get("COMP_ID") == null ? "" : hashMap.get("COMP_ID").toString();
				String V_COMP_NM = hashMap.get("COMP_NM") == null ? "" : hashMap.get("COMP_NM").toString();
				String V_COMP_TYPE = hashMap.get("COMP_TYPE") == null ? "" : hashMap.get("COMP_TYPE").toString();

				// 				System.out.println("V_TYPE" + V_TYPE);
				// 				System.out.println("COMP_ID" + V_COMP_ID);
				// 				System.out.println("COMP_NM" + V_COMP_NM);
				// 				System.out.println("COMP_TYPE_NM" + V_COMP_TYPE);

				cs = conn.prepareCall("call USP_B_COMP_HSPF(?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //
				cs.setString(2, V_COMP_ID); //
				cs.setString(3, V_COMP_NM); //
				cs.setString(4, V_COMP_TYPE); //
				cs.setString(5, V_USR_ID); //
				cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
		} else { // 배열이아닐경우
			JSONObject jsondata = JSONObject.fromObject(jsonData);
			String V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
			String V_COMP_ID = jsondata.get("COMP_ID") == null ? "" : jsondata.get("COMP_ID").toString();
			String V_COMP_NM = jsondata.get("COMP_NM") == null ? "" : jsondata.get("COMP_NM").toString().toLowerCase();
			String V_COMP_TYPE = jsondata.get("COMP_TYPE") == null ? "" : jsondata.get("COMP_TYPE").toString();

			// 			System.out.println("V_TYPE" + V_TYPE);
			// 			System.out.println("COMP_ID" + V_COMP_ID);
			// 			System.out.println("COMP_NM" + V_COMP_NM);
			// 			System.out.println("COMP_TYPE_NM" + V_COMP_TYPE);

			cs = conn.prepareCall("call USP_B_COMP_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_COMP_ID); //
			cs.setString(3, V_COMP_NM); //
			cs.setString(4, V_COMP_TYPE); //
			cs.setString(5, V_USR_ID); //
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
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

