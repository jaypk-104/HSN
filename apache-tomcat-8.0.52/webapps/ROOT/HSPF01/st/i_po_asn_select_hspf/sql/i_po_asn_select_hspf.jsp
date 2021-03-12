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

		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toString();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toString();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toString();
		
		
		
		if( V_TYPE.equals("S")){
			String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").toString().substring(0,10);
			String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").toString().substring(0,10);
			String V_DLVY_AVL_DT_FR = request.getParameter("V_DLVY_AVL_DT_FR") == null ? "" : request.getParameter("V_DLVY_AVL_DT_FR").toString().substring(0,10);
			String V_DLVY_AVL_DT_TO = request.getParameter("V_DLVY_AVL_DT_TO") == null ? "" : request.getParameter("V_DLVY_AVL_DT_TO").toString().substring(0,10);
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toString().toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toString().toUpperCase();
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toString();
			String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toString().toUpperCase();
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toString();
			String V_BL_NO = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BL_NO").toString().toUpperCase();
			String V_BC_NO = request.getParameter("V_BC_NO") == null ? "" : request.getParameter("V_BC_NO").toString().toUpperCase();
			
			cs = conn.prepareCall("call USP_I_PO_ASN_SELECT(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(3, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(4, V_DLVY_AVL_DT_FR);//V_DLVY_AVL_DT_FR
			cs.setString(5, V_DLVY_AVL_DT_TO);//V_DLVY_AVL_DT_TO
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD
			cs.setString(7, V_ITEM_NM);//V_ITEM_NM
			cs.setString(8, V_ASN_NO);//V_ASN_NO
			cs.setString(9, V_PO_NO);//V_PO_NO
			cs.setString(10, V_BP_CD);//V_BP_CD
			cs.setString(11, V_BL_NO);//V_BL_NO
			cs.setString(12, V_BC_NO);//V_BC_NO
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("BL_NO", rs.getString("BL_NO"));

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
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>
