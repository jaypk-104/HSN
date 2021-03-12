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

		//MyViewport
		String u_pono = request.getParameter("u_pono");
		String u_dlvy_dt_from = request.getParameter("u_dlvy_dt_from").length() == 0 ? "" : request.getParameter("u_dlvy_dt_from").substring(0, 10);
		String u_dlvy_dt_to = request.getParameter("u_dlvy_dt_to").length() == 0 ? "" : request.getParameter("u_dlvy_dt_to").substring(0, 10);
		String u_itemcd = request.getParameter("u_itemcd");
		String u_gr_dt_from = request.getParameter("u_gr_dt_from").length() == 0 ? "" : request.getParameter("u_gr_dt_from").substring(0, 10);
		String u_gr_dt_to = request.getParameter("u_gr_dt_to").length() == 0 ? "" : request.getParameter("u_gr_dt_to").substring(0, 10);
		String u_dn_dt_from = request.getParameter("u_dn_dt_from").length() == 0 ? "" : request.getParameter("u_dn_dt_from").substring(0, 10);
		String u_dn_dt_to = request.getParameter("u_dn_dt_to").length() == 0 ? "" : request.getParameter("u_dn_dt_to").substring(0, 10);
		String u_bp_cd = request.getParameter("u_bp_cd");
		
		
		
		/*
		if(u_bp_cd.equals("00000")){
			u_bp_cd = "";
		}

		String sql = " SELECT A.CUST_PO_NO,A.CUST_PO_SEQ,B.MAST_PO_NO,B.MAST_PO_SEQ,B.PO_DT,A.BP_CD,AX.BP_NM, A.ITEM_CD,E.ITEM_NM,";
		sql += " E.SPEC,B.PO_QTY, B.DLVY_DT, C.DLV_AVL_DT, NVL(C.ASN_NO,'') ASN_NO, SUM(NVL(D.BOX_QTY,'')) DLV_AVL_QTY ";
		sql += " ,TO_CHAR(NVL(F.GR_DT,''), 'YYYY-MM-DD') GR_DT,SUM(F.GR_QTY) GR_QTY,TO_CHAR(NVL(G.DN_DT,''), 'YYYY-MM-DD') DN_DT,SUM(G.DN_QTY) DN_QTY,  ";
		sql += " CASE H.PLANT_CD WHEN '03' THEN 'HSAM(멕시코)' WHEN '01' THEN 'HSAA(미국)' ELSE 'HSAU(미국)' END PLANT_NM";
		sql += " FROM M_PO_SURVEY A LEFT OUTER JOIN M_PO_SURVEY_DTL B ";
		sql += " on A.po_no=b.po_no and a.po_seq=b.po_seq ";
		sql += " LEFT OUTER JOIN B_BIZ_INFO AX ON A.BP_CD = AX.BP_CD ";
		sql += " LEFT OUTER JOIN SUPP_BARCD_MST C ON B.MAST_PO_NO=C.MAST_PO_NO AND B.MAST_PO_SEQ=C.MAST_PO_SEQ ";
		sql += " LEFT OUTER JOIN SUPP_BARCD_DTL D ON C.ASN_NO=D.ASN_NO AND C.MAST_PO_NO=D.MAST_PO_NO AND C.MAST_PO_SEQ=D.MAST_PO_SEQ ";
		sql += " LEFT OUTER JOIN B_ITEM_SWM E ON A.ITEM_CD=E.ITEM_CD ";
		sql += " LEFT OUTER JOIN M_SUPP_TO_GR F ON D.MAST_PO_NO=F.MAST_PO_NO AND D.MAST_PO_SEQ=F.MAST_PO_SEQ ";
		sql += " AND D.BOX_BC_NO=F.BOX_BC_NO ";
		sql += " LEFT OUTER JOIN S_DN_HSNA G ON F.BOX_BC_NO=G.BOX_BC_NO ";
		sql += " LEFT OUTER JOIN M_PO_REC_HSNA H ON A.CUST_PO_NO = H.PO_NO  AND A.CUST_PO_SEQ = H.PO_SEQ  ";
		sql += " WHERE B.MAST_PO_NO LIKE '%" + u_pono + "%'";
		sql += " AND A.BP_CD LIKE '%" + u_bp_cd + "%'";
		sql += " AND A.ITEM_CD LIKE '%" + u_itemcd + "%'";
		if (u_dlvy_dt_to.length() != 0) {
			sql += " AND TO_CHAR(NVL(B.DLVY_DT,''), 'YYYY-MM-DD')  <= '" + u_dlvy_dt_to + "'  AND B.DLVY_DT IS NOT NULL ";
		}
		if (u_dlvy_dt_from.length() != 0) {
			sql += " AND TO_CHAR(NVL(B.DLVY_DT,''), 'YYYY-MM-DD')  >= '" + u_dlvy_dt_from + "'  AND B.DLVY_DT IS NOT NULL ";
		}
		if (u_gr_dt_to.length() != 0) {
			sql += " AND TO_CHAR(NVL(F.GR_DT,''), 'YYYY-MM-DD')  <= '" + u_gr_dt_to + "'  AND F.GR_DT IS NOT NULL ";
		}
		if (u_gr_dt_from.length() != 0) {
			sql += " AND TO_CHAR(NVL(F.GR_DT,''), 'YYYY-MM-DD')  >= '" + u_gr_dt_from + "' AND F.GR_DT IS NOT NULL ";
		}
		if (u_dn_dt_to.length() != 0) {
			sql += " AND TO_CHAR(NVL(G.DN_DT,''), 'YYYY-MM-DD')  <= '" + u_dn_dt_to + "' AND G.DN_DT IS NOT NULL";
		}
		if (u_dn_dt_from.length() != 0) {
			sql += " AND TO_CHAR(NVL(G.DN_DT,''), 'YYYY-MM-DD')  >= '" + u_dn_dt_from + "'  AND G.DN_DT IS NOT NULL";
		}

		sql += " GROUP BY A.CUST_PO_NO,A.CUST_PO_SEQ,B.MAST_PO_NO,B.MAST_PO_SEQ,B.PO_DT,A.BP_CD,AX.BP_NM,A.ITEM_CD,E.ITEM_NM, ";
		sql += " E.SPEC, B.PO_QTY, B.DLVY_DT,C.DLV_AVL_DT,C.ASN_NO,F.GR_DT,G.DN_DT, ";
		sql += " CASE H.PLANT_CD WHEN '03' THEN 'HSAM(멕시코)' WHEN '01' THEN 'HSAA(미국)' ELSE 'HSAU(미국)' END ";
		sql += " ORDER BY MAST_PO_NO, TO_NUMBER(MAST_PO_SEQ) ";

// 		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		*/

		cs = conn.prepareCall("call USP_SUPP_INOUTSTATUS_SELECT(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, u_pono);
		cs.setString(3, u_itemcd);
		cs.setString(4, u_dlvy_dt_from);
		cs.setString(5, u_dlvy_dt_to);
		cs.setString(6, u_gr_dt_from);
		cs.setString(7, u_gr_dt_to);
		cs.setString(8, u_dn_dt_from);
		cs.setString(9, u_dn_dt_to);
		cs.setString(10, u_bp_cd);
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(11);
		
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("MAST_PO_NO", rs.getString("MAST_PO_NO"));
			subObject.put("MAST_PO_SEQ", rs.getString("MAST_PO_SEQ"));
			subObject.put("PO_DT", (rs.getString("PO_DT") == null) ? "" : rs.getString("PO_DT").substring(0, 10));
			subObject.put("BP_CD", rs.getString("BP_CD"));
			subObject.put("BP_NM", rs.getString("BP_NM"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("PO_QTY", rs.getString("PO_QTY"));
			subObject.put("DLVY_DT", (rs.getString("DLVY_DT") == null) ? "" : rs.getString("DLVY_DT").substring(0, 10));
			subObject.put("ASN_NO", rs.getString("ASN_NO"));
			subObject.put("DLV_AVL_DT", (rs.getString("DLV_AVL_DT") == null) ? "" : rs.getString("DLV_AVL_DT").substring(0, 10));
			subObject.put("DLV_AVL_QTY", rs.getString("DLV_AVL_QTY"));
			subObject.put("GR_DT", (rs.getString("GR_DT") == null) ? "" : rs.getString("GR_DT").substring(0, 10));
			subObject.put("GR_QTY", rs.getString("GR_QTY"));
			subObject.put("DN_DT", (rs.getString("DN_DT") == null) ? "" : rs.getString("DN_DT").substring(0, 10));
			subObject.put("DN_QTY", rs.getString("DN_QTY"));
			subObject.put("PLANT_NM", rs.getString("PLANT_NM"));
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








