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
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0, 10);
		String V_M_BP_NM = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO").toUpperCase();

		System.out.println("V_TYPE" + V_TYPE);

		//발주참조조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_M_LOCAL_LC_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_LC_NO
			cs.setString(4, "");//V_LC_DOC_NO
			cs.setString(5, "");//V_LC_AMEND_SEQ
			cs.setString(6, "");//V_BANK_CD
			cs.setString(7, V_PO_NO);//V_PO_NO
			cs.setString(8, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(9, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(10, V_M_BP_NM);//V_M_BP_NM
			cs.setString(11, "");//V_REQ_DT
			cs.setString(12, "");//V_OPEN_DT
			cs.setString(13, "");//V_EXPIRY_DT
			cs.setString(14, "");//V_AMEND_DT
			cs.setString(15, "");//V_CUR
			cs.setString(16, "");//V_XCH_RATE
			cs.setString(17, "");//V_DOC_AMT
			cs.setString(18, "");//V_LOC_AMT
			cs.setString(19, "");//V_PAY_METH
			cs.setString(20, "");//V_IN_TERMS
			cs.setString(21, "");//V_M_BP_CD
			cs.setString(22, "");//V_LC_KIND
			cs.setString(23, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(24);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("OVER_TOL", rs.getString("OVER_TOL"));
				subObject.put("UNDER_TOL", rs.getString("UNDER_TOL"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				jsonArray.add(subObject);

			}

			jsonObject = new JSONObject();

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//LC헤더조회
		} else if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_M_LOCAL_LC_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_LC_NO);//V_LC_NO
			cs.setString(4, "");//V_LC_DOC_NO
			cs.setString(5, "");//V_LC_AMEND_SEQ
			cs.setString(6, "");//V_BANK_CD
			cs.setString(7, "");//V_PO_NO
			cs.setString(8, "");//V_PO_DT_FR
			cs.setString(9, "");//V_PO_DT_TO
			cs.setString(10, "");//V_M_BP_NM
			cs.setString(11, "");//V_REQ_DT
			cs.setString(12, "");//V_OPEN_DT
			cs.setString(13, "");//V_EXPIRY_DT
			cs.setString(14, "");//V_AMEND_DT
			cs.setString(15, "");//V_CUR
			cs.setString(16, "");//V_XCH_RATE
			cs.setString(17, "");//V_DOC_AMT
			cs.setString(18, "");//V_LOC_AMT
			cs.setString(19, "");//V_PAY_METH
			cs.setString(20, "");//V_IN_TERMS
			cs.setString(21, "");//V_M_BP_CD
			cs.setString(22, "");//V_LC_KIND
			cs.setString(23, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(24);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_AMEND_SEQ", rs.getString("LC_AMEND_SEQ"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("REQ_DT", rs.getString("REQ_DT"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("EXPIRY_DT", rs.getString("EXPIRY_DT"));
				subObject.put("AMEND_DT", rs.getString("AMEND_DT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				jsonArray.add(subObject);

			}
			jsonObject = new JSONObject();

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			// LC디테일조회
		} else if (V_TYPE.equals("DS")) {
			cs = conn.prepareCall("call USP_M_LOCAL_LC_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "DS");//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_LC_NO);//V_LC_NO
			cs.setString(4, "");//V_LC_SEQ
			cs.setString(5, "");//V_HS_CD
			cs.setString(6, "");//V_ITEM_CD
			cs.setString(7, "");//V_QTY
			cs.setString(8, "");//V_PRICE
			cs.setString(9, "");//V_DOC_AMT
			cs.setString(10, "");//V_OVER_TOL
			cs.setString(11, "");//V_UNDER_TOL
			cs.setString(12, "");//V_PO_NO
			cs.setString(13, "");//V_PO_SEQ
			cs.setString(14, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(15);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("OVER_TOL", rs.getString("OVER_TOL"));
				subObject.put("UNDER_TOL", rs.getString("UNDER_TOL"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
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

			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO");
			String V_BANK_CD = request.getParameter("V_BANK_CD") == null ? "" : request.getParameter("V_BANK_CD");
			String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE");
			String V_EXPIRY_DT = request.getParameter("V_EXPIRY_DT") == null ? "" : request.getParameter("V_EXPIRY_DT").substring(0, 10);
			String V_AMEND_DT = request.getParameter("V_AMEND_DT") == null ? "" : request.getParameter("V_AMEND_DT").substring(0, 10);
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR");
			String V_OPEN_DT = request.getParameter("V_OPEN_DT") == null ? "" : request.getParameter("V_OPEN_DT").substring(0, 10);
			V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_TYPE2 = hashMap.get("V_TYPE2") == null ? "" : hashMap.get("V_TYPE2").toString();
					String V_LC_SEQ = "";

					if (!V_TYPE.equals("SI")) {
						V_LC_NO = hashMap.get("LC_NO") == null ? "" : hashMap.get("LC_NO").toString();
					}

					if (V_TYPE.equals("SI")) {
						V_LC_SEQ = (i + 1) + "";
					} else {
						V_LC_SEQ = hashMap.get("LC_SEQ") == null ? "" : hashMap.get("LC_SEQ").toString();
					}
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_QTY = hashMap.get("PO_QTY") == null ? "" : hashMap.get("PO_QTY").toString();
					String V_PRICE = hashMap.get("PO_PRC") == null ? "" : hashMap.get("PO_PRC").toString();
					String V_DOC_AMT = hashMap.get("PO_AMT") == null ? "" : hashMap.get("PO_AMT").toString();
					String V_OVER_TOL = hashMap.get("OVER_TOL") == null ? "" : hashMap.get("OVER_TOL").toString();
					String V_UNDER_TOL = hashMap.get("UNDER_TOL") == null ? "" : hashMap.get("UNDER_TOL").toString();
					V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();

					System.out.println("V_TYPE" + V_TYPE);
					System.out.println("V_TYPE2" + V_TYPE2);
					System.out.println("V_LC_NO" + V_LC_NO);
					System.out.println("V_LC_SEQ" + V_LC_SEQ);

					//LC번호 채번
					if (i == 0) {
						if (V_TYPE.equals("SI")) {
							cs = conn.prepareCall("call USP_M_LOCAL_LC_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, "NI");//V_TYPE
							cs.setString(2, V_COMP_ID);//V_COMP_ID
							cs.setString(3, "");//V_LC_NO
							cs.setString(4, "");//V_LC_DOC_NO
							cs.setString(5, "");//V_LC_AMEND_SEQ
							cs.setString(6, "");//V_BANK_CD
							cs.setString(7, "");//V_PO_NO
							cs.setString(8, "");//V_PO_DT_FR
							cs.setString(9, "");//V_PO_DT_TO
							cs.setString(10, "");//V_M_BP_NM
							cs.setString(11, "");//V_REQ_DT
							cs.setString(12, V_OPEN_DT);//V_OPEN_DT
							cs.setString(13, "");//V_EXPIRY_DT
							cs.setString(14, "");//V_AMEND_DT
							cs.setString(15, "");//V_CUR
							cs.setString(16, "");//V_XCH_RATE
							cs.setString(17, "");//V_DOC_AMT
							cs.setString(18, "");//V_LOC_AMT
							cs.setString(19, "");//V_PAY_METH
							cs.setString(20, "");//V_IN_TERMS
							cs.setString(21, "");//V_M_BP_CD
							cs.setString(22, "");//V_LC_KIND
							cs.setString(23, V_USR_ID);//V_USR_ID
							cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
							cs.executeQuery();

							rs = (ResultSet) cs.getObject(24);

							while (rs.next()) {
								V_LC_NO = rs.getString("LC_NO");
							}

							response.setContentType("text/plain; charset=UTF-8");
							PrintWriter pw = response.getWriter();
							pw.print(V_LC_NO);
							pw.flush();
							pw.close();
						}

						//LC헤더등록
						cs = conn.prepareCall("call USP_M_LOCAL_LC_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_LC_NO);//V_LC_NO
						cs.setString(4, V_LC_DOC_NO);//V_LC_DOC_NO
						cs.setString(5, "");//V_LC_AMEND_SEQ
						cs.setString(6, V_BANK_CD);//V_BANK_CD
						cs.setString(7, "");//V_PO_NO
						cs.setString(8, "");//V_PO_DT_FR
						cs.setString(9, "");//V_PO_DT_TO
						cs.setString(10, "");//V_M_BP_NM
						cs.setString(11, "");//V_REQ_DT
						cs.setString(12, V_OPEN_DT);//V_OPEN_DT
						cs.setString(13, V_EXPIRY_DT);//V_EXPIRY_DT
						cs.setString(14, V_AMEND_DT);//V_AMEND_DT
						cs.setString(15, V_CUR);//V_CUR
						cs.setString(16, V_XCH_RATE);//V_XCH_RATE
						cs.setString(17, "");//V_DOC_AMT
						cs.setString(18, "");//V_LOC_AMT
						cs.setString(19, "");//V_PAY_METH
						cs.setString(20, "");//V_IN_TERMS
						cs.setString(21, "");//V_M_BP_CD
						cs.setString(22, "");//V_LC_KIND
						cs.setString(23, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}

					//LC DETAIL 등록
					cs = conn.prepareCall("call USP_M_LOCAL_LC_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE2);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_LC_NO);//V_LC_NO
					cs.setString(4, V_LC_SEQ);//V_LC_SEQ
					cs.setString(5, "");//V_HS_CD
					cs.setString(6, V_ITEM_CD);//V_ITEM_CD
					cs.setString(7, V_QTY);//V_QTY
					cs.setString(8, V_PRICE);//V_PRICE
					cs.setString(9, V_DOC_AMT);//V_DOC_AMT
					cs.setString(10, V_OVER_TOL);//V_OVER_TOL
					cs.setString(11, V_UNDER_TOL);//V_UNDER_TOL
					cs.setString(12, V_PO_NO);//V_PO_NO
					cs.setString(13, V_PO_SEQ);//V_PO_SEQ
					cs.setString(14, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_TYPE2 = jsondata.get("V_TYPE2") == null ? "" : jsondata.get("V_TYPE2").toString();

				if (!V_TYPE.equals("SI")) {
					V_LC_NO = jsondata.get("LC_NO") == null ? "" : jsondata.get("LC_NO").toString();
				}
				String V_LC_SEQ = "";

				if (V_TYPE.equals("SI")) {
					V_LC_SEQ = "1";
				} else {
					V_LC_SEQ = jsondata.get("LC_SEQ") == null ? "" : jsondata.get("LC_SEQ").toString();
				}

				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_QTY = jsondata.get("PO_QTY") == null ? "" : jsondata.get("PO_QTY").toString();
				String V_PRICE = jsondata.get("PO_PRC") == null ? "" : jsondata.get("PO_PRC").toString();
				String V_DOC_AMT = jsondata.get("PO_AMT") == null ? "" : jsondata.get("PO_AMT").toString();
				String V_OVER_TOL = jsondata.get("OVER_TOL") == null ? "" : jsondata.get("OVER_TOL").toString();
				String V_UNDER_TOL = jsondata.get("UNDER_TOL") == null ? "" : jsondata.get("UNDER_TOL").toString();
				V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();

				System.out.println("V_TYPE" + V_TYPE);
				System.out.println("V_TYPE2" + V_TYPE2);
				System.out.println("V_LC_NO" + V_LC_NO);
				System.out.println("V_LC_SEQ" + V_LC_SEQ);

				//신규등록일때만 LC번호채번
				if (V_TYPE.equals("SI")) {
					cs = conn.prepareCall("call USP_M_LOCAL_LC_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "NI");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, "");//V_LC_NO
					cs.setString(4, "");//V_LC_DOC_NO
					cs.setString(5, "");//V_LC_AMEND_SEQ
					cs.setString(6, "");//V_BANK_CD
					cs.setString(7, "");//V_PO_NO
					cs.setString(8, "");//V_PO_DT_FR
					cs.setString(9, "");//V_PO_DT_TO
					cs.setString(10, "");//V_M_BP_NM
					cs.setString(11, "");//V_REQ_DT
					cs.setString(12, V_OPEN_DT);//V_OPEN_DT
					cs.setString(13, "");//V_EXPIRY_DT
					cs.setString(14, "");//V_AMEND_DT
					cs.setString(15, "");//V_CUR
					cs.setString(16, "");//V_XCH_RATE
					cs.setString(17, "");//V_DOC_AMT
					cs.setString(18, "");//V_LOC_AMT
					cs.setString(19, "");//V_PAY_METH
					cs.setString(20, "");//V_IN_TERMS
					cs.setString(21, "");//V_M_BP_CD
					cs.setString(22, "");//V_LC_KIND
					cs.setString(23, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(24);

					while (rs.next()) {
						V_LC_NO = rs.getString("LC_NO");
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(V_LC_NO);
					pw.flush();
					pw.close();
				}

				//LC헤더등록
				cs = conn.prepareCall("call USP_M_LOCAL_LC_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_LC_NO);//V_LC_NO
				cs.setString(4, V_LC_DOC_NO);//V_LC_DOC_NO
				cs.setString(5, "");//V_LC_AMEND_SEQ
				cs.setString(6, V_BANK_CD);//V_BANK_CD
				cs.setString(7, "");//V_PO_NO
				cs.setString(8, "");//V_PO_DT_FR
				cs.setString(9, "");//V_PO_DT_TO
				cs.setString(10, "");//V_M_BP_NM
				cs.setString(11, "");//V_REQ_DT
				cs.setString(12, V_OPEN_DT);//V_OPEN_DT
				cs.setString(13, V_EXPIRY_DT);//V_EXPIRY_DT
				cs.setString(14, V_AMEND_DT);//V_AMEND_DT
				cs.setString(15, V_CUR);//V_CUR
				cs.setString(16, V_XCH_RATE);//V_XCH_RATE
				cs.setString(17, "");//V_DOC_AMT
				cs.setString(18, "");//V_LOC_AMT
				cs.setString(19, "");//V_PAY_METH
				cs.setString(20, "");//V_IN_TERMS
				cs.setString(21, "");//V_M_BP_CD
				cs.setString(22, "");//V_LC_KIND
				cs.setString(23, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				//LC DETAIL 등록
				cs = conn.prepareCall("call USP_M_LOCAL_LC_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE2);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_LC_NO);//V_LC_NO
				cs.setString(4, V_LC_SEQ);//V_LC_SEQ
				cs.setString(5, "");//V_HS_CD
				cs.setString(6, V_ITEM_CD);//V_ITEM_CD
				cs.setString(7, V_QTY);//V_QTY
				cs.setString(8, V_PRICE);//V_PRICE
				cs.setString(9, V_DOC_AMT);//V_DOC_AMT
				cs.setString(10, V_OVER_TOL);//V_OVER_TOL
				cs.setString(11, V_UNDER_TOL);//V_UNDER_TOL
				cs.setString(12, V_PO_NO);//V_PO_NO
				cs.setString(13, V_PO_SEQ);//V_PO_SEQ
				cs.setString(14, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
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


