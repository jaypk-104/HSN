<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
 <%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		String V_GRID_NO = request.getParameter("V_GRID_NO");
		//System.out.println("V_GRID_NO : " + V_GRID_NO);
		if (V_GRID_NO.equals("1")) {
			String V_CONT_NO = request.getParameter("V_CONT_NO2");
			/*
			String sql = "SELECT DISTINCT CONT_NO, CONT_MGM_NO, CFM_YN";
			sql += " FROM S_CONTAINER_MST ";
			sql += "WHERE CONT_MGM_NO IS NOT NULL AND UPPER(CONT_NO) LIKE UPPER('%" + V_CONT_NO + "%') ";
			sql += "ORDER BY CFM_YN, CONT_NO, CONT_MGM_NO";

			rs = stmt.executeQuery(sql);
			*/
			
			cs = conn.prepareCall("call USP_S_CONTAINER_SELECT_SWM(?,?,?,?)");
			cs.setString(1, "S_LEFT");
			cs.setString(2, V_CONT_NO);
			cs.setString(3, "");
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
		
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(4);
			
			while (rs.next()) {
				subObject = new JSONObject();

				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("CONT_SIZE", rs.getString("CONT_SIZE"));
				subObject.put("CONT_SEAL_NO", rs.getString("CONT_SEAL_NO"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("PLANT_CD", rs.getString("PLANT_CD"));
				jsonArray.add(subObject);
			}

		} else if (V_GRID_NO.equals("2")) {
			String V_CONT_NO = request.getParameter("V_CONT_NO");
			String V_CONT_MGM_NO1 = request.getParameter("V_CONT_MGM_NO1");

			/*
			String sql = "SELECT C.CONT_NO,C.CONT_MGM_NO,A.PAL_BC_NO,A.BOX_BC_NO, A.ITEM_CD,B.ITEM_NM, B.STOCK_UNIT, B.SPEC, A.BOX_QTY,A.CONT_LOAD_DT, C.CFM_YN,";
			sql += " CASE WHEN A.PLANT_CD='01' THEN 'HSAA' ELSE 'HSAU'	END PLANT_CD";
			sql += " FROM S_CONTAINER_DTL A LEFT OUTER JOIN B_ITEM_SWM B ON A.ITEM_CD=B.ITEM_CD ";
			sql += " LEFT OUTER JOIN S_CONTAINER_MST C	ON A.CONT_MGM_NO=C.CONT_MGM_NO ";
			sql += " WHERE C.CONT_NO = '" + V_CONT_NO + "' AND C.CONT_MGM_NO = '" + V_CONT_MGM_NO1 + "'";

			rs = stmt.executeQuery(sql);
			*/
			
			cs = conn.prepareCall("call USP_S_CONTAINER_SELECT_SWM(?,?,?,?)");
			cs.setString(1, "S_RIGHT_SUM");
			cs.setString(2, V_CONT_NO);
			cs.setString(3, V_CONT_MGM_NO1);
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
		
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(4);

			//rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				subObject = new JSONObject();
// 				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
// 				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("STOCK_UNIT", rs.getString("UNIT"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PLANT_CD", rs.getString("PLANT_CD"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("CONT_LOAD_DT", rs.getString("CONT_LOAD_DT") == null ? "" : rs.getString("CONT_LOAD_DT").substring(0, 10));
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				jsonArray.add(subObject);
				
			}
			
			
			
			
		} //else {}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		// 	  System.out.println(jsonObject);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
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
