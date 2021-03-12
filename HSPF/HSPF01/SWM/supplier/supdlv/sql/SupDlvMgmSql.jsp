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
		// 	 System.out.println("납품예정SQL");
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		//MyViewport
		String u_pay_from_dt = request.getParameter("u_pay_from_dt").substring(0, 10);
		String u_pay_to_dt = request.getParameter("u_pay_to_dt").substring(0, 10);
		String u_po_from_dt = request.getParameter("u_po_from_dt").substring(0, 10);
		String u_po_to_dt = request.getParameter("u_po_to_dt").substring(0, 10);
		String u_po_no = request.getParameter("u_po_no");
		String u_item_cd = request.getParameter("u_item_cd");
		String u_asn_no = request.getParameter("u_asn_no");
		String u_bp_nm = request.getParameter("u_bp_nm");
		String gbp_cd = request.getParameter("gbp_cd"); //거래처코드
		// 		String gbp_cd = "05116"; //거래처코드
		
		
		/*
		String sql = "";
		sql = "SELECT DISTINCT A.MAST_PO_NO, A.MAST_PO_SEQ, AX.BP_NM, A.ITEM_CD, B.ITEM_NM, B.SPEC,                                                ";
		sql += "                B.STOCK_UNIT, A.PO_DT, A.DLVY_DT, A.PO_QTY, NVL (C.GR_QTY, 0) GR_QTY, '' AVAIL_DT,                                  ";
		sql += "                0 AVAIL_QTY, D.BARCD_CNT, A.PO_QTY - NVL (E.DLVY_AVL_QTY, 0) AS REMAIN_QTY, '' AVAIL_DT, 0 AVAIL_QTY, D.BARCD_CNT, ";
		sql += "                CASE H.PLANT_CD WHEN '03' THEN 'HSAM(멕시코)' WHEN '01' THEN 'HSAA(미국)' ELSE 'HSAU(미국)' END PLANT_NM                   ";
		sql += "FROM            M_PO_SURVEY_DTL A                                                                                                   ";
		sql += "                LEFT OUTER JOIN B_ITEM_SWM B                                                                                        ";
		sql += "                ON              A.ITEM_CD = B.ITEM_CD                                                                               ";
		sql += "                LEFT OUTER JOIN B_BIZ_INFO AX                                                                                       ";
		sql += "                ON              A.BP_CD = AX.BP_CD                                                                                  ";
		sql += "                LEFT OUTER JOIN M_SUPP_TO_GR_SUM C                                                                                  ";
		sql += "                ON              A.MAST_PO_NO  = C.MAST_PO_NO                                                                        ";
		sql += "                AND             A.MAST_PO_SEQ = C.MAST_PO_SEQ                                                                       ";
		sql += "                LEFT OUTER JOIN SUPP_BARCD_MST_CNT D                                                                                ";
		sql += "                ON              A.MAST_PO_NO  = D.MAST_PO_NO                                                                        ";
		sql += "                AND             A.MAST_PO_SEQ = D.MAST_PO_SEQ                                                                       ";
		sql += "                LEFT OUTER JOIN M_SUPP_TO_AVL_QTY_SUM E                                                                             ";
		sql += "                ON              A.MAST_PO_NO  = E.MAST_PO_NO                                                                        ";
		sql += "                AND             A.MAST_PO_SEQ = E.MAST_PO_SEQ                                                                       ";
		sql += "                LEFT OUTER JOIN SUPP_BARCD_MST F                                                                                    ";
		sql += "                ON              A.MAST_PO_NO  = F.MAST_PO_NO                                                                        ";
		sql += "                AND             A.MAST_PO_SEQ = F.MAST_PO_SEQ                                                                       ";
		sql += "                LEFT OUTER JOIN M_PO_SURVEY G                                                                                       ";
		sql += "                ON A.PO_NO = G.PO_NO                                                                                                ";
		sql += "                AND A.PO_SEQ = G.PO_SEQ                                                                                             ";
		sql += "                LEFT OUTER JOIN M_PO_REC_HSNA H                                                                                     ";
		sql += "                ON G.CUST_PO_NO = H.PO_NO                                                                                           ";
		sql += "                AND G.CUST_PO_SEQ = H.PO_SEQ                                                                                        ";
		sql += "WHERE a.bp_cd='" + gbp_cd + "'";
		sql += " AND A.DLVY_DT <='" + u_pay_to_dt + "' AND A.DLVY_DT >='" + u_pay_from_dt + "'";
		sql += " AND A.PO_DT<= '" + u_po_to_dt + "' AND A.PO_DT>='" + u_po_from_dt + "' ";
		sql += " AND NVL(F.ASN_NO, ' ') LIKE '%" + u_asn_no + "%' ";
		sql += " AND A.MAST_PO_NO LIKE '%" + u_po_no + "%' AND A.ITEM_CD LIKE '%" + u_item_cd + "%' ORDER BY A.MAST_PO_NO, A.MAST_PO_SEQ";

		String adminSql = "";
		adminSql = "SELECT DISTINCT A.MAST_PO_NO, A.MAST_PO_SEQ, AX.BP_NM, A.ITEM_CD, B.ITEM_NM, B.SPEC,                                                ";
		adminSql += "                B.STOCK_UNIT, A.PO_DT, A.DLVY_DT, A.PO_QTY, NVL (C.GR_QTY, 0) GR_QTY, '' AVAIL_DT,                                  ";
		adminSql += "                0 AVAIL_QTY, D.BARCD_CNT, A.PO_QTY - NVL (E.DLVY_AVL_QTY, 0) AS REMAIN_QTY, '' AVAIL_DT, 0 AVAIL_QTY, D.BARCD_CNT, ";
		adminSql += "                CASE H.PLANT_CD WHEN '03' THEN 'HSAM(멕시코)' WHEN '01' THEN 'HSAA(미국)' ELSE 'HSAU(미국)' END PLANT_NM                   ";
		adminSql += "FROM            M_PO_SURVEY_DTL A                                                                                                   ";
		adminSql += "                LEFT OUTER JOIN B_BIZ_INFO AX                                                                                       ";
		adminSql += "                ON              A.BP_CD = AX.BP_CD                                                                                  ";
		adminSql += "                LEFT OUTER JOIN B_ITEM_SWM B                                                                                        ";
		adminSql += "                ON              A.ITEM_CD = B.ITEM_CD                                                                               ";
		adminSql += "                LEFT OUTER JOIN M_SUPP_TO_GR_SUM C                                                                                  ";
		adminSql += "                ON              A.MAST_PO_NO  = C.MAST_PO_NO                                                                        ";
		adminSql += "                AND             A.MAST_PO_SEQ = C.MAST_PO_SEQ                                                                       ";
		adminSql += "                LEFT OUTER JOIN SUPP_BARCD_MST_CNT D                                                                                ";
		adminSql += "                ON              A.MAST_PO_NO  = D.MAST_PO_NO                                                                        ";
		adminSql += "                AND             A.MAST_PO_SEQ = D.MAST_PO_SEQ                                                                       ";
		adminSql += "                LEFT OUTER JOIN M_SUPP_TO_AVL_QTY_SUM E                                                                             ";
		adminSql += "                ON              A.MAST_PO_NO  = E.MAST_PO_NO                                                                        ";
		adminSql += "                AND             A.MAST_PO_SEQ = E.MAST_PO_SEQ                                                                       ";
		adminSql += "                LEFT OUTER JOIN SUPP_BARCD_MST F                                                                                    ";
		adminSql += "                ON              A.MAST_PO_NO  = F.MAST_PO_NO                                                                        ";
		adminSql += "                AND             A.MAST_PO_SEQ = F.MAST_PO_SEQ                                                                       ";
		adminSql += "                LEFT OUTER JOIN M_PO_SURVEY G                                                                                       ";
		adminSql += "                ON A.PO_NO = G.PO_NO                                                                                                ";
		adminSql += "                AND A.PO_SEQ = G.PO_SEQ                                                                                             ";
		adminSql += "                LEFT OUTER JOIN M_PO_REC_HSNA H                                                                                     ";
		adminSql += "                ON G.CUST_PO_NO = H.PO_NO                                                                                           ";
		adminSql += "                AND G.CUST_PO_SEQ = H.PO_SEQ                                                                                        ";
		adminSql += " WHERE A.DLVY_DT <='" + u_pay_to_dt + "' AND A.DLVY_DT >='" + u_pay_from_dt + "'";
		adminSql += " AND A.PO_DT<= '" + u_po_to_dt + "' AND A.PO_DT>='" + u_po_from_dt + "' ";
		adminSql += " AND A.MAST_PO_NO LIKE '%" + u_po_no + "%' AND A.ITEM_CD LIKE '%" + u_item_cd + "%' ";
		adminSql += " AND NVL(F.ASN_NO, ' ') LIKE '%" + u_asn_no + "%' ";
		adminSql += " AND NVL(AX.BP_NM, ' ') LIKE '%" + u_bp_nm + "%' ";
		adminSql += "  ORDER BY A.MAST_PO_NO, A.MAST_PO_SEQ ";

		if (gbp_cd.equals("00000")) {
			rs = stmt.executeQuery(adminSql);
		} else {
			rs = stmt.executeQuery(sql);
		}
		*/
		
		//SQL 박혀있는것 SP로 수정.
		
		cs = conn.prepareCall("call USP_SUPP_SELECT(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, u_asn_no);
		cs.setString(3, u_po_no);
		cs.setString(4, u_po_from_dt);
		cs.setString(5, u_po_to_dt);
		cs.setString(6, u_pay_from_dt);
		cs.setString(7, u_pay_to_dt);
		cs.setString(8, u_item_cd);
		cs.setString(9, u_bp_nm);
		cs.setString(10, gbp_cd);
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(11);
		
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("MAST_PO_NO", rs.getString("MAST_PO_NO"));
			subObject.put("MAST_PO_SEQ", rs.getString("MAST_PO_SEQ"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("STOCK_UNIT", rs.getString("STOCK_UNIT"));
			subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
			subObject.put("DLVY_DT", rs.getString("DLVY_DT").substring(0, 10));
			subObject.put("PO_QTY", rs.getString("PO_QTY"));
			subObject.put("GR_QTY", rs.getString("GR_QTY"));
			subObject.put("REMAIN_QTY", rs.getString("REMAIN_QTY"));
			subObject.put("REMAIN_QTY2", rs.getString("REMAIN_QTY2"));
			subObject.put("AVAIL_DT", rs.getString("AVAIL_DT"));
			subObject.put("AVAIL_QTY", rs.getString("AVAIL_QTY"));
			subObject.put("BARCD_CNT", rs.getString("BARCD_CNT"));
			subObject.put("BP_NM", rs.getString("BP_NM"));
			subObject.put("PLANT_NM", rs.getString("PLANT_NM"));
			
			subObject.put("BL_NO", rs.getString("BL_NO")); 
			subObject.put("BL_SEQ", rs.getString("BL_SEQ")); 
			subObject.put("CC_NO", rs.getString("CC_NO")); 
			subObject.put("CC_SEQ", rs.getString("CC_SEQ")); 
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








