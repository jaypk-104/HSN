<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0, 10);
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		// 		System.out.println("V_TYPE" + V_TYPE);
		//System.out.println("V_PO_DT_FR" + V_PO_DT_FR);
		//System.out.println("V_PO_DT_TO" + V_PO_DT_TO);
		//System.out.println("V_BP_CD" + V_BP_CD);

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_M_IMPORT_TOTAL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(4, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(5, V_BP_CD);//V_BP_CD
			cs.setString(6, "");//V_LC_DOC_NO
			cs.setString(7, "");//V_BL_DOC_NO
			cs.setString(8, "");//V_LOADING_DT
			cs.setString(9, "");//V_MAKER
			cs.setString(10, "");//V_AGENT
			cs.setString(11, "");//V_OFFER_NO
			cs.setString(12, "");//V_RTA_DT
			cs.setString(13, "");//V_ETD
			cs.setString(14, "");//V_ETA
			cs.setString(15, "");//V_DOC_YN
			cs.setString(16, "");//V_OBL_YN
			cs.setString(17, "");//V_IN_DT
			cs.setString(18, "");//V_FR_TIME
			cs.setString(19, "");//V_TAX_YN
			cs.setString(20, "");//V_IN_REQ_DT
			cs.setString(21, "");//V_REQ_SL_CD
			cs.setString(22, "");//V_FOR_BP_CD
			cs.setString(23, "");//V_INVOICE_DT
			cs.setString(24, "");//V_DUE_DT
			cs.setString(25, "");//V_SEND_DT
			cs.setString(26, "");//V_REMARK
			cs.setString(27, "");//V_PO_NO
			cs.setString(28, "");//V_PO_SEQ
			cs.setString(29, "");//V_LC_NO
			cs.setString(30, "");//V_LC_SEQ
			cs.setString(31, "");//V_BL_NO
			cs.setString(32, "");//V_BL_SEQ
			cs.setString(33, "");//V_CC_NO
			cs.setString(34, "");//V_CC_SEQ
			cs.setString(35, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(36);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAKER", rs.getString("MAKER"));
				subObject.put("AGENT", rs.getString("AGENT"));
				subObject.put("OFFER_NO", rs.getString("OFFER_NO"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("RTA", rs.getString("RTA"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_OPEN_DT", rs.getString("LC_OPEN_DT"));
				subObject.put("ETD", rs.getString("ETD"));
				subObject.put("ETA", rs.getString("ETA"));
				subObject.put("BL_DT", rs.getString("BL_DT"));
				subObject.put("DOC_YN", rs.getString("DOC_YN"));
				subObject.put("OBL_YN", rs.getString("OBL_YN"));
				subObject.put("IMPORT_DT", rs.getString("IMPORT_DT"));
				subObject.put("FREE_TIME", rs.getString("FREE_TIME"));
				subObject.put("OVER_DT", rs.getString("OVER_DT"));
				subObject.put("TAX_YN", rs.getString("TAX_YN"));
				subObject.put("IN_REQ_DT", rs.getString("IN_REQ_DT"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("FOR_BP_CD", rs.getString("FOR_BP_CD"));
				subObject.put("FOR_BP_NM", rs.getString("FOR_BP_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("INVOICE_DT", rs.getString("INVOICE_DT"));
				subObject.put("DUE_DT", rs.getString("DUE_DT"));
				subObject.put("SEND_DT", rs.getString("SEND_DT"));
				subObject.put("DISTB_AMT", rs.getString("DISTB_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("CC_SEQ", rs.getString("CC_SEQ"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			//System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}
		//발주헤더조회

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>


