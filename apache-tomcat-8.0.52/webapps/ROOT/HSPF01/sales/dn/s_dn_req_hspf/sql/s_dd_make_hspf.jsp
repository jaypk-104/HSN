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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_DR_NO = request.getParameter("V_DR_NO") == null ? "" : request.getParameter("V_DR_NO");
		String V_CUST_ORDER_NO = request.getParameter("V_CUST_ORDER_NO") == null ? "" : request.getParameter("V_CUST_ORDER_NO");
		String V_DR_DT_FROM = request.getParameter("V_DR_DT_FROM") == null ? "" : request.getParameter("V_DR_DT_FROM").substring(0, 10);
		String V_DR_DT_TO = request.getParameter("V_DR_DT_TO") == null ? "" : request.getParameter("V_DR_DT_TO").substring(0, 10);
		String V_S_BP_CD = request.getParameter("V_BP_CD_RIGHT") == null ? "" : request.getParameter("V_BP_CD_RIGHT");
		String V_S_BP_NM = request.getParameter("V_BP_NM_RIGHT") == null ? "" : request.getParameter("V_BP_NM_RIGHT");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");
		if (V_SL_CD.equals("T")) {
			V_SL_CD = "";
		}
		String V_DD_NO = request.getParameter("V_DD_NO") == null ? "" : request.getParameter("V_DD_NO");

		String V_TITLE = request.getParameter("V_TITLE") == null ? "" : request.getParameter("V_TITLE");
		String V_DD_DT = request.getParameter("V_DD_DT") == null ? "" : request.getParameter("V_DD_DT").substring(0,10);
		String V_S_REQ_NO = request.getParameter("V_S_REQ_NO") == null ? "" : request.getParameter("V_S_REQ_NO");
		String V_TO_NM = request.getParameter("V_TO_NM") == null ? "" : request.getParameter("V_TO_NM");
		String V_TO_USR_NM = request.getParameter("V_TO_USR_NM") == null ? "" : request.getParameter("V_TO_USR_NM");
		String V_FROM_NM = request.getParameter("V_FROM_NM") == null ? "" : request.getParameter("V_FROM_NM");
		String V_FROM_USR_NM = request.getParameter("V_FROM_USR_NM") == null ? "" : request.getParameter("V_FROM_USR_NM");
		String V_FROM_USR_TEL = request.getParameter("V_FROM_USR_TEL") == null ? "" : request.getParameter("V_FROM_USR_TEL");
		String V_DLV_IND_NM = request.getParameter("V_DLV_IND_NM") == null ? "" : request.getParameter("V_DLV_IND_NM");
		String V_ARRV_COMP_NM = request.getParameter("V_ARRV_COMP_NM") == null ? "" : request.getParameter("V_ARRV_COMP_NM");
		String V_ARRV_COMP_ADDR = request.getParameter("V_ARRV_COMP_ADDR") == null ? "" : request.getParameter("V_ARRV_COMP_ADDR");
		String V_REQ_TEXT = request.getParameter("V_REQ_TEXT") == null ? "" : request.getParameter("V_REQ_TEXT");
		String V_TO_USR_TEL = request.getParameter("V_TO_USR_TEL") == null ? "" : request.getParameter("V_TO_USR_TEL");
		String V_VEH_INFO_REQUESTOR = request.getParameter("V_VEH_INFO_REQUESTOR") == null ? "" : request.getParameter("V_VEH_INFO_REQUESTOR");
		String V_VEH_INFO_REQUESTOR_TEL = request.getParameter("V_VEH_INFO_REQUESTOR_TEL") == null ? "" : request.getParameter("V_VEH_INFO_REQUESTOR_TEL");

		String V_SO_NO = request.getParameter("V_SO_NO") == null ? "" : request.getParameter("V_SO_NO");

		//오른쪽출고현황조회
		if (V_TYPE.equals("RS") || V_TYPE.equals("RS_N")) {
			cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DR_DT_FROM);//V_DR_DT_FROM
			cs.setString(4, V_DR_DT_TO);//V_DR_DT_TO
			cs.setString(5, V_S_BP_CD);//V_S_BP_CD -- V_BP_CD_RIGHT
			cs.setString(6, V_S_BP_NM);//V_S_BP_NM -- V_BP_NM_RIGHT
			cs.setString(7, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
			cs.setString(8, V_DR_NO);//V_DR_NO
			cs.setString(9, "");//V_DR_SEQ
			cs.setString(10, "");//V_DD_DT
			cs.setString(11, V_DD_NO);//V_DD_NO
			cs.setString(12, V_ITEM_CD);//V_ITEM_CD
			cs.setString(13, "");//V_DR_QTY
			cs.setString(14, V_SL_CD);//V_TO_SL_CD
			cs.setString(15, V_SO_NO);//V_REMARK --수주번호조회로 사용
			cs.setString(16, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(18, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(17);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DR_NO", rs.getString("DR_NO"));
				subObject.put("DR_SEQ", rs.getString("DR_SEQ"));
				subObject.put("DR_DT", rs.getString("DR_DT").substring(0, 10));
				subObject.put("S_BP_CD", rs.getString("BP_CD"));
				subObject.put("S_BP_NM", rs.getString("BP_NM"));
				subObject.put("CUST_ORDER_NO", rs.getString("CUST_ORDER_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("DR_QTY", rs.getString("DR_QTY"));
				subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("DR_REQ_YN", rs.getString("DR_REQ_YN"));
				subObject.put("SO_NO", rs.getString("SO_NO"));
				subObject.put("DD_NO", rs.getString("DD_NO"));
				subObject.put("DD_SEQ", rs.getString("DD_SEQ"));
				subObject.put("PRINT_COUNT", rs.getString("PRINT_COUNT"));
				subObject.put("DD_TOT_QTY", rs.getString("DD_TOT_QTY"));
				subObject.put("IN_QTY", rs.getString("IN_QTY"));
				subObject.put("MAT_STOCK_QTY", rs.getString("MAT_STOCK_QTY"));
				subObject.put("KIFT_STOCK_QTY", rs.getString("KIFT_STOCK_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("SAMPLE_YN", rs.getString("SAMPLE_YN"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//출고지시서 재출력시 생성정보 불러오기
		} else if (V_TYPE.equals("S") || V_TYPE.equals("U")) {
			V_DD_NO = request.getParameter("V_DD_NO");
			String V_DD_SEQ = request.getParameter("V_DD_SEQ");

			cs = conn.prepareCall("call USP_S_DN_DIREC_HDR_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DD_NO);//V_DD_NO
			cs.setString(4, V_DD_DT);//V_DD_DT
			cs.setString(5, V_S_REQ_NO);//V_S_REQ_NO
			cs.setString(6, V_TO_NM);//V_TO_NM
			cs.setString(7, V_TO_USR_NM);//V_TO_USR_NM
			cs.setString(8, V_FROM_NM);//V_FROM_NM
			cs.setString(9, V_FROM_USR_NM);//V_FROM_USR_NM
			cs.setString(10, V_FROM_USR_TEL);//V_FROM_USR_TEL
			cs.setString(11, V_ARRV_COMP_NM);//V_ARRV_COMP_NM
			cs.setString(12, V_ARRV_COMP_ADDR);//V_ARRV_COMP_ADDR
			cs.setString(13, V_DLV_IND_NM);//V_DLV_IND_NM
			cs.setString(14, V_REQ_TEXT);//V_REQ_TEXT
			cs.setString(15, V_USR_ID);//V_USR_ID
			cs.setString(16, V_TO_USR_TEL);//V_TO_USR_TEL
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(18, V_VEH_INFO_REQUESTOR);//
			cs.setString(19, V_VEH_INFO_REQUESTOR_TEL);//
			cs.executeQuery();

			if (V_TYPE.equals("S")) {
				rs = (ResultSet) cs.getObject(17);
				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("DD_NO", rs.getString("DD_NO"));
					subObject.put("DD_DT", rs.getString("DD_DT").substring(0, 10));
					subObject.put("S_REQ_NO", rs.getString("S_REQ_NO"));
					subObject.put("TO_NM", rs.getString("TO_NM"));
					subObject.put("TO_USR_NM", rs.getString("TO_USR_NM"));
					subObject.put("FROM_NM", rs.getString("FROM_NM"));
					subObject.put("FROM_USR_NM", rs.getString("FROM_USR_NM"));
					subObject.put("FROM_USR_TEL", rs.getString("FROM_USR_TEL"));
					subObject.put("ARRV_COMP_NM", rs.getString("ARRV_COMP_NM"));
					subObject.put("ARRV_COMP_ADDR", rs.getString("ARRV_COMP_ADDR"));
					subObject.put("DLV_IND_NM", rs.getString("DLV_IND_NM"));
					subObject.put("REQ_TEXT", rs.getString("REQ_TEXT"));
					subObject.put("TO_USR_TEL", rs.getString("TO_USR_TEL"));
					subObject.put("VEH_INFO_REQUESTOR", rs.getString("VEH_INFO_REQUESTOR"));
					subObject.put("VEH_INFO_REQUESTOR_TEL", rs.getString("VEH_INFO_REQUESTOR_TEL"));
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

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");

			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_DR_NO = hashMap.get("DR_NO") == null ? "" : hashMap.get("DR_NO").toString();
					String V_DR_SEQ = hashMap.get("DR_SEQ") == null ? "" : hashMap.get("DR_SEQ").toString();
					String V_DR_QTY = hashMap.get("DR_QTY") == null ? "" : hashMap.get("DR_QTY").toString();
					V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_TO_SL_CD = hashMap.get("SL_NM") == null ? "" : hashMap.get("SL_NM").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();

					String V_GR_DT = hashMap.get("GR_DT") == null ? "" : hashMap.get("GR_DT").toString().substring(0, 10);
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String SAMPLE_YN = hashMap.get("SAMPLE_YN") == null ? "" : hashMap.get("SAMPLE_YN").toString();

					//출고지시번호채번
					if (V_TYPE.equals("DI")) {
						if (i == 0) {
							cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, "AI");//V_TYPE
							cs.setString(2, V_COMP_ID);//V_COMP_ID
							cs.setString(3, "");//V_DR_DT_FROM
							cs.setString(4, "");//V_DR_DT_TO
							cs.setString(5, "");//V_S_BP_CD
							cs.setString(6, "");//V_S_BP_NM
							cs.setString(7, "");//V_CUST_ORDER_NO
							cs.setString(8, "");//V_DR_NO
							cs.setString(9, "");//V_DR_SEQ
							cs.setString(10, "");//V_DD_DT
							cs.setString(11, "");//V_DD_NO
							cs.setString(12, "");//V_ITEM_CD
							cs.setString(13, "");//V_DR_QTY
							cs.setString(14, "");//V_TO_SL_CD
							cs.setString(15, V_REMARK);//V_REMARK
							cs.setString(16, V_USR_ID);//V_USR_ID
							cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
							cs.setString(18, "");//
							cs.executeQuery();

							rs = (ResultSet) cs.getObject(17);
							while (rs.next()) {
								V_DD_NO = rs.getString("DD_NO");
							}

							cs = conn.prepareCall("call USP_S_DN_DIREC_HDR_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, "I");//V_TYPE
							cs.setString(2, V_COMP_ID);//V_COMP_ID
							cs.setString(3, V_DD_NO);//V_DD_NO
							cs.setString(4, V_DD_DT);//V_DD_DT
							cs.setString(5, V_S_REQ_NO);//V_S_REQ_NO
							cs.setString(6, V_TO_NM);//V_TO_NM
							cs.setString(7, V_TO_USR_NM);//V_TO_USR_NM
							cs.setString(8, V_FROM_NM);//V_FROM_NM
							cs.setString(9, V_FROM_USR_NM);//V_FROM_USR_NM
							cs.setString(10, V_FROM_USR_TEL);//V_FROM_USR_NM
							cs.setString(11, V_ARRV_COMP_NM);//V_ARRV_COMP_NM
							cs.setString(12, V_ARRV_COMP_ADDR);//V_ARRV_COMP_ADDR
							cs.setString(13, V_DLV_IND_NM);//V_DD_NO
							cs.setString(14, V_REQ_TEXT);//V_REQ_TEXT
							cs.setString(15, V_USR_ID);//V_USR_ID
							cs.setString(16, V_TO_USR_TEL);//V_TO_USR_TEL
							cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
							cs.setString(18, V_VEH_INFO_REQUESTOR);//
							cs.setString(19, V_VEH_INFO_REQUESTOR_TEL);//
							cs.executeQuery();

							response.setContentType("text/plain; charset=UTF-8");
							PrintWriter pw = response.getWriter();
							pw.print(V_DD_NO);
							pw.flush();
							pw.close();
						}

					}

					if (V_TYPE.equals("RD") || V_TYPE.equals("DD") || V_TYPE.equals("DD_Y")) {
						//재출력일 때만 DD_NO를 들고온다.
						V_DD_NO = hashMap.get("DD_NO") == null ? "" : hashMap.get("DD_NO").toString();
					}

					if (V_TYPE.equals("PR")) { //발주요청일 때만 해당 쿼리탄다..
						cs = conn.prepareCall("call USP_S_DR_TO_PO(?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_DR_NO);//V_DR_NO
						cs.setString(4, V_DR_SEQ);//V_DR_SEQ
						cs.setString(5, V_USR_ID);//V_S_BP_CD
						cs.executeQuery();
					} else {
						cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_GR_DT);//V_DR_DT_FROM
						cs.setString(4, V_DR_DT_TO);//V_DR_DT_FROM -임시사용(입고일)
						cs.setString(5, V_S_BP_CD);//V_S_BP_CD
						cs.setString(6, V_BL_NO);//V_S_BP_NM - 임시사용(BL_NO)
						cs.setString(7, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
						cs.setString(8, V_DR_NO);//V_DR_NO
						cs.setString(9, V_DR_SEQ);//V_DR_SEQ
						cs.setString(10, V_DD_DT);//V_DD_DT
						cs.setString(11, V_DD_NO);//V_DD_NO
						cs.setString(12, V_ITEM_CD);//V_ITEM_CD
						cs.setString(13, V_DR_QTY);//V_DR_QTY
						cs.setString(14, V_TO_SL_CD);//V_TO_SL_CD
						cs.setString(15, V_REMARK);//V_REMARK
						cs.setString(16, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(18, SAMPLE_YN);//SAMPLE_YN
						cs.executeQuery();

						if (i == jsonAr.size() - 1) {
							response.setContentType("text/plain; charset=UTF-8");
							PrintWriter pw = response.getWriter();
							pw.print(V_DD_NO);
							pw.flush();
							pw.close();
						}

					}
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_DR_NO = jsondata.get("DR_NO") == null ? "" : jsondata.get("DR_NO").toString();
				String V_DR_SEQ = jsondata.get("DR_SEQ") == null ? "" : jsondata.get("DR_SEQ").toString();
				String V_DR_QTY = jsondata.get("DR_QTY") == null ? "" : jsondata.get("DR_QTY").toString();
				V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_TO_SL_CD = jsondata.get("SL_NM") == null ? "" : jsondata.get("SL_NM").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				V_DD_NO = jsondata.get("DD_NO") == null ? "" : jsondata.get("DD_NO").toString();
				String V_DD_SEQ = jsondata.get("DD_SEQ") == null ? "" : jsondata.get("DD_SEQ").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();

				String V_GR_DT = jsondata.get("GR_DT") == null ? "" : jsondata.get("GR_DT").toString().substring(0, 10);
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String SAMPLE_YN = jsondata.get("SAMPLE_YN") == null ? "" : jsondata.get("SAMPLE_YN").toString();

				//출고지시번호채번
				if (V_TYPE.equals("DI")) {
					cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "AI");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, "");//V_DR_DT_FROM
					cs.setString(4, "");//V_DR_DT_TO
					cs.setString(5, "");//V_S_BP_CD
					cs.setString(6, "");//V_S_BP_NM
					cs.setString(7, "");//V_CUST_ORDER_NO
					cs.setString(8, "");//V_DR_NO
					cs.setString(9, "");//V_DR_SEQ
					cs.setString(10, "");//V_DD_DT
					cs.setString(11, "");//V_DD_NO
					cs.setString(12, "");//V_ITEM_CD
					cs.setString(13, "");//V_DR_QTY
					cs.setString(14, "");//V_TO_SL_CD
					cs.setString(15, V_REMARK);//V_REMARK
					cs.setString(16, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(18, "");//
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(17);
					while (rs.next()) {
						V_DD_NO = rs.getString("DD_NO");
					}

					cs = conn.prepareCall("call USP_S_DN_DIREC_HDR_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "I");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_DD_NO);//V_DD_NO
					cs.setString(4, V_DD_DT);//V_DD_DT
					cs.setString(5, V_S_REQ_NO);//V_S_REQ_NO
					cs.setString(6, V_TO_NM);//V_TO_NM
					cs.setString(7, V_TO_USR_NM);//V_TO_USR_NM
					cs.setString(8, V_FROM_NM);//V_FROM_NM
					cs.setString(9, V_FROM_USR_NM);//V_FROM_USR_NM
					cs.setString(10, V_FROM_USR_TEL);//V_FROM_USR_TEL
					cs.setString(11, V_ARRV_COMP_NM);//V_ARRV_COMP_NM
					cs.setString(12, V_ARRV_COMP_ADDR);//V_ARRV_COMP_ADDR
					cs.setString(13, V_DLV_IND_NM);//V_DD_NO
					cs.setString(14, V_REQ_TEXT);//V_REQ_TEXT
					cs.setString(15, V_USR_ID);//V_USR_ID
					cs.setString(16, V_TO_USR_TEL);//V_TO_USR_TEL
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(18, V_VEH_INFO_REQUESTOR);//
					cs.setString(19, V_VEH_INFO_REQUESTOR_TEL);//
					cs.executeQuery();

				}

				if (V_TYPE.equals("RD") || V_TYPE.equals("DD") || V_TYPE.equals("DD_Y")) {
					V_DD_NO = jsondata.get("DD_NO") == null ? "" : jsondata.get("DD_NO").toString();
				}

				if (V_TYPE.equals("PR")) { //발주요청일 때만 해당 쿼리탄다..
					cs = conn.prepareCall("call USP_S_DR_TO_PO(?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_DR_NO);//V_DR_NO
					cs.setString(4, V_DR_SEQ);//V_DR_SEQ
					cs.setString(5, V_USR_ID);//V_S_BP_CD
					cs.executeQuery();
				} else {
					cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_GR_DT);//V_DR_DT_FROM
					cs.setString(4, V_DR_DT_TO);//V_DR_DT_FROM -임시사용(입고일)
					cs.setString(5, V_S_BP_CD);//V_S_BP_CD
					cs.setString(6, V_BL_NO);//V_S_BP_NM - 임시사용(BL_NO)
					cs.setString(7, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
					cs.setString(8, V_DR_NO);//V_DR_NO
					cs.setString(9, V_DR_SEQ);//V_DR_SEQ
					cs.setString(10, V_DD_DT);//V_DD_DT
					cs.setString(11, V_DD_NO);//V_DD_NO
					cs.setString(12, V_ITEM_CD);//V_ITEM_CD
					cs.setString(13, V_DR_QTY);//V_DR_QTY
					cs.setString(14, V_TO_SL_CD);//V_TO_SL_CD
					cs.setString(15, V_REMARK);//V_REMARK
					cs.setString(16, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(18, SAMPLE_YN);//SAMPLE_YN
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(V_DD_NO);
					pw.flush();
					pw.close();
				}
			}

			//출고지시정보 수동추가
		} else if (V_TYPE.equals("SYNC2")) {
			request.setCharacterEncoding("utf-8");

			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_DR_QTY = hashMap.get("DR_QTY") == null ? "" : hashMap.get("DR_QTY").toString();
					V_CUST_ORDER_NO = hashMap.get("CUST_ORDER_NO") == null ? "" : hashMap.get("CUST_ORDER_NO").toString();
					V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_TO_SL_CD = hashMap.get("SL_NM") == null ? "" : hashMap.get("SL_NM").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_DR_DT = hashMap.get("DR_DT") == null ? "" : hashMap.get("DR_DT").toString().substring(0, 10);;
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();

					String V_GR_DT = hashMap.get("GR_DT") == null ? "" : hashMap.get("GR_DT").toString().substring(0, 10);;
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String SAMPLE_YN = hashMap.get("SAMPLE_YN") == null ? "" : hashMap.get("SAMPLE_YN").toString();

					if (i == 0) {
						cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, "DA_INIT");//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, "");//V_DR_DT_FROM
						cs.setString(4, "");//V_DR_DT_TO
						cs.setString(5, "");//V_S_BP_CD
						cs.setString(6, "");//V_S_BP_NM
						cs.setString(7, "");//V_CUST_ORDER_NO
						cs.setString(8, "");//V_DR_NO
						cs.setString(9, "");//V_DR_SEQ
						cs.setString(10, V_DR_DT);//V_DD_DT - 임시사용
						cs.setString(11, "");//V_DD_NO
						cs.setString(12, "");//V_ITEM_CD
						cs.setString(13, "");//V_DR_QTY
						cs.setString(14, "");//V_TO_SL_CD
						cs.setString(15, V_REMARK);//V_REMARK
						cs.setString(16, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(18, "");//
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(17);
						while (rs.next()) {
							V_DR_NO = rs.getString("DR_NO");
						}
					}

					// 					System.out.println(V_DR_NO);

					cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_GR_DT);//V_DR_DT_FROM -임시사용(입고일)
					cs.setString(4, "");//V_DR_DT_TO
					cs.setString(5, V_S_BP_CD);//V_S_BP_CD
					cs.setString(6, V_BL_NO);//V_S_BP_NM - 임시사용(BL_NO)
					cs.setString(7, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
					cs.setString(8, V_DR_NO);//V_DR_NO
					cs.setString(9, "");//V_DR_SEQ
					cs.setString(10, V_DR_DT);//V_DD_DT - 임시사용
					cs.setString(11, "");//V_DD_NO
					cs.setString(12, V_ITEM_CD);//V_ITEM_CD
					cs.setString(13, V_DR_QTY);//V_DR_QTY
					cs.setString(14, V_TO_SL_CD);//V_TO_SL_CD
					cs.setString(15, V_REMARK);//V_REMARK
					cs.setString(16, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(18, SAMPLE_YN);//SAMPLE_YN
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_DR_QTY = jsondata.get("DR_QTY") == null ? "" : jsondata.get("DR_QTY").toString();
				V_CUST_ORDER_NO = jsondata.get("CUST_ORDER_NO") == null ? "" : jsondata.get("CUST_ORDER_NO").toString();
				V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_TO_SL_CD = jsondata.get("SL_NM") == null ? "" : jsondata.get("SL_NM").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_DR_DT = jsondata.get("DR_DT") == null ? "" : jsondata.get("DR_DT").toString().substring(0, 10);
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();

				String V_GR_DT = jsondata.get("GR_DT") == null ? "" : jsondata.get("GR_DT").toString().substring(0, 10);
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String SAMPLE_YN = jsondata.get("SAMPLE_YN") == null ? "" : jsondata.get("SAMPLE_YN").toString();
				
				
				cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "DA_INIT");//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, "");//V_DR_DT_FROM
				cs.setString(4, "");//V_DR_DT_TO
				cs.setString(5, "");//V_S_BP_CD
				cs.setString(6, "");//V_S_BP_NM
				cs.setString(7, "");//V_CUST_ORDER_NO
				cs.setString(8, "");//V_DR_NO
				cs.setString(9, "");//V_DR_SEQ
				cs.setString(10, V_DR_DT);//V_DD_DT - 임시사용
				cs.setString(11, "");//V_DD_NO
				cs.setString(12, "");//V_ITEM_CD
				cs.setString(13, "");//V_DR_QTY
				cs.setString(14, "");//V_TO_SL_CD
				cs.setString(15, V_REMARK);//V_REMARK
				cs.setString(16, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(18, "");//
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(17);
				while (rs.next()) {
					V_DR_NO = rs.getString("DR_NO");
				}

				cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_GR_DT);//V_DR_DT_FROM -임시사용(입고일)
				cs.setString(4, "");//V_DR_DT_TO
				cs.setString(5, V_S_BP_CD);//V_S_BP_CD
				cs.setString(6, V_BL_NO);//V_S_BP_NM - 임시사용(BL_NO)
				cs.setString(7, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
				cs.setString(8, V_DR_NO);//V_DR_NO
				cs.setString(9, "");//V_DR_SEQ
				cs.setString(10, V_DR_DT);//V_DD_DT - 임시사용
				cs.setString(11, "");//V_DD_NO
				cs.setString(12, V_ITEM_CD);//V_ITEM_CD
				cs.setString(13, V_DR_QTY);//V_DR_QTY
				cs.setString(14, V_TO_SL_CD);//V_TO_SL_CD
				cs.setString(15, V_REMARK);//V_REMARK
				cs.setString(16, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(18, SAMPLE_YN);//SAMPLE_YN
				cs.executeQuery();
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(V_DR_NO);
			pw.flush();
			pw.close();
		} else if (V_TYPE.equals("GR")) {
			cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DR_DT_FROM);//V_DR_DT_FROM
			cs.setString(4, V_DR_DT_TO);//V_DR_DT_TO
			cs.setString(5, V_S_BP_CD);//V_S_BP_CD -- V_BP_CD_RIGHT
			cs.setString(6, V_S_BP_NM);//V_S_BP_NM -- V_BP_NM_RIGHT
			cs.setString(7, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
			cs.setString(8, V_DR_NO);//V_DR_NO
			cs.setString(9, "");//V_DR_SEQ
			cs.setString(10, "");//V_DD_DT
			cs.setString(11, V_DD_NO);//V_DD_NO
			cs.setString(12, V_ITEM_CD);//V_ITEM_CD
			cs.setString(13, "");//V_DR_QTY
			cs.setString(14, V_SL_CD);//V_TO_SL_CD
			cs.setString(15, "");//V_REMARK
			cs.setString(16, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(18, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(17);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
				subObject.put("GR_TYPE_NM", rs.getString("GR_TYPE_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("RM_QTY", rs.getString("RM_QTY"));
				subObject.put("GR_PRC", rs.getString("GR_PRC"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("GR_AMT", rs.getString("GR_AMT"));
				subObject.put("GR_LOC_AMT", rs.getString("GR_LOC_AMT"));
				subObject.put("DISTB_AMT", rs.getString("DISTB_AMT"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("EXPECT_QTY", rs.getString("EXPECT_QTY"));
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



