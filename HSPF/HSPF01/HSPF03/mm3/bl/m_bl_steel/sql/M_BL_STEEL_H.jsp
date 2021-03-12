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
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").toString().substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").toString().substring(0, 10);
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();

		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
		
		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_001_M_BL_PO_N_LC_REF(?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(3, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(4, V_PO_NO);//V_PO_NO
			cs.setString(5, V_M_BP_NM);//V_M_BP_NM
			cs.setString(6, V_LC_DOC_NO);//V_APPROV_NO
			cs.setString(7, V_APPROV_NO);//V_APPROV_NO
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("CONT_REMARK", rs.getString("CONT_REMARK"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("TRANSPORT", rs.getString("TRANSPORT"));
				subObject.put("TRANSPORT_NM", rs.getString("TRANSPORT_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("ORIGIN_NM", rs.getString("ORIGIN_NM"));
				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));

				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("BL_REMAIN_QTY", rs.getString("BL_REMAIN_QTY"));

				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("COL_TYPE_NM", rs.getString("COL_TYPE_NM"));
				
				subObject.put("COL_TITLE", rs.getString("COL_TITLE"));
				
				
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

			cs = conn.prepareCall("call USP_001_M_BL_HDR_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BL_NO);//V_BL_NO
			cs.setString(4, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(5, "");//V_LOADING_DT 
			cs.setString(6, "");//V_M_BP_CD
			cs.setString(7, "");//V_TRANS_TYPE
			cs.setString(8, "");//V_VESSEL_NM
			cs.setString(9, "");//V_VESSEL_NO
			cs.setString(10, "");//V_IN_TERMS
			cs.setString(11, "");//V_PAY_METH
			cs.setString(12, "");//V_CUR
			cs.setString(13, "");//V_XCH_RATE
			cs.setString(14, "");//V_FORWARD_XCH
			cs.setString(15, "");//V_CHARGE_YN
			cs.setString(16, "");//V_CHARGE_SEQ
			cs.setString(17, "");//V_LC_CH_YN
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.setString(19, "");//V_CFM_YN
			cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(21, "");//V_IV_TYPE
			cs.setString(22, "");//V_LAST_YN
			cs.setString(23, "");//V_DISCHGE_PORT
			cs.setString(24, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(20);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT").substring(0, 10));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("BP_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("TRANS_TYPE", rs.getString("TRANS_TYPE"));
				subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("VESSEL_NO", rs.getString("VESSEL_NO"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("FORWARD_XCH", rs.getString("FORWARD_XCH"));
				subObject.put("CHARGE_YN", rs.getString("CHARGE_YN"));
				subObject.put("CHARGE_SEQ", rs.getString("CHARGE_SEQ"));
				subObject.put("LC_CH_YN", rs.getString("LC_CH_YN"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("LAST_YN", rs.getString("LAST_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("REC_CHARGE_NO", rs.getString("REC_CHARGE_NO"));
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

			//BL 헤더 저장 / 수정 / 삭제 / 확정
		} else if (V_TYPE.equals("I") || V_TYPE.equals("U") || V_TYPE.equals("D") || V_TYPE.equals("CF")) {

			String V_LOADING_DT = request.getParameter("V_LOADING_DT") == null ? "" : request.getParameter("V_LOADING_DT").substring(0, 10);
			String V_M_BP_CD2 = request.getParameter("V_M_BP_CD2") == null ? "" : request.getParameter("V_M_BP_CD2").toUpperCase();
			V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
			V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_TRANS_TYPE = request.getParameter("V_TRANS_TYPE") == null ? "" : request.getParameter("V_TRANS_TYPE").toUpperCase();
			String V_VESSEL_NM = request.getParameter("V_VESSEL_NM") == null ? "" : request.getParameter("V_VESSEL_NM").toUpperCase();
			String V_VESSEL_NO = request.getParameter("V_VESSEL_NO") == null ? "" : request.getParameter("V_VESSEL_NO").toUpperCase();
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE").toUpperCase();
			String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
			String V_LAST_YN = request.getParameter("V_LAST_YN") == null ? "" : request.getParameter("V_LAST_YN").toUpperCase();
			String V_DISCHGE_PORT = request.getParameter("V_DISCHGE_PORT") == null ? "" : request.getParameter("V_DISCHGE_PORT").toUpperCase();
			String V_REC_CHARGE_NO = request.getParameter("V_REC_CHARGE_NO") == null ? "" : request.getParameter("V_REC_CHARGE_NO").toUpperCase();
			
			if(V_LAST_YN.equals("TRUE")) {
				V_LAST_YN = "Y";	
			} else {
				V_LAST_YN = "N";	
			}

			cs = conn.prepareCall("call USP_001_M_BL_HDR_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BL_NO);//V_BL_NO
			cs.setString(4, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(5, V_LOADING_DT);//V_LOADING_DT 
			cs.setString(6, V_M_BP_CD2);//V_M_BP_CD
			cs.setString(7, V_TRANS_TYPE);//V_TRANS_TYPE
			cs.setString(8, V_VESSEL_NM);//V_VESSEL_NM
			cs.setString(9, V_VESSEL_NO);//V_VESSEL_NO
			cs.setString(10, V_IN_TERMS);//V_IN_TERMS
			cs.setString(11, V_PAY_METH);//V_PAY_METH
			cs.setString(12, V_CUR);//V_CUR
			cs.setString(13, V_XCH_RATE);//V_XCH_RATE
			cs.setString(14, "");//V_FORWARD_XCH
			cs.setString(15, "");//V_CHARGE_YN
			cs.setString(16, "");//V_CHARGE_SEQ
			cs.setString(17, "");//V_LC_CH_YN
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.setString(19, "");//V_CFM_YN
			cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(21, V_IV_TYPE);//V_IV_TYPE
			cs.setString(22, V_LAST_YN);//V_LAST_YN
			cs.setString(23, V_DISCHGE_PORT);//V_DISCHGE_PORT
			cs.setString(24, V_REC_CHARGE_NO);//V_REC_CHARGE_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(20);

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

		} else if (V_TYPE.equals("BL")) {
			
			V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
			String V_LAST_YN = request.getParameter("V_LAST_YN") == null ? "" : request.getParameter("V_LAST_YN").toUpperCase();
			
			if(V_LAST_YN.equals("TRUE")) {
				V_LAST_YN = "Y";	
			} else {
				V_LAST_YN = "N";	
			}

			cs = conn.prepareCall("call USP_001_M_BL_HDR_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BL_NO);//V_BL_NO
			cs.setString(4, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(5, "");//V_LOADING_DT 
			cs.setString(6, "");//V_M_BP_CD
			cs.setString(7, "");//V_TRANS_TYPE
			cs.setString(8, "");//V_VESSEL_NM
			cs.setString(9, "");//V_VESSEL_NO
			cs.setString(10, "");//V_IN_TERMS
			cs.setString(11, "");//V_PAY_METH
			cs.setString(12, "");//V_CUR
			cs.setString(13, "");//V_XCH_RATE
			cs.setString(14, "");//V_FORWARD_XCH
			cs.setString(15, "");//V_CHARGE_YN
			cs.setString(16, "");//V_CHARGE_SEQ
			cs.setString(17, "");//V_LC_CH_YN
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.setString(19, "");//V_CFM_YN
			cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(21, "");//V_IV_TYPE
			cs.setString(22, V_LAST_YN);//V_LAST_YN
			cs.setString(23, "");//V_DISCHGE_PORT
			cs.setString(24, "");//
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
// 		System.out.println(cs);
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


