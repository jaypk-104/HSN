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
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_001_M_PO_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_NO);//V_PO_NO
			cs.setString(4, "");//V_PO_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_PO_TYPE
			cs.setString(7, "");//V_IN_TERMS
			cs.setString(8, "");//V_PAY_METH
			cs.setString(9, "");//V_CUR
			cs.setString(10, "");//V_XCH_RATE
			cs.setString(11, "");//V_APPROV_NO
			cs.setString(12, "");//V_PUR_USR
			cs.setString(13, "");//V_S_BP_CD
			cs.setString(14, "");//V_TRANSPORT
			cs.setString(15, "");//V_REMARK
			cs.setString(16, "");//V_PO_CFM
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, "");//V_BL_YN
			cs.setString(20, "");//V_TRANSFER
			cs.setString(21, "");//V_APPROV_MGM_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("PO_USR_ID", rs.getString("PO_USR_ID"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("TRANSPORT", rs.getString("TRANSPORT"));
				subObject.put("TRANSPORT_NM", rs.getString("TRANSPORT_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("PO_CFM", rs.getString("PO_CFM"));
				subObject.put("BL_YN", rs.getString("BL_YN").equals("Y") ? true : false);
				subObject.put("TRANSFER", rs.getString("TRANSFER").equals("Y") ? true : false);
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//발주팝업 조회
		} else if (V_TYPE.equals("SP")) {

			String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").toString().substring(0, 10);
			String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").toString().substring(0, 10);
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
			V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
			V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();

			cs = conn.prepareCall("call USP_001_M_PO_POPUP_STEEL(?,?,?,?,?,?,?)");
			cs.setString(1, V_PO_DT_FR);//V_TYPE
			cs.setString(2, V_PO_DT_TO);//V_COMP_ID
			cs.setString(3, V_M_BP_NM);//V_PO_NO
			cs.setString(4, V_APPROV_NO);//V_PO_SEQ
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(6, V_S_BP_NM);//V_PO_NO
			cs.setString(7, V_PO_NO);//V_PO_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("M_BP_NM", rs.getString("BP_NM"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("PO_CFM", rs.getString("PO_CFM"));
				subObject.put("BL_YN", rs.getString("BL_YN").equals("Y") ? true : false);
				subObject.put("TRANSFER", rs.getString("TRANSFER").equals("Y") ? true : false);
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("AP")) {

			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();

			cs = conn.prepareCall("call USP_001_M_PO_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_NO);//V_PO_NO
			cs.setString(4, "");//V_PO_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_PO_TYPE
			cs.setString(7, "");//V_IN_TERMS
			cs.setString(8, "");//V_PAY_METH
			cs.setString(9, "");//V_CUR
			cs.setString(10, "");//V_XCH_RATE
			cs.setString(11, "");//V_APPROV_NO
			cs.setString(12, "");//V_PUR_USR
			cs.setString(13, "");//V_S_BP_CD
			cs.setString(14, "");//V_TRANSPORT
			cs.setString(15, "");//V_REMARK
			cs.setString(16, "");//V_PO_CFM
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, "");//V_BL_YN
			cs.setString(20, V_M_BP_NM);//V_M_BP_NM
			cs.setString(21, V_S_BP_NM);//V_S_BP_NM
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("APPROV_SEQ", rs.getString("APPROV_SEQ"));
				subObject.put("APPROV_DT", rs.getString("APPROV_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("COMP_TYPE", rs.getString("COMP_TYPE"));
				subObject.put("COMP_TYPE_NM", rs.getString("COMP_TYPE_NM"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("REGION_NM", rs.getString("REGION_NM"));
				subObject.put("RISK_REF_NO", rs.getString("RISK_REF_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("USANCE_TYPE", rs.getString("USANCE_TYPE"));
				subObject.put("USANCE_TYPE_NM", rs.getString("USANCE_TYPE_NM"));
				subObject.put("APPROV_USR_NM", rs.getString("APPROV_USR_NM"));

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

			//품의팝업조회
		} else if (V_TYPE.equals("AS")) {

			cs = conn.prepareCall("call USP_001_M_PO_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_PO_NO
			cs.setString(4, "");//V_PO_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_PO_TYPE
			cs.setString(7, "");//V_IN_TERMS
			cs.setString(8, "");//V_PAY_METH
			cs.setString(9, "");//V_CUR
			cs.setString(10, "");//V_XCH_RATE
			cs.setString(11, V_APPROV_NO);//V_APPROV_NO
			cs.setString(12, "");//V_PUR_USR
			cs.setString(13, "");//V_S_BP_CD
			cs.setString(14, "");//V_TRANSPORT
			cs.setString(15, "");//V_REMARK
			cs.setString(16, "");//V_PO_CFM
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, "");//V_BL_YN
			cs.setString(20, "");//V_TRANSFER
			cs.setString(21, "");//V_APPROV_MGM_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("CONT_REMARK", rs.getString("CONT_REMARK"));
				subObject.put("CONT_QTY", rs.getString("CONT_QTY"));
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				subObject.put("APPROV_MGM_SEQ", rs.getString("APPROV_MGM_SEQ"));
				subObject.put("APPROV_DT", rs.getString("APPROV_DT"));
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

			//발주헤더 저장 / 수정 / 삭제 / 확정
		} else if (V_TYPE.equals("I") || V_TYPE.equals("U") || V_TYPE.equals("D") || V_TYPE.equals("CF")) {

			V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
			String V_PO_TYPE = request.getParameter("V_PO_TYPE") == null ? "" : request.getParameter("V_PO_TYPE").toUpperCase();
			String V_PO_DT = request.getParameter("V_PO_DT") == null ? "" : request.getParameter("V_PO_DT").substring(0, 10);
			String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
			String V_PUR_USR = request.getParameter("V_PUR_USR") == null ? "" : request.getParameter("V_PUR_USR").toUpperCase();
			String V_TRANSPORT = request.getParameter("V_TRANSPORT") == null ? "" : request.getParameter("V_TRANSPORT").toUpperCase();
			String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toUpperCase();
			String V_PO_CFM = request.getParameter("V_PO_CFM") == null ? "" : request.getParameter("V_PO_CFM").toUpperCase();
			String V_BL_YN = request.getParameter("V_BL_YN") == null ? "" : request.getParameter("V_BL_YN").toUpperCase();
			String V_TRANSFER = request.getParameter("V_TRANSFER") == null ? "" : request.getParameter("V_TRANSFER").toUpperCase();
			String V_APPROV_MGM_NO = request.getParameter("V_APPROV_MGM_NO") == null ? "" : request.getParameter("V_APPROV_MGM_NO").toUpperCase();

			if (V_BL_YN.equals("TRUE")) {
				V_BL_YN = "Y";
			} else {
				V_BL_YN = "N";
			}

			if (V_TRANSFER.equals("TRUE")) {
				V_TRANSFER = "Y";
			} else {
				V_TRANSFER = "N";
			}

			cs = conn.prepareCall("call USP_001_M_PO_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_NO);//V_PO_NO
			cs.setString(4, V_M_BP_CD);//V_PO_SEQ
			cs.setString(5, V_PO_DT);//V_ITEM_CD
			cs.setString(6, V_PO_TYPE);//V_PO_TYPE
			cs.setString(7, V_IN_TERMS);//V_IN_TERMS
			cs.setString(8, V_PAY_METH);//V_PAY_METH
			cs.setString(9, V_CUR);//V_CUR
			cs.setString(10, V_XCH_RATE);//V_XCH_RATE
			cs.setString(11, V_APPROV_NO);//V_APPROV_NO
			cs.setString(12, V_USR_ID);//V_PUR_USR
			cs.setString(13, V_S_BP_CD);//V_S_BP_CD
			cs.setString(14, V_TRANSPORT);//V_TRANSPORT
			cs.setString(15, V_REMARK);//V_REMARK
			cs.setString(16, V_PO_CFM);//V_PO_CFM
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, V_BL_YN);//V_BL_YN
			cs.setString(20, V_TRANSFER);//V_TRANSFER
			cs.setString(21, V_APPROV_MGM_NO);//V_TRANSFER
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);
			String res = "";
			if (V_TYPE.equals("CF")) {
				if (rs.next()) {
					res = rs.getString("PO_CFM");
				}
			} else {
				if (rs.next()) {
					res = rs.getString("V_PO_NO2");
				}
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


