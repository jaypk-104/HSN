<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").toUpperCase().substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase().substring(0, 10);
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_S_COG_IMP_TOT_HSPF(?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_DN_DT_FR);//V_DN_DT_FR
			cs.setString(3, V_DN_DT_TO);//V_DN_DT_TO 
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(5, V_M_BP_CD);//V_M_BP_CD 
			cs.setString(6, V_BL_DOC_NO);//V_BL_DOC_NO 
			cs.setString(7, V_ITEM_CD);//V_ITEM_CD 
			cs.setString(8, V_ITEM_NM);//V_ITEM_NM 
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(4);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BL_QTY", rs.getString("BL_QTY"));
				subObject.put("BP00002_QTY", rs.getString("BP00002_QTY"));
				subObject.put("BP00007_QTY", rs.getString("BP00007_QTY"));
				subObject.put("BP00012_QTY", rs.getString("BP00012_QTY"));
				subObject.put("BP00059_QTY", rs.getString("BP00059_QTY"));
				subObject.put("BP04364_QTY", rs.getString("BP04364_QTY"));
				subObject.put("BP06325_QTY", rs.getString("BP06325_QTY"));
				subObject.put("BP06689_QTY", rs.getString("BP06689_QTY"));
				subObject.put("BP06930_QTY", rs.getString("BP06930_QTY"));
				subObject.put("BP06983_QTY", rs.getString("BP06983_QTY"));
				subObject.put("BPGITA_QTY", rs.getString("BPGITA_QTY"));
				subObject.put("NET_QTY", rs.getString("NET_QTY"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("MAGIN", rs.getString("MAGIN"));
				subObject.put("PAN_PRC", rs.getString("PAN_PRC"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("BP00002_AMT", rs.getString("BP00002_AMT"));
				subObject.put("BP00007_AMT", rs.getString("BP00007_AMT"));
				subObject.put("BP00012_AMT", rs.getString("BP00012_AMT"));
				subObject.put("BP00059_AMT", rs.getString("BP00059_AMT"));
				subObject.put("BP04364_AMT", rs.getString("BP04364_AMT"));
				subObject.put("BP06325_AMT", rs.getString("BP06325_AMT"));
				subObject.put("BP06689_AMT", rs.getString("BP06689_AMT"));
				subObject.put("BP06930_AMT", rs.getString("BP06930_AMT"));
				subObject.put("BP06983_AMT", rs.getString("BP06983_AMT"));
				subObject.put("BPGITA_AMT", rs.getString("BPGITA_AMT"));
				subObject.put("BP00002_PAN_AMT", rs.getString("BP00002_PAN_AMT"));
				subObject.put("BP00007_PAN_AMT", rs.getString("BP00007_PAN_AMT"));
				subObject.put("BP00012_PAN_AMT", rs.getString("BP00012_PAN_AMT"));
				subObject.put("BP00059_PAN_AMT", rs.getString("BP00059_PAN_AMT"));
				subObject.put("BP04364_PAN_AMT", rs.getString("BP04364_PAN_AMT"));
				subObject.put("BP06325_PAN_AMT", rs.getString("BP06325_PAN_AMT"));
				subObject.put("BP06689_PAN_AMT", rs.getString("BP06689_PAN_AMT"));
				subObject.put("BP06930_PAN_AMT", rs.getString("BP06930_PAN_AMT"));
				subObject.put("BP06983_PAN_AMT", rs.getString("BP06983_PAN_AMT"));
				subObject.put("BPGITA_PAN_AMT", rs.getString("BPGITA_PAN_AMT"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("PAY_XCH_RATE", rs.getString("PAY_XCH_RATE"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("BP00002_PAY_AMT", rs.getString("BP00002_PAY_AMT"));
				subObject.put("BP00007_PAY_AMT", rs.getString("BP00007_PAY_AMT"));
				subObject.put("BP00012_PAY_AMT", rs.getString("BP00012_PAY_AMT"));
				subObject.put("BP00059_PAY_AMT", rs.getString("BP00059_PAY_AMT"));
				subObject.put("BP04364_PAY_AMT", rs.getString("BP04364_PAY_AMT"));
				subObject.put("BP06325_PAY_AMT", rs.getString("BP06325_PAY_AMT"));
				subObject.put("BP06689_PAY_AMT", rs.getString("BP06689_PAY_AMT"));
				subObject.put("BP06930_PAY_AMT", rs.getString("BP06930_PAY_AMT"));
				subObject.put("BP06983_PAY_AMT", rs.getString("BP06983_PAY_AMT"));
				subObject.put("BPGITA_PAY_AMT", rs.getString("BPGITA_PAY_AMT"));
				subObject.put("BP00002_PAN_LOC_AMT", rs.getString("BP00002_PAN_LOC_AMT"));
				subObject.put("BP00007_PAN_LOC_AMT", rs.getString("BP00007_PAN_LOC_AMT"));
				subObject.put("BP00012_PAN_LOC_AMT", rs.getString("BP00012_PAN_LOC_AMT"));
				subObject.put("BP00059_PAN_LOC_AMT", rs.getString("BP00059_PAN_LOC_AMT"));
				subObject.put("BP04364_PAN_LOC_AMT", rs.getString("BP04364_PAN_LOC_AMT"));
				subObject.put("BP06325_PAN_LOC_AMT", rs.getString("BP06325_PAN_LOC_AMT"));
				subObject.put("BP06689_PAN_LOC_AMT", rs.getString("BP06689_PAN_LOC_AMT"));
				subObject.put("BP06930_PAN_LOC_AMT", rs.getString("BP06930_PAN_LOC_AMT"));
				subObject.put("BP06983_PAN_LOC_AMT", rs.getString("BP06983_PAN_LOC_AMT"));
				subObject.put("BPGITA_PAN_LOC_AMT", rs.getString("BPGITA_PAN_LOC_AMT"));
				subObject.put("SPC23", rs.getString("SPC23"));
				subObject.put("SPCALL", rs.getString("SPCALL"));
				subObject.put("DISB_PRC", rs.getString("DISB_PRC"));
				subObject.put("BP00002_DISB_AMT", rs.getString("BP00002_DISB_AMT"));
				subObject.put("BP00007_DISB_AMT", rs.getString("BP00007_DISB_AMT"));
				subObject.put("BP00012_DISB_AMT", rs.getString("BP00012_DISB_AMT"));
				subObject.put("BP00059_DISB_AMT", rs.getString("BP00059_DISB_AMT"));
				subObject.put("BP04364_DISB_AMT", rs.getString("BP04364_DISB_AMT"));
				subObject.put("BP06325_DISB_AMT", rs.getString("BP06325_DISB_AMT"));
				subObject.put("BP06689_DISB_AMT", rs.getString("BP06689_DISB_AMT"));
				subObject.put("BP06930_DISB_AMT", rs.getString("BP06930_DISB_AMT"));
				subObject.put("BP06983_DISB_AMT", rs.getString("BP06983_DISB_AMT"));
				subObject.put("BPGITA_DISB_AMT", rs.getString("BPGITA_DISB_AMT"));
				subObject.put("TOT_AMT", rs.getString("TOT_AMT"));
				subObject.put("BP00002_TOT_AMT", rs.getString("BP00002_TOT_AMT"));
				subObject.put("BP00007_TOT_AMT", rs.getString("BP00007_TOT_AMT"));
				subObject.put("BP00012_TOT_AMT", rs.getString("BP00012_TOT_AMT"));
				subObject.put("BP00059_TOT_AMT", rs.getString("BP00059_TOT_AMT"));
				subObject.put("BP04364_TOT_AMT", rs.getString("BP04364_TOT_AMT"));
				subObject.put("BP06325_TOT_AMT", rs.getString("BP06325_TOT_AMT"));
				subObject.put("BP06689_TOT_AMT", rs.getString("BP06689_TOT_AMT"));
				subObject.put("BP06930_TOT_AMT", rs.getString("BP06930_TOT_AMT"));
				subObject.put("BP06983_TOT_AMT", rs.getString("BP06983_TOT_AMT"));
				subObject.put("BP00002_PAN_TOT_AMT", rs.getString("BP00002_PAN_TOT_AMT"));
				subObject.put("BP00007_PAN_TOT_AMT", rs.getString("BP00007_PAN_TOT_AMT"));
				subObject.put("BP00012_PAN_TOT_AMT", rs.getString("BP00012_PAN_TOT_AMT"));
				subObject.put("BP00059_PAN_TOT_AMT", rs.getString("BP00059_PAN_TOT_AMT"));
				subObject.put("BP04364_PAN_TOT_AMT", rs.getString("BP04364_PAN_TOT_AMT"));
				subObject.put("BP06325_PAN_TOT_AMT", rs.getString("BP06325_PAN_TOT_AMT"));
				subObject.put("BP06689_PAN_TOT_AMT", rs.getString("BP06689_PAN_TOT_AMT"));
				subObject.put("BP06930_PAN_TOT_AMT", rs.getString("BP06930_PAN_TOT_AMT"));
				subObject.put("BP06983_PAN_TOT_AMT", rs.getString("BP06983_PAN_TOT_AMT"));
				subObject.put("BPGITA_PAN_TOT_AMT", rs.getString("BPGITA_PAN_TOT_AMT"));
				subObject.put("BP00002_IK_TOT_AMT", rs.getString("BP00002_IK_TOT_AMT"));
				subObject.put("BP00007_IK_TOT_AMT", rs.getString("BP00007_IK_TOT_AMT"));
				subObject.put("BP00012_IK_TOT_AMT", rs.getString("BP00012_IK_TOT_AMT"));
				subObject.put("BP00059_IK_TOT_AMT", rs.getString("BP00059_IK_TOT_AMT"));
				subObject.put("BP04364_IK_TOT_AMT", rs.getString("BP04364_IK_TOT_AMT"));
				subObject.put("BP06325_IK_TOT_AMT", rs.getString("BP06325_IK_TOT_AMT"));
				subObject.put("BP06689_IK_TOT_AMT", rs.getString("BP06689_IK_TOT_AMT"));
				subObject.put("BP06930_IK_TOT_AMT", rs.getString("BP06930_IK_TOT_AMT"));
				subObject.put("BP06983_IK_TOT_AMT", rs.getString("BP06983_IK_TOT_AMT"));
				subObject.put("BPGITA_IK_TOT_AMT", rs.getString("BPGITA_IK_TOT_AMT"));
				subObject.put("BASE_PRC_AMT", rs.getString("BASE_PRC_AMT"));
				subObject.put("BP00002_BASE_PRC_AMT", rs.getString("BP00002_BASE_PRC_AMT"));
				subObject.put("BP00007_BASE_PRC_AMT", rs.getString("BP00007_BASE_PRC_AMT"));
				subObject.put("BP00012_BASE_PRC_AMT", rs.getString("BP00012_BASE_PRC_AMT"));
				subObject.put("BP00059_BASE_PRC_AMT", rs.getString("BP00059_BASE_PRC_AMT"));
				subObject.put("BP04364_BASE_PRC_AMT", rs.getString("BP04364_BASE_PRC_AMT"));
				subObject.put("BP06325_BASE_PRC_AMT", rs.getString("BP06325_BASE_PRC_AMT"));
				subObject.put("BP06689_BASE_PRC_AMT", rs.getString("BP06689_BASE_PRC_AMT"));
				subObject.put("BP06930_BASE_PRC_AMT", rs.getString("BP06930_BASE_PRC_AMT"));
				subObject.put("BP06983_BASE_PRC_AMT", rs.getString("BP06983_BASE_PRC_AMT"));
				subObject.put("BPGITA_BASE_PRC_AMT", rs.getString("BPGITA_BASE_PRC_AMT"));
				subObject.put("BP00002_PAN_PRC", rs.getString("BP00002_PAN_PRC"));
				subObject.put("BP00007_PAN_PRC", rs.getString("BP00007_PAN_PRC"));
				subObject.put("BP00012_PAN_PRC", rs.getString("BP00012_PAN_PRC"));
				subObject.put("BP00059_PAN_PRC", rs.getString("BP00059_PAN_PRC"));
				subObject.put("BP04364_PAN_PRC", rs.getString("BP04364_PAN_PRC"));
				subObject.put("BP06325_PAN_PRC", rs.getString("BP06325_PAN_PRC"));
				subObject.put("BP06689_PAN_PRC", rs.getString("BP06689_PAN_PRC"));
				subObject.put("BP06930_PAN_PRC", rs.getString("BP06930_PAN_PRC"));
				subObject.put("BP06983_PAN_PRC", rs.getString("BP06983_PAN_PRC"));
				subObject.put("BPGITA_PAN_PRC", rs.getString("BPGITA_PAN_PRC"));
				subObject.put("BP00002_BILL_AMT", rs.getString("BP00002_BILL_AMT"));
				subObject.put("BP00007_BILL_AMT", rs.getString("BP00007_BILL_AMT"));
				subObject.put("BP00012_BILL_AMT", rs.getString("BP00012_BILL_AMT"));
				subObject.put("BP00059_BILL_AMT", rs.getString("BP00059_BILL_AMT"));
				subObject.put("BP04364_BILL_AMT", rs.getString("BP04364_BILL_AMT"));
				subObject.put("BP06325_BILL_AMT", rs.getString("BP06325_BILL_AMT"));
				subObject.put("BP06689_BILL_AMT", rs.getString("BP06689_BILL_AMT"));
				subObject.put("BP06930_BILL_AMT", rs.getString("BP06930_BILL_AMT"));
				subObject.put("BP06983_BILL_AMT", rs.getString("BP06983_BILL_AMT"));
				subObject.put("BPGITA_BILL_AMT", rs.getString("BPGITA_BILL_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("IH")) {
			
		} 

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

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


