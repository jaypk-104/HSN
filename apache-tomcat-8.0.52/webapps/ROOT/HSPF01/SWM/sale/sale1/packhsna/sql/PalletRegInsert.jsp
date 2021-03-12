<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.TreeMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	ResultSet rs = null;
	CallableStatement cs = null;

	try {
		request.setCharacterEncoding("utf-8");
		String data = request.getParameter("data");
		String jsonData = URLDecoder.decode(data, "UTF-8");

		if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);
				String V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
				String V_INV_MGM_NO = request.getParameter("V_INV_MGM_NO") == null ? "" : request.getParameter("V_INV_MGM_NO");
				String V_CONT_MGM_NO = hashMap.get("CONT_MGM_NO") == null ? "" : hashMap.get("CONT_MGM_NO").toString();
				if (V_TYPE.equals("D")) {
					V_INV_MGM_NO = hashMap.get("INV_MGM_NO") == null ? "" : hashMap.get("INV_MGM_NO").toString();
					V_CONT_MGM_NO = hashMap.get("CONT_NO") == null ? "" : hashMap.get("CONT_NO").toString();
				}
				String V_PAL_BC_NO = hashMap.get("PAL_BC_NO") == null ? "" : hashMap.get("PAL_BC_NO").toString();
				String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

// 				System.out.println("V_TYPE" + V_TYPE);
// 				System.out.println("V_INV_MGM_NO" + V_INV_MGM_NO);
// 				System.out.println("V_CONT_MGM_NO" + V_CONT_MGM_NO);
// 				System.out.println("V_PAL_BC_NO" + V_PAL_BC_NO);
// 				System.out.println("V_USR_ID" + V_USR_ID);

				cs = conn.prepareCall("{call USP_S_INV_DTL_INSERT(?,?,?,?,?)}");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_INV_MGM_NO);
				cs.setString(3, V_CONT_MGM_NO);
				cs.setString(4, V_PAL_BC_NO);
				cs.setString(5, V_USR_ID);
				cs.execute();
			}
		} else {
			JSONObject jsondata = JSONObject.fromObject(jsonData);

			String V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
			String V_INV_MGM_NO = request.getParameter("V_INV_MGM_NO") == null ? "" : request.getParameter("V_INV_MGM_NO");
			String V_CONT_MGM_NO = jsondata.get("CONT_MGM_NO") == null ? "" : jsondata.get("CONT_MGM_NO").toString();
			if (V_TYPE.equals("D")) {
				V_INV_MGM_NO = jsondata.get("INV_MGM_NO") == null ? "" : jsondata.get("INV_MGM_NO").toString();
				V_CONT_MGM_NO = jsondata.get("CONT_NO") == null ? "" : jsondata.get("CONT_NO").toString();
			}
			String V_PAL_BC_NO = jsondata.get("PAL_BC_NO") == null ? "" : jsondata.get("PAL_BC_NO").toString();
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

// 			System.out.println("V_TYPE" + V_TYPE);
// 			System.out.println("V_INV_MGM_NO" + V_INV_MGM_NO);
// 			System.out.println("V_CONT_MGM_NO" + V_CONT_MGM_NO);
// 			System.out.println("V_PAL_BC_NO" + V_PAL_BC_NO);
// 			System.out.println("V_USR_ID" + V_USR_ID);

			cs = conn.prepareCall("{call USP_S_INV_DTL_INSERT(?,?,?,?,?)}");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_INV_MGM_NO);
			cs.setString(3, V_CONT_MGM_NO);
			cs.setString(4, V_PAL_BC_NO);
			cs.setString(5, V_USR_ID);
			cs.execute();
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
