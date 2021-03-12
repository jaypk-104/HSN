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
		String V_BS_DT = request.getParameter("V_BS_DT") == null ? "" : request.getParameter("V_BS_DT").toUpperCase().substring(0, 10);
		String V_FROM_DT = request.getParameter("V_FROM_DT") == null ? "" : request.getParameter("V_FROM_DT").toUpperCase().substring(0, 10);
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
		String V_RM_YN = request.getParameter("V_RM_YN") == null ? "" : request.getParameter("V_RM_YN").toUpperCase();
		String V_REF_NO = request.getParameter("V_REF_NO") == null ? "" : request.getParameter("V_REF_NO").toUpperCase();
		String V_FROM_CHECK = request.getParameter("V_FROM_CHECK") == null ? "" : request.getParameter("V_FROM_CHECK").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_FROM_CHECK.equals("N")) V_FROM_DT = "";
		
		if (V_TYPE.equals("SH1")) {
			cs = conn.prepareCall("call USP_A_AR_STATUS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BS_DT);//V_BS_DT
			cs.setString(4, V_FROM_DT);//V_FROM_DT 
			cs.setString(5, V_BP_CD);//V_BP_CD 
			cs.setString(6, V_DEPT_CD);//V_DEPT_CD
			cs.setString(7, V_RM_YN);//V_RM_YN
			cs.setString(8, V_FROM_CHECK);//V_REF_NO
			cs.setString(9, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("AR_NO", rs.getString("AR_NO"));
				subObject.put("AR_DT", rs.getString("AR_DT"));
				subObject.put("DUE_DT", rs.getString("DUE_DT"));
				subObject.put("OVER_DT", rs.getString("OVER_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("BAL_DOC_AMT", rs.getString("BAL_DOC_AMT"));
				subObject.put("BAL_LOC_AMT", rs.getString("BAL_LOC_AMT"));
				subObject.put("INTER_AMT", rs.getString("INTER_AMT"));
				subObject.put("INTER_VAT", rs.getString("INTER_VAT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
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

		} else if (V_TYPE.equals("SH2")) {
			cs = conn.prepareCall("call USP_A_AR_STATUS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BS_DT);//V_BS_DT
			cs.setString(4, V_FROM_DT);//V_FROM_DT 
			cs.setString(5, V_BP_CD);//V_BP_CD 
			cs.setString(6, V_DEPT_CD);//V_DEPT_CD
			cs.setString(7, V_RM_YN);//V_RM_YN
			cs.setString(8, V_FROM_CHECK);//V_REF_NO
			cs.setString(9, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BC_NO", rs.getString("BC_NO"));
				subObject.put("BC_TYPE", rs.getString("BC_TYPE"));
				subObject.put("BANK_DT", rs.getString("BANK_DT"));
				subObject.put("DUE_DT", rs.getString("DUE_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BANK_ACCT_NO", rs.getString("BANK_ACCT_NO"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
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
			
		} else if (V_TYPE.equals("SH3")) {
			cs = conn.prepareCall("call USP_A_AR_STATUS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BS_DT);//V_BS_DT
			cs.setString(4, V_FROM_DT);//V_FROM_DT 
			cs.setString(5, V_BP_CD);//V_BP_CD 
			cs.setString(6, V_DEPT_CD);//V_DEPT_CD
			cs.setString(7, V_RM_YN);//V_RM_YN
			cs.setString(8, "");//V_REF_NO
			cs.setString(9, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("ACCT_CD", rs.getString("ACCT_CD"));
				subObject.put("ACCT_NM", rs.getString("ACCT_NM"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SD1")) {
			cs = conn.prepareCall("call USP_A_AR_STATUS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BS_DT);//V_BS_DT
			cs.setString(4, V_FROM_DT);//V_FROM_DT 
			cs.setString(5, V_BP_CD);//V_BP_CD 
			cs.setString(6, V_DEPT_CD);//V_DEPT_CD
			cs.setString(7, V_RM_YN);//V_RM_YN
			cs.setString(8, V_REF_NO);//V_REF_NO
			cs.setString(9, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CLS_AR_NO", rs.getString("CLS_AR_NO"));
				subObject.put("BC_TYPE", rs.getString("BC_TYPE"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BANK_ACCT_NO", rs.getString("BANK_ACCT_NO"));
				subObject.put("CLS_DT", rs.getString("CLS_DT"));
				subObject.put("CLS_IN_AMT", rs.getString("CLS_IN_AMT"));
				subObject.put("BAL_IN_AMT", rs.getString("BAL_IN_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SD2")) {
			cs = conn.prepareCall("call USP_A_AR_STATUS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BS_DT);//V_BS_DT
			cs.setString(4, V_FROM_DT);//V_FROM_DT 
			cs.setString(5, V_BP_CD);//V_BP_CD 
			cs.setString(6, V_DEPT_CD);//V_DEPT_CD
			cs.setString(7, V_RM_YN);//V_RM_YN
			cs.setString(8, V_REF_NO);//V_REF_NO
			cs.setString(9, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("AR_NO", rs.getString("AR_NO"));
				subObject.put("AR_DT", rs.getString("AR_DT"));
				subObject.put("DUE_DT", rs.getString("DUE_DT"));
				subObject.put("OVER_DT", rs.getString("OVER_DT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("BAL_DOC_AMT", rs.getString("BAL_DOC_AMT"));
				subObject.put("BAL_LOC_AMT", rs.getString("BAL_LOC_AMT"));
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


