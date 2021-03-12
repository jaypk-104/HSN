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
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String sql = ""; 
		sql += " SELECT A.BP_CD, BUYER_ADDR, CONSIGNEE, NOTIFY, SHIP_MARK ";
		sql += " , NVL(A.DISCHGE_PORT,B.DISCHGE_PORT) DISCHGE_PORT, NVL(A.LOADING_PORT,B.LOADING_PORT) LOADING_PORT ";
		sql += " , B.PAY_METH, B.IN_TERMS ";
		sql += " FROM B_BIZ_TRADE_INFO A ";
		sql += " LEFT OUTER JOIN ( ";
		sql += "	SELECT BP_CD,MAX(PAY_DUR) PAY_DUR,MAX(PAY_METH) PAY_METH,MAX(IN_TERMS) IN_TERMS ";
		sql += "		 , MAX(DISCHGE_PORT) DISCHGE_PORT, MAX(LOADING_PORT) LOADING_PORT FROM B_BP_PAY_DUR_TOT_HSPF ";
		sql += "	WHERE TYPE_CD = 'O' AND (BP_CD, SEQ) IN "; 
		sql += "		(SELECT BP_CD,MAX(SEQ) FROM B_BP_PAY_DUR_TOT_HSPF WHERE TYPE_CD = 'O' GROUP BY BP_CD) ";
		sql += "	GROUP BY BP_CD) B ";
		sql += "	ON A.BP_CD = B.BP_CD ";
		sql += " WHERE A.BP_SEQ=1 ";
		
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("BP_CD", rs.getString("BP_CD"));
			subObject.put("BUYER_ADDR", rs.getString("BUYER_ADDR"));
			subObject.put("CONSIGNEE", rs.getString("CONSIGNEE"));
			subObject.put("NOTIFY", rs.getString("NOTIFY"));
			subObject.put("SHIP_MARK", rs.getString("SHIP_MARK"));
			subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
			subObject.put("LOADING_PORT", rs.getString("LOADING_PORT"));
			subObject.put("PAY_METH", rs.getString("PAY_METH"));
			subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

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


