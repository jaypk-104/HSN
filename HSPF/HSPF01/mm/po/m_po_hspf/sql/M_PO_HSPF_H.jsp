<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
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
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_REQ_DT_FR = request.getParameter("V_REQ_DT_FR") == null ? "" : request.getParameter("V_REQ_DT_FR").substring(0, 10);
		String V_REQ_DT_TO = request.getParameter("V_REQ_DT_TO") == null ? "" : request.getParameter("V_REQ_DT_TO").substring(0, 10);
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_COMM_NO = request.getParameter("V_COMM_NO") == null ? "" : request.getParameter("V_COMM_NO").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("RS")) {
			cs = conn.prepareCall("call USP_M_PO_HSPF_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_PR_NO
			cs.setString(4, "");//V_PR_SEQ
			cs.setString(5, V_REQ_DT_FR);//V_PR_DT_FR
			cs.setString(6, V_REQ_DT_TO);//V_PR_DT_FR
			cs.setString(7, V_PO_NO);//V_PO_NO
			cs.setString(8, V_M_BP_CD);//V_M_BP_CD
			cs.setString(9, V_M_BP_NM);//V_M_BP_NM
			cs.setString(10, "");//V_PO_DT
			cs.setString(11, "");//V_PO_TYPE
			cs.setString(12, "");//V_IN_TERMS
			cs.setString(13, "");//V_PAY_METH
			cs.setString(14, "");//V_CUR
			cs.setString(15, "");//V_XCHG_RATE
			cs.setString(16, "");//V_DLV_TYPE
			cs.setString(17, "");//V_REMARK
			cs.setString(18, "");//V_PO_USR_ID
			cs.setString(19, "");//V_APPROV_NO
			cs.setString(20, V_ITEM_CD);//V_ITEM_CD
			cs.setString(21, "");//PO_CFM
			cs.setString(22, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(23, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(23);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PUR_NO", rs.getString("PUR_NO"));
				subObject.put("PUR_SEQ", rs.getString("PUR_SEQ"));
				subObject.put("PUR_DT", rs.getString("PUR_DT").substring(0, 10));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PUR_QTY", rs.getString("PUR_QTY"));
				subObject.put("PO_RM_QTY", rs.getString("PO_RM_QTY"));
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
		//발주헤더조회
		else if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_M_PO_HSPF_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_PR_NO
			cs.setString(4, "");//V_PR_SEQ
			cs.setString(5, V_REQ_DT_FR);//V_PR_DT_FR
			cs.setString(6, V_REQ_DT_TO);//V_PR_DT_FR
			cs.setString(7, V_PO_NO);//V_PO_NO
			cs.setString(8, V_M_BP_CD);//V_M_BP_CD
			cs.setString(9, V_M_BP_NM);//V_M_BP_NM
			cs.setString(10, "");//V_PO_DT
			cs.setString(11, "");//V_PO_TYPE
			cs.setString(12, "");//V_IN_TERMS
			cs.setString(13, "");//V_PAY_METH
			cs.setString(14, "");//V_CUR
			cs.setString(15, "");//V_XCHG_RATE
			cs.setString(16, "");//V_DLV_TYPE
			cs.setString(17, "");//V_REMARK
			cs.setString(18, "");//V_PO_USR_ID
			cs.setString(19, "");//V_APPROV_NO
			cs.setString(20, V_ITEM_CD);//V_ITEM_CD
			cs.setString(21, "");//PO_CFM
			cs.setString(22, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(23, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(23);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("DLV_TYPE", rs.getString("DLV_TYPE"));
				subObject.put("DLV_TYPE_NM", rs.getString("DLV_TYPE_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("PO_CFM", rs.getString("PO_CFM"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
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
		//발주헤더저장/수정/발주확정/발주확정취소
		else if (V_TYPE.equals("I") || V_TYPE.equals("U") || V_TYPE.equals("DA") || V_TYPE.equals("CF") || V_TYPE.equals("CN")) {
			V_M_BP_CD = request.getParameter("V_M_BP_CD2") == null ? "" : request.getParameter("V_M_BP_CD2");
			String V_PO_TYPE = request.getParameter("V_PO_TYPE") == null ? "" : request.getParameter("V_PO_TYPE");
			String V_PO_DT = request.getParameter("V_PO_DT") == null ? "" : request.getParameter("V_PO_DT").substring(0, 10);
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR");
			String V_XCHG_RATE = request.getParameter("V_XCHG_RATE") == null ? "" : request.getParameter("V_XCHG_RATE");
			String V_PAY = request.getParameter("V_PAY") == null ? "" : request.getParameter("V_PAY");
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS");
			String V_DLV_TYPE = request.getParameter("V_DLV_TYPE") == null ? "" : request.getParameter("V_DLV_TYPE");
			String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK");
			
			String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD"); //직입고
			if(V_S_BP_CD.length() > 5) {
				V_S_BP_CD = V_S_BP_CD.substring(0, 5);
			}
			
			cs = conn.prepareCall("call USP_M_PO_HSPF_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_S_BP_CD);//V_PUR_NO -- 직입고 임시 PARAM 사용
			cs.setString(4, "");//V_PR_SEQ
			cs.setString(5, V_REQ_DT_FR);//V_PR_DT_FR
			cs.setString(6, V_REQ_DT_TO);//V_PR_DT_FR
			cs.setString(7, V_PO_NO);//V_PO_NO
			cs.setString(8, V_M_BP_CD);//V_M_BP_CD
			cs.setString(9, V_M_BP_NM);//V_M_BP_NM
			cs.setString(10, V_PO_DT);//V_PO_DT
			cs.setString(11, V_PO_TYPE);//V_PO_TYPE
			cs.setString(12, V_IN_TERMS);//V_IN_TERMS
			cs.setString(13, V_PAY);//V_PAY_METH
			cs.setString(14, V_CUR);//V_CUR
			cs.setString(15, V_XCHG_RATE);//V_XCHG_RATE
			cs.setString(16, V_DLV_TYPE);//V_DLV_TYPE
			cs.setString(17, V_REMARK);//V_REMARK
			cs.setString(18, "");//V_PO_USR_ID
			cs.setString(19, V_COMM_NO);//V_APPROV_NO
			cs.setString(20, V_ITEM_CD);//V_ITEM_CD
			cs.setString(21, "");//PO_CFM
			cs.setString(22, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(23, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			//발주헤더 저장시만 수행
			if (V_TYPE.equals("I")) {
				rs = (ResultSet) cs.getObject(23);

				String V_PO_NO2 = ""; //발주번호채번
				while (rs.next()) {
					V_PO_NO2 = rs.getString("V_PO_NO2");
				}
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(V_PO_NO2);
				pw.flush();
				pw.close();
			}

			//번외 단가불러오기 _D
			else if (V_TYPE.equals("B")) {

				cs = conn.prepareCall("call USP_M_PO_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, "");//V_PO_NO
				cs.setString(4, "");//V_PO_SEQ
				cs.setString(5, V_ITEM_CD);//V_ITEM_CD
				cs.setString(6, "");//V_PO_QTY
				cs.setString(7, "");//V_PO_PRC
				cs.setString(8, "");//V_PO_AMT
				cs.setString(9, "");//V_PO_LOC_AMT
				cs.setString(10, "");//V_VAT_TYPE
				cs.setString(11, "");//V_PO_VAT_AMT
				cs.setString(12, "");//V_DLVY_HOPE_DT
				cs.setString(13, "");//V_HOPE_SL_CD
				cs.setString(14, "");//V_OVER_TOL
				cs.setString(15, "");//V_UNDER_TOL
				cs.setString(16, "");//V_ERP_TRANS_YN
				cs.setString(17, "");//V_PR_NO
				cs.setString(18, "");//V_PR_SEQ
				cs.setString(19, V_M_BP_CD);//V_M_BP_CD
				cs.setString(20, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(21);
				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("MB_PRC", rs.getString("MB_PRC"));
					subObject.put("LT", rs.getString("LT"));
					subObject.put("HP_SL_CD", rs.getString("HP_SL_CD"));
					subObject.put("HP_SL_NM", rs.getString("HP_SL_NM"));
					subObject.put("MIN_PO_QTY", rs.getString("MIN_PO_QTY"));
					jsonArray.add(subObject);
				}

				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

// 				System.out.println(jsonObject);
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
			}
		}

	} catch (Exception e) {
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


