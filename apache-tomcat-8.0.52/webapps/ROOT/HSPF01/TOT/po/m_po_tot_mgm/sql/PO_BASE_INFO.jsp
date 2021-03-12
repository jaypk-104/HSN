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
		String sql = "SELECT BP_CD, PO_TYPE, IN_TERMS, PAY_METH, CUR, SYS_TYPE, GR_TYPE, DLV_TYPE, VAT_TYPE, TRANS_TYPE, DISCHGE_PORT FROM M_PO_BASE_INFO_TOT_HSPF ";
		rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("BP_CD", rs.getString("BP_CD"));
			subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
			subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
			subObject.put("PAY_METH", rs.getString("PAY_METH"));
			subObject.put("CUR", rs.getString("CUR"));
			subObject.put("SYS_TYPE", rs.getString("SYS_TYPE"));
			subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
			subObject.put("DLV_TYPE", rs.getString("DLV_TYPE"));
			subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
			subObject.put("TRANS_TYPE", rs.getString("TRANS_TYPE"));
			subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
			
			jsonArray.add(subObject);
		}
		
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

//			System.out.println(sql);
//			System.out.println(jsonObject);

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
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>


