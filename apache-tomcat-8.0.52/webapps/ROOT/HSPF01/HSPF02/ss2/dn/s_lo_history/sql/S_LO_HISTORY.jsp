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

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_BS_FR_DT = request.getParameter("V_BS_FR_DT") == null ? "" : request.getParameter("V_BS_FR_DT").toUpperCase().substring(0, 10);
		String V_BS_TO_DT = request.getParameter("V_BS_TO_DT") == null ? "" : request.getParameter("V_BS_TO_DT").toUpperCase().substring(0, 10);
		// 		System.out.println(V_TYPE);
		// 		System.out.println(V_BS_FR_DT);
		// 		System.out.println(V_BS_TO_DT);

		cs = conn.prepareCall("call DISTR_S_LO_HIS.USP_S_LO_HISTORY(?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_BS_FR_DT);//V_BS_FR_DT
		cs.setString(3, V_BS_TO_DT);//V_BS_TO_DT
		cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(4);

		while (rs.next()) {
			subObject = new JSONObject();
			/* 매출 */
			if (V_TYPE.equals("S")) {
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("ROWNUM", rs.getString("ROWNUM"));
				subObject.put("GUBUN1", rs.getString("GUBUN1"));
				subObject.put("GUBUN2", rs.getString("GUBUN2"));
				subObject.put("BP_REGNO", rs.getString("BP_REGNO"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("REG_NM", rs.getString("REG_NM"));
				subObject.put("SL_RGST_NO", rs.getString("SL_RGST_NO"));
				subObject.put("REF_NO", rs.getString("REF_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SIC_NO", rs.getString("SIC_NO"));
				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("IS_NO", rs.getString("IS_NO"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("PART_CODE", rs.getString("PART_CODE"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("REGION_NM", rs.getString("REGION_NM"));
			}
			else if (V_TYPE.equals("I")) {
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("ROWNUM", rs.getString("ROWNUM"));
				subObject.put("GUBUN1", rs.getString("GUBUN1"));
				subObject.put("GUBUN2", rs.getString("GUBUN2"));
				subObject.put("BP_REGNO", rs.getString("BP_REGNO"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("REG_NM", rs.getString("REG_NM"));
				subObject.put("SL_RGST_NO", rs.getString("SL_RGST_NO"));
				subObject.put("REF_NO", rs.getString("REF_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SIC_NO", rs.getString("SIC_NO"));
				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("IS_NO", rs.getString("IS_NO"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("PART_CODE", rs.getString("PART_CODE"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("REGION_NM", rs.getString("REGION_NM"));
			}

			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
// 		System.out.println(jsonObject);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

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
		if (cs2 != null) try {
			cs2.close();
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


