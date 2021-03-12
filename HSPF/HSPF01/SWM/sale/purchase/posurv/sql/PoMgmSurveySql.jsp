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
		String u_cus_from_dt = request.getParameter("u_cus_from_dt").substring(0, 10);
		String u_cus_to_dt = request.getParameter("u_cus_to_dt").substring(0, 10);

		String u_cus_pay_from_dt = request.getParameter("u_cus_pay_from_dt").substring(0, 10);
		String u_cus_pay_to_dt = request.getParameter("u_cus_pay_to_dt").substring(0, 10);

		String u_cus_po_no = request.getParameter("u_cus_po_no");

		String u_pay_from_dt = request.getParameter("u_pay_from_dt").substring(0, 10);
		String u_pay_to_dt = request.getParameter("u_pay_to_dt").substring(0, 10);

		String u_po_from_dt = request.getParameter("u_po_from_dt").substring(0, 10);
		String u_po_to_dt = request.getParameter("u_po_to_dt").substring(0, 10);

		String poradio = request.getParameter("poradio");
		
		String po_no = request.getParameter("po_no").toString();
		String item_cd = request.getParameter("item_cd").toString();
		String bp_cdORnm = request.getParameter("bp_cdORnm").toString();
		
		/*
		if (poradio.equals("Y")) {
			poradio = " ='" + poradio + "'";
		} else if (poradio.equals("N")) {
			poradio = " ='" + poradio + "'";
		} else if (poradio.equals("ALL")) {
			poradio = " in('Y','N')";
		}

		//   System.out.println("poradio: "+ poradio);

		String sql = "SELECT B.PO_CFM,A.PO_DT CUST_PO_DT,A.PO_NO CUST_PO_NO, A.PO_SEQ CUST_PO_SEQ, ";
		sql += "A.SL_QTY CUST_PO_QTY,A.DLV_DT CUST_DLVY_DT, B.PO_NO,B.PO_SEQ,B.ITEM_CD,C.ITEM_NM,C.SPEC, ";
		sql += "B.BP_CD , D.BP_NM, B.CUR,B.PO_TOT_QTY PO_QTY ,B.PO_PRC,B.PO_AMT, B.FIR_DLV, B.FIR_QTY, B.SEC_DLV, ";
		sql += "B.SEC_QTY, B.THR_DLV, B.THR_QTY, B.FOR_DLV, B.FOR_QTY, B.FIF_QTY, B.FIF_DLV FROM M_PO_REC_HSNA A ";
		sql += "INNER JOIN M_PO_SURVEY B ON A.PO_NO=B.CUST_PO_NO AND A.PO_SEQ=B.CUST_PO_SEQ LEFT OUTER JOIN B_ITEM_SWM C ";
		sql += "ON B.ITEM_CD=C.ITEM_CD LEFT OUTER JOIN B_BIZ_INFO D ON B.BP_CD=D.BP_CD ";
		sql += "WHERE A.PO_DT >='" + u_cus_from_dt + "' AND A.PO_DT <='" + u_cus_to_dt + "'";
		sql += " AND PO_CFM " + poradio + " ";
		sql += " AND A.DLV_DT>='" + u_cus_pay_from_dt + "' AND A.DLV_DT <='" + u_cus_pay_to_dt + "'";
		sql += " AND A.PO_NO LIKE '%" + u_cus_po_no + "%'";
		sql += "AND (B.FIR_DLV >=" + "'" + u_pay_from_dt + "'" + "AND B.FIR_DLV<=" + "'" + u_pay_to_dt + "' ";
		sql += "or B.SEC_DLV >='" + u_pay_from_dt + "' " + "AND B.SEC_DLV<= '" + u_pay_to_dt + "'";
		sql += "or B.THR_DLV >='" + u_pay_from_dt + "' " + "AND B.THR_DLV<= '" + u_pay_to_dt + "'";
		sql += "or B.FOR_DLV >='" + u_pay_from_dt + "' " + "AND B.FOR_DLV<= '" + u_pay_to_dt + "'";
		sql += "or B.FIF_DLV >='" + u_pay_from_dt + "' " + "AND B.FIF_DLV<= '" + u_pay_to_dt + "'";
		sql += " and b.po_dt>='" + u_po_from_dt + "' and b.po_dt<='" + u_po_to_dt + "')";
		sql += "AND B.PO_NO LIKE '%" + po_no + "%' ";
		sql += "AND B.ITEM_CD LIKE '%" + item_cd +"%' ";
		sql += "AND (D.BP_NM LIKE '%" + bp_cdORnm + "%' OR B.BP_CD LIKE '%" + bp_cdORnm + "%') ";

// 			System.out.println(sql);

		rs = stmt.executeQuery(sql);
		*/
		
		cs = conn.prepareCall("call USP_PO_CFM_SURVEY_SELECT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, po_no);
		cs.setString(3, u_cus_po_no);
		cs.setString(4, item_cd);
		cs.setString(5, bp_cdORnm);
		cs.setString(6, poradio);
		cs.setString(7, u_cus_from_dt);
		cs.setString(8, u_cus_to_dt);
		cs.setString(9, u_cus_pay_from_dt);
		cs.setString(10, u_cus_pay_to_dt);
		cs.setString(11, u_pay_from_dt);
		cs.setString(12, u_pay_to_dt);
		cs.setString(13, u_po_from_dt);
		cs.setString(14, u_po_to_dt);
		cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(15);
		
		
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("ASN_NO", rs.getString("ASN_NO"));
			subObject.put("PO_CFM", rs.getString("PO_CFM"));
			subObject.put("CUST_PO_DT", rs.getString("CUST_PO_DT").substring(0, 10));
			subObject.put("CUST_PO_NO", rs.getString("CUST_PO_NO"));
			subObject.put("CUST_PO_SEQ", rs.getString("CUST_PO_SEQ"));
			subObject.put("CUST_PO_QTY", rs.getString("CUST_PO_QTY"));
			subObject.put("CUST_DLVY_DT", rs.getString("CUST_DLVY_DT").substring(0, 10));
			subObject.put("PO_NO", rs.getString("PO_NO"));
			subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("BP_CD", rs.getString("BP_CD"));
			subObject.put("BP_NM", rs.getString("BP_NM"));
			subObject.put("CUR", rs.getString("CUR"));
			subObject.put("PO_QTY", rs.getString("PO_QTY"));
			subObject.put("PO_PRC", rs.getString("PO_PRC"));
			subObject.put("PO_AMT", rs.getString("PO_AMT"));
			subObject.put("FIR_DLV", rs.getString("FIR_DLV") == null ? "" : rs.getString("FIR_DLV").substring(0, 10));
			subObject.put("FIR_QTY", rs.getString("FIR_QTY"));
			subObject.put("SEC_DLV", rs.getString("SEC_DLV") == null ? "" : rs.getString("SEC_DLV").substring(0, 10));
			subObject.put("SEC_QTY", rs.getString("SEC_QTY"));
			subObject.put("THR_DLV", rs.getString("THR_DLV") == null ? "" : rs.getString("THR_DLV").substring(0, 10));
			subObject.put("THR_QTY", rs.getString("THR_QTY"));
			subObject.put("FOR_DLV", rs.getString("FOR_DLV") == null ? "" : rs.getString("FIR_DLV").substring(0, 10));
			subObject.put("FOR_QTY", rs.getString("FOR_QTY"));
			subObject.put("FIF_DLV", rs.getString("FIF_DLV") == null ? "" : rs.getString("FIF_DLV").substring(0, 10));
			subObject.put("FIF_QTY", rs.getString("FIF_QTY"));
			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		//   System.out.println(jsonString);

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

