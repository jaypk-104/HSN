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
		// 	 System.out.println("ASN팝업 하단그리드 SQL");
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		//ASN팝업 상세내역 SQL
		String ASN_NO = (request.getParameter("ASN_NO") == null || request.getParameter("ASN_NO").equals("") ? "" : request.getParameter("ASN_NO"));
		String V_EXCEL = (request.getParameter("V_EXCEL") == null ? "" : request.getParameter("V_EXCEL"));
		session.setAttribute("ASN_NO", ASN_NO);
		if (!ASN_NO.equals("") || ASN_NO != null) {
			/*
			String sql = "SELECT A.ASN_NO,A.ASN_SEQ,A.ITEM_CD,B.ITEM_NM,PAL_BC_SEQ,PAL_BC_NO,PAL_QTY,BOX_BC_SEQ,BOX_BC_NO,BOX_QTY,LOT_NO,MAKE_DT,A.VALID_DT ";
			sql += " FROM SUPP_BARCD_DTL A LEFT OUTER JOIN B_ITEM_SWM B ON A.ITEM_CD=B.ITEM_CD ";
			sql += " WHERE A.ASN_NO='" + ASN_NO + "'";

			// 			System.out.println(sql);

			rs = stmt.executeQuery(sql);
			*/
			
			cs = conn.prepareCall("call USP_SUPP_SELECT(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "POP_DTL");
			cs.setString(2, ASN_NO);
			cs.setString(3, "");
			cs.setString(4, "");
			cs.setString(5, "");
			cs.setString(6, "");
			cs.setString(7, "");
			cs.setString(8, "");
			cs.setString(9, "");
			cs.setString(10, "");
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);

			while (rs.next()) {
				subObject = new JSONObject();

				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("ASN_SEQ", rs.getString("ASN_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PAL_BC_SEQ", rs.getString("PAL_BC_SEQ"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("PAL_QTY", rs.getString("PAL_QTY"));
				subObject.put("BOX_BC_SEQ", rs.getString("BOX_BC_SEQ"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("MAKE_DT", (rs.getString("MAKE_DT") == null ? "" : rs.getString("MAKE_DT").substring(0, 10)));
				subObject.put("VALID_DT", (rs.getString("VALID_DT") == null ? "" : rs.getString("VALID_DT").substring(0, 10)));
				jsonArray.add(subObject);
			}
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			// 	  System.out.println(jsonObject);

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

