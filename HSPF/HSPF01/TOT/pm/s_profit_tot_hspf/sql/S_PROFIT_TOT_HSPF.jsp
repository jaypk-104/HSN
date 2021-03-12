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
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");
		String V_DATE = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE").replace("-", "").substring(0, 6);
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_S_TOTAL_PROFIT_HSPF(?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_S_BP_NM);//V_S_BP_CD
			cs.setString(4, V_DATE);//V_YYYYMM
			cs.setString(5, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(7, V_ITEM_CD);//V_ITEM_CD 		
			cs.setString(8, V_ITEM_NM);//V_ITEM_NM 		
			cs.setString(9, "");//V_ENERGY_YN
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BILL_DT", rs.getString("BILL_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("S_DEPT_CD", rs.getString("S_DEPT_CD"));
				subObject.put("S_DEPT_NM", rs.getString("S_DEPT_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("S_KO_QTY", rs.getString("S_KO_QTY"));
				subObject.put("S_KO_AMT", rs.getString("S_KO_AMT"));
				subObject.put("S_LOC_QTY", rs.getString("S_LOC_QTY"));
				subObject.put("S_LOC_AMT", rs.getString("S_LOC_AMT"));
				subObject.put("S_EXP_QTY", rs.getString("S_EXP_QTY"));
				subObject.put("S_EXP_AMT", rs.getString("S_EXP_AMT"));
				subObject.put("S_MID_QTY", rs.getString("S_MID_QTY"));
				subObject.put("S_MID_AMT", rs.getString("S_MID_AMT"));
				subObject.put("S_TOT_QTY", rs.getString("S_TOT_QTY"));
				subObject.put("S_TOT_AMT", rs.getString("S_TOT_AMT"));
				subObject.put("C_KO_QTY", rs.getString("C_KO_QTY"));
				subObject.put("C_KO_AMT", rs.getString("C_KO_AMT"));
				subObject.put("C_LOC_QTY", rs.getString("C_LOC_QTY"));
				subObject.put("C_LOC_AMT", rs.getString("C_LOC_AMT"));
				subObject.put("C_EXP_QTY", rs.getString("C_EXP_QTY"));
				subObject.put("C_EXP_AMT", rs.getString("C_EXP_AMT"));
				subObject.put("C_MID_QTY", rs.getString("C_MID_QTY"));
				subObject.put("C_MID_AMT", rs.getString("C_MID_AMT"));
				subObject.put("C_TOT_QTY", rs.getString("C_TOT_QTY"));
				subObject.put("C_TOT_AMT", rs.getString("C_TOT_AMT"));
				subObject.put("P_KO_QTY", rs.getString("P_KO_QTY"));
				subObject.put("P_KO_AMT", rs.getString("P_KO_AMT"));
				subObject.put("P_LOC_QTY", rs.getString("P_LOC_QTY"));
				subObject.put("P_LOC_AMT", rs.getString("P_LOC_AMT"));
				subObject.put("P_EXP_QTY", rs.getString("P_EXP_QTY"));
				subObject.put("P_EXP_AMT", rs.getString("P_EXP_AMT"));
				subObject.put("P_MID_QTY", rs.getString("P_MID_QTY"));
				subObject.put("P_MID_AMT", rs.getString("P_MID_AMT"));
				subObject.put("P_TOT_QTY", rs.getString("P_TOT_QTY"));
				subObject.put("P_TOT_AMT", rs.getString("P_TOT_AMT"));
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
			cs = conn.prepareCall("call USP_003_S_TOTAL_PROFIT_HSPF(?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_S_BP_CD
			cs.setString(4, V_DATE);//V_YYYYMM
			cs.setString(5, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(7, "");//V_ITEM_CD 		
			cs.setString(8, "");//V_ITEM_NM		
			cs.setString(9, "");//V_ENERGY_YN
			cs.executeQuery();
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


