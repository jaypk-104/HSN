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
// 		System.out.println("ASN팝업상단그리드");
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

// 		String MAST_PO_NO = request.getParameter("MAST_PO_NO");
// 		String MAST_PO_SEQ = request.getParameter("MAST_PO_SEQ");
// 		String PO_NO_SEQ = MAST_PO_NO + MAST_PO_SEQ;
		String ASN_NO = request.getParameter("ASN_NO");
// 		System.out.println(ASN_NO);

		//ASN팝업 상단그리드
		/*
		String sql = "SELECT A.ASN_NO,A.MAST_PO_NO,A.MAST_PO_SEQ,A.MAST_PO_SEQ_NO,A.ITEM_CD,B.ITEM_NM,B.SPEC,B.STOCK_UNIT,A.GR_QTY, A.PRINT_FLG, ";
		sql += "A.ASN_STS,A.CFM_YN,C.DTL_NM ASN_STS_NM, D.DLVY_DT,D.PO_QTY, D.PO_QTY-E.BARCD_QTY AS REMAIN_QTY, A.DLV_AVL_QTY,A.DLV_AVL_DT  ";
		sql += "FROM SUPP_BARCD_MST  A, B_ITEM_SWM B ,B_DTL_INFO c,M_PO_SURVEY_DTL D, SUPP_BARCD_MST_CNT E   ";
		sql += "WHERE A.ITEM_CD=B.ITEM_CD and a.ASN_STS=c.dtl_cd and c.mast_cd='HSNA2' ";
		sql += "AND A.MAST_PO_NO=D.MAST_PO_NO AND A.MAST_PO_SEQ=D.MAST_PO_SEQ "; // AND GR_QTY=0
		sql += "AND d.MAST_PO_NO=E.MAST_PO_NO AND d.MAST_PO_SEQ=E.MAST_PO_SEQ ";
		sql += "AND ASN_NO='"+ASN_NO+"' ";
		sql += "ORDER BY A.ASN_NO";
// 		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		*/
		
		cs = conn.prepareCall("call USP_SUPP_SELECT(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "POP_HD");
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
		  subObject.put("MAST_PO_NO", rs.getString("MAST_PO_NO"));
		  subObject.put("MAST_PO_SEQ", rs.getString("MAST_PO_SEQ"));
		  subObject.put("MAST_PO_SEQ_NO", rs.getString("MAST_PO_SEQ_NO"));
		  subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
		  subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
		  subObject.put("SPEC", rs.getString("SPEC"));
		  subObject.put("STOCK_UNIT", rs.getString("STOCK_UNIT"));
		  subObject.put("ASN_STS", rs.getString("ASN_STS"));
		  subObject.put("ASN_STS_NM", rs.getString("ASN_STS_NM"));
		  subObject.put("CFM_YN", rs.getString("CFM_YN"));
		  subObject.put("DLVY_DT", rs.getString("DLVY_DT"));
		  subObject.put("PO_QTY", rs.getString("PO_QTY"));
		  subObject.put("REMAIN_QTY", rs.getString("REMAIN_QTY"));
		  subObject.put("DLV_AVL_QTY", rs.getString("DLV_AVL_QTY"));
		  subObject.put("DLV_AVL_DT", rs.getString("DLV_AVL_DT").substring(0, 10));
		  subObject.put("GR_QTY", rs.getString("GR_QTY"));
		  subObject.put("PRINT_FLG", rs.getString("PRINT_FLG"));
		  jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	} catch (Exception e) {
		e.printStackTrace();
	}finally{
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

