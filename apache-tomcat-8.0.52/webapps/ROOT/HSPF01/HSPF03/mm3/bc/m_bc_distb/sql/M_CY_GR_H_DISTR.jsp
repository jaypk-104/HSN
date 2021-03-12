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
	ResultSet rs1 = null;
	CallableStatement cs = null;
	CallableStatement cs1 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_LOADING_DT_FR = request.getParameter("V_LOADING_DT_FR") == null ? "" : request.getParameter("V_LOADING_DT_FR").toString().substring(0, 10);
		String V_LOADING_DT_TO = request.getParameter("V_LOADING_DT_TO") == null ? "" : request.getParameter("V_LOADING_DT_TO").toString().substring(0, 10);
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_CC_YN = request.getParameter("V_CC_YN") == null ? "" : request.getParameter("V_CC_YN").toUpperCase();
		String V_INTEREST = request.getParameter("V_INTEREST") == null ? "" : request.getParameter("V_INTEREST").toUpperCase();

// 		System.out.println("V_CC_YN" + V_CC_YN);
// 		System.out.println("V_INTEREST" + V_INTEREST);
		
		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call DISTR_CY.USP_M_CY_GR_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(4, V_LOADING_DT_FR);//V_LOADING_DT_FR
			cs.setString(5, V_LOADING_DT_TO);//V_LOADING_DT_TO
			cs.setString(6, V_M_BP_NM);//V_M_BP_NM
			cs.setString(7, V_BL_DOC_NO);//V_CY_NO -- 대체사용
			cs.setString(8, V_CC_YN);//V_CC_YN -- V_INBOARD_DT 대체사용
			cs.setString(9, "");//V_FR_TIME
			cs.setString(10, "");//V_IN_DT
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("CONT_QTY", rs.getString("CONT_QTY"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("CY_NO", rs.getString("CY_NO"));
				subObject.put("CY_SEQ", rs.getString("CY_SEQ"));
				subObject.put("INBOARD_DT", rs.getString("INBOARD_DT"));
				subObject.put("FR_TIME", rs.getString("FR_TIME"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("CY_NO", rs.getString("CY_NO"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("OWN_DT", rs.getString("OWN_DT"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));

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

		} else if (V_TYPE.equals("S1")) {

			cs = conn.prepareCall("call DISTR_BL.USP_M_BL_HDR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_BL_NO
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

		} else if (V_TYPE.equals("HI") || V_TYPE.equals("U") || V_TYPE.equals("D") || V_TYPE.equals("CF")) {} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				String res = "";

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_INBOARD_DT = hashMap.get("INBOARD_DT") == null ? "" : hashMap.get("INBOARD_DT").toString().substring(0, 10);
					String V_FR_TIME = hashMap.get("FR_TIME") == null || hashMap.get("FR_TIME").equals("null") ? "" : hashMap.get("FR_TIME").toString().substring(0, 10);
					String V_IN_DT = hashMap.get("IN_DT") == null ? "" : hashMap.get("IN_DT").toString().substring(0, 10);
					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();

					String V_CY_NO = hashMap.get("CY_NO") == null ? "" : hashMap.get("CY_NO").toString();
					String V_CY_SEQ = hashMap.get("CY_SEQ") == null ? "" : hashMap.get("CY_SEQ").toString();
					String V_LC_NO = hashMap.get("LC_NO") == null ? "" : hashMap.get("LC_NO").toString();
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String V_BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
					String V_CONT_QTY = hashMap.get("CONT_QTY") == null ? "" : hashMap.get("CONT_QTY").toString();
					String V_BOX_WGT_UNIT = hashMap.get("BOX_WGT_UNIT") == null ? "" : hashMap.get("BOX_WGT_UNIT").toString();
					String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();

					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();

					cs = conn.prepareCall("call DISTR_CY.USP_M_CY_GR_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
					cs.setString(4, "");//V_LOADING_DT_FR
					cs.setString(5, "");//V_LOADING_DT_TO
					cs.setString(6, "");//V_M_BP_NM
					cs.setString(7, V_CY_NO);//V_CY_NO
					cs.setString(8, V_INBOARD_DT);//V_INBOARD_DT
					cs.setString(9, V_FR_TIME);//V_FR_TIME
					cs.setString(10, V_IN_DT);//V_IN_DT
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(12);

					while (rs.next()) {
						res = rs.getString("res");
					}

					//신규일 경우
					if (hashMap.get("CY_NO") == null) {
						V_CY_NO = res;
						V_CY_SEQ = (i + 1) + "";
					}

					cs1 = conn.prepareCall("call DISTR_CY.USP_M_CY_GR_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs1.setString(1, V_TYPE);//V_TYPE
					cs1.setString(2, V_COMP_ID);//V_COMP_ID
					cs1.setString(3, V_CY_NO);//V_CY_NO
					cs1.setString(4, V_CY_SEQ);//V_CY_SEQ
					cs1.setString(5, V_LC_NO);//V_LC_NO
					cs1.setString(6, V_BL_NO);//V_BL_NO
					cs1.setString(7, V_BL_SEQ);//V_BL_SEQ
					cs1.setString(8, V_SL_CD);//V_SL_CD
					cs1.setString(9, V_ITEM_CD);//V_ITEM_CD
					cs1.setString(10, V_BOX_QTY);//V_BOX_QTY
					cs1.setString(11, V_CONT_QTY);//V_CONT_QTY
					cs1.setString(12, V_BOX_WGT_UNIT);
					cs1.setString(13, V_QTY);
					cs1.setString(14, V_USR_ID);
					cs1.setString(15, V_PO_NO);
					cs1.setString(16, V_PO_SEQ);
					cs1.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(res);
					pw.flush();
					pw.close();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_INBOARD_DT = jsondata.get("INBOARD_DT") == null ? "" : jsondata.get("INBOARD_DT").toString().substring(0, 10);
				String V_FR_TIME = jsondata.get("FR_TIME") == null || jsondata.get("FR_TIME").equals("null") ? "" : jsondata.get("FR_TIME").toString().substring(0, 10);
				String V_IN_DT = jsondata.get("IN_DT") == null ? "" : jsondata.get("IN_DT").toString().substring(0, 10);
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();

				String V_CY_NO = jsondata.get("CY_NO") == null ? "" : jsondata.get("CY_NO").toString();
				String V_CY_SEQ = jsondata.get("CY_SEQ") == null ? "" : jsondata.get("CY_SEQ").toString();
				String V_LC_NO = jsondata.get("LC_NO") == null ? "" : jsondata.get("LC_NO").toString();
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String V_BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
				String V_CONT_QTY = jsondata.get("CONT_QTY") == null ? "" : jsondata.get("CONT_QTY").toString();
				String V_BOX_WGT_UNIT = jsondata.get("BOX_WGT_UNIT") == null ? "" : jsondata.get("BOX_WGT_UNIT").toString();
				String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();

				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();

				cs = conn.prepareCall("call DISTR_CY.USP_M_CY_GR_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
				cs.setString(4, "");//V_LOADING_DT_FR
				cs.setString(5, "");//V_LOADING_DT_TO
				cs.setString(6, "");//V_M_BP_NM
				cs.setString(7, V_CY_NO);//V_CY_NO
				cs.setString(8, V_INBOARD_DT);//V_INBOARD_DT
				cs.setString(9, V_FR_TIME);//V_FR_TIME
				cs.setString(10, V_IN_DT);//V_IN_DT
				cs.setString(11, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(12);

				String res = "";

				while (rs.next()) {
					res = rs.getString("res");
				}

				//신규일 경우
				if (jsondata.get("CY_NO") == null) {
					V_CY_NO = res;
					V_CY_SEQ = 1 + "";
				}

				cs1 = conn.prepareCall("call DISTR_CY.USP_M_CY_GR_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs1.setString(1, V_TYPE);//V_TYPE
				cs1.setString(2, V_COMP_ID);//V_COMP_ID
				cs1.setString(3, V_CY_NO);//V_CY_NO
				cs1.setString(4, V_CY_SEQ);//V_CY_SEQ
				cs1.setString(5, V_LC_NO);//V_LC_NO
				cs1.setString(6, V_BL_NO);//V_BL_NO
				cs1.setString(7, V_BL_SEQ);//V_BL_SEQ
				cs1.setString(8, V_SL_CD);//V_SL_CD
				cs1.setString(9, V_ITEM_CD);//V_ITEM_CD
				cs1.setString(10, V_BOX_QTY);//V_BOX_QTY
				cs1.setString(11, V_CONT_QTY);//V_CONT_QTY
				cs1.setString(12, V_BOX_WGT_UNIT);
				cs1.setString(13, V_QTY);
				cs1.setString(14, V_USR_ID);
				cs1.setString(15, V_PO_NO);
				cs1.setString(16, V_PO_SEQ);
				cs1.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(res);
				pw.flush();
				pw.close();

			}

		}

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		String res = e.toString();
		pw.print(res);
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
		if (cs1 != null) try {
			cs1.close();
		} catch (SQLException ex) {}
		if (rs1 != null) try {
			rs1.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>


