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
		String V_MNTH_FR = request.getParameter("V_MNTH_FR") == null ? "" : request.getParameter("V_MNTH_FR").replace("-", "").substring(0, 6);
		String V_MNTH_TO = request.getParameter("V_MNTH_TO") == null ? "" : request.getParameter("V_MNTH_TO").replace("-", "").substring(0, 6);
		String V_SALES_GRP = request.getParameter("V_SALES_GRP") == null ? "" : request.getParameter("V_SALES_GRP").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
		String V_EX_BILL_YN = request.getParameter("V_EX_BILL_YN") == null ? "" : request.getParameter("V_EX_BILL_YN").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_S_TOTAL_ITEM_BILL_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_MNTH_FR);//V_MNTH_FR
			cs.setString(3, V_MNTH_TO);//V_MNTH_TO
			cs.setString(4, V_SALES_GRP);//V_SALES_GRP 
			cs.setString(5, V_ITEM_CD);//V_ITEM_CD 
			cs.setString(6, V_BP_NM);//V_BP_NM 
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, V_ITEM_NM);//V_ITEM_CD
			cs.setString(9, V_EX_BILL_YN);//V_EX_BILL_YN
			cs.setString(10, V_M_BP_NM);//V_M_BP_NM
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(7);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("BILL_DT", rs.getString("BILL_DT"));
				subObject.put("GROUP_TYPE_NM", rs.getString("GROUP_TYPE_NM"));
				subObject.put("ITEM_GROUP_NM", rs.getString("ITEM_GROUP_NM"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("TO_SALES_GRP", rs.getString("TO_SALES_GRP"));
				subObject.put("SALES_GRP_NM", rs.getString("SALES_GRP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("BILL_CUR", rs.getString("BILL_CUR"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("IV_QTY", rs.getString("IV_QTY"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("IV_LOC_AMT", rs.getString("IV_LOC_AMT"));
				subObject.put("IV_DOC_PRC", rs.getString("IV_DOC_PRC"));
				subObject.put("IV_DOC_AMT", rs.getString("IV_DOC_AMT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("BILL_QTY", rs.getString("BILL_QTY"));
				subObject.put("BILL_PRC", rs.getString("BILL_PRC"));
				subObject.put("BILL_LOC_PRC", rs.getString("BILL_LOC_PRC"));
				subObject.put("BILL_DOC_AMT", rs.getString("BILL_DOC_AMT"));
				subObject.put("BILL_LOC_AMT", rs.getString("BILL_LOC_AMT"));
				subObject.put("S_PROFIT_AMT", rs.getString("S_PROFIT_AMT"));
				subObject.put("S_PROFIT_RATE", rs.getString("S_PROFIT_RATE"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("C")) {
			
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


