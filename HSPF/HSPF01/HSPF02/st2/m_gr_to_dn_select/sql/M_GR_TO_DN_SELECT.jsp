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
		String V_APPROV_NM = request.getParameter("V_APPROV_NM") == null ? "" : request.getParameter("V_APPROV_NM").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_REGION = request.getParameter("V_REGION") == null ? "" : request.getParameter("V_REGION").toUpperCase();
		String V_SALE_TYPE = request.getParameter("V_SALE_TYPE") == null ? "" : request.getParameter("V_SALE_TYPE").toUpperCase();
		String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
		String V_BF_TYPE = request.getParameter("V_BF_TYPE") == null ? "" : request.getParameter("V_BF_TYPE").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();

		
		if(V_REGION.equals("T")) {
			V_REGION = "";
		}
		if(V_SALE_TYPE.equals("T")) {
			V_SALE_TYPE = "";
		}
		if(V_IV_TYPE.equals("T")) {
			V_IV_TYPE = "";
		}
		if(V_BF_TYPE.equals("A")) {
			V_BF_TYPE = "";
		}

		
		cs = conn.prepareCall("call DISTR_TOT_Q.USP_MS_QUERY(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_BS_FR_DT);//V_BS_FR_DT
		cs.setString(3, V_BS_TO_DT);//V_BS_TO_DT
		cs.setString(4, V_APPROV_NM);//V_APPROV_NM
		cs.setString(5, V_M_BP_NM);//V_M_BP_CD
		cs.setString(6, V_S_BP_NM);//V_DN_DT
		cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
		cs.setString(8, V_BL_DOC_NO);//V_DN_DT
		cs.setString(9, V_REGION);//V_REGION
		cs.setString(10, V_SALE_TYPE);//V_SALE_TYPE
		cs.setString(11, V_IV_TYPE);//V_IV_TYPE
		cs.setString(12, V_BF_TYPE);//V_BF_TYPE
		cs.setString(13, V_ITEM_NM);//V_ITEM_NM
		cs.setString(14, V_APPROV_NO);//V_APPROV_NO
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(7);

		while (rs.next()) {
			subObject = new JSONObject();

			
			subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
			subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
			subObject.put("PO_NO", rs.getString("PO_NO"));
			subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
			subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
			subObject.put("CONT_NO", rs.getString("CONT_NO"));
			subObject.put("CONT_QTY", rs.getString("CONT_QTY"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
			subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
			subObject.put("QTY", rs.getString("QTY"));
			subObject.put("REGION", rs.getString("REGION"));
			subObject.put("YESU", rs.getString("YESU"));
			subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
			subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
			subObject.put("GYUL", rs.getString("GYUL"));
			subObject.put("INSU", rs.getString("INSU"));
			subObject.put("HWAN", rs.getString("HWAN"));
			subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
			subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
			subObject.put("LC_DIS", rs.getString("LC_DIS"));
			subObject.put("LC_AMEND", rs.getString("LC_AMEND"));
			subObject.put("GITA", rs.getString("GITA"));
			subObject.put("INSUR_AMT", rs.getString("INSUR_AMT"));
			subObject.put("DISTR_CC_AMT", rs.getString("DISTR_CC_AMT"));
			subObject.put("HAYEOK", rs.getString("HAYEOK"));
			subObject.put("DISTR_REC", rs.getString("DISTR_REC"));
			subObject.put("DISTR_TAX", rs.getString("DISTR_TAX"));
			subObject.put("DISTR_ETC", rs.getString("DISTR_ETC"));
			subObject.put("LD_DT", rs.getString("LD_DT"));
			subObject.put("ID_DT", rs.getString("ID_DT"));
			subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
			subObject.put("SL_NM", rs.getString("SL_NM"));
			subObject.put("SL_AMT", rs.getString("SL_AMT"));
			subObject.put("USANCE", rs.getString("USANCE"));
			subObject.put("GL_IN_AMT", rs.getString("GL_IN_AMT"));
			subObject.put("FO_IN_AMT", rs.getString("FO_IN_AMT"));
			subObject.put("STATE", rs.getString("STATE"));
			subObject.put("DN_DT", rs.getString("DN_DT"));
			subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
			subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
			subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
			subObject.put("DN_QTY", rs.getString("DN_QTY"));
			subObject.put("DN_REAL_QTY", rs.getString("DN_REAL_QTY"));
			subObject.put("S_COG_AMT", rs.getString("S_COG_AMT"));
			subObject.put("A_COG_AMT", rs.getString("A_COG_AMT"));
			subObject.put("DN_AMT", rs.getString("DN_AMT"));
			subObject.put("DN_FINAL_AMT", rs.getString("DN_FINAL_AMT"));
			subObject.put("S_PROFIT", rs.getString("S_PROFIT"));
			subObject.put("S_PROFIT_RT", rs.getString("S_PROFIT_RT"));
			subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
			subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
			subObject.put("S_PROFIT2", rs.getString("S_PROFIT2"));
			subObject.put("S_PROFIT_RT2", rs.getString("S_PROFIT_RT2"));
			subObject.put("S_DAY", rs.getString("S_DAY"));
			subObject.put("BRAND", rs.getString("BRAND"));
			subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
			subObject.put("BILL_NO", rs.getString("BILL_NO"));
			subObject.put("TAX_BILL_NO", rs.getString("TAX_BILL_NO"));
			subObject.put("INTER_AMT", rs.getString("INTER_AMT"));
			subObject.put("MG_AMT", rs.getString("MG_AMT"));
			subObject.put("PER_AMT", rs.getString("PER_AMT"));
			subObject.put("OV_AMT", rs.getString("OV_AMT"));
			subObject.put("BAND_YN", rs.getString("BAND_YN"));

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

		//하단

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


