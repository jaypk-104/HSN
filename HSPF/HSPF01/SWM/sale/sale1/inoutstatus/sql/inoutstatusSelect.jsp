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

		String mast_po_no = request.getParameter("mast_po_no");
		String item_cd = request.getParameter("item_cd");
		String cust_po_no = request.getParameter("cust_po_no");
		String bp_cdORnm = request.getParameter("bp_cdORnm");
		String cont_no = request.getParameter("cont_no");
		String inv_no = request.getParameter("inv_no");
		String asn_no = request.getParameter("asn_no");
		String dlvy_from_dt = request.getParameter("dlvy_from_dt");
		String dlvy_to_dt = request.getParameter("dlvy_to_dt");
		String dn_from_dt = request.getParameter("dn_from_dt");
		String dn_to_dt = request.getParameter("dn_to_dt");
		String gr_from_dt = request.getParameter("gr_from_dt");
		String gr_to_dt = request.getParameter("gr_to_dt");

		String V_chk_AA = request.getParameter("V_chk_AA");
		String V_chk_AU = request.getParameter("V_chk_AU");
		String V_chk_AM = request.getParameter("V_chk_AM");
		String V_chk_TN = request.getParameter("V_chk_TN");

		String V_PLANT_CD = "";

		mast_po_no = (mast_po_no == null || mast_po_no.equals("") ? "" : mast_po_no.toString());
		item_cd = (item_cd == null || item_cd.equals("") ? "" : item_cd.toString());
		cust_po_no = (cust_po_no == null || cust_po_no.equals("") ? "" : cust_po_no.toString());
		bp_cdORnm = (bp_cdORnm == null || bp_cdORnm.equals("") ? "" : bp_cdORnm.toString());
		cont_no = (cont_no == null || cont_no.equals("") ? "" : cont_no.toString());
		inv_no = (inv_no == null || inv_no.equals("") ? "" : inv_no.toString());
		asn_no = (asn_no == null || asn_no.equals("") ? "" : asn_no.toString());
		dlvy_from_dt = (dlvy_from_dt == null || dlvy_from_dt.equals("") ? "0000-00-00" : dlvy_from_dt.substring(0, 10));
		dlvy_to_dt = (dlvy_to_dt == null || dlvy_to_dt.equals("") ? "9999-99-99" : dlvy_to_dt.substring(0, 10));
		dn_from_dt = (dn_from_dt == null || dn_from_dt.equals("") ? "" : dn_from_dt.substring(0, 10));
		dn_to_dt = (dn_to_dt == null || dn_to_dt.equals("") ? "" : dn_to_dt.substring(0, 10));
		gr_from_dt = (gr_from_dt == null || gr_from_dt.equals("") ? "" : gr_from_dt.substring(0, 10));
		gr_to_dt = (gr_to_dt == null || gr_to_dt.equals("") ? "" : gr_to_dt.substring(0, 10));
		
		/*

		String sql = "SELECT                                                                                                                                                                       ";
		sql += "         CASE AY.PLANT_CD                                                                                                                                                    ";
		sql += "                  WHEN '03'                                                                                                                                                  ";
		sql += "                  THEN 'HSAM'                                                                                                                                                ";
		sql += "                  WHEN '01'                                                                                                                                                  ";
		sql += "                  THEN 'HSAA'                                                                                                                                                ";
		sql += "                  ELSE 'HSAU'                                                                                                                                                ";
		sql += "         END PLANT_NM, A.CUST_PO_NO, A.CUST_PO_SEQ, B.MAST_PO_NO, B.MAST_PO_SEQ, B.PO_DT,                                                                                    ";
		sql += "         A.BP_CD, AX.BP_NM, A.ITEM_CD, E.ITEM_NM, E.SPEC, B.PO_QTY,                                                                                                          ";
		sql += "         B.DLVY_DT, C.DLV_AVL_DT, NVL (C.ASN_NO, '') ASN_NO, SUM (NVL (D.BOX_QTY, '')) DLV_AVL_QTY, TO_CHAR (NVL (F.GR_DT, ''), 'YYYY-MM-DD') GR_DT, SUM (F.GR_QTY) GR_QTY, ";
		sql += "         TO_CHAR (NVL (G.DN_DT, ''), 'YYYY-MM-DD') DN_DT, SUM (G.DN_QTY) DN_QTY, HX.CONT_NO, SUM (H.BOX_QTY) CTN_QTY, IX.INV_NO, SUM (I.INV_QTY) INV_QTY,                    ";
		sql += "         SUM (BL_QTY) BL_QTY                                                                                                                                                 ";
		sql += "FROM     M_PO_SURVEY A                                                                                                                                                       ";
		sql += "         LEFT OUTER JOIN M_PO_SURVEY_DTL B                                                                                                                                   ";
		sql += "         ON       A.PO_NO  = B.PO_NO                                                                                                                                         ";
		sql += "         AND      A.PO_SEQ = B.PO_SEQ                                                                                                                                        ";
		sql += "         LEFT OUTER JOIN M_PO_REC_HSNA AY                                                                                                                                    ";
		sql += "         ON       A.CUST_PO_NO  = AY.PO_NO                                                                                                                                   ";
		sql += "         AND      A.CUST_PO_SEQ = AY.PO_SEQ                                                                                                                                  ";
		sql += "         LEFT OUTER JOIN B_BIZ_INFO AX                                                                                                                                       ";
		sql += "         ON       A.BP_CD = AX.BP_CD                                                                                                                                         ";
		sql += "         LEFT OUTER JOIN SUPP_BARCD_MST C                                                                                                                                    ";
		sql += "         ON       B.MAST_PO_NO  = C.MAST_PO_NO                                                                                                                               ";
		sql += "         AND      B.MAST_PO_SEQ = C.MAST_PO_SEQ                                                                                                                              ";
		sql += "         LEFT OUTER JOIN SUPP_BARCD_DTL D                                                                                                                                    ";
		sql += "         ON       C.ASN_NO      = D.ASN_NO                                                                                                                                   ";
		sql += "         AND      C.MAST_PO_NO  = D.MAST_PO_NO                                                                                                                               ";
		sql += "         AND      C.MAST_PO_SEQ = D.MAST_PO_SEQ                                                                                                                              ";
		sql += "         LEFT OUTER JOIN B_ITEM_SWM E                                                                                                                                        ";
		sql += "         ON       A.ITEM_CD = E.ITEM_CD                                                                                                                                      ";
		sql += "         LEFT OUTER JOIN M_SUPP_TO_GR F                                                                                                                                      ";
		sql += "         ON       D.MAST_PO_NO  = F.MAST_PO_NO                                                                                                                               ";
		sql += "         AND      D.MAST_PO_SEQ = F.MAST_PO_SEQ                                                                                                                              ";
		sql += "         AND      D.BOX_BC_NO   = F.BOX_BC_NO                                                                                                                                ";
		sql += "         LEFT OUTER JOIN S_DN_HSNA G                                                                                                                                         ";
		sql += "         ON       F.BOX_BC_NO = G.BOX_BC_NO                                                                                                                                  ";
		sql += "         LEFT OUTER JOIN S_CONTAINER_DTL H                                                                                                                                   ";
		sql += "         ON       G.BOX_BC_NO = H.BOX_BC_NO                                                                                                                                  ";
		sql += "         LEFT OUTER JOIN S_CONTAINER_MST HX                                                                                                                                  ";
		sql += "         ON       H.CONT_MGM_NO = HX.CONT_MGM_NO                                                                                                                             ";
		sql += "         LEFT OUTER JOIN S_INVOICE_HSNA_DTL I                                                                                                                                ";
		sql += "         ON       H.BOX_BC_NO = I.BOX_BC_NO                                                                                                                                  ";
		sql += "         LEFT OUTER JOIN S_INVOICE_HSNA_HDR IX                                                                                                                               ";
		sql += "         ON       I.INV_MGM_NO = IX.INV_MGM_NO                                                                                                                               ";
		sql += "         LEFT OUTER JOIN S_BL_HSNA_DTL J                                                                                                                                     ";
		sql += "         ON       I.INV_MGM_NO  = J.INV_MGM_NO                                                                                                                               ";
		sql += "         AND      J.INV_MGM_SEQ = I.INV_SEQ                                                                                                                                  ";
		sql += "WHERE B.MAST_PO_NO LIKE '%" + mast_po_no + "%' ";
		sql += "AND A.CUST_PO_NO LIKE '%" + cust_po_no + "%' ";
		sql += "AND A.ITEM_CD LIKE '%" + item_cd + "%' ";
		sql += "AND (AX.BP_NM LIKE '%" + bp_cdORnm + "%' OR A.BP_CD LIKE '%" + bp_cdORnm + "%') ";

		if (cont_no == "") {
			sql += "AND (HX.CONT_NO IS NULL OR  HX.CONT_NO LIKE '%" + cont_no + "%') ";
		} else {
			sql += "AND HX.CONT_NO LIKE '%" + cont_no + "%' ";
		}

		if (inv_no == "") {
			sql += "AND (IX.INV_NO IS NULL OR IX.INV_NO LIKE '%" + inv_no + "%') ";
		} else {
			sql += "AND IX.INV_NO LIKE '%" + inv_no + "%' ";
		}

		if (asn_no == "") {
			sql += "AND (C.ASN_NO IS NULL OR C.ASN_NO LIKE '%" + asn_no + "%') ";
		} else {
			sql += "AND C.ASN_NO LIKE '%" + asn_no + "%' ";
		}

		if (dlvy_to_dt != "") {
			sql += "AND TO_CHAR(NVL(B.DLVY_DT,''), 'YYYY-MM-DD')  <= '" + dlvy_to_dt + "' AND B.DLVY_DT IS NOT NULL ";
		}
		if (dlvy_from_dt != "") {
			sql += "AND TO_CHAR(NVL(B.DLVY_DT,''), 'YYYY-MM-DD')  >= '" + dlvy_from_dt + "' AND B.DLVY_DT IS NOT NULL ";
		}
		if (dn_to_dt != "") {
			sql += "AND TO_CHAR(NVL(G.DN_DT,''), 'YYYY-MM-DD')  <= '" + dn_to_dt + "' AND G.DN_DT IS NOT NULL ";
		}
		if (dn_from_dt != "") {
			sql += "AND TO_CHAR(NVL(G.DN_DT,''), 'YYYY-MM-DD')  >= '" + dn_from_dt + "'  AND G.DN_DT IS NOT NULL ";
		}
		if (gr_to_dt != "") {
			sql += "AND TO_CHAR(NVL(F.GR_DT,''), 'YYYY-MM-DD') <= '" + gr_to_dt + "' AND F.GR_DT IS NOT NULL ";
		}
		if (gr_from_dt != "") {
			sql += "AND TO_CHAR(NVL(F.GR_DT,''), 'YYYY-MM-DD') >= '" + gr_from_dt + "' AND F.GR_DT IS NOT NULL ";
		}
		if (V_chk_AA.equals("false")) {
			sql += "AND AY.PLANT_CD <> '01'";
		}
		if (V_chk_AU.equals("false")) {
			sql += "AND AY.PLANT_CD <> '02'";
		}
		if (V_chk_AM.equals("false")) {
			sql += "AND AY.PLANT_CD <> '03'";
		}

		sql += "GROUP BY A.CUST_PO_NO,A.CUST_PO_SEQ,B.MAST_PO_NO,B.MAST_PO_SEQ,B.PO_DT,A.BP_CD,AX.BP_NM,A.ITEM_CD,E.ITEM_NM,  ";
		sql += " E.SPEC, B.PO_QTY, B.DLVY_DT,C.DLV_AVL_DT,C.ASN_NO,F.GR_DT,G.DN_DT,HX.CONT_NO,IX.INV_NO  ";
		sql += " , CASE AY.PLANT_CD WHEN '03' THEN 'HSAM' WHEN '01' THEN 'HSAA' ELSE 'HSAU' END  ";
		sql += " ORDER BY CUST_PO_NO, TO_NUMBER(CUST_PO_SEQ), ";
		sql += " MAST_PO_NO, TO_NUMBER(MAST_PO_SEQ)";

		rs = stmt.executeQuery(sql);
		*/
		
		cs = conn.prepareCall("call USP_SALE_INOUTSTATUS_SELECT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, mast_po_no);
		cs.setString(3, item_cd);
		cs.setString(4, cust_po_no);
		cs.setString(5, bp_cdORnm);
		cs.setString(6, cont_no);
		cs.setString(7, inv_no);
		cs.setString(8, asn_no);
		cs.setString(9, dlvy_from_dt);
		cs.setString(10, dlvy_to_dt);
		cs.setString(11, dn_from_dt);
		cs.setString(12, dn_to_dt);
		cs.setString(13, gr_from_dt);
		cs.setString(14, gr_to_dt);
		cs.setString(15, V_chk_AA);
		cs.setString(16, V_chk_AU);
		cs.setString(17, V_chk_AM);
		cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
		cs.setString(19, V_chk_TN);

		cs.executeQuery();
		rs = (ResultSet) cs.getObject(18);

		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("CUST_PO_NO", rs.getString("CUST_PO_NO"));
			subObject.put("CUST_PO_SEQ", rs.getString("CUST_PO_SEQ"));
			subObject.put("MAST_PO_NO", rs.getString("MAST_PO_NO"));
			subObject.put("MAST_PO_SEQ", rs.getString("MAST_PO_SEQ"));
			subObject.put("PO_DT", rs.getString("PO_DT"));
			subObject.put("BP_CD", rs.getString("BP_CD"));
			subObject.put("BP_NM", rs.getString("BP_NM"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("PO_QTY", rs.getInt("PO_QTY"));
			subObject.put("DLVY_DT", rs.getString("DLVY_DT"));
			subObject.put("DLV_AVL_DT", rs.getString("DLV_AVL_DT"));
			subObject.put("ASN_NO", rs.getString("ASN_NO"));
			subObject.put("DLV_AVL_QTY", rs.getInt("DLV_AVL_QTY"));
			subObject.put("GR_DT", rs.getString("GR_DT"));
			subObject.put("GR_QTY", rs.getInt("GR_QTY"));
			subObject.put("DN_DT", rs.getString("DN_DT"));
			subObject.put("DN_QTY", rs.getInt("DN_QTY"));
			subObject.put("CONT_NO", rs.getString("CONT_NO"));
			subObject.put("CTN_QTY", rs.getInt("CTN_QTY"));
			subObject.put("INV_NO", rs.getString("INV_NO"));
			subObject.put("INV_QTY", rs.getInt("INV_QTY"));
			subObject.put("BL_QTY", rs.getInt("BL_QTY"));
			subObject.put("PLANT_NM", rs.getString("PLANT_NM"));
			subObject.put("CONT_SIZE", rs.getString("CONT_SIZE"));
			subObject.put("CONT_SEAL_NO", rs.getString("CONT_SEAL_NO"));

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