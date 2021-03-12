<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		JSONObject jsonObject = new JSONObject();

		String sql = "";
		String V_MAST_CD = request.getParameter("V_MAST_CD") == null ? "" : request.getParameter("V_MAST_CD");
		String V_PARAM1 = request.getParameter("V_PARAM1") == null ? "" : request.getParameter("V_PARAM1");
		String V_PARAM2 = request.getParameter("V_PARAM2") == null ? "" : request.getParameter("V_PARAM2");
		String V_GRID = request.getParameter("V_GRID") == null ? "" : request.getParameter("V_GRID");

// 		System.out.println("V_GRID" + V_GRID);
// 		System.out.println("V_MAST_CD" + V_MAST_CD);

		if (!V_MAST_CD.equals("")) {
			if (V_MAST_CD.equals("Z_ROLE_HSPF")) {
				sql = "SELECT DTL_CD, DTL_NM, PRINT_SEQ FROM (                 ";
				sql += "SELECT ROLE_CD DTL_CD, ROLE_NM DTL_NM, ROWNUM PRINT_SEQ ";
				sql += "FROM Z_ROLE_HSPF                                   ";
				if (!V_GRID.equals("Y")) {
					sql += "UNION SELECT 'T', '전체', 0 FROM DUAL                          ";
				}
				sql += ") ORDER BY PRINT_SEQ;                                      ";

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}
			} else if (V_MAST_CD.equals("SL_N") || V_MAST_CD.equals("RC_N") || V_MAST_CD.equals("LC_N")
					|| V_MAST_CD.equals("SL") || V_MAST_CD.equals("SL_G")) { /*로케이션, 창고*/

				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, "");//V_PARAM1
				cs.setString(3, "");//V_PARAM2
				cs.setString(4, "");//V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}
			} else if (V_MAST_CD.equals("DN_REQ_LIST")) {

				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, V_PARAM1);//V_PARAM1
				cs.setString(3, "");//V_PARAM2
				cs.setString(4, "");//V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("COMP_ID", rs.getString("COMP_ID"));
					subObject.put("IDX", rs.getString("IDX"));
					subObject.put("TITLE", rs.getString("TITLE"));
					subObject.put("ARRV_COMP_ADDR", rs.getString("ARRV_COMP_ADDR"));
					jsonArray.add(subObject);
				}
			} else if (V_MAST_CD.equals("DN_REQ_DETAIL")) {

				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, V_PARAM1); //V_PARAM1
				cs.setString(3, V_PARAM2); //V_PARAM2
				cs.setString(4, ""); //V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("TO_NM", rs.getString("TO_NM"));
					subObject.put("TO_USR_NM", rs.getString("TO_USR_NM"));
					subObject.put("FROM_NM", rs.getString("FROM_NM"));
					subObject.put("FROM_USR_NM", rs.getString("FROM_USR_NM"));
					subObject.put("FROM_USR_TEL", rs.getString("FROM_USR_TEL"));
					subObject.put("TO_USR_TEL", rs.getString("TO_USR_TEL"));
					subObject.put("ARRV_COMP_NM", rs.getString("ARRV_COMP_NM"));
					subObject.put("ARRV_COMP_ADDR", rs.getString("ARRV_COMP_ADDR"));
					subObject.put("DLV_IND_NM", rs.getString("DLV_IND_NM"));
					subObject.put("REQ_TEXT", rs.getString("REQ_TEXT"));
					subObject.put("TO_USR_TEL", rs.getString("TO_USR_TEL"));
					jsonArray.add(subObject);
				}
			} else if (V_MAST_CD.equals("BANK")) {

				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, V_PARAM1); //V_PARAM1
				cs.setString(3, V_PARAM2); //V_PARAM2
				cs.setString(4, ""); //V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}
			} else if ((V_MAST_CD.equals("ST") && V_PARAM1.length() > 1)) {

				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, V_PARAM1); //V_PARAM1
				cs.setString(3, V_PARAM2); //V_PARAM2
				cs.setString(4, ""); //V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}
			} else if (V_MAST_CD.equals("SL_DISTR") && V_GRID.equals("Y")) { //일반무역창고코드

				sql = "select SL_CD DTL_CD, SL_NM DTL_NM, SL_NM SL_NM, REGION, B.DTL_NM REGION_NM, A.REF_NO ";
				sql += " from B_STORAGE_DISTR A LEFT OUTER JOIN B_DTL_INFO B ";
				sql += " ON A.REGION = B.DTL_CD AND B.MAST_CD = 'BA26' ";
				sql += " ORDER BY SL_CD ";

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					subObject.put("REGION", rs.getString("REGION"));
					subObject.put("REGION_NM", rs.getString("REGION_NM"));
					subObject.put("REF_NO", rs.getString("REF_NO"));
					jsonArray.add(subObject);
				}

			} else if (V_MAST_CD.equals("SL_DISTR") && V_GRID.equals("N")) { //일반무역창고코드
				sql = "";
				sql += "                                                                                     ";
				sql += "SELECT SL_CD DTL_CD, SL_NM DTL_NM, SL_NM SL_NM, REGION, B.DTL_NM REGION_NM, A.REF_NO, NVL(PRINT_SEQ,1) PRINT_SEQ ";
				sql += "FROM   B_STORAGE_DISTR A                                                             ";
				sql += "       LEFT OUTER JOIN B_DTL_INFO B                                                  ";
				sql += "       ON     A.REGION  = B.DTL_CD                                                   ";
				sql += "       AND    B.MAST_CD = 'BA26'                                                     ";
				sql += "UNION ALL                                                                            ";
				sql += "SELECT   'T', '전체', '전체', NULL, NULL, NULL, 0                                       ";
				sql += "FROM     DUAL                                                                        ";
				sql += " ORDER BY PRINT_SEQ, DTL_CD;                                                                 ";

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}

			} else if (V_MAST_CD.equals("MEAT_LG")) {

				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, "");//V_PARAM1
				cs.setString(3, "");//V_PARAM2
				cs.setString(4, "");//V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}
			} else if (V_MAST_CD.equals("RISK")) { //원산지코드

				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, V_PARAM1);//V_PARAM1
				cs.setString(3, "");//V_PARAM2
				cs.setString(4, "");//V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}
			} else if (V_MAST_CD.equals("ORIGIN")) { //원산지코드

				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, V_PARAM1);//V_PARAM1
				cs.setString(3, "");//V_PARAM2
				cs.setString(4, "");//V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}

			} else if (V_MAST_CD.equals("USANCE")) { //품의등록 - 유산스조건

				sql = "";
				sql += "SELECT A.DTL_CD, B.DTL_NM         ";
				sql += "FROM   B_DTL_DESC A, B_DTL_INFO B ";
				sql += "WHERE  A.COMP_ID=B.COMP_ID        ";
				sql += "AND    A.DTL_CD =B.DTL_CD         ";
				sql += "AND    A.MAST_CD=B.MAST_CD        ";
				sql += "AND    A.MAST_CD='MA03'           ";
				sql += "AND    DAYS     >0                ";
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}
			} else if (V_MAST_CD.equals("SL_STEEL")) {
				
// 				System.out.println("vvvv");
				
				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, "");//V_PARAM1
				cs.setString(3, "");//V_PARAM2
				cs.setString(4, V_GRID);//V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}

			} else if (V_MAST_CD.equals("ITEMGRP")) {
				
// 				System.out.println("vvvv");
				
				cs = conn.prepareCall("call USP_B_COMBOBOX_HSPF(?,?,?,?,?)");
				cs.setString(1, V_MAST_CD);//V_MAST_CD
				cs.setString(2, "");//V_PARAM1
				cs.setString(3, "");//V_PARAM2
				cs.setString(4, V_GRID);//V_GRID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("ITEM_GROUP_CD"));
					subObject.put("DTL_NM", rs.getString("ITEM_GROUP_NM"));
					jsonArray.add(subObject);
				}

			}
			else if (V_MAST_CD.equals("STEEL_PUR_GRP")) {
				
				sql = "SELECT PUR_GRP DTL_CD, PUR_GRP_NM DTL_NM FROM B_PUR_GRP_STEEL" ;

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					jsonArray.add(subObject);
				}

			} 
			else if (V_MAST_CD.equals("VAT_RATE")) {
				
				sql += " SELECT A.MAST_CD, A.DTL_CD, A.DTL_NM, B.VAT_RATE ";
				sql += "   FROM B_DTL_INFO A INNER JOIN B_TAX_RATE B ON A.DTL_CD = B.VAT_TYPE "; 
				sql += "  WHERE A.MAST_CD = 'BA05' " ;

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					subObject.put("DTL_NM", rs.getString("DTL_NM"));
					subObject.put("VAT_RATE", rs.getString("VAT_RATE"));
					jsonArray.add(subObject);
				}

			} 
			else {

				
				sql += " SELECT TO_CHAR(DTL_CD) DTL_CD, TO_CHAR(DTL_NM) DTL_NM, PRINT_SEQ ";
				sql += " FROM B_DTL_INFO ";
				sql += " WHERE MAST_CD = '" + V_MAST_CD + "' ";
				if (!V_GRID.equals("Y")) {
					sql += " UNION SELECT 'T' , '전체', 0  FROM dual ";
				}
				if (V_MAST_CD.equals("MA13")) {
					sql += " ORDER BY DTL_NM; ";
				} else {
					sql += " ORDER BY PRINT_SEQ, DTL_CD; ";
				}

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DTL_CD", rs.getString("DTL_CD"));
					if(V_MAST_CD.equals("MA04") || V_MAST_CD.equals("MA03")) {
						subObject.put("DTL_NM", rs.getString("DTL_NM") + " (" + rs.getString("DTL_CD") + ")");
					} else {
						subObject.put("DTL_NM", rs.getString("DTL_NM"));
					}
					jsonArray.add(subObject);
				}
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

// 			System.out.println(sql);
// 			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}

	} catch (Exception e) {
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
