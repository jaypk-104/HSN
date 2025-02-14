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

		// 		System.out.println("V_PO_DT_FR" + V_PO_DT_FR);
		// 		System.out.println("V_PO_DT_TO" + V_PO_DT_TO);
		// 		System.out.println("V_PO_NO" + V_PO_NO);
		// 		System.out.println("V_M_BP_NM" + V_M_BP_NM);
		// 		System.out.println("V_LC_DOC_NO" + V_LC_DOC_NO);
		// 		System.out.println("V_APPROV_NO" + V_APPROV_NO);

		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call DISTR_BL.USP_PO_N_LC_REF(?,?,?,?,?,?,?,?)");

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
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT").substring(0, 10));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("SPEC", rs.getString("SPEC"));
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
				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
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

		} else if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call DISTR_BL.USP_M_BL_HDR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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

			
			cs = conn.prepareCall("call DISTR_BL.USP_M_BL_HDR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (!V_TYPE.equals("V")) {
				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
						String V_PO_SEQ = (i + 1) + "";
						String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
						String V_OVER_TOL = hashMap.get("OVER_TOL") == null ? "" : hashMap.get("OVER_TOL").toString();
						String V_UNDER_TOL = hashMap.get("UNDER_TOL") == null ? "" : hashMap.get("UNDER_TOL").toString();
						String V_PUR_NO = hashMap.get("PUR_NO") == null ? "" : hashMap.get("PUR_NO").toString();
						String V_PUR_SEQ = hashMap.get("PUR_SEQ") == null ? "" : hashMap.get("PUR_SEQ").toString();
						String V_PO_PRC = hashMap.get("PO_PRC") == null ? "" : hashMap.get("PO_PRC").toString();
						String V_PO_AMT = hashMap.get("PO_AMT") == null ? "" : hashMap.get("PO_AMT").toString();
						String V_PO_LOC_AMT = hashMap.get("PO_LOC_AMT") == null ? "" : hashMap.get("PO_LOC_AMT").toString();
						String V_PO_VAT_AMT = hashMap.get("PO_VAT_AMT") == null ? "" : hashMap.get("PO_VAT_AMT").toString();
						String V_DLVY_HOPE_DT = hashMap.get("DLVY_HOPE_DT") == null ? "" : hashMap.get("DLVY_HOPE_DT").toString();
						String V_HOPE_SL_CD = hashMap.get("HOPE_SL_CD") == null ? "" : hashMap.get("HOPE_SL_CD").toString();

						cs = conn.prepareCall("call USP_M_PO_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_PO_NO);//V_PO_NO
						cs.setString(4, V_PO_SEQ);//V_PO_SEQ
						cs.setString(5, "");//V_ITEM_CD
						cs.setString(6, "");//V_PO_QTY
						cs.setString(7, V_PO_PRC);//V_PO_PRC
						cs.setString(8, V_PO_AMT);//V_PO_AMT
						cs.setString(9, V_PO_LOC_AMT);//V_PO_LOC_AMT
						cs.setString(10, V_VAT_TYPE);//V_VAT_TYPE
						cs.setString(11, V_PO_VAT_AMT);//V_PO_VAT_AMT
						cs.setString(12, V_DLVY_HOPE_DT);//V_DLVY_HOPE_DT
						cs.setString(13, V_HOPE_SL_CD);//V_HOPE_SL_CD
						cs.setString(14, V_OVER_TOL);//V_OVER_TOL
						cs.setString(15, V_UNDER_TOL);//V_UNDER_TOL
						// 						cs.setString(16, V_SUPP_REMARK);//V_SUPP_REMARK
						cs.setString(17, V_PUR_NO);//V_PUR_NO
						cs.setString(18, V_PUR_SEQ);//V_PUR_SEQ
						cs.setString(19, "");//V_M_BP_CD
						cs.setString(20, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						if (V_TYPE.equals("B")) {
							rs = (ResultSet) cs.getObject(21);

							while (rs.next()) {
								subObject = new JSONObject();
								subObject.put("MB_PRC", rs.getString("MB_PRC"));
								subObject.put("LT", rs.getString("LT"));
								subObject.put("HP_SL_CD", rs.getString("HP_SL_CD"));
								subObject.put("HP_SL_NM", rs.getString("HP_SL_NM"));
								jsonArray.add(subObject);
							}
						}
					}
				} else {
					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
					String V_PO_SEQ = "1";
					if (V_TYPE.equals("D")) {
						V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
						V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					}
					if (V_TYPE.equals("U")) {
						V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
						V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					}

					String V_PO_QTY = jsondata.get("PO_QTY") == null ? "" : jsondata.get("PO_QTY").toString();
					String V_PO_PRC = jsondata.get("PO_PRC") == null ? "" : jsondata.get("PO_PRC").toString();
					String V_PO_AMT = jsondata.get("PO_AMT") == null ? "" : jsondata.get("PO_AMT").toString();
					String V_PO_LOC_AMT = jsondata.get("PO_LOC_AMT") == null ? "" : jsondata.get("PO_LOC_AMT").toString();
					String V_PO_VAT_AMT = jsondata.get("PO_VAT_AMT") == null ? "" : jsondata.get("PO_VAT_AMT").toString();
					String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
					String V_OVER_TOL = jsondata.get("OVER_TOL") == null ? "" : jsondata.get("OVER_TOL").toString();
					if (V_OVER_TOL.equals("null")) {
						V_OVER_TOL = "";
					}
					String V_UNDER_TOL = jsondata.get("UNDER_TOL") == null ? "" : jsondata.get("UNDER_TOL").toString();
					if (V_UNDER_TOL == null) {
						V_UNDER_TOL = "";
					}
					String V_PUR_NO = jsondata.get("PUR_NO") == null ? "" : jsondata.get("PUR_NO").toString();
					String V_PUR_SEQ = jsondata.get("PUR_SEQ") == null ? "" : jsondata.get("PUR_SEQ").toString();

					String V_DLVY_HOPE_DT = jsondata.get("DLVY_HOPE_DT") == null ? "" : jsondata.get("DLVY_HOPE_DT").toString();
					if (V_DLVY_HOPE_DT.equals("null")) {
						V_DLVY_HOPE_DT = "";
						// 					System.out.println("텍스트 null");
					} else if (V_DLVY_HOPE_DT == null) {
						// 					System.out.println("진짜null");
					} else if (V_DLVY_HOPE_DT.equals("")) {
						// 					System.out.println("공백");
					} else {
						// 					System.out.println("엘사?");
						V_DLVY_HOPE_DT = V_DLVY_HOPE_DT.substring(0, 10);
					}

					String V_HOPE_SL_CD = jsondata.get("HOPE_SL_CD") == null ? "" : jsondata.get("HOPE_SL_CD").toString();
					if (V_HOPE_SL_CD.equals("null")) {
						V_HOPE_SL_CD = "";
					}

					String V_SUPP_REMARK = jsondata.get("SUPP_REMARK") == null ? "" : jsondata.get("SUPP_REMARK").toString();
					cs = conn.prepareCall("call USP_M_PO_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_PO_NO);//V_PO_NO
					cs.setString(4, V_PO_SEQ);//V_PO_SEQ
					cs.setString(5, "");//V_ITEM_CD
					cs.setString(6, V_PO_QTY);//V_PO_QTY
					cs.setString(7, V_PO_PRC);//V_PO_PRC
					cs.setString(8, V_PO_AMT);//V_PO_AMT
					cs.setString(9, V_PO_LOC_AMT);//V_PO_LOC_AMT
					cs.setString(10, V_VAT_TYPE);//V_VAT_TYPE
					cs.setString(11, V_PO_VAT_AMT);//V_PO_VAT_AMT
					cs.setString(12, V_DLVY_HOPE_DT);//V_DLVY_HOPE_DT
					cs.setString(13, V_HOPE_SL_CD);//V_HOPE_SL_CD
					cs.setString(14, V_OVER_TOL);//V_OVER_TOL
					cs.setString(15, V_UNDER_TOL);//V_UNDER_TOL
					cs.setString(16, V_SUPP_REMARK);//V_SUPP_REMARK
					cs.setString(17, V_PUR_NO);//V_PUR_NO
					cs.setString(18, V_PUR_SEQ);//V_PUR_SEQ
					cs.setString(19, "");//V_M_BP_CD
					cs.setString(20, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					if (V_TYPE.equals("B")) {
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
					}
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


