<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.reflect.InvocationTargetException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Properties"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

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
		String V_DT_FR = request.getParameter("V_DT_FR") == null ? "" : request.getParameter("V_DT_FR").toString().substring(0, 10);
		String V_DT_TO = request.getParameter("V_DT_TO") == null ? "" : request.getParameter("V_DT_TO").toString().substring(0, 10);
		String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_CLS_DT_FR = request.getParameter("V_CLS_DT_FR") == null ? "" : request.getParameter("V_CLS_DT_FR").toString().substring(0, 10);
		String V_CLS_DT_TO = request.getParameter("V_CLS_DT_TO") == null ? "" : request.getParameter("V_CLS_DT_TO").toString().substring(0, 10);
		String V_CLS_AR_NO = request.getParameter("V_CLS_AR_NO") == null ? "" : request.getParameter("V_CLS_AR_NO").toUpperCase();
		String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toUpperCase();
		String V_DT_BS = request.getParameter("V_DT_BS") == null || request.getParameter("V_DT_BS").equals("") ? "" : request.getParameter("V_DT_BS").toString().substring(0, 10);

		if (V_TYPE.equals("T1D1")) {
			cs = conn.prepareCall("call USP_A_DEPOSIT_STAT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "S");//V_TYPE
			cs.setString(3, V_DT_FR);//V_DT_FR
			cs.setString(4, V_DT_TO);//V_DT_TO
			cs.setString(5, V_DEPT_CD);//V_DEPT_CD
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(7, V_BP_CD);//V_BP_CD
			cs.setString(8, V_REMARK);//V_REMARK
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BC_NO", rs.getString("BC_NO"));
				subObject.put("BANK_DT", rs.getString("BANK_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("IN_AMT", rs.getString("IN_AMT"));
				subObject.put("IN_LOC_AMT", rs.getString("IN_LOC_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BANK_ACCT_NO", rs.getString("BANK_ACCT_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("TEMP_GL_YN", rs.getString("TEMP_GL_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("T1D2")) {
			cs = conn.prepareCall("call USP_A_NOTE_STAT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "S");//V_TYPE
			cs.setString(3, V_DT_FR);//V_DT_FR
			cs.setString(4, V_DT_TO);//V_DT_TO
			cs.setString(5, V_DEPT_CD);//V_DEPT_CD
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(7, V_BP_CD);//V_BP_CD
			cs.setString(8, V_REMARK);//V_REMARK
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("NOTE_NO", rs.getString("NOTE_NO"));
				subObject.put("ISSUE_DT", rs.getString("ISSUE_DT"));
				subObject.put("DUE_DT", rs.getString("DUE_DT"));
				subObject.put("BAE_DT", rs.getString("BAE_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BP_REG_NO", rs.getString("BP_REG_NO"));
				subObject.put("BANK_ACCT_NO", rs.getString("BANK_ACCT_NO"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("NOTE_AMT", rs.getString("NOTE_AMT"));
				subObject.put("BAE_AMT", rs.getString("BAE_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("TEMP_GL_YN", rs.getString("TEMP_GL_YN"));
				subObject.put("FNOTE_YN", rs.getString("FNOTE_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("RP")) {
			String V_AR_TYPE = request.getParameter("V_AR_TYPE") == null ? "" : request.getParameter("V_AR_TYPE").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_AR_POP_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_AR_TYPE);//V_AR_TYPE
			cs.setString(4, V_DT_FR);//V_AR_DT_FR
			cs.setString(5, V_DT_TO);//V_AR_DT_TO
			cs.setString(6, V_DEPT_CD);//V_DEPT_CD
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, V_BP_CD);//V_BP_CD
			cs.setString(9, "");//V_AR_NO
			cs.setString(10, V_DT_BS);//V_AR_DT_BS
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("AR_NO", rs.getString("AR_NO"));
				subObject.put("AR_TYPE", rs.getString("AR_TYPE"));
				subObject.put("AR_DT", rs.getString("AR_DT"));
				subObject.put("ISSUE_DT", rs.getString("ISSUE_DT"));
				subObject.put("DUE_DT", rs.getString("DUE_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ACCT_CD", rs.getString("ACCT_CD"));
				subObject.put("ACCT_NM", rs.getString("ACCT_NM"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("BAL_DOC_AMT", rs.getString("BAL_DOC_AMT"));
				subObject.put("BAL_LOC_AMT", rs.getString("BAL_LOC_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("GOCHUL_YN", rs.getString("GOCHUL_YN"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("INTER_AMT", rs.getString("INTER_AMT"));
				subObject.put("INTER_VAT", rs.getString("INTER_VAT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("COL")) {
			String V_AR_NO = request.getParameter("V_AR_NO") == null ? "" : request.getParameter("V_AR_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_AR_POP_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_AR_TYPE
			cs.setString(4, "");//V_AR_DT_FR
			cs.setString(5, "");//V_AR_DT_TO
			cs.setString(6, "");//V_DEPT_CD
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, "");//V_BP_CD
			cs.setString(9, V_AR_NO);//V_AR_NO
			cs.setString(10, "");//V_AR_DT_BS
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("COL_DT", rs.getString("COL_DT"));
				subObject.put("COL_AMT", rs.getString("COL_AMT"));
				subObject.put("BF_COL_AMT", rs.getString("BF_COL_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("BF_COL_AMT"));
				subObject.put("BAL_AMT", rs.getString("BF_COL_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("IV")) {
			String V_AR_NO = request.getParameter("V_AR_NO") == null ? "" : request.getParameter("V_AR_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_AR_POP_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_AR_TYPE
			cs.setString(4, V_DT_FR);//V_AR_DT_FR
			cs.setString(5, "");//V_AR_DT_TO
			cs.setString(6, V_DT_FR);//V_DEPT_CD
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, V_BP_CD);//V_BP_CD
			cs.setString(9, "");//V_AR_NO
			cs.setString(10, "");//V_AR_DT_BS
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IV_NO", rs.getString("IV_NO"));
				subObject.put("IV_DT", rs.getString("IV_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
// 				subObject.put("REMAIN_DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
// 				subObject.put("RECV_AMT", rs.getString("RECV_AMT"));
				subObject.put("RECV_LOC_AMT", rs.getString("RECV_LOC_AMT"));
// 				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
// 				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SP")) {
			cs = conn.prepareCall("call USP_A_CLS_AR_SELECT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_CLS_AR_NO
			cs.setString(4, V_DT_FR);//V_AR_DT_FR
			cs.setString(5, V_DT_TO);//V_AR_DT_TO
			cs.setString(6, V_CLS_DT_FR);//V_CLS_DT_FR
			cs.setString(7, V_CLS_DT_TO);//V_CLS_DT_TO
			cs.setString(8, V_DEPT_CD);//V_DEPT_CD
			cs.setString(9, V_BP_CD);//V_S_BP_CD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(11, "");//V_CLS_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CLS_TYPE", rs.getString("CLS_TYPE"));
				subObject.put("CLS_TYPE_NM", rs.getString("CLS_TYPE_NM"));
				subObject.put("CLS_AR_NO", rs.getString("CLS_AR_NO"));
				subObject.put("AR_DT", rs.getString("AR_DT"));
				subObject.put("ISSUE_DT", rs.getString("ISSUE_DT"));
				subObject.put("CLS_DT", rs.getString("CLS_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ACCT_CD", rs.getString("ACCT_CD"));
				subObject.put("ACCT_NM", rs.getString("ACCT_NM"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("CLS_DOC_AMT", rs.getString("CLS_DOC_AMT"));
				subObject.put("CLS_LOC_AMT", rs.getString("CLS_LOC_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("IN_AMT", rs.getString("IN_AMT"));
				subObject.put("REFUND_AMT", rs.getString("REFUND_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2H")) {
			cs = conn.prepareCall("call USP_A_CLS_AR_SELECT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "SH");//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, "");//V_AR_DT_FR
			cs.setString(5, "");//V_AR_DT_TO
			cs.setString(6, "");//V_CLS_DT_FR
			cs.setString(7, "");//V_CLS_DT_TO
			cs.setString(8, "");//V_DEPT_CD
			cs.setString(9, "");//V_S_BP_CD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(11, "");//V_CLS_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CLS_AR_NO", rs.getString("CLS_AR_NO"));
				subObject.put("CLS_DT", rs.getString("CLS_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("GL_NO", rs.getString("GL_NO"));
				subObject.put("CLS_YN", rs.getString("CLS_YN"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2D1")) {
			cs = conn.prepareCall("call USP_A_CLS_AR_SELECT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "S1");//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, "");//V_AR_DT_FR
			cs.setString(5, "");//V_AR_DT_TO
			cs.setString(6, "");//V_CLS_DT_FR
			cs.setString(7, "");//V_CLS_DT_TO
			cs.setString(8, "");//V_DEPT_CD
			cs.setString(9, "");//V_S_BP_CD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(11, "");//V_CLS_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("REF_NO", rs.getString("REF_NO"));
				subObject.put("REF_TYPE", rs.getString("REF_TYPE"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BANK_DT", rs.getString("BANK_DT"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("BAL_AMT", rs.getString("BAL_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("BAL_AMT"));
				subObject.put("BF_LOC_AMT", rs.getString("BF_LOC_AMT"));
				subObject.put("TEMP_GL_YN", rs.getString("TEMP_GL_YN"));
				subObject.put("AR_NO", rs.getString("AR_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2D2")) {
			String V_CLS_TYPE = request.getParameter("V_CLS_TYPE") == null ? "" : request.getParameter("V_CLS_TYPE").toUpperCase();
			String U_TYPE = "S2";
			if(V_CLS_TYPE.equals("Z")) U_TYPE = "S3";
			
			cs = conn.prepareCall("call USP_A_CLS_AR_SELECT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, U_TYPE);//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, "");//V_AR_DT_FR
			cs.setString(5, "");//V_AR_DT_TO
			cs.setString(6, "");//V_CLS_DT_FR
			cs.setString(7, "");//V_CLS_DT_TO
			cs.setString(8, "");//V_DEPT_CD
			cs.setString(9, "");//V_S_BP_CD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(11, V_CLS_TYPE);//V_CLS_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("AR_TYPE", rs.getString("AR_TYPE"));
// 				subObject.put("CLS_TYPE_NM", rs.getString("CLS_TYPE_NM"));
				subObject.put("AR_NO", rs.getString("AR_NO"));
				subObject.put("AR_DT", rs.getString("AR_DT"));
				subObject.put("ISSUE_DT", rs.getString("ISSUE_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ACCT_CD", rs.getString("ACCT_CD"));
				subObject.put("ACCT_NM", rs.getString("ACCT_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("RECV_AMT", rs.getString("RECV_AMT"));
				subObject.put("RECV_LOC_AMT", rs.getString("RECV_LOC_AMT"));
				subObject.put("BF_RECV_AMT", rs.getString("RECV_LOC_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("REMAIN_DOC_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("REMAIN_LOC_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("DR_CR_FG", rs.getString("DR_CR_FG"));
				subObject.put("CLS_TYPE", rs.getString("CLS_TYPE"));
				subObject.put("GOCHUL_YN", rs.getString("GOCHUL_YN"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("INTER_AMT", rs.getString("INTER_AMT"));
				subObject.put("INTER_VAT", rs.getString("INTER_VAT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2S_COL")) {
			String V_CLS_TYPE = request.getParameter("V_CLS_TYPE") == null ? "" : request.getParameter("V_CLS_TYPE").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_CLS_AR_SELECT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, "");//V_AR_DT_FR
			cs.setString(5, "");//V_AR_DT_TO
			cs.setString(6, "");//V_CLS_DT_FR
			cs.setString(7, "");//V_CLS_DT_TO
			cs.setString(8, "");//V_DEPT_CD
			cs.setString(9, "");//V_S_BP_CD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(11, V_CLS_TYPE);//V_CLS_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("COL_DT", rs.getString("COL_DT"));
				subObject.put("COL_AMT", rs.getString("COL_AMT"));
				subObject.put("BF_COL_AMT", rs.getString("BF_COL_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("BAL_AMT", rs.getString("REMAIN_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T3S_IV")) {
			String V_CLS_TYPE = request.getParameter("V_CLS_TYPE") == null ? "" : request.getParameter("V_CLS_TYPE").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_CLS_AR_SELECT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, "");//V_AR_DT_FR
			cs.setString(5, "");//V_AR_DT_TO
			cs.setString(6, "");//V_CLS_DT_FR
			cs.setString(7, "");//V_CLS_DT_TO
			cs.setString(8, "");//V_DEPT_CD
			cs.setString(9, "");//V_S_BP_CD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(11, V_CLS_TYPE);//V_CLS_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IV_NO", rs.getString("IV_NO"));
				subObject.put("IV_DT", rs.getString("IV_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
// 				subObject.put("RECV_AMT", rs.getString("RECV_AMT"));
				subObject.put("RECV_LOC_AMT", rs.getString("RECV_LOC_AMT"));
// 				subObject.put("REMAIN_DOC_AMT", rs.getString("REMAIN_DOC_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2IH")) {
			V_TYPE = V_CLS_AR_NO.equals("") ? "I" : "U";
			V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
			String V_CLS_DT = request.getParameter("V_CLS_DT") == null ? "" : request.getParameter("V_CLS_DT").toString().substring(0, 10);
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_AR_REC_HDR_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, V_CLS_DT);//V_CLS_DT
			cs.setString(5, V_BP_CD);//V_S_BP_CD
			cs.setString(6, V_DEPT_CD);//V_DEPT_CD
			cs.setString(7, V_CUR);//V_CUR
			cs.setString(8, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(10, V_XCH_RATE);//V_XCH_RATE
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(9);
			if (rs.next()) {
				V_CLS_AR_NO = rs.getString("CLS_AR_NO");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(V_CLS_AR_NO);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2ID")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
// 			String V_CLS_TYPE = request.getParameter("V_CLS_TYPE") == null ? "" : request.getParameter("V_CLS_TYPE").toUpperCase();
			String V_BANK_CD = request.getParameter("V_BANK_CD") == null ? "" : request.getParameter("V_BANK_CD").toUpperCase();
			String V_BANK_ACCNT_NO = request.getParameter("V_BANK_ACCT_NO") == null ? "" : request.getParameter("V_BANK_ACCT_NO").toUpperCase();
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_CLS_TYPE = hashMap.get("CLS_TYPE") == null ? "" : hashMap.get("CLS_TYPE").toString();
					String V_AR_NO = hashMap.get("AR_NO") == null ? "" : hashMap.get("AR_NO").toString();
// 					String V_BANK_CD = hashMap.get("BANK_CD") == null ? "" : hashMap.get("BANK_CD").toString();
					String V_DB_NO = hashMap.get("DB_NO") == null ? "" : hashMap.get("DB_NO").toString();
					String V_IV_NO = hashMap.get("IV_NO") == null ? "" : hashMap.get("IV_NO").toString();
					String V_ACCT_CD = hashMap.get("ACCT_CD") == null ? "" : hashMap.get("ACCT_CD").toString();
					String V_DR_CR_FG = hashMap.get("DR_CR_FG") == null ? "" : hashMap.get("DR_CR_FG").toString();
					String V_CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String V_XCH_RATE = hashMap.get("XCH_RATE") == null ? "" : hashMap.get("XCH_RATE").toString();
					String V_DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
					String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
					String V_REMAIN_AMT = hashMap.get("REMAIN_AMT") == null ? "" : hashMap.get("REMAIN_AMT").toString();
					String V_COST_CD = hashMap.get("COST_CD") == null ? "" : hashMap.get("COST_CD").toString();
					V_DEPT_CD = hashMap.get("DEPT_CD") == null ? "" : hashMap.get("DEPT_CD").toString();
					V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();

					String V_NOTE_NO = "";
// 					if(V_CLS_TYPE.equals("N")){
// 						V_NOTE_NO = V_AR_NO;
// 						V_AR_NO = "";
// 					}
					
					cs = conn.prepareCall("call USP_A_AR_REC_ITEM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
					cs.setString(4, V_SEQ);//V_SEQ
					cs.setString(5, V_CLS_TYPE);//V_CLS_TYPE
					cs.setString(6, V_NOTE_NO);//V_NOTE_NO
					cs.setString(7, V_BANK_CD);//V_BANK_CD
					cs.setString(8, V_BANK_ACCNT_NO);//V_BANK_ACCNT_NO
					cs.setString(9, V_DB_NO);//V_DB_NO
					cs.setString(10, V_IV_NO);//V_IV_NO
					cs.setString(11, V_ACCT_CD);//V_ACCT_CD
					cs.setString(12, V_DR_CR_FG);//V_DR_CR_FG
					cs.setString(13, V_CUR);//V_CUR
					cs.setString(14, V_XCH_RATE);//V_XCH_RATE
					cs.setString(15, V_DOC_AMT);//V_DOC_AMT
					cs.setString(16, V_LOC_AMT);//V_LOC_AMT
					cs.setString(17, V_REMARK);//V_REMARK
					cs.setString(18, V_USR_ID);//V_USR_ID
					cs.setString(19, V_REMAIN_AMT);//V_REMAIN_AMT
					cs.setString(20, V_AR_NO);//V_AR_NO
					cs.setString(21, V_COST_CD);//V_COST_CD
					cs.setString(22, V_DEPT_CD);//V_DEPT_CD
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
//					JSONObject jsondata = JSONObject.fromObject(jsonData);
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_CLS_TYPE = jsondata.get("CLS_TYPE") == null ? "" : jsondata.get("CLS_TYPE").toString();
				String V_AR_NO = jsondata.get("AR_NO") == null ? "" : jsondata.get("AR_NO").toString();
// 				String V_BANK_CD = jsondata.get("BANK_CD") == null ? "" : jsondata.get("BANK_CD").toString();
				String V_DB_NO = jsondata.get("DB_NO") == null ? "" : jsondata.get("DB_NO").toString();
				String V_IV_NO = jsondata.get("IV_NO") == null ? "" : jsondata.get("IV_NO").toString();
				String V_ACCT_CD = jsondata.get("ACCT_CD") == null ? "" : jsondata.get("ACCT_CD").toString();
				String V_DR_CR_FG = jsondata.get("DR_CR_FG") == null ? "" : jsondata.get("DR_CR_FG").toString();
				String V_CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String V_XCH_RATE = jsondata.get("XCH_RATE") == null ? "" : jsondata.get("XCH_RATE").toString();
				String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
				String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
				String V_REMAIN_AMT = jsondata.get("REMAIN_AMT") == null ? "" : jsondata.get("REMAIN_AMT").toString();
				String V_COST_CD = jsondata.get("COST_CD") == null ? "" : jsondata.get("COST_CD").toString();
				V_DEPT_CD = jsondata.get("DEPT_CD") == null ? "" : jsondata.get("DEPT_CD").toString();
				V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();

				String V_NOTE_NO = "";
// 				if(V_CLS_TYPE.equals("N")){
// 					V_NOTE_NO = V_AR_NO;
// 					V_AR_NO = "";
// 				}
				
				cs = conn.prepareCall("call USP_A_AR_REC_ITEM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
				cs.setString(4, V_SEQ);//V_SEQ
				cs.setString(5, V_CLS_TYPE);//V_CLS_TYPE
				cs.setString(6, V_NOTE_NO);//V_NOTE_NO
				cs.setString(7, V_BANK_CD);//V_BANK_CD
				cs.setString(8, V_BANK_ACCNT_NO);//V_BANK_ACCNT_NO
				cs.setString(9, V_DB_NO);//V_DB_NO
				cs.setString(10, V_IV_NO);//V_IV_NO
				cs.setString(11, V_ACCT_CD);//V_ACCT_CD
				cs.setString(12, V_DR_CR_FG);//V_DR_CR_FG
				cs.setString(13, V_CUR);//V_CUR
				cs.setString(14, V_XCH_RATE);//V_XCH_RATE
				cs.setString(15, V_DOC_AMT);//V_DOC_AMT
				cs.setString(16, V_LOC_AMT);//V_LOC_AMT
				cs.setString(17, V_REMARK);//V_REMARK
				cs.setString(18, V_USR_ID);//V_USR_ID
				cs.setString(19, V_REMAIN_AMT);//V_REMAIN_AMT
				cs.setString(20, V_AR_NO);//V_AR_NO
				cs.setString(21, V_COST_CD);//V_COST_CD
				cs.setString(22, V_DEPT_CD);//V_DEPT_CD
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
			
		} else if (V_TYPE.equals("T2ID2")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_CLS_DT = request.getParameter("V_CLS_DT") == null ? "" : request.getParameter("V_CLS_DT").toString().substring(0, 10);
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_BC_NO = hashMap.get("BC_NO") == null ? "" : hashMap.get("BC_NO").toString();
					String V_BC_TYPE = hashMap.get("BC_TYPE") == null ? "" : hashMap.get("BC_TYPE").toString();
					String V_AR_NO = hashMap.get("AR_NO") == null ? "" : hashMap.get("AR_NO").toString();
					String V_CLS_IN_AMT = hashMap.get("CLS_IN_AMT") == null ? "" : hashMap.get("CLS_IN_AMT").toString();
					String V_CLS_OUT_AMT = hashMap.get("CLS_OUT_AMT") == null ? "" : hashMap.get("CLS_OUT_AMT").toString();
					String V_BAL_IN_AMT = hashMap.get("BAL_IN_AMT") == null ? "" : hashMap.get("BAL_IN_AMT").toString();
					String V_BAL_OUT_AMT = hashMap.get("BAL_OUT_AMT") == null ? "" : hashMap.get("BAL_OUT_AMT").toString();

					if(V_TYPE.equals("D")){
						V_BC_NO = hashMap.get("REF_NO") == null ? "" : hashMap.get("REF_NO").toString();	
					}
					
					cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
					cs.setString(4, V_BC_NO);//V_BC_NO
					cs.setString(5, V_BC_TYPE);//V_BC_TYPE
					cs.setString(6, V_AR_NO);//V_AR_NO
					cs.setString(7, V_CLS_DT);//V_CLS_DT
					cs.setString(8, V_CUR);//V_BANK_ACCV_CURNT_NO
					cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
					cs.setString(10, V_CLS_OUT_AMT);//V_CLS_OUT_AMT
					cs.setString(11, V_BAL_IN_AMT);//V_BAL_IN_AMT
					cs.setString(12, V_BAL_OUT_AMT);//V_BAL_OUT_AMT
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.setString(14, V_SEQ);//V_SEQ
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_BC_NO = jsondata.get("BC_NO") == null ? "" : jsondata.get("BC_NO").toString();
				String V_BC_TYPE = jsondata.get("BC_TYPE") == null ? "" : jsondata.get("BC_TYPE").toString();
				String V_AR_NO = jsondata.get("AR_NO") == null ? "" : jsondata.get("AR_NO").toString();
				String V_CLS_IN_AMT = jsondata.get("CLS_IN_AMT") == null ? "" : jsondata.get("CLS_IN_AMT").toString();
				String V_CLS_OUT_AMT = jsondata.get("CLS_OUT_AMT") == null ? "" : jsondata.get("CLS_OUT_AMT").toString();
				String V_BAL_IN_AMT = jsondata.get("BAL_IN_AMT") == null ? "" : jsondata.get("BAL_IN_AMT").toString();
				String V_BAL_OUT_AMT = jsondata.get("BAL_OUT_AMT") == null ? "" : jsondata.get("BAL_OUT_AMT").toString();

				if(V_TYPE.equals("D")){
					V_BC_NO = jsondata.get("REF_NO") == null ? "" : jsondata.get("REF_NO").toString();	
				}
				
				cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
				cs.setString(4, V_BC_NO);//V_BC_NO
				cs.setString(5, V_BC_TYPE);//V_BC_TYPE
				cs.setString(6, V_AR_NO);//V_AR_NO
				cs.setString(7, V_CLS_DT);//V_CLS_DT
				cs.setString(8, V_CUR);//V_BANK_ACCV_CURNT_NO
				cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
				cs.setString(10, V_CLS_OUT_AMT);//V_CLS_OUT_AMT
				cs.setString(11, V_BAL_IN_AMT);//V_BAL_IN_AMT
				cs.setString(12, V_BAL_OUT_AMT);//V_BAL_OUT_AMT
				cs.setString(13, V_USR_ID);//V_USR_ID
				cs.setString(14, V_SEQ);//V_SEQ
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
			
		} else if (V_TYPE.equals("T2ID2COL")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_CLS_DT = request.getParameter("V_CLS_DT") == null ? "" : request.getParameter("V_CLS_DT").toString().substring(0, 10);
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_MAST_DB_NO = hashMap.get("MAST_DB_NO") == null ? "" : hashMap.get("MAST_DB_NO").toString();
					String V_COL_NO = hashMap.get("COL_NO") == null ? "" : hashMap.get("COL_NO").toString();
					String V_COL_SEQ= hashMap.get("COL_SEQ") == null ? "" : hashMap.get("COL_SEQ").toString();
					String V_BC_TYPE = hashMap.get("BC_TYPE") == null ? "" : hashMap.get("BC_TYPE").toString();
					String V_AR_NO = hashMap.get("AR_NO") == null ? "" : hashMap.get("AR_NO").toString();
					String V_CLS_IN_AMT = hashMap.get("CLS_IN_AMT") == null ? "" : hashMap.get("CLS_IN_AMT").toString();
					String V_BAL_IN_AMT = hashMap.get("BAL_IN_AMT") == null ? "" : hashMap.get("BAL_IN_AMT").toString();

					if(V_TYPE.equals("D")){
						V_MAST_DB_NO = hashMap.get("MAST_DB_NO") == null ? "" : hashMap.get("MAST_DB_NO").toString();	
					}
					
					cs = conn.prepareCall("call USP_A_COL_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
					cs.setString(4, V_MAST_DB_NO);//V_MAST_DB_NO
					cs.setString(5, V_COL_NO);//V_COL_NO
					cs.setString(6, V_COL_SEQ);//V_COL_SEQ
					cs.setString(7, V_BC_TYPE);//V_BC_TYPE
					cs.setString(8, V_AR_NO);//V_AR_NO
					cs.setString(9, V_CLS_DT);//V_CLS_DT
					cs.setString(10, V_CUR);//V_CUR
					cs.setString(11, V_CLS_IN_AMT);//V_CLS_IN_AMT
					cs.setString(12, V_BAL_IN_AMT);//V_BAL_IN_AMT
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.setString(14, V_SEQ);//V_SEQ
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_MAST_DB_NO = jsondata.get("MAST_DB_NO") == null ? "" : jsondata.get("MAST_DB_NO").toString();
				String V_COL_NO = jsondata.get("COL_NO") == null ? "" : jsondata.get("COL_NO").toString();
				String V_COL_SEQ= jsondata.get("COL_SEQ") == null ? "" : jsondata.get("COL_SEQ").toString();
				String V_BC_TYPE = jsondata.get("BC_TYPE") == null ? "" : jsondata.get("BC_TYPE").toString();
				String V_AR_NO = jsondata.get("AR_NO") == null ? "" : jsondata.get("AR_NO").toString();
				String V_CLS_IN_AMT = jsondata.get("CLS_IN_AMT") == null ? "" : jsondata.get("CLS_IN_AMT").toString();
				String V_BAL_IN_AMT = jsondata.get("BAL_IN_AMT") == null ? "" : jsondata.get("BAL_IN_AMT").toString();

				if(V_TYPE.equals("D")){
					V_MAST_DB_NO = jsondata.get("MAST_DB_NO") == null ? "" : jsondata.get("MAST_DB_NO").toString();	
				}
				
				cs = conn.prepareCall("call USP_A_COL_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
				cs.setString(4, V_MAST_DB_NO);//V_MAST_DB_NO
				cs.setString(5, V_COL_NO);//V_COL_NO
				cs.setString(6, V_COL_SEQ);//V_COL_SEQ
				cs.setString(7, V_BC_TYPE);//V_BC_TYPE
				cs.setString(8, V_AR_NO);//V_AR_NO
				cs.setString(9, V_CLS_DT);//V_CLS_DT
				cs.setString(10, V_CUR);//V_CUR
				cs.setString(11, V_CLS_IN_AMT);//V_CLS_IN_AMT
				cs.setString(12, V_BAL_IN_AMT);//V_BAL_IN_AMT
				cs.setString(13, V_USR_ID);//V_USR_ID
				cs.setString(14, V_SEQ);//V_SEQ
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
			
		} else if (V_TYPE.equals("T3ID")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_CLS_DT = request.getParameter("V_CLS_DT") == null ? "" : request.getParameter("V_CLS_DT").toString().substring(0, 10);
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_IV_NO = hashMap.get("IV_NO") == null ? "" : hashMap.get("IV_NO").toString();
					String V_AR_NO = hashMap.get("AR_NO") == null ? "" : hashMap.get("AR_NO").toString();
					String V_CLS_IN_AMT = hashMap.get("CLS_IN_AMT") == null ? "" : hashMap.get("CLS_IN_AMT").toString();
					String V_BAL_IN_AMT = hashMap.get("BAL_IN_AMT") == null ? "" : hashMap.get("BAL_IN_AMT").toString();
					
					cs = conn.prepareCall("call USP_A_IV_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
					cs.setString(4, V_IV_NO);//V_IV_NO
					cs.setString(5, V_AR_NO);//V_AR_NO
					cs.setString(6, V_SEQ);//V_SEQ
					cs.setString(7, V_CLS_DT);//V_CLS_DT
					cs.setString(8, V_CUR);//V_CUR
					cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
					cs.setString(10, V_BAL_IN_AMT);//V_BAL_IN_AMT
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_IV_NO = jsondata.get("IV_NO") == null ? "" : jsondata.get("IV_NO").toString();
				String V_AR_NO = jsondata.get("AR_NO") == null ? "" : jsondata.get("AR_NO").toString();
				String V_CLS_IN_AMT = jsondata.get("CLS_IN_AMT") == null ? "" : jsondata.get("CLS_IN_AMT").toString();
				String V_BAL_IN_AMT = jsondata.get("BAL_IN_AMT") == null ? "" : jsondata.get("BAL_IN_AMT").toString();
				
				cs = conn.prepareCall("call USP_A_IV_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
				cs.setString(4, V_IV_NO);//V_IV_NO
				cs.setString(5, V_AR_NO);//V_AR_NO
				cs.setString(6, V_SEQ);//V_SEQ
				cs.setString(7, V_CLS_DT);//V_CLS_DT
				cs.setString(8, V_CUR);//V_CUR
				cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
				cs.setString(10, V_BAL_IN_AMT);//V_BAL_IN_AMT
				cs.setString(11, V_USR_ID);//V_USR_ID
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
			
		} else if (V_TYPE.equals("ACCT_POP")) {
			String V_ACCT_CD = request.getParameter("V_ACCT_CD") == null ? "" : request.getParameter("V_ACCT_CD").toUpperCase();
			String V_ACCT_NM = request.getParameter("V_ACCT_NM") == null ? "" : request.getParameter("V_ACCT_NM").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_ACCT_POP_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "S");//V_TYPE
			cs.setString(3, V_ACCT_CD);//V_ACCT_CD
			cs.setString(4, V_ACCT_NM);//V_ACCT_NM
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ACCT_CD", rs.getString("ACCT_CD"));
				subObject.put("ACCT_NM", rs.getString("ACCT_NM"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("ACCT_REF")) {
			String V_ACCT_CD = request.getParameter("V_ACCT_CD") == null ? "" : request.getParameter("V_ACCT_CD").toUpperCase();
			String V_SEQ = request.getParameter("V_SEQ") == null ? "" : request.getParameter("V_SEQ").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_ACCT_POP_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_ACCT_CD);//V_ACCT_CD
			cs.setString(4, "");//V_ACCT_NM
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("V_TYPE", "I");
				subObject.put("SEQ", V_SEQ);
				subObject.put("ACCT_CD", rs.getString("ACCT_CD"));
				subObject.put("CTRL_CD", rs.getString("CTRL_CD"));
				subObject.put("CTRL_NM", rs.getString("CTRL_NM"));
				subObject.put("CTRL_VAL", rs.getString("CTRL_VAL"));
				subObject.put("CTRL_VAL_NM", rs.getString("CTRL_VAL_NM"));
				subObject.put("DTL_SEQ", rs.getString("DTL_SEQ"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2ID3")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_DTL_SEQ = hashMap.get("DTL_SEQ") == null ? "" : hashMap.get("DTL_SEQ").toString();
					String V_CTRL_CD = hashMap.get("CTRL_CD") == null ? "" : hashMap.get("CTRL_CD").toString();
					String V_CTRL_VAL = hashMap.get("CTRL_VAL") == null ? "" : hashMap.get("CTRL_VAL").toString();
					String V_CTRL_VAL_NM = hashMap.get("CTRL_VAL_NM") == null ? "" : hashMap.get("CTRL_VAL_NM").toString();
					String V_ACCT_CD = hashMap.get("ACCT_CD") == null ? "" : hashMap.get("ACCT_CD").toString();

					cs = conn.prepareCall("call USP_A_AR_REC_DTL_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
					cs.setString(4, V_SEQ);//V_SEQ
					cs.setString(5, V_DTL_SEQ);//V_SEQ2
					cs.setString(6, V_CTRL_CD);//V_CTRL_CD
					cs.setString(7, V_CTRL_VAL);//V_CTRL_VAL
					cs.setString(8, V_USR_ID);//V_USR_ID
					cs.setString(9, V_ACCT_CD);//V_ACCT_CD
					cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(11, V_CTRL_VAL_NM);//V_CTRL_VAL_NM
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_DTL_SEQ = jsondata.get("DTL_SEQ") == null ? "" : jsondata.get("DTL_SEQ").toString();
				String V_CTRL_CD = jsondata.get("CTRL_CD") == null ? "" : jsondata.get("CTRL_CD").toString();
				String V_CTRL_VAL = jsondata.get("CTRL_VAL") == null ? "" : jsondata.get("CTRL_VAL").toString();
				String V_CTRL_VAL_NM = jsondata.get("CTRL_VAL_NM") == null ? "" : jsondata.get("CTRL_VAL_NM").toString();
				String V_ACCT_CD = jsondata.get("ACCT_CD") == null ? "" : jsondata.get("ACCT_CD").toString();

				cs = conn.prepareCall("call USP_A_AR_REC_DTL_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
				cs.setString(4, V_SEQ);//V_SEQ
				cs.setString(5, V_DTL_SEQ);//V_SEQ2
				cs.setString(6, V_CTRL_CD);//V_CTRL_CD
				cs.setString(7, V_CTRL_VAL);//V_CTRL_VAL
				cs.setString(8, V_USR_ID);//V_USR_ID
				cs.setString(9, V_ACCT_CD);//V_ACCT_CD
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(11, V_CTRL_VAL_NM);//V_CTRL_VAL_NM
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
			
		} else if (V_TYPE.equals("T2T2S2")) {
			String V_SEQ = request.getParameter("V_SEQ") == null ? "" : request.getParameter("V_SEQ").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_AR_REC_DTL_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "S");//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, V_SEQ);//V_SEQ
			cs.setString(5, "");//V_SEQ2
			cs.setString(6, "");//V_CTRL_CD
			cs.setString(7, "");//V_CTRL_VAL
			cs.setString(8, V_USR_ID);//V_USR_ID
			cs.setString(9, "");//V_ACCT_CD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(11, "");//V_CTRL_VAL_NM
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("DTL_SEQ", rs.getString("DTL_SEQ"));
				subObject.put("ACCT_CD", rs.getString("ACCT_CD"));
				subObject.put("CTRL_CD", rs.getString("CTRL_CD"));
				subObject.put("CTRL_NM", rs.getString("CTRL_NM"));
				subObject.put("CTRL_VAL", rs.getString("CTRL_VAL"));
				subObject.put("CTRL_VAL_NM", rs.getString("CTRL_VAL_NM"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("ERP")) {
			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE").toUpperCase();
			String V_TEMP_GL_NO = "";
			
			cs = conn.prepareCall("call USP_A_TEMP_AR_HSPF(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, U_TYPE);//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);
			if (rs.next()) {
				V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
			}

			if (V_TEMP_GL_NO.contains("TG")) {
// 				/*애니링크 시작*/
//  				JSONObject anyObject = new JSONObject();
//  				JSONArray anyArray = new JSONArray();
//  				JSONObject anySubObject = new JSONObject();

//  				URL url = null;
				
//  				if(V_TYPE.equals("I")) { //확정
//  					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert"); 
//  				} else if(V_TYPE.equals("D")) { //확정취소
//  					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel"); 
//  				}
				
//  				URLConnection con = url.openConnection();
//  				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
//  				con.setDoOutput(true);

//  				anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
//  				anySubObject.put("V_USR_ID", V_USR_ID);
//  				anySubObject.put("V_DB_ID", "sa");
//  				anySubObject.put("V_DB_PW", "hsnadmin");

//  				anyArray.add(anySubObject);
//  				anyObject.put("data", anyArray);
//  				String parameter = anyObject + "";

//  				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
//  				wr.write(parameter);
//  				wr.flush();

//  				BufferedReader rd = null;

//  				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
//  				String line = null;
//  				String result = null;
//  				while ((line = rd.readLine()) != null) {
//  					result = URLDecoder.decode(line, "UTF-8");
//  				}
				
 				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				
				jsonObject.put("resString", "SUCCESS");
 				pw.print(jsonObject);
 				
 				pw.flush();
 				pw.close();
 			}
		
// 		} else if (V_TYPE.equals("MATCH")) {
// 			String V_BC_NO = request.getParameter("BC_NO") == null ? "" : request.getParameter("BC_NO").toString();
// 			String V_BC_TYPE = request.getParameter("BC_TYPE") == null ? "" : request.getParameter("BC_TYPE").toString();
// 			String V_AR_NO = request.getParameter("AR_NO") == null ? "" : request.getParameter("AR_NO").toString();
// 			String V_CLS_IN_AMT = request.getParameter("CLS_IN_AMT") == null ? "" : request.getParameter("CLS_IN_AMT").toString();
			
// 			cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 			cs.setString(1, V_COMP_ID);//V_COMP_ID
// 			cs.setString(2, V_TYPE);//V_TYPE
// 			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
// 			cs.setString(4, V_BC_NO);//V_BC_NO
// 			cs.setString(5, V_BC_TYPE);//V_BC_TYPE
// 			cs.setString(6, V_AR_NO);//V_AR_NO
// 			cs.setString(7, "");//V_CLS_DT
// 			cs.setString(8, "");//V_BANK_ACCV_CURNT_NO
// 			cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
// 			cs.setString(10, "");//V_CLS_OUT_AMT
// 			cs.setString(11, "");//V_BAL_IN_AMT
// 			cs.setString(12, "");//V_BAL_OUT_AMT
// 			cs.setString(13, V_USR_ID);//V_USR_ID
// 			cs.setString(14, "");//V_SEQ
// 			cs.executeQuery();
				
//  			response.setContentType("text/plain; charset=UTF-8");
// 			PrintWriter pw = response.getWriter();
				
// 			jsonObject.put("resString", "SUCCESS");
//  			pw.print(jsonObject);
 				
//  			pw.flush();
//  			pw.close();
		
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


