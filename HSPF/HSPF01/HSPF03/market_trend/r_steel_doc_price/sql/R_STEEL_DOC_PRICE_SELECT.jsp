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

		if (V_CLASS.equals("V6")) {
			
			String SQL =       "SELECT PDATE                                                                                               ";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE1,1, INSTR(VALUE1,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE1,INSTR(VALUE1,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE2,1, INSTR(VALUE2,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE2,INSTR(VALUE2,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE3,1, INSTR(VALUE3,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE3,INSTR(VALUE3,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE4,1, INSTR(VALUE4,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE4";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE4,INSTR(VALUE4,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE4_1";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE5,1, INSTR(VALUE5,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE5";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE5,INSTR(VALUE5,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE5_1";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE6,1, INSTR(VALUE6,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE6";
					SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(VALUE6,INSTR(VALUE6,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE6_1, REMARK ";
					SQL = SQL + " FROM R_STEEL_DOC_PRICE_VAL6 WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";

			
			rs = stmt.executeQuery(SQL);

			while (rs.next()) {
				subObject = new JSONObject();
				
				subObject.put("PDATE", rs.getString("PDATE"));
				subObject.put("VALUE1", rs.getString("VALUE1"));
				subObject.put("VALUE1_1", rs.getString("VALUE1_1"));
				subObject.put("VALUE2", rs.getString("VALUE2"));
				subObject.put("VALUE2_1", rs.getString("VALUE2_1"));
				subObject.put("VALUE3", rs.getString("VALUE3"));
				subObject.put("VALUE3_1", rs.getString("VALUE3_1"));
				subObject.put("VALUE4", rs.getString("VALUE4"));
				subObject.put("VALUE4_1", rs.getString("VALUE4_1"));
				subObject.put("VALUE5", rs.getString("VALUE5"));
				subObject.put("VALUE5_1", rs.getString("VALUE5_1"));
				subObject.put("VALUE6", rs.getString("VALUE6"));
				subObject.put("VALUE6_1", rs.getString("VALUE6_1"));
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
			String SQL =       "SELECT TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE                                                                                               ";
			SQL = SQL + "    , REPLACE(REPLACE(SUBSTR(VALUE1,1, INSTR(VALUE1,CHR(13),'1','1')), CHR(10), ''), CHR(13), '') AS VALUE1";
			SQL = SQL + "    , REPLACE(REPLACE(SUBSTR(VALUE2,1, INSTR(VALUE2,CHR(13),'1','1')), CHR(10), ''), CHR(13), '') AS VALUE2";
			SQL = SQL + "    , REPLACE(REPLACE(SUBSTR(VALUE3,1, INSTR(VALUE3,CHR(13),'1','1')), CHR(10), ''), CHR(13), '') AS VALUE3";
			SQL = SQL + "    , REPLACE(REPLACE(SUBSTR(VALUE4,1, INSTR(VALUE4,CHR(13),'1','1')), CHR(10), ''), CHR(13), '') AS VALUE4";
			SQL = SQL + "    , REPLACE(REPLACE(SUBSTR(VALUE5,1, INSTR(VALUE5,CHR(13),'1','1')), CHR(10), ''), CHR(13), '') AS VALUE5";
			SQL = SQL + "    , REPLACE(REPLACE(SUBSTR(VALUE6,1, INSTR(VALUE6,CHR(13),'1','1')), CHR(10), ''), CHR(13), '') AS VALUE6";
			SQL = SQL + " FROM R_STEEL_DOC_PRICE_VAL6 WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE";

	
			rs = stmt.executeQuery(SQL);
			

			while (rs.next()) {
				subObject = new JSONObject();
				
				subObject.put("PDATE", rs.getString("PDATE"));
				subObject.put("VALUE1", rs.getString("VALUE1"));
				subObject.put("VALUE2", rs.getString("VALUE2"));
				subObject.put("VALUE3", rs.getString("VALUE3"));
				subObject.put("VALUE4", rs.getString("VALUE4"));
				subObject.put("VALUE5", rs.getString("VALUE5"));
				subObject.put("VALUE6", rs.getString("VALUE6"));
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


