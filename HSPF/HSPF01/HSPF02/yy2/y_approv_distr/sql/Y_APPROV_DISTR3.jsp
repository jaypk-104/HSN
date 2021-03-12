<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_TYPE2 = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_TAB_TYPE = request.getParameter("V_TAB_TYPE") == null ? "" : request.getParameter("V_TAB_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_RISK_NO = request.getParameter("V_RISK_NO") == null ? "" : request.getParameter("V_RISK_NO").toUpperCase();
		String V_APPROV_MGM_NO = request.getParameter("V_APPROV_MGM_NO") == null ? "" : request.getParameter("V_APPROV_MGM_NO").toUpperCase();
		// 		System.out.println(V_TYPE);
		// 		System.out.println(V_APPROV_MGM_NO);

		if (V_TAB_TYPE.equals("T3")) {
			if (V_TYPE.equals("S")) {

				cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_DESC(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
				cs.setString(4, "");//V_APPROV_NM
				cs.setString(5, "");//V_APPROV_SEQ
				cs.setString(6, "");//V_APPROV_DT
				cs.setString(7, V_USR_ID);//V_RISK_REF_NO
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(8);
				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
					subObject.put("APPROV_DESC_SEQ", rs.getString("APPROV_DESC_SEQ"));
					subObject.put("IV_TEXT", rs.getString("IV_TEXT"));
					subObject.put("SL_TEXT", rs.getString("SL_TEXT"));
					jsonArray.add(subObject);
				}

				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

// 				System.out.println(jsonObject);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();

			} else if (V_TYPE.equals("I") || V_TYPE.equals("D")) {
				String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
				String V_APPROV_DESC_SEQ = request.getParameter("V_APPROV_DESC_SEQ") == null ? "" : request.getParameter("V_APPROV_DESC_SEQ").toUpperCase();
				String V_IV_TEXT = request.getParameter("V_IV_TEXT") == null ? "" : request.getParameter("V_IV_TEXT").toString();
				String V_SL_TEXT = request.getParameter("V_SL_TEXT") == null ? "" : request.getParameter("V_SL_TEXT").toUpperCase();

// 				System.out.println(V_IV_TEXT);

				cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_DESC(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
				cs.setString(4, V_APPROV_DESC_SEQ);//V_APPROV_NM
				cs.setString(5, V_IV_TEXT);//V_APPROV_SEQ
				cs.setString(6, V_SL_TEXT);//V_APPROV_DT
				cs.setString(7, V_USR_ID);//V_RISK_REF_NO
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				String res = "success";
				// 				System.out.println(res);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(res);
				pw.flush();
				pw.close();

			}
		}

	} catch (

	Exception e) {
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


