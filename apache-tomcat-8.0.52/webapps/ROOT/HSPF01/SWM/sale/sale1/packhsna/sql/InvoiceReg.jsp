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

		String V_INV_MGM_NO = request.getParameter("V_INV_MGM_NO");
		/*
		 String sql = "SELECT A.INV_MGM_NO,A.CONT_NO,PAL_BC_NO,A.ITEM_CD,B.ITEM_NM FROM ";
				sql += "(SELECT INV_MGM_NO,CONT_NO,PAL_BC_NO,MAX(ITEM_CD)ITEM_CD FROM S_INVOICE_HSNA_DTL ";
				sql += " GROUP BY INV_MGM_NO,CONT_NO,PAL_BC_NO) A , B_ITEM_SWM B WHERE A.ITEM_CD=B.ITEM_CD ";
				sql += " AND A.INV_MGM_NO='"+V_INV_MGM_NO+"' ";

		rs = stmt.executeQuery(sql);
		 */

		cs = conn.prepareCall("call USP_S_INV_SELECT(?,?,?,?,?,?)");
		cs.setString(1, "S_REG_DTL");
		cs.setString(2, V_INV_MGM_NO);
		cs.setString(3, "");
		cs.setString(4, "");
		cs.setString(5, "");
		cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);

		cs.executeQuery();
		rs = (ResultSet) cs.getObject(6);

		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("INV_MGM_NO", rs.getString("INV_MGM_NO"));
			subObject.put("CONT_NO", rs.getString("CONT_NO"));
			subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
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
