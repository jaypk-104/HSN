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

		if (V_CLASS.equals("GRID")) {
			if(V_TYPE.equals("E01") || V_TYPE.equals("E02") || V_TYPE.equals("E03")){
				String SQL =       "SELECT PDATE                                                                                                         ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(GI,1, INSTR(GI,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1           ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(GI,INSTR(GI,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1          ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN,1, INSTR(YN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2           ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(YN,INSTR(YN,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1          ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(AVERAGE,1, INSTR(AVERAGE,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3 ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(AVERAGE,INSTR(AVERAGE,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1";
						SQL = SQL + "    , REMARK                                                                                                         ";
						SQL = SQL + "FROM R_STEEL_SCRAP WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";

				
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
			else if(V_TYPE.equals("E04")){
				String SQL =       "SELECT A.PDATE                                                                                                           ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(A.GI,1, INSTR(A.GI,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1           ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(A.GI,INSTR(A.GI,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1          ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(A.YN,1, INSTR(A.YN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2           ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(A.YN,INSTR(A.YN,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1          ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(A.AVERAGE,1, INSTR(A.AVERAGE,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3 ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(A.AVERAGE,INSTR(A.AVERAGE,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(B.GI,1, INSTR(B.GI,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE4           ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(B.GI,INSTR(B.GI,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE4_1          ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(B.YN,1, INSTR(B.YN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE5           ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(B.YN,INSTR(B.YN,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE5_1          ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(B.AVERAGE,1, INSTR(B.AVERAGE,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE6  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(B.AVERAGE,INSTR(B.AVERAGE,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE6_1, A.REMARK ";
						SQL = SQL + "FROM R_STEEL_SCRAP A                                                                                                     ";
						SQL = SQL + "LEFT OUTER JOIN R_STEEL_SCRAP B ON A.PDATE = B.PDATE                                                                     ";
						SQL = SQL + "WHERE A.PGM_ID = 'E04-1' AND B.PGM_ID ='E04-2' and A.PDATE >= '" + V_FROM_DT + "' AND A.PDATE <= '" + V_TO_DT + "' ORDER BY A.PDATE desc";
				
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
			else if(V_TYPE.equals("E05")){
				String SQL =       "SELECT PDATE                                                                                                 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(KI1,1, INSTR(KI1,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(KI1,INSTR(KI1,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN1,1, INSTR(YN1,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(YN1,INSTR(YN1,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(KI2,1, INSTR(KI2,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(KI2,INSTR(KI2,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN2,1, INSTR(YN2,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE4  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(YN2,INSTR(YN2,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE4_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(KI3,1, INSTR(KI3,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE5  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(KI3,INSTR(KI3,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE5_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN3,1, INSTR(YN3,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE6  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(YN3,INSTR(YN3,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE6_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(KI4,1, INSTR(KI4,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE7  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(KI4,INSTR(KI4,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE7_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN4,1, INSTR(YN4,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE8  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(YN4,INSTR(YN4,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE8_1 ";
						SQL = SQL + "FROM R_STEEL_DOC_PUR WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";
						
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
					subObject.put("VALUE7", rs.getString("VALUE7"));
					subObject.put("VALUE7_1", rs.getString("VALUE7_1"));
					subObject.put("VALUE8", rs.getString("VALUE8"));
					subObject.put("VALUE8_1", rs.getString("VALUE8_1"));
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
			else if(V_TYPE.equals("E06")){
				String SQL =       "SELECT PDATE                                                                                                     ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(MID,1, INSTR(MID,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1     ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(MID,INSTR(MID,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1    ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(SOUTH,1, INSTR(SOUTH,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2 ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(SOUTH,INSTR(SOUTH,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(TOTAL,1, INSTR(TOTAL,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(TOTAL,INSTR(TOTAL,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1, REMARK ";
						SQL = SQL + "FROM R_STEEL_DOC_STOCK WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";

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
			else if(V_TYPE.equals("E07")){
				String SQL =       "SELECT PDATE                                                                                                                   ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(USA_TWN,1, INSTR(USA_TWN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1           ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(USA_TWN,INSTR(USA_TWN,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1          ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(USA_COMP,1, INSTR(USA_COMP,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2         ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(USA_COMP,INSTR(USA_COMP,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1        ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(USA_MIDWEST,1, INSTR(USA_MIDWEST,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3   ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(USA_MIDWEST,INSTR(USA_MIDWEST,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1  ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(TUR_BULK,1, INSTR(TUR_BULK,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE4         ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(TUR_BULK,INSTR(TUR_BULK,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE4_1        ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(TUR_RUS,1, INSTR(TUR_RUS,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE5           ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(TUR_RUS,INSTR(TUR_RUS,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE5_1          ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(JPN_LOCAL,1, INSTR(JPN_LOCAL,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE6       ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(JPN_LOCAL,INSTR(JPN_LOCAL,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE6_1      ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(BRA_IMPORT,1, INSTR(BRA_IMPORT,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE7     ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(BRA_IMPORT,INSTR(BRA_IMPORT,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE7_1    ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(EASIA_INPORT,1, INSTR(EASIA_INPORT,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE8 ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(EASIA_INPORT,INSTR(EASIA_INPORT,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE8_1";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(CHN_LOCAL,1, INSTR(CHN_LOCAL,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE9       ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(CHN_LOCAL,INSTR(CHN_LOCAL,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE9_1      ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(IND_LOCAL,1, INSTR(IND_LOCAL,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE10      ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(IND_LOCAL,INSTR(IND_LOCAL,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE10_1     ";
						SQL = SQL + "FROM R_STEEL_OVERSEA_PRICE WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";
						
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
					subObject.put("VALUE7", rs.getString("VALUE7"));
					subObject.put("VALUE7_1", rs.getString("VALUE7_1"));
					subObject.put("VALUE8", rs.getString("VALUE8"));
					subObject.put("VALUE8_1", rs.getString("VALUE8_1"));
					subObject.put("VALUE9", rs.getString("VALUE9"));
					subObject.put("VALUE9_1", rs.getString("VALUE9_1"));
					subObject.put("VALUE10", rs.getString("VALUE10"));
					subObject.put("VALUE10_1", rs.getString("VALUE10_1"));
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
			else if(V_TYPE.equals("E08")){
				String SQL =       "SELECT PDATE                                                                                                 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(USA,1, INSTR(USA,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1 ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(USA,INSTR(USA,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(JPN,1, INSTR(JPN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(JPN,INSTR(JPN,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(RUS,1, INSTR(RUS,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(RUS,INSTR(RUS,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1, REMARK ";
						SQL = SQL + "FROM R_STEEL_KOR_IMPORT  WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";
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
			else if(V_TYPE.equals("E09")){
				String SQL =       "SELECT PDATE                                                                                                     ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(CITY1,1, INSTR(CITY1,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1 ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(CITY1,INSTR(CITY1,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(CITY2,1, INSTR(CITY2,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(CITY2,INSTR(CITY2,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1, REMARK ";
						SQL = SQL + "FROM R_STEEL_TOKYOTEKKO  WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE desc";

				rs = stmt.executeQuery(SQL);

						while (rs.next()) {
							subObject = new JSONObject();
							
							subObject.put("PDATE", rs.getString("PDATE"));
							subObject.put("VALUE1", rs.getString("VALUE1"));
							subObject.put("VALUE1_1", rs.getString("VALUE1_1"));
							subObject.put("VALUE2", rs.getString("VALUE2"));
							subObject.put("VALUE2_1", rs.getString("VALUE2_1"));
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
			
		}
		
		else if (V_CLASS.equals("CHART")) {
			if(V_TYPE.equals("E01") || V_TYPE.equals("E02") || V_TYPE.equals("E03")){
				String SQL =       "SELECT TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE                                                                                                         ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(GI,1, INSTR(GI,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1           ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN,1, INSTR(YN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2           ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(AVERAGE,1, INSTR(AVERAGE,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3 ";
				SQL = SQL + "    , REMARK                                                                                                         ";
				SQL = SQL + "FROM R_STEEL_SCRAP WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE ";
				
				rs = stmt.executeQuery(SQL);
				
	
				while (rs.next()) {
					subObject = new JSONObject();
					
					subObject.put("PDATE", rs.getString("PDATE"));
					subObject.put("VALUE1", rs.getString("VALUE1"));
					subObject.put("VALUE2", rs.getString("VALUE2"));
					subObject.put("VALUE3", rs.getString("VALUE3"));
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
			else if(V_TYPE.equals("E04")){
				String SQL =       "SELECT TO_CHAR(A.PDATE, 'YYYY-MM-DD') PDATE                                                                                                         ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(A.GI,1, INSTR(A.GI,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1           ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(A.YN,1, INSTR(A.YN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2           ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(A.AVERAGE,1, INSTR(A.AVERAGE,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3 ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(B.GI,1, INSTR(B.GI,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE4           ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(B.YN,1, INSTR(B.YN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE5           ";
				SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(B.AVERAGE,1, INSTR(B.AVERAGE,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE6  ";
				SQL = SQL + "FROM R_STEEL_SCRAP A                                                                                                     ";
				SQL = SQL + "LEFT OUTER JOIN R_STEEL_SCRAP B ON A.PDATE = B.PDATE                                                                     ";
				SQL = SQL + "WHERE A.PGM_ID = 'E04-1' AND B.PGM_ID ='E04-2' and A.PDATE >= '" + V_FROM_DT + "' AND A.PDATE <= '" + V_TO_DT + "' ORDER BY A.PDATE ";
				
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
			else if(V_TYPE.equals("E05")){
				String SQL =       "SELECT TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE                                                                                                         ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(KI1,1, INSTR(KI1,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1  ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN1,1, INSTR(YN1,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2  ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(KI2,1, INSTR(KI2,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3  ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN2,1, INSTR(YN2,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE4  ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(KI3,1, INSTR(KI3,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE5  ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN3,1, INSTR(YN3,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE6  ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(KI4,1, INSTR(KI4,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE7  ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(YN4,1, INSTR(YN4,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE8  ";
						SQL = SQL + "FROM R_STEEL_DOC_PUR WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE";
						
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
					subObject.put("VALUE7", rs.getString("VALUE7"));
					subObject.put("VALUE8", rs.getString("VALUE8"));
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
			else if(V_TYPE.equals("E06")){
				String SQL =       "SELECT TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE                                                                                                         ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(MID,1, INSTR(MID,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1     ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(MID,INSTR(MID,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1    ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(SOUTH,1, INSTR(SOUTH,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2 ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(SOUTH,INSTR(SOUTH,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(TOTAL,1, INSTR(TOTAL,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3  ";
						SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(TOTAL,INSTR(TOTAL,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1, REMARK ";
						SQL = SQL + "FROM R_STEEL_DOC_STOCK WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE";

				rs = stmt.executeQuery(SQL);

						while (rs.next()) {
							subObject = new JSONObject();
							
							subObject.put("PDATE", rs.getString("PDATE"));
							subObject.put("VALUE1", rs.getString("VALUE1"));
							subObject.put("VALUE2", rs.getString("VALUE2"));
							subObject.put("VALUE3", rs.getString("VALUE3"));
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
			else if(V_TYPE.equals("E07")){
				String SQL =       "SELECT TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE                                                                                                         ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(USA_TWN,1, INSTR(USA_TWN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1           ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(USA_COMP,1, INSTR(USA_COMP,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2         ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(USA_MIDWEST,1, INSTR(USA_MIDWEST,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3   ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(TUR_BULK,1, INSTR(TUR_BULK,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE4         ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(TUR_RUS,1, INSTR(TUR_RUS,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE5           ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(JPN_LOCAL,1, INSTR(JPN_LOCAL,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE6       ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(BRA_IMPORT,1, INSTR(BRA_IMPORT,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE7     ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(EASIA_INPORT,1, INSTR(EASIA_INPORT,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE8 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(CHN_LOCAL,1, INSTR(CHN_LOCAL,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE9       ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(IND_LOCAL,1, INSTR(IND_LOCAL,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE10      ";
						SQL = SQL + "FROM R_STEEL_OVERSEA_PRICE WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE ";
						
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
					subObject.put("VALUE7", rs.getString("VALUE7"));
					subObject.put("VALUE8", rs.getString("VALUE8"));
					subObject.put("VALUE9", rs.getString("VALUE9"));
					subObject.put("VALUE10", rs.getString("VALUE10"));
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
			else if(V_TYPE.equals("E08")){
					String SQL =       "SELECT TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE                                                                                                         ";
							SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(USA,1, INSTR(USA,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1 ";
							SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(USA,INSTR(USA,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE1_1 ";
							SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(JPN,1, INSTR(JPN,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2  ";
							SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(JPN,INSTR(JPN,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE2_1 ";
							SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(RUS,1, INSTR(RUS,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE3  ";
							SQL = SQL + "    , NVL(REPLACE(REPLACE(SUBSTR(RUS,INSTR(RUS,CHR(13),'1','1') ), CHR(10), ''), CHR(13), ''), 0) AS VALUE3_1, REMARK ";
							SQL = SQL + "FROM R_STEEL_KOR_IMPORT WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE ";
					rs = stmt.executeQuery(SQL);

					while (rs.next()) {
						subObject = new JSONObject();
						
						subObject.put("PDATE", rs.getString("PDATE"));
						subObject.put("VALUE1", rs.getString("VALUE1"));
						subObject.put("VALUE2", rs.getString("VALUE2"));
						subObject.put("VALUE3", rs.getString("VALUE3"));
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
			else if(V_TYPE.equals("E09")){
				String SQL =       "SELECT TO_CHAR(PDATE, 'YYYY-MM-DD') PDATE                                                                                                         ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(CITY1,1, INSTR(CITY1,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE1 ";
						SQL = SQL + "    ,NVL(REPLACE(REPLACE(SUBSTR(CITY2,1, INSTR(CITY2,CHR(13),'1','1')), CHR(10), ''), CHR(13), ''), 0) AS VALUE2  ";
						SQL = SQL + "FROM R_STEEL_TOKYOTEKKO  WHERE PGM_ID  = '" + V_TYPE + "' and PDATE >= '" + V_FROM_DT + "' AND PDATE <= '" + V_TO_DT + "' ORDER BY PDATE";

				rs = stmt.executeQuery(SQL);

				while (rs.next()) {
					subObject = new JSONObject();
					
					subObject.put("PDATE", rs.getString("PDATE"));
					subObject.put("VALUE1", rs.getString("VALUE1"));
					subObject.put("VALUE2", rs.getString("VALUE2"));
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


