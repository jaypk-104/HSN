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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_BL_DT_FR = request.getParameter("V_BL_DT_FR") == null ? "" : request.getParameter("V_BL_DT_FR").toString().substring(0, 10);
		String V_BL_DT_TO = request.getParameter("V_BL_DT_TO") == null ? "" : request.getParameter("V_BL_DT_TO").toString().substring(0, 10);
		String V_BF_DT_FR = request.getParameter("V_BF_DT_FR") == null ? "" : request.getParameter("V_BF_DT_FR").toString().substring(0, 10);
		String V_BF_DT_TO = request.getParameter("V_BF_DT_TO") == null ? "" : request.getParameter("V_BF_DT_TO").toString().substring(0, 10);
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
		if (V_SL_CD.equals("T")) {
			V_SL_CD = "";
		}
		
// 		System.out.println(V_M_BP_NM);


		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_001_M_CC_BL_REF_STEEL(?,?,?,?,?,?,?,?)");

			cs.setString(1, V_BL_DT_FR);//V_BL_DT_FR
			cs.setString(2, V_BL_DT_TO);//V_BL_DT_TO
			cs.setString(3, V_BF_DT_FR);//V_BF_DT_FR
			cs.setString(4, V_BF_DT_TO);//V_BF_DT_TO
			cs.setString(5, V_M_BP_NM);//V_M_BP_NM
			cs.setString(6, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(7, V_SL_CD);//V_SL_CD
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BON_QTY", rs.getString("BON_QTY"));//BOX_QTY
				subObject.put("BON_WGT_UNIT", rs.getString("BON_WGT_UNIT"));//BON_WGT_UNIT
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("TAX_RT", rs.getString("TAX_RT"));
				subObject.put("CC_REMAIN_QTY", rs.getString("CC_REMAIN_QTY"));
				subObject.put("CC_RM_BON_QTY", rs.getString("CC_RM_BON_QTY"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("S")) {

			String V_CC_NO = request.getParameter("V_CC_NO") == null ? "" : request.getParameter("V_CC_NO").toUpperCase();

			cs = conn.prepareCall("call USP_001_M_CC_HDR_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_CC_NO);//V_CC_NO
			cs.setString(4, "");//V_ID_NO
			cs.setString(5, "");//V_ID_DT 
			cs.setString(6, "");//V_M_BP_CD
			cs.setString(7, "");//V_TAX_CUSTOM
			cs.setString(8, "");//V_PAY_METH
			cs.setString(9, "");//V_IN_TERMS
			cs.setString(10, "");//V_BL_DOC_NO
			cs.setString(11, "");//V_DISCHGE_PORT
			cs.setString(12, "");//V_CUR
			cs.setString(13, "");//V_XCH_RATE
			cs.setString(14, "");//V_FORWARD_XCH
			cs.setString(15, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(17, "");//
			cs.setString(18, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("ID_NO", rs.getString("ID_NO"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("TAX_CUSTOM", rs.getString("TAX_CUSTOM"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("FORWARD_XCH", rs.getString("FORWARD_XCH"));
				subObject.put("TOTAL_QTY", rs.getString("TOTAL_QTY"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("BP_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("CY_DT", rs.getString("CY_DT"));
				subObject.put("SPOT_XCH", rs.getString("SPOT_XCH"));
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

			//헤더 저장 / 수정 / 삭제 / 확정
		} else if (V_TYPE.equals("I") || V_TYPE.equals("U") || V_TYPE.equals("D") || V_TYPE.equals("CF")) {

			String V_CC_NO = request.getParameter("V_CC_NO") == null ? "" : request.getParameter("V_CC_NO").toUpperCase();
			//System.out.println("V_TYPE" + V_TYPE);
			//System.out.println("V_CC_NO" + V_CC_NO);
			String V_BL_DOC_NO2 = request.getParameter("V_BL_DOC_NO2") == null ? "" : request.getParameter("V_BL_DOC_NO2").toUpperCase();
			String V_DISCHGE_PORT = request.getParameter("V_DISCHGE_PORT") == null ? "" : request.getParameter("V_DISCHGE_PORT").toUpperCase();
			String V_TAX_CUSTOM = request.getParameter("V_TAX_CUSTOM") == null ? "" : request.getParameter("V_TAX_CUSTOM").toUpperCase();
			String V_ID_NO = request.getParameter("V_ID_NO") == null ? "" : request.getParameter("V_ID_NO").toUpperCase();
			String V_ID_DT = request.getParameter("V_ID_DT") == null ? "" : request.getParameter("V_ID_DT").toString().substring(0, 10);
			String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE").toUpperCase();
			String V_TOTAL_QTY = request.getParameter("V_TOTAL_QTY") == null ? "" : request.getParameter("V_TOTAL_QTY").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_FORWARD_XCH = request.getParameter("V_FORWARD_XCH") == null ? "" : request.getParameter("V_FORWARD_XCH").toUpperCase();
			String V_SPOT_XCH = request.getParameter("V_SPOT_XCH") == null ? "" : request.getParameter("V_SPOT_XCH").toUpperCase(); //현물환율
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
			String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
			String V_CY_DT = request.getParameter("V_CY_DT") == null ? "" : request.getParameter("V_CY_DT").toString().substring(0, 10);

			cs = conn.prepareCall("call USP_001_M_CC_HDR_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_CC_NO);//V_CC_NO
			cs.setString(4, V_ID_NO);//V_ID_NO
			cs.setString(5, V_ID_DT);//V_ID_DT 
			cs.setString(6, V_M_BP_CD);//V_M_BP_CD
			cs.setString(7, V_TAX_CUSTOM);//V_TAX_CUSTOM
			cs.setString(8, V_PAY_METH);//V_PAY_METH
			cs.setString(9, V_IN_TERMS);//V_IN_TERMS
			cs.setString(10, V_BL_DOC_NO2);//V_BL_DOC_NO
			cs.setString(11, V_DISCHGE_PORT);//V_DISCHGE_PORT
			cs.setString(12, V_CUR);//V_CUR
			cs.setString(13, V_XCH_RATE);//V_XCH_RATE
			cs.setString(14, V_FORWARD_XCH);//V_FORWARD_XCH
			cs.setString(15, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(17, V_CY_DT);//V_CY_DT
			cs.setString(18, V_SPOT_XCH);//V_SPOT_XCH
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);

			String res = "";
			if (rs.next()) {
				res = rs.getString("res");
			}

			// 			System.out.println("res" + res);

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


