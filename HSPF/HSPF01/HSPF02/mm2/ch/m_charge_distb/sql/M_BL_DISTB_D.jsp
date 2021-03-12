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

		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call DISTR_BL.USP_M_BL_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_NO);//V_BL_NO
			cs.setString(4, V_BL_SEQ);//V_BL_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_QTY
			cs.setString(7, "");//V_PRICE
			cs.setString(8, "");//V_DOC_AMT
			cs.setString(9, "");//V_LOC_AMT
			cs.setString(10, "");//V_PO_NO
			cs.setString(11, "");//V_PO_SEQ
			cs.setString(12, "");//V_CONT_NO
			cs.setString(13, "");//V_CONT_QTY
			cs.setString(14, "");//V_BOX_QTY
			cs.setString(15, "");//V_BOX_WGT_UNIT
			cs.setString(16, "");//V_FORWARD_XCH_AMT
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("CONT_QTY", rs.getString("CONT_QTY"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("CC_QTY", rs.getString("CC_QTY"));
				subObject.put("CY_QTY", rs.getString("CY_QTY"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
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

		} else if (V_TYPE.equals("SP")) {

			String V_LOADING_DT_FR = request.getParameter("W_LOADING_DT_FR") == null ? "" : request.getParameter("W_LOADING_DT_FR").substring(0, 10);
			String V_LOADING_DT_TO = request.getParameter("W_LOADING_DT_TO") == null ? "" : request.getParameter("W_LOADING_DT_TO").substring(0, 10);
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("W_BL_DOC_NO") == null ? "" : request.getParameter("W_BL_DOC_NO").toUpperCase();
			String V_CONT_NO = request.getParameter("W_CONT_NO") == null ? "" : request.getParameter("W_CONT_NO").toUpperCase();

			cs = conn.prepareCall("call DISTR_BL.USP_M_BL_POPUP(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_LOADING_DT_FR);//V_LOADING_DT_FR
			cs.setString(2, V_LOADING_DT_TO);//V_LOADING_DT_TO
			cs.setString(3, V_M_BP_NM);//V_M_BP_NM
			cs.setString(4, "");//V_S_BP_NM
			cs.setString(5, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(6, V_CONT_NO);//V_CONT_NO
			cs.setString(7, "");
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
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

			//BL DTL 저장 / 수정 / 삭제 / 확정
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
						V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
						V_BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
						String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
						String V_PRICE = hashMap.get("PRICE") == null ? "" : hashMap.get("PRICE").toString();
						String V_DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
						String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
						String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
						String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
						String V_CONT_NO = hashMap.get("CONT_NO") == null ? "" : hashMap.get("CONT_NO").toString();
						String V_CONT_QTY = hashMap.get("CONT_QTY") == null ? "" : hashMap.get("CONT_QTY").toString();
						String V_BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
						String V_BOX_WGT_UNIT = hashMap.get("BOX_WGT_UNIT") == null ? "" : hashMap.get("BOX_WGT_UNIT").toString();
						String V_FORWARD_XCH_AMT = hashMap.get("FORWARD_XCH_AMT") == null ? "" : hashMap.get("FORWARD_XCH_AMT").toString();
						String V_OVER_TOL = hashMap.get("OVER_TOL") == null ? "" : hashMap.get("OVER_TOL").toString();

						if (V_TYPE.equals("I")) {
							V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO");
							V_BL_SEQ = (i + 1) + "";
						}

						// 						System.out.println("V_TYPE_DTL: " + V_TYPE);

						cs = conn.prepareCall("call DISTR_BL.USP_M_BL_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_BL_NO);//V_BL_NO
						cs.setString(4, V_BL_SEQ);//V_BL_SEQ
						cs.setString(5, V_ITEM_CD);//V_ITEM_CD
						cs.setString(6, V_QTY);//V_QTY
						cs.setString(7, V_PRICE);//V_PRICE
						cs.setString(8, V_DOC_AMT);//V_DOC_AMT
						cs.setString(9, V_LOC_AMT);//V_LOC_AMT
						cs.setString(10, V_PO_NO);//V_PO_NO
						cs.setString(11, V_PO_SEQ);//V_PO_SEQ
						cs.setString(12, V_CONT_NO);//V_CONT_NO
						cs.setString(13, V_CONT_QTY);//V_CONT_QTY
						cs.setString(14, V_BOX_QTY);//V_BOX_QTY
						cs.setString(15, V_BOX_WGT_UNIT);//V_BOX_WGT_UNIT
						cs.setString(16, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
						cs.setString(17, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
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
					V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
					V_BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
					String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
					String V_PRICE = jsondata.get("PRICE") == null ? "" : jsondata.get("PRICE").toString();
					String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
					String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
					String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
					String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					String V_CONT_NO = jsondata.get("CONT_NO") == null ? "" : jsondata.get("CONT_NO").toString();
					String V_CONT_QTY = jsondata.get("CONT_QTY") == null ? "" : jsondata.get("CONT_QTY").toString();
					String V_BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
					String V_BOX_WGT_UNIT = jsondata.get("BOX_WGT_UNIT") == null ? "" : jsondata.get("BOX_WGT_UNIT").toString();
					String V_FORWARD_XCH_AMT = jsondata.get("FORWARD_XCH_AMT") == null ? "" : jsondata.get("FORWARD_XCH_AMT").toString();
					String V_OVER_TOL = jsondata.get("OVER_TOL") == null ? "" : jsondata.get("OVER_TOL").toString();

					if (V_TYPE.equals("I")) {
						V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO");
						V_BL_SEQ = 1 + "";
					}

					// 					System.out.println("V_TYPE_DTL: " + V_TYPE);

					cs = conn.prepareCall("call DISTR_BL.USP_M_BL_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_BL_NO);//V_BL_NO
					cs.setString(4, V_BL_SEQ);//V_BL_SEQ
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, V_QTY);//V_QTY
					cs.setString(7, V_PRICE);//V_PRICE
					cs.setString(8, V_DOC_AMT);//V_DOC_AMT
					cs.setString(9, V_LOC_AMT);//V_LOC_AMT
					cs.setString(10, V_PO_NO);//V_PO_NO
					cs.setString(11, V_PO_SEQ);//V_PO_SEQ
					cs.setString(12, V_CONT_NO);//V_CONT_NO
					cs.setString(13, V_CONT_QTY);//V_CONT_QTY
					cs.setString(14, V_BOX_QTY);//V_BOX_QTY
					cs.setString(15, V_BOX_WGT_UNIT);//V_BOX_WGT_UNIT
					cs.setString(16, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
					cs.setString(17, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
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


