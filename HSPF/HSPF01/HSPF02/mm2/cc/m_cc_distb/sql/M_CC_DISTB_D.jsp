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
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
		String V_BL_SEQ = request.getParameter("V_BL_SEQ") == null ? "" : request.getParameter("V_BL_SEQ").toUpperCase();
		String V_CC_NO = request.getParameter("V_CC_NO") == null ? "" : request.getParameter("V_CC_NO").toUpperCase();

		// 		System.out.println(V_CC_NO);

		//통관하단조회
		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call DISTR_CC.USP_M_CC_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_CC_NO);//V_CC_NO
			cs.setString(4, "");//V_CC_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_QTY
			cs.setString(7, "");//V_DOC_AMT
			cs.setString(8, "");//V_DOC_AMT
			cs.setString(9, "");//V_PO_NO
			cs.setString(10, "");//V_PO_SEQ
			cs.setString(11, "");//V_FORWARD_XCH_AMT
			cs.setString(12, "");//V_BOX_QTY
			cs.setString(13, "");//V_BOX_WGT_UNIT
			cs.setString(14, "");//V_GR_QTY
			cs.setString(15, "");//V_SL_CD
			cs.setString(16, V_BL_NO);//V_BL_NO
			cs.setString(17, V_BL_SEQ);//V_BL_SEQ
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(20, "");//V_DATA
			cs.setString(21, "");//V_TAX_RATE
			cs.setString(22, "");//V_EX_YN
			cs.setString(23, "");//V_REMARK
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);
			while (rs.next()) {

				subObject = new JSONObject();
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("CC_SEQ", rs.getString("CC_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("TOTAL_QTY", rs.getString("TOTAL_QTY"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("XCH_AMT", rs.getString("XCH_AMT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("DATA", rs.getString("DATA"));
				subObject.put("TAX_RATE", rs.getString("TAX_RATE"));
				subObject.put("EX_YN", rs.getString("EX_YN"));
				subObject.put("REMARK", rs.getString("REMARK"));
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

			//통관팝업조회
		} else if (V_TYPE.equals("SP")) {

			String V_ID_DT_FR = request.getParameter("V_ID_DT_FR") == null ? "" : request.getParameter("V_ID_DT_FR").substring(0, 10);
			String V_ID_DT_TO = request.getParameter("V_ID_DT_TO") == null ? "" : request.getParameter("V_ID_DT_TO").substring(0, 10);
			String W_ID_NO = request.getParameter("W_ID_NO") == null ? "" : request.getParameter("W_ID_NO").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("W_BL_DOC_NO") == null ? "" : request.getParameter("W_BL_DOC_NO").toUpperCase();
			String V_CONT_NO = request.getParameter("W_CONT_NO") == null ? "" : request.getParameter("W_CONT_NO").toUpperCase();

			cs = conn.prepareCall("call DISTR_CC.USP_M_CC_POPUP_DISTR(?,?,?,?,?)");
			cs.setString(1, V_ID_DT_FR);//V_ID_DT_FR
			cs.setString(2, V_ID_DT_TO);//V_ID_DT_TO
			cs.setString(3, W_ID_NO);//W_ID_NO
			cs.setString(4, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("ID_NO", rs.getString("ID_NO"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("TOTAL_QTY", rs.getString("TOTAL_QTY"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				// 				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
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

			//DTL 저장 / 수정 / 삭제 / 확정
		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			//System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {

					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_CC_NO = hashMap.get("CC_NO") == null ? "" : hashMap.get("CC_NO").toString();
					String V_CC_SEQ = hashMap.get("CC_SEQ") == null ? "" : hashMap.get("CC_SEQ").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					String V_DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
					String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String V_FORWARD_XCH_AMT = hashMap.get("FORWARD_XCH_AMT") == null ? "" : hashMap.get("FORWARD_XCH_AMT").toString();
					String V_BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
					String V_BOX_WGT_UNIT = hashMap.get("BOX_WGT_UNIT") == null ? "" : hashMap.get("BOX_WGT_UNIT").toString();
					String V_GR_QTY = hashMap.get("GR_QTY") == null ? "" : hashMap.get("GR_QTY").toString();
					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					V_BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
					String V_DATA = hashMap.get("DATA") == null ? "" : hashMap.get("DATA").toString();
					String V_TAX_RATE = hashMap.get("TAX_RATE") == null ? "0" : hashMap.get("TAX_RATE").toString();
					String V_EX_YN = hashMap.get("EX_YN") == null ? "" : hashMap.get("EX_YN").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();

					if (V_TYPE.equals("I")) {
						V_CC_NO = request.getParameter("V_CC_NO") == null ? "" : request.getParameter("V_CC_NO");
						V_CC_SEQ = (i + 1) + "";
					}

					cs = conn.prepareCall("call DISTR_CC.USP_M_CC_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_CC_NO);//V_CC_NO
					cs.setString(4, V_CC_SEQ);//V_CC_SEQ
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, V_QTY);//V_QTY
					cs.setString(7, V_DOC_AMT);//V_DOC_AMT
					cs.setString(8, V_LOC_AMT);//V_DOC_AMT
					cs.setString(9, V_PO_NO);//V_PO_NO
					cs.setString(10, V_PO_SEQ);//V_PO_SEQ
					cs.setString(11, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
					cs.setString(12, V_BOX_QTY);//V_BOX_QTY
					cs.setString(13, V_BOX_WGT_UNIT);//V_BOX_WGT_UNIT
					cs.setString(14, V_GR_QTY);//V_GR_QTY
					cs.setString(15, V_SL_CD);//V_SL_CD
					cs.setString(16, V_BL_NO);//V_BL_NO
					cs.setString(17, V_BL_SEQ);//V_BL_SEQ
					cs.setString(18, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(20, V_DATA);//V_DATA
					cs.setString(21, V_TAX_RATE);//V_TAX_RATE
					cs.setString(22, V_EX_YN);//V_EX_YN
					cs.setString(23, V_REMARK);//V_REMARK
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_CC_NO = jsondata.get("CC_NO") == null ? "" : jsondata.get("CC_NO").toString();
				String V_CC_SEQ = jsondata.get("CC_SEQ") == null ? "" : jsondata.get("CC_SEQ").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
				String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
				String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String V_FORWARD_XCH_AMT = jsondata.get("FORWARD_XCH_AMT") == null ? "" : jsondata.get("FORWARD_XCH_AMT").toString();
				String V_BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
				String V_BOX_WGT_UNIT = jsondata.get("BOX_WGT_UNIT") == null ? "" : jsondata.get("BOX_WGT_UNIT").toString();
				String V_GR_QTY = jsondata.get("GR_QTY") == null ? "" : jsondata.get("GR_QTY").toString();
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				V_BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
				String V_DATA = jsondata.get("DATA") == null ? "" : jsondata.get("DATA").toString();
				String V_TAX_RATE = jsondata.get("TAX_RATE") == null ? "0" : jsondata.get("TAX_RATE").toString();
				String V_EX_YN = jsondata.get("EX_YN") == null ? "" : jsondata.get("EX_YN").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();

				// 				System.out.println("V_TAX_RATE" + V_TAX_RATE);
				// 								System.out.println("V_CC_SEQ" + V_CC_SEQ);

				if (V_TYPE.equals("I")) {
					V_CC_NO = request.getParameter("V_CC_NO") == null ? "" : request.getParameter("V_CC_NO");
					V_CC_SEQ = 1 + "";
				}

				cs = conn.prepareCall("call DISTR_CC.USP_M_CC_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_CC_NO);//V_CC_NO
				cs.setString(4, V_CC_SEQ);//V_CC_SEQ
				cs.setString(5, V_ITEM_CD);//V_ITEM_CD
				cs.setString(6, V_QTY);//V_QTY
				cs.setString(7, V_DOC_AMT);//V_DOC_AMT
				cs.setString(8, V_LOC_AMT);//V_DOC_AMT
				cs.setString(9, V_PO_NO);//V_PO_NO
				cs.setString(10, V_PO_SEQ);//V_PO_SEQ
				cs.setString(11, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
				cs.setString(12, V_BOX_QTY);//V_BOX_QTY
				cs.setString(13, V_BOX_WGT_UNIT);//V_BOX_WGT_UNIT
				cs.setString(14, V_GR_QTY);//V_GR_QTY
				cs.setString(15, V_SL_CD);//V_SL_CD
				cs.setString(16, V_BL_NO);//V_BL_NO
				cs.setString(17, V_BL_SEQ);//V_BL_SEQ
				cs.setString(18, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(20, V_DATA);//V_DATA
				cs.setString(21, V_TAX_RATE);//V_TAX_RATE
				cs.setString(22, V_EX_YN);//V_EX_YN
				cs.setString(23, V_REMARK);//V_REMARK
				cs.executeQuery();

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


