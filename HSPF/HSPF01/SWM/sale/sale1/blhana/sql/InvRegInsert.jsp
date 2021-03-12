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

		//MyViewport
		String V_BL_MGM_NO = request.getParameter("V_BL_MGM_NO");

		if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);
				String V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
				String V_INV_MGM_NO = hashMap.get("INV_MGM_NO") == null ? "" : hashMap.get("INV_MGM_NO").toString();
				String V_INV_NO = hashMap.get("INV_NO") == null ? "" : hashMap.get("INV_NO").toString();
				String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

// 				System.out.println("V_TYPE" + V_TYPE);
// 				System.out.println("V_BL_MGM_NO" + V_BL_MGM_NO);
// 				System.out.println("V_INV_MGM_NO" + V_INV_MGM_NO);
// 				System.out.println("V_INV_NO" + V_INV_NO);
// 				System.out.println("V_USR_ID" + V_USR_ID);

				cs = conn.prepareCall("{call USP_S_BL_DTL_INSERT(?,?,?,?,?)}");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_BL_MGM_NO);
				cs.setString(3, V_INV_MGM_NO);
				cs.setString(4, V_INV_NO);
				cs.setString(5, V_USR_ID);

				cs.execute();
			}
		} else {
			JSONObject jsondata = JSONObject.fromObject(jsonData);

			String V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
			String V_INV_MGM_NO = jsondata.get("INV_MGM_NO") == null ? "" : jsondata.get("INV_MGM_NO").toString();
			String V_INV_NO = jsondata.get("INV_NO") == null ? "" : jsondata.get("INV_NO").toString();
			String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

 			/*System.out.println("V_TYPE" + V_TYPE);
 			System.out.println("V_BL_MGM_NO" + V_BL_MGM_NO);
 			System.out.println("V_INV_MGM_NO" + V_INV_MGM_NO);
 			System.out.println("V_INV_NO" + V_INV_NO);
 			System.out.println("V_USR_ID" + V_USR_ID); 
 			Jsondata로 가져오면 
 			V_TYPE D
 			V_BL_MGM_NO null
 			V_INV_MGM_NO SV2019072400005
 			V_INV_NO BBB
 			V_USR_ID ADMINGR2
 			
 			*/

			cs = conn.prepareCall("{call USP_S_BL_DTL_INSERT(?,?,?,?,?)}");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_BL_MGM_NO);
			cs.setString(3, V_INV_MGM_NO);
			cs.setString(4, V_INV_NO);
			cs.setString(5, V_USR_ID);

			
			cs.execute();
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
