<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%--<%@page import="net.sf.json.JSONObject"%>--%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").toString().substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").toString().substring(0, 10);
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO").toUpperCase();

		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call DISTR_LC.USP_M_LC_PO_REF(?,?,?,?,?,?)");
			cs.setString(1, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(2, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(3, V_PO_NO);//V_PO_NO
			cs.setString(4, V_M_BP_NM);//V_M_BP_NM
			cs.setString(5, V_APPROV_NO);//V_APPROV_NO
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
// 				subObject.put("LC_NO", rs.getString("LC_NO"));
// 				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("HS_CD", rs.getString("HS_CD"));
				subObject.put("UNDER_TOL", rs.getString("UNDER_TOL"));
				subObject.put("OVER_TOL", rs.getString("OVER_TOL"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("ORIGIN_NM", rs.getString("ORIGIN_NM"));
				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
				subObject.put("CONT_REMARK", rs.getString("CONT_REMARK"));
				subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("COL_TYPE_NM", rs.getString("COL_TYPE_NM"));
				subObject.put("LC_REMAIN_QTY", rs.getString("LC_REMAIN_QTY"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			// 			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//발주팝업 조회
		} else if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call DISTR_LC.USP_M_LC_DISTR_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_LC_NO);//V_LC_NO
			cs.setString(4, "");//V_LC_DOC_NO
			cs.setString(5, "");//V_LC_AMEND_SEQ
			cs.setString(6, "");//V_BANK_CD
			cs.setString(7, "");//V_PO_NO
			cs.setString(8, "");//V_REQ_DT
			cs.setString(9, "");//V_OPEN_DT
			cs.setString(10, "");//V_EXPIRY_DT
			cs.setString(11, "");//V_AMEND_DT
			cs.setString(12, "");//V_CUR
			cs.setString(13, "");//V_XCH_RATE
			cs.setString(14, "");//V_DOC_AMT
			cs.setString(15, "");//V_LOC_AMT
			cs.setString(16, "");//V_PAY_METH
			cs.setString(17, "");//V_IN_TERMS
			cs.setString(18, "");//V_M_BP_CD
			cs.setString(19, "");//V_LC_KIND
			cs.setString(20, "");//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(22, "");//V_USR_ID
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(21);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("LC_AMEND_SEQ", rs.getString("LC_AMEND_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

// 						System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//LC헤더 저장 / 수정 / 삭제 / 확정
		} else if (V_TYPE.equals("I") || V_TYPE.equals("U") || V_TYPE.equals("D") || V_TYPE.equals("CF")) {

			// 			System.out.println("V_TYPE :" + V_TYPE);

			String V_OPEN_DT = request.getParameter("V_OPEN_DT") == null ? "" : request.getParameter("V_OPEN_DT").substring(0, 10);
			String V_M_BP_CD2 = request.getParameter("V_M_BP_CD2") == null ? "" : request.getParameter("V_M_BP_CD2").toUpperCase();
			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
			String V_BANK_CD = request.getParameter("V_BANK_CD") == null ? "" : request.getParameter("V_BANK_CD").toUpperCase();
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE").toUpperCase();
// 			String V_DOC_AMT = request.getParameter("V_DOC_AMT") == null ? "" : request.getParameter("V_DOC_AMT").toUpperCase().replaceAll(",", "");
			String V_DOC_AMT = "0";

			V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
			String V_COL_NO = request.getParameter("V_COL_NO") == null ? "" : request.getParameter("V_COL_NO").toUpperCase();

			// 			System.out.println("V_DOC_AMT" + V_DOC_AMT);
			// 			System.out.println("V_LC_NO" + V_LC_NO);

			cs = conn.prepareCall("call DISTR_LC.USP_M_LC_DISTR_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_LC_NO);//V_LC_NO
			cs.setString(4, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(5, "");//V_LC_AMEND_SEQ 
			cs.setString(6, V_BANK_CD);//V_BANK_CD
			cs.setString(7, V_PO_NO);//V_PO_NO
			cs.setString(8, V_OPEN_DT);//V_REQ_DT
			cs.setString(9, V_OPEN_DT);//V_OPEN_DT
			cs.setString(10, V_OPEN_DT);//V_EXPIRY_DT
			cs.setString(11, V_OPEN_DT);//V_AMEND_DT
			cs.setString(12, V_CUR);//V_CUR
			cs.setString(13, V_XCH_RATE);//V_XCH_RATE
			cs.setString(14, V_DOC_AMT);//V_DOC_AMT
			cs.setString(15, "");//V_LOC_AMT
			cs.setString(16, V_PAY_METH);//V_PAY_METH
			cs.setString(17, V_IN_TERMS);//V_IN_TERMS
			cs.setString(18, V_M_BP_CD2);//V_M_BP_CD
			cs.setString(19, "");//V_LC_KIND
			cs.setString(20, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(22, V_COL_NO);//V_COL_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(21);

			String res = "";
			// 			System.out.println(rs);
			if (rs.next()) {
				res = rs.getString("res");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(res);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC")) {}
		else if (V_TYPE.equals("CANCEL") ) {
// 			System.out.println("V_LC_NO : " + V_LC_NO);
			
			cs = conn.prepareCall("call USP_002_M_LC_CANCEL_DISTR(?,?,?)");
			cs.setString(1, V_LC_NO);//
			cs.setString(2, V_USR_ID);//
			cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(3);
			
			String res = "";
			if (rs.next()) {
				res = rs.getString("res");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(res);
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


