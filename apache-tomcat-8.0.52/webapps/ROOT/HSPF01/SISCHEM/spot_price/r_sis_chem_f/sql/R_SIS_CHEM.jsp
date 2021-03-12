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
		String V_CLASS = request.getParameter("V_CLASS") == null ? "" : request.getParameter("V_CLASS");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_FROM_DT = request.getParameter("V_FROM_DT") == null ? "" : request.getParameter("V_FROM_DT").substring(0, 10);
		String V_TO_DT = request.getParameter("V_TO_DT") == null ? "" : request.getParameter("V_TO_DT").substring(0, 10);
		
		if (V_CLASS.equals("NUM")) {
			String sql = "SELECT  TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE, NEWS, USGS, KORS, TAIS, SEAS, JAPS FROM R_CIS_CHEM_NUM_HSPF WHERE PGM_ID = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";
			
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				subObject = new JSONObject();
				
				subObject.put("PDATE", rs.getString("PDATE"));
				subObject.put("NEWS", rs.getString("NEWS"));
				subObject.put("USGS", rs.getString("USGS"));
				subObject.put("KORS", rs.getString("KORS"));
				subObject.put("TAIS", rs.getString("TAIS"));
				subObject.put("SEAS", rs.getString("SEAS"));
				subObject.put("JAPS", rs.getString("JAPS"));
				jsonArray.add(subObject);

			}
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}

		else if (V_CLASS.equals("CHAR")) {
			String sql = "SELECT  TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE, REGION, PRICE, REMARK FROM R_CIS_CHEM_CHAR_REG_HSPF WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";
			
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				subObject = new JSONObject();
				
				subObject.put("PDATE", rs.getString("PDATE"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("REMARK", rs.getString("REMARK"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}
		else if (V_CLASS.equals("CHART")) {
			String sql = "SELECT  TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE, MAXS FROM R_CIS_CHEM_NUM_HSPF WHERE PGM_ID = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ";
			
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				subObject = new JSONObject();
				
				subObject.put("PDATE", rs.getString("PDATE"));
				subObject.put("MAXS", rs.getString("MAXS"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
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


