<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="HSPLATFORM.HSCOMMON"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");

	String W_S_BP_CD = request.getParameter("W_S_BP_CD") == null ? "" : request.getParameter("W_S_BP_CD").toUpperCase();
	String W_S_BP_NM = request.getParameter("W_S_BP_NM") == null ? "" : request.getParameter("W_S_BP_NM").toUpperCase();

	String sql = "";
	sql += "SELECT A.COMP_ID, A.ITEM_CD, A.ITEM_NM, A.SPEC, A.UNIT, A.MAKER, B.BP_CD, B.S_PRICE, C.BP_NM ";
	sql += "FROM B_ITEM_HSPF A                                                                           ";
	sql += "LEFT OUTER JOIN B_ITEM_SALE_HSPF B ON A.ITEM_CD = B.ITEM_CD                                  ";
	sql += "LEFT OUTER JOIN B_BIZ_HSPF C ON B.BP_CD = C.BP_CD                                            ";
	sql += "WHERE 1=1                                                                                    ";
	sql += "AND A.COMP_ID = B.COMP_ID                                                                    ";
	sql += "AND A.ITEM_CD LIKE '%"+W_S_BP_CD+"%'                                                                      ";
	sql += "AND A.ITEM_NM LIKE '%"+W_S_BP_NM+"%';                                                                     ";
	sql += "                                                                                             ";

	rs = stmt.executeQuery(sql);
	while (rs.next()) {
		subObject = new JSONObject();

		subObject.put("COMP_ID", rs.getString("COMP_ID"));
		subObject.put("W_ITEM_CD", rs.getString("ITEM_CD"));
		subObject.put("W_ITEM_NM", rs.getString("ITEM_NM"));
		subObject.put("W_SPEC", rs.getString("SPEC"));
		subObject.put("W_UNIT", rs.getString("UNIT"));
		subObject.put("W_MAKER", rs.getString("MAKER"));
		subObject.put("BP_CD", rs.getString("BP_CD"));
		subObject.put("W_S_BP_NM", rs.getString("BP_NM"));
		subObject.put("W_S_PRC", rs.getString("S_PRICE"));
		jsonArray.add(subObject);

	}
	jsonObject.put("success", true);
	jsonObject.put("resultList", jsonArray);

// 	System.out.println(jsonObject);
	response.setContentType("text/plain; charset=UTF-8");
	PrintWriter pw = response.getWriter();
	pw.print(jsonObject);
	pw.flush();
	pw.close();
%>

