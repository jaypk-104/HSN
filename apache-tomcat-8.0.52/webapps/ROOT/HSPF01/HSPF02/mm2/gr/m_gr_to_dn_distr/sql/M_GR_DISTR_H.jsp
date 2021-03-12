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
		String V_ID_DT_FR = request.getParameter("V_ID_DT_FR") == null ? "" : request.getParameter("V_ID_DT_FR").toUpperCase().substring(0, 10);
		String V_ID_DT_TO = request.getParameter("V_ID_DT_TO") == null ? "" : request.getParameter("V_ID_DT_TO").toUpperCase().substring(0, 10);
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
		String V_SL_CD2 = request.getParameter("V_SL_CD2") == null ? "" : request.getParameter("V_SL_CD2").toUpperCase();

		if (V_SL_CD.equals("T")) {
			V_SL_CD = "";
		}

		if (V_TYPE.equals("SH")) {

			cs = conn.prepareCall("call DISTR_GR.USP_M_GR_DISTR_REF(?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_ID_DT_FR);//V_ID_DT_FR
			cs.setString(3, V_ID_DT_TO);//V_ID_DT_TO
			cs.setString(4, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(5, V_M_BP_NM);//V_M_BP_NM
			cs.setString(6, V_SL_CD);//V_SL_CD
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("CC_SEQ", rs.getString("CC_SEQ"));
				subObject.put("ID_NO", rs.getString("ID_NO"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("INBOARD_DT", rs.getString("INBOARD_DT"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("INBOARD_DT"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
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

		} else if (V_TYPE.equals("SD")) {

			cs = conn.prepareCall("call DISTR_GR.USP_M_GR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_MVMT_NO
			cs.setString(4, "");//V_FIRST_YN
			cs.setString(5, "");//V_IV_TYPE
			cs.setString(6, "");//V_MVMT_DT
			cs.setString(7, "");//V_M_BP_CD
			cs.setString(8, "");//V_GR_SEQ
			cs.setString(9, "");//V_GR_SEQ
			cs.setString(10, "");//V_CUR
			cs.setString(11, "");//V_XCHG_RT
			cs.setString(12, "");//V_FORWARD_XCH_RT
			cs.setString(13, "");//V_ITEM_CD
			cs.setString(14, "");//V_QTY
			cs.setString(15, "");//V_DOC_AMT
			cs.setString(16, "");//V_LOC_AMT
			cs.setString(17, "");//V_PO_NO
			cs.setString(18, "");//V_PO_SEQ
			cs.setString(19, "");//V_FORWARD_XCH_AMT
			cs.setString(20, "");//V_BOX_QTY
			cs.setString(21, "");//V_BOX_WGT_UNIT
			cs.setString(22, "");//V_DN_QTY
			cs.setString(23, "");//V_SL_CD
			cs.setString(24, "");//V_CC_NO
			cs.setString(25, "");//V_CC_SEQ
			cs.setString(26, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(27);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("TOTAL_QTY", rs.getString("TOTAL_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("TOTAL_QTY", rs.getString("TOTAL_QTY"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("PAY_TYPE_NM", rs.getString("PAY_TYPE_NM"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("TONG_AMT", rs.getString("TONG_AMT"));
				subObject.put("GWAN_AMT", rs.getString("GWAN_AMT"));
				subObject.put("INSU_AMT", rs.getString("INSU_AMT"));
				subObject.put("ETC_AMT", rs.getString("ETC_AMT"));
				subObject.put("TOTAL_AMT", rs.getString("TOTAL_AMT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("ETC_AMT", rs.getString("ETC_AMT"));
				subObject.put("AC_AMT", rs.getString("AC_AMT"));
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("CC_SEQ", rs.getString("CC_SEQ"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);


			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			String V_GR_NO = "";
			String V_MVMT_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").substring(0, 10);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_CC_NO = hashMap.get("CC_NO") == null ? "" : hashMap.get("CC_NO").toString();
					String V_CC_SEQ = hashMap.get("CC_SEQ") == null ? "" : hashMap.get("CC_SEQ").toString();
					String V_ID_NO = hashMap.get("ID_NO") == null ? "" : hashMap.get("ID_NO").toString();
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String V_CONT_NO = hashMap.get("CONT_NO") == null ? "" : hashMap.get("CONT_NO").toString();
					String V_LOADING_DT = hashMap.get("LOADING_DT") == null ? "" : hashMap.get("LOADING_DT").toString().substring(0, 10);
					String V_INBOARD_DT = hashMap.get("INBOARD_DT") == null ? "" : hashMap.get("INBOARD_DT").toString().substring(0, 10);
					String V_ID_DT = hashMap.get("ID_DT") == null ? "" : hashMap.get("ID_DT").toString().substring(0, 10);
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String V_SPEC = hashMap.get("SPEC") == null ? "" : hashMap.get("SPEC").toString();
					String V_UNIT = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
					String V_BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
					String V_QTY = hashMap.get("PRC") == null ? "" : hashMap.get("PRC").toString();
					String V_PRC = hashMap.get("PRICE") == null ? "" : hashMap.get("PRICE").toString();
					String V_XCHG_RT = hashMap.get("XCHG_RT") == null ? "" : hashMap.get("XCHG_RT").toString();
					String V_DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
					String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
					String V_BOX_WGT_UNIT = hashMap.get("BOX_WGT_UNIT") == null ? "" : hashMap.get("BOX_WGT_UNIT").toString();
					String V_FORWARD_XCH_RT = hashMap.get("FORWARD_XCH_RT") == null ? "" : hashMap.get("FORWARD_XCH_RT").toString();
					String V_FORWARD_XCH_AMT = hashMap.get("FORWARD_XCH_AMT") == null ? "" : hashMap.get("FORWARD_XCH_AMT").toString();

					String V_FIRST_YN = "";
					String V_GR_SEQ = "";

					if (V_TYPE.equals("I") && (i == 0)) {
						V_FIRST_YN = "Y";
						V_GR_SEQ = 1 + "";

					} else if (V_TYPE.equals("I") && (i > 0)) {
						V_FIRST_YN = "N";
						V_GR_SEQ = (i + 1) + "";
					}

					if (!V_TYPE.equals("I")) {
						V_GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
						V_GR_SEQ = hashMap.get("GR_SEQ") == null ? "" : hashMap.get("GR_SEQ").toString();
					}

					String V_IV_TYPE = hashMap.get("IV_TYPE") == null ? "" : hashMap.get("IV_TYPE").toString();
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();

					cs = conn.prepareCall("call DISTR_GR.USP_M_GR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_MVMT_NO);//V_MVMT_NO
					cs.setString(4, V_FIRST_YN);//V_FIRST_YN
					cs.setString(5, V_IV_TYPE);//V_IV_TYPE
					cs.setString(6, V_MVMT_DT);//V_MVMT_DT
					cs.setString(7, V_M_BP_CD);//V_M_BP_CD
					cs.setString(8, V_GR_NO);//V_GR_SEQ
					cs.setString(9, V_GR_SEQ);//V_GR_SEQ
					cs.setString(10, V_CUR);//V_CUR
					cs.setString(11, V_XCHG_RT);//V_XCHG_RT
					cs.setString(12, V_FORWARD_XCH_RT);//V_FORWARD_XCH_RT
					cs.setString(13, V_ITEM_CD);//V_ITEM_CD
					cs.setString(14, V_QTY);//V_QTY
					cs.setString(15, V_DOC_AMT);//V_DOC_AMT
					cs.setString(16, V_LOC_AMT);//V_LOC_AMT
					cs.setString(17, V_PO_NO);//V_PO_NO
					cs.setString(18, V_PO_SEQ);//V_PO_SEQ
					cs.setString(19, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
					cs.setString(20, V_BOX_QTY);//V_BOX_QTY
					cs.setString(21, V_BOX_WGT_UNIT);//V_BOX_WGT_UNIT
					cs.setString(22, V_DN_QTY);//V_DN_QTY
					cs.setString(23, V_SL_CD2);//V_SL_CD
					cs.setString(24, V_CC_NO);//V_CC_NO
					cs.setString(25, V_CC_SEQ);//V_CC_SEQ
					cs.setString(26, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					if (V_TYPE.equals("I") && (i == 0)) {
						rs = (ResultSet) cs.getObject(27);
						while (rs.next()) {
							V_GR_NO = rs.getString("GR_NO");
						}
					}

					System.out.println("V_GR_NO" + V_GR_NO);

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_CC_NO = jsondata.get("CC_NO") == null ? "" : jsondata.get("CC_NO").toString();
				String V_CC_SEQ = jsondata.get("CC_SEQ") == null ? "" : jsondata.get("CC_SEQ").toString();
				String V_ID_NO = jsondata.get("ID_NO") == null ? "" : jsondata.get("ID_NO").toString();
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String V_CONT_NO = jsondata.get("CONT_NO") == null ? "" : jsondata.get("CONT_NO").toString();
				String V_LOADING_DT = jsondata.get("LOADING_DT") == null ? "" : jsondata.get("LOADING_DT").toString().substring(0, 10);
				String V_INBOARD_DT = jsondata.get("INBOARD_DT") == null ? "" : jsondata.get("INBOARD_DT").toString().substring(0, 10);
				String V_ID_DT = jsondata.get("ID_DT") == null ? "" : jsondata.get("ID_DT").toString().substring(0, 10);
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String V_SPEC = jsondata.get("SPEC") == null ? "" : jsondata.get("SPEC").toString();
				String V_UNIT = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
				String V_BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
				String V_QTY = jsondata.get("PRC") == null ? "" : jsondata.get("PRC").toString();
				String V_PRC = jsondata.get("PRICE") == null ? "" : jsondata.get("PRICE").toString();
				String V_XCHG_RT = jsondata.get("XCHG_RT") == null ? "" : jsondata.get("XCHG_RT").toString();
				String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
				String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
				String V_BOX_WGT_UNIT = jsondata.get("BOX_WGT_UNIT") == null ? "" : jsondata.get("BOX_WGT_UNIT").toString();
				String V_FORWARD_XCH_RT = jsondata.get("FORWARD_XCH_RT") == null ? "" : jsondata.get("FORWARD_XCH_RT").toString();
				String V_FORWARD_XCH_AMT = jsondata.get("FORWARD_XCH_AMT") == null ? "" : jsondata.get("FORWARD_XCH_AMT").toString();
				
				
				String V_FIRST_YN = "Y";
				V_GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();
				String V_GR_SEQ = jsondata.get("GR_SEQ") == null ? "" : jsondata.get("GR_SEQ").toString();

				if (V_TYPE.equals("I")) {
					V_GR_SEQ = 1 + "";
				}

				String V_IV_TYPE = jsondata.get("IV_TYPE") == null ? "" : jsondata.get("IV_TYPE").toString();
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();

				cs = conn.prepareCall("call DISTR_GR.USP_M_GR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_MVMT_NO);//V_MVMT_NO
				cs.setString(4, V_FIRST_YN);//V_FIRST_YN
				cs.setString(5, V_IV_TYPE);//V_IV_TYPE
				cs.setString(6, V_MVMT_DT);//V_MVMT_DT
				cs.setString(7, V_M_BP_CD);//V_M_BP_CD
				cs.setString(8, V_GR_NO);//V_GR_SEQ
				cs.setString(9, V_GR_SEQ);//V_GR_SEQ
				cs.setString(10, V_CUR);//V_CUR
				cs.setString(11, V_XCHG_RT);//V_XCHG_RT
				cs.setString(12, V_FORWARD_XCH_RT);//V_FORWARD_XCH_RT
				cs.setString(13, V_ITEM_CD);//V_ITEM_CD
				cs.setString(14, V_QTY);//V_QTY
				cs.setString(15, V_DOC_AMT);//V_DOC_AMT
				cs.setString(16, V_LOC_AMT);//V_LOC_AMT
				cs.setString(17, V_PO_NO);//V_PO_NO
				cs.setString(18, V_PO_SEQ);//V_PO_SEQ
				cs.setString(19, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
				cs.setString(20, V_BOX_QTY);//V_BOX_QTY
				cs.setString(21, V_BOX_WGT_UNIT);//V_BOX_WGT_UNIT
				cs.setString(22, V_DN_QTY);//V_DN_QTY
				cs.setString(23, V_SL_CD2);//V_SL_CD
				cs.setString(24, V_CC_NO);//V_CC_NO
				cs.setString(25, V_CC_SEQ);//V_CC_SEQ
				cs.setString(26, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				// 				if (i == 0) {
				// 					rs = (ResultSet) cs.getObject(27);
				// 					while (rs.next()) {
				// 						V_GR_NO = rs.getString("GR_NO");
				// 					}
				// 				}

// 				System.out.println("V_GR_NO" + V_GR_NO);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
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


