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
<%@page import="org.apache.commons.lang.StringUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs1 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String V_ASN_NO = "";

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_PO_SEQ = request.getParameter("V_PO_SEQ") == null ? "" : request.getParameter("V_PO_SEQ").toUpperCase();

		//ASN팝업[상단HEADER 조회]
		if (V_TYPE.equals("HS")) {
			cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_ASN_NO);
			cs.setString(4, ""); //V_PO_NO
			cs.setString(5, ""); //V_PO_SEQ
			cs.setString(6, ""); //V_LOT_BC_NO
			cs.setString(7, ""); //V_LOT_BC_SEQ
			cs.setString(8, ""); //V_LOT_NO
			cs.setString(9, ""); //V_LOT_QTY
			cs.setString(10, ""); //V_VALID_DT
			cs.setString(11, ""); //V_MAKE_DT
			cs.setString(12, V_USR_ID);
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("ASN_STS", rs.getString("ASN_STS"));
				subObject.put("ASN_STS_NM", rs.getString("ASN_STS_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BAR_NO_PRINT", rs.getString("BAR_NO_PRINT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT") == null ? "" : rs.getString("DLVY_AVL_DT").substring(0, 10));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
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

		//ASN팝업[하단DETAIL 조회]
		else if (V_TYPE.equals("DS")) {
			cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_ASN_NO);
			cs.setString(4, ""); //V_PO_NO
			cs.setString(5, ""); //V_PO_SEQ
			cs.setString(6, ""); //V_LOT_BC_NO
			cs.setString(7, ""); //V_LOT_BC_SEQ
			cs.setString(8, ""); //V_LOT_NO
			cs.setString(9, ""); //V_LOT_QTY
			cs.setString(10, ""); //V_VALID_DT
			cs.setString(11, ""); //V_MAKE_DT
			cs.setString(12, V_USR_ID);
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("ASN_SEQ", rs.getString("ASN_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("PAL_BC_SEQ", rs.getString("PAL_BC_SEQ"));
				subObject.put("PAL_QTY", rs.getString("PAL_QTY"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("BOX_BC_SEQ", rs.getString("BOX_BC_SEQ"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_BC_SEQ", rs.getString("LOT_BC_SEQ"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("VALID_DT", rs.getString("VALID_DT") == null ? "" : rs.getString("VALID_DT").substring(0, 10));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT") == null ? "" : rs.getString("MAKE_DT").substring(0, 10));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				jsonArray.add(subObject);
			}
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//로트저장
		} else if (V_TYPE.equals("LOT")) {

			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					String V_LOT_NO = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
					String V_LOT_BC_NO = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();
					String V_LOT_BC_SEQ = hashMap.get("LOT_BC_SEQ") == null ? "" : hashMap.get("LOT_BC_SEQ").toString();
					String V_MAKE_DT = hashMap.get("MAKE_DT") == null || hashMap.get("MAKE_DT").equals("") ? "" : hashMap.get("MAKE_DT").toString().substring(0, 10);
					String V_VALID_DT = hashMap.get("VALID_DT") == null || hashMap.get("VALID_DT").equals("") ? "" : hashMap.get("VALID_DT").toString().substring(0, 10);
					String V_LOT_QTY = hashMap.get("LOT_QTY") == null ? "" : hashMap.get("LOT_QTY").toString();
					V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();

					cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?)");

					cs.setString(1, "DV");
					cs.setString(2, V_COMP_ID);
					cs.setString(3, V_ASN_NO);
					cs.setString(4, V_PO_NO); //V_PO_NO
					cs.setString(5, V_PO_SEQ); //V_PO_SEQ
					cs.setString(6, V_LOT_BC_NO); //V_LOT_BC_NO
					cs.setString(7, V_LOT_BC_SEQ); //V_LOT_BC_SEQ
					cs.setString(8, V_LOT_NO); //V_LOT_NO
					cs.setString(9, V_LOT_QTY); //V_LOT_QTY
					cs.setString(10, V_VALID_DT); //V_VALID_DT
					cs.setString(11, V_MAKE_DT); //V_MAKE_DT
					cs.setString(12, V_USR_ID);
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					if (i == jsonAr.size() - 1) {
						cs1 = conn.prepareCall("call USP_SCM_DLVY_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?)");

						cs1.setString(1, "DV_LAST");
						cs1.setString(2, V_COMP_ID);
						cs1.setString(3, V_ASN_NO);
						cs1.setString(4, V_PO_NO); //V_PO_NO
						cs1.setString(5, V_PO_SEQ); //V_PO_SEQ
						cs1.setString(6, V_LOT_BC_NO); //V_LOT_BC_NO
						cs1.setString(7, V_LOT_BC_SEQ); //V_LOT_BC_SEQ
						cs1.setString(8, V_LOT_NO); //V_LOT_NO
						cs1.setString(9, V_LOT_QTY); //V_LOT_QTY
						cs1.setString(10, V_VALID_DT); //V_VALID_DT
						cs1.setString(11, V_MAKE_DT); //V_MAKE_DT
						cs1.setString(12, V_USR_ID);
						cs1.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
						cs1.executeQuery();
					}

				}

			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				String V_LOT_NO = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
				String V_LOT_BC_NO = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();
				String V_LOT_BC_SEQ = jsondata.get("LOT_BC_SEQ") == null ? "" : jsondata.get("LOT_BC_SEQ").toString();
				String V_MAKE_DT = jsondata.get("MAKE_DT") == null ? "" : jsondata.get("MAKE_DT").toString().substring(0, 10);
				String V_VALID_DT = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString().substring(0, 10);
				String V_LOT_QTY = jsondata.get("LOT_QTY") == null ? "" : jsondata.get("LOT_QTY").toString();
				V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();

				cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "DV");
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_ASN_NO);
				cs.setString(4, V_PO_NO); //V_PO_NO
				cs.setString(5, V_PO_SEQ); //V_PO_SEQ
				cs.setString(6, V_LOT_BC_NO); //V_LOT_BC_NO
				cs.setString(7, V_LOT_BC_SEQ); //V_LOT_BC_SEQ
				cs.setString(8, V_LOT_NO); //V_LOT_NO
				cs.setString(9, V_LOT_QTY); //V_LOT_QTY
				cs.setString(10, V_VALID_DT); //V_VALID_DT
				cs.setString(11, V_MAKE_DT); //V_MAKE_DT
				cs.setString(12, V_USR_ID);
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				cs1 = conn.prepareCall("call USP_SCM_DLVY_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?)");

				cs1.setString(1, "DV_LAST");
				cs1.setString(2, V_COMP_ID);
				cs1.setString(3, V_ASN_NO);
				cs1.setString(4, V_PO_NO); //V_PO_NO
				cs1.setString(5, V_PO_SEQ); //V_PO_SEQ
				cs1.setString(6, V_LOT_BC_NO); //V_LOT_BC_NO
				cs1.setString(7, V_LOT_BC_SEQ); //V_LOT_BC_SEQ
				cs1.setString(8, V_LOT_NO); //V_LOT_NO
				cs1.setString(9, V_LOT_QTY); //V_LOT_QTY
				cs1.setString(10, V_VALID_DT); //V_VALID_DT
				cs1.setString(11, V_MAKE_DT); //V_MAKE_DT
				cs1.setString(12, V_USR_ID);
				cs1.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs1.executeQuery();

			}

		} else if (V_TYPE.equals("A")) {

			String V_LOT_BC_NO = request.getParameter("V_LOT_BC_NO");
			String V_LOT_NO = request.getParameter("V_LOT_NO");
			String V_MAKE_DT = request.getParameter("V_MAKE_DT");
			String V_VALID_DT = request.getParameter("V_VALID_DT");

			cs = conn.prepareCall("call USP_SCM_BARCD_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_LOT_BC_NO);
			cs.setString(4, V_LOT_NO);
			cs.setString(5, V_MAKE_DT);
			cs.setString(6, V_VALID_DT); //V_VALID_DT
			cs.setString(7, ""); //V_PAL_CHG_BC_NO
			cs.setString(8, ""); //V_BOX_CHG_BC_NO
			cs.setString(9, ""); //V_LOT_CHG_BC_NO
			cs.setString(10, ""); //V_PAL_QTY
			cs.setString(11, ""); //V_BOX_QTY
			cs.setString(12, "");
			cs.setString(13, V_USR_ID);
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("V_PAL_TEXT", rs.getString("V_PAL_TEXT"));
				subObject.put("V_BOX_TEXT", rs.getString("V_BOX_TEXT"));
				subObject.put("V_LOT_BC_NO", rs.getString("V_LOT_BC_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC2")) {

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

					String V_PAL_CHG_BC_NO = hashMap.get("PAL_BC_NO") == null ? "" : hashMap.get("PAL_BC_NO").toString();
					String V_BOX_CHG_BC_NO = hashMap.get("BOX_BC_NO") == null ? "" : hashMap.get("BOX_BC_NO").toString();
					String V_LOT_CHG_BC_NO = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();
					String V_LOT_BC_NO = request.getParameter("V_LOT_BC_NO");
					String V_LOT_NO = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
					String V_MAKE_DT = hashMap.get("MAKE_DT") == null ? "" : hashMap.get("MAKE_DT").toString().substring(0, 10);
					String V_VALID_DT = hashMap.get("VALID_DT") == null ? "" : hashMap.get("VALID_DT").toString().substring(0, 10);
					String V_LOT_QTY = hashMap.get("LOT_QTY") == null ? "" : hashMap.get("LOT_QTY").toString();
					String V_BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();

					V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();

					cs = conn.prepareCall("call USP_SCM_BARCD_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_COMP_ID);
					cs.setString(3, V_LOT_BC_NO);
					cs.setString(4, V_LOT_NO);
					cs.setString(5, V_MAKE_DT);
					cs.setString(6, V_VALID_DT); //V_VALID_DT
					cs.setString(7, V_PAL_CHG_BC_NO); //V_PAL_CHG_BC_NO
					cs.setString(8, V_BOX_CHG_BC_NO); //V_BOX_CHG_BC_NO
					cs.setString(9, V_LOT_CHG_BC_NO); //V_LOT_CHG_BC_NO
					cs.setString(10, ""); //V_PAL_QTY
					cs.setString(11, V_BOX_QTY); //V_BOX_QTY
					cs.setString(12, V_LOT_QTY); //V_LOT_QTY
					cs.setString(13, V_USR_ID);
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();

				String V_PAL_CHG_BC_NO = jsondata.get("PAL_BC_NO") == null ? "" : jsondata.get("PAL_BC_NO").toString();
				String V_BOX_CHG_BC_NO = jsondata.get("BOX_BC_NO") == null ? "" : jsondata.get("BOX_BC_NO").toString();
				String V_LOT_CHG_BC_NO = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();
				String V_LOT_BC_NO = request.getParameter("V_LOT_BC_NO");
				String V_LOT_NO = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
				String V_MAKE_DT = jsondata.get("MAKE_DT") == null ? "" : jsondata.get("MAKE_DT").toString().substring(0, 10);
				String V_VALID_DT = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString().substring(0, 10);
				String V_BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
				String V_LOT_QTY = jsondata.get("LOT_QTY") == null ? "" : jsondata.get("LOT_QTY").toString();

				V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();

				cs = conn.prepareCall("call USP_SCM_BARCD_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_LOT_BC_NO);
				cs.setString(4, V_LOT_NO);
				cs.setString(5, V_MAKE_DT);
				cs.setString(6, V_VALID_DT); //V_VALID_DT
				cs.setString(7, V_PAL_CHG_BC_NO); //V_PAL_CHG_BC_NO
				cs.setString(8, V_BOX_CHG_BC_NO); //V_BOX_CHG_BC_NO
				cs.setString(9, V_LOT_CHG_BC_NO); //V_LOT_CHG_BC_NO
				cs.setString(10, ""); //V_PAL_QTY
				cs.setString(11, V_BOX_QTY); //V_BOX_QTY
				cs.setString(12, V_LOT_QTY); //V_LOT_QTY
				cs.setString(13, V_USR_ID);
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}

		} // 	ASN등록팝업[바코드관리 - CB(생성) MD(삭제) MP(발행) BC(확정) BD(취소)]
		else if (V_TYPE.equals("GRDN")) {
			String V_DD_NO = request.getParameter("V_DD_NO") == null ? "" : request.getParameter("V_DD_NO").toUpperCase();
			String V_GR_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").toUpperCase().substring(0, 10);
			String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);

			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					String V_LOT_NO = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
					String V_LOT_BC_NO = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();
					String V_LOT_BC_SEQ = hashMap.get("LOT_BC_SEQ") == null ? "" : hashMap.get("LOT_BC_SEQ").toString();
					String V_MAKE_DT = hashMap.get("MAKE_DT") == null || hashMap.get("MAKE_DT").equals("") ? "" : hashMap.get("MAKE_DT").toString().substring(0, 10);
					String V_VALID_DT = hashMap.get("VALID_DT") == null || hashMap.get("VALID_DT").equals("") ? "" : hashMap.get("VALID_DT").toString().substring(0, 10);
					String V_LOT_QTY = hashMap.get("LOT_QTY") == null ? "" : hashMap.get("LOT_QTY").toString();
					V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();

					String V_GR_QTY = hashMap.get("GR_QTY") == null ? "" : hashMap.get("GR_QTY").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();
					String V_GR_NO = "";

					//입고번호채번
					cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D_GR_DN(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "HI");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_GR_DT);//V_GR_DT
					cs.setString(4, V_DN_DT);//V_DN_DT
					cs.setString(5, V_LOT_BC_NO);//V_LOT_BC_NO
					cs.setString(6, "");//V_M_BP_NM
					cs.setString(7, "");//V_PO_TYPE
					cs.setString(8, "");//V_PO_NO
					cs.setString(9, "");//V_PO_SEQ
					cs.setString(10, "");//V_BAR_YN
					cs.setString(11, "");//V_GR_NO
					cs.setString(12, "");//V_GR_DT
					cs.setString(13, "");//V_IN_QTY
					cs.setString(14, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(15);
					while (rs.next()) {
						V_GR_NO = rs.getString("GR_NO");
					}

					cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D_GR_DN(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "LI");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_GR_DT);//V_GR_DT
					cs.setString(4, V_DN_DT);//V_DN_DT
					cs.setString(5, V_LOT_BC_NO);//V_LOT_BC_NO
					cs.setString(6, "");//V_M_BP_NM
					cs.setString(7, "");//V_PO_TYPE
					cs.setString(8, V_PO_NO);//V_PO_NO
					cs.setString(9, V_PO_SEQ);//V_PO_SEQ
					cs.setString(10, V_DD_NO);//V_DD_NO
					cs.setString(11, V_GR_NO);//V_GR_NO
					cs.setString(12, V_GR_QTY);//V_GR_QTY
					cs.setString(13, V_DN_QTY);//V_DN_QTY
					cs.setString(14, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}

			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				String V_LOT_NO = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
				String V_LOT_BC_NO = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();
				String V_LOT_BC_SEQ = jsondata.get("LOT_BC_SEQ") == null ? "" : jsondata.get("LOT_BC_SEQ").toString();
				String V_MAKE_DT = jsondata.get("MAKE_DT") == null || jsondata.get("MAKE_DT").equals("") ? "" : jsondata.get("MAKE_DT").toString().substring(0, 10);
				String V_VALID_DT = jsondata.get("VALID_DT") == null || jsondata.get("VALID_DT").equals("") ? "" : jsondata.get("VALID_DT").toString().substring(0, 10);
				String V_LOT_QTY = jsondata.get("LOT_QTY") == null ? "" : jsondata.get("LOT_QTY").toString();
				V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();

				String V_GR_NO = "";
				String V_GR_QTY = jsondata.get("GR_QTY") == null ? "" : jsondata.get("GR_QTY").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();

				cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D_GR_DN(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "HI");//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_GR_DT);//V_GR_DT
				cs.setString(4, V_DN_DT);//V_DN_DT
				cs.setString(5, V_LOT_BC_NO);//V_LOT_BC_NO
				cs.setString(6, "");//V_M_BP_NM
				cs.setString(7, "");//V_PO_TYPE
				cs.setString(8, "");//V_PO_NO
				cs.setString(9, "");//V_PO_SEQ
				cs.setString(10, "");//V_BAR_YN
				cs.setString(11, "");//V_GR_NO
				cs.setString(12, "");//V_GR_DT
				cs.setString(13, "");//V_IN_QTY
				cs.setString(14, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(15);
				while (rs.next()) {
					V_GR_NO = rs.getString("GR_NO");
				}

				// 				System.out.println(V_GR_NO);

				cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D_GR_DN(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "LI");//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_GR_DT);//V_GR_DT
				cs.setString(4, V_DN_DT);//V_DN_DT
				cs.setString(5, V_LOT_BC_NO);//V_LOT_BC_NO
				cs.setString(6, "");//V_M_BP_NM
				cs.setString(7, "");//V_PO_TYPE
				cs.setString(8, V_PO_NO);//V_PO_NO
				cs.setString(9, V_PO_SEQ);//V_PO_SEQ
				cs.setString(10, V_DD_NO);//V_DD_NO
				cs.setString(11, V_GR_NO);//V_GR_NO
				cs.setString(12, V_GR_QTY);//V_IN_DT
				cs.setString(13, V_DN_QTY);//V_IN_QTY
				cs.setString(14, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
		} else {

			cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_ASN_NO);
			cs.setString(4, V_PO_NO);
			cs.setString(5, V_PO_SEQ);
			cs.setString(6, ""); //V_LOT_BC_NO
			cs.setString(7, ""); //V_LOT_BC_SEQ
			cs.setString(8, ""); //V_LOT_NO
			cs.setString(9, ""); //V_LOT_QTY
			cs.setString(10, ""); //V_VALID_DT
			cs.setString(11, ""); //V_MAKE_DT
			cs.setString(12, V_USR_ID);
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			if (V_TYPE.equals("BC")) {
				String retVal = "";
				rs = (ResultSet) cs.getObject(13);
				while (rs.next()) {
					retVal = rs.getString("CHECKS");
				}

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(retVal);
				pw.flush();
				pw.close();
			}
		}

	} catch (Exception e) {
		
		System.out.println("---------------------------------------------------");
		e.printStackTrace();
		System.out.println(V_ASN_NO);
		System.out.println("---------------------------------------------------");
	} finally {
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (cs1 != null) try {
			cs1.close();
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


