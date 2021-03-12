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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_YYYYMM = request.getParameter("V_YYYYMM") == null ? "" : request.getParameter("V_YYYYMM").replace("-", "").substring(0, 6);
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_I_INV_SUM_TOT_HSPF(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMM);//V_YYYYMM
			cs.setString(4, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("YYYYMM", rs.getString("YYYYMM"));
				subObject.put("BS_TOT_QTY", rs.getString("BS_TOT_QTY"));
				subObject.put("BS_TOT_AMT", rs.getString("BS_TOT_AMT"));
				subObject.put("GR_TOT_QTY", rs.getString("GR_TOT_QTY"));
				subObject.put("GR_TOT_AMT", rs.getString("GR_TOT_AMT"));
				subObject.put("G_DN_TOT_QTY", rs.getString("G_DN_TOT_QTY"));
				subObject.put("G_DN_TOT_AMT", rs.getString("G_DN_TOT_AMT"));
				subObject.put("J_DN_TOT_QTY", rs.getString("J_DN_TOT_QTY"));
				subObject.put("J_DN_TOT_AMT", rs.getString("J_DN_TOT_AMT"));
				subObject.put("DN_TOT_QTY", rs.getString("DN_TOT_QTY"));
				subObject.put("DN_TOT_AMT", rs.getString("DN_TOT_AMT"));
				subObject.put("G_DN_EX_TOT_QTY", rs.getString("G_DN_EX_TOT_QTY"));
				subObject.put("G_DN_EX_TOT_AMT", rs.getString("G_DN_EX_TOT_AMT"));
				subObject.put("J_DN_EX_TOT_QTY", rs.getString("J_DN_EX_TOT_QTY"));
				subObject.put("J_DN_EX_TOT_AMT", rs.getString("J_DN_EX_TOT_AMT"));
				subObject.put("ST_TOT_QTY", rs.getString("ST_TOT_QTY"));
				subObject.put("ST_TOT_AMT", rs.getString("ST_TOT_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("C")) {
			cs = conn.prepareCall("call USP_003_I_INV_SUM_TOT_HSPF(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMM);//V_YYYYMM
			cs.setString(4, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
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


