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
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String V_PO_NO = "";
	String V_PO_SEQ = "";

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_MAST_PO_NO = request.getParameter("V_MAST_PO_NO") == null ? "" : request.getParameter("V_MAST_PO_NO").toUpperCase();
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_PO_USR_NM = request.getParameter("V_PO_USR_NM") == null ? "" : request.getParameter("V_PO_USR_NM").toUpperCase();

		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0, 10);

// 		System.out.println("V_MAST_PO_NO: " + V_MAST_PO_NO);

		if (V_TYPE.equals("SH") || V_TYPE.equals("SD") || V_TYPE.equals("CF")) {

			cs = conn.prepareCall("call USP_003_M_OFFER_CFM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//
			cs.setString(3, V_MAST_PO_NO);//V_MAST_PO_NO
			cs.setString(4, V_M_BP_CD);//V_BP_CD
			cs.setString(5, V_PO_DT_FR);//V_PUR_DT_FR
			cs.setString(6, V_PO_DT_TO);//V_PUR_DT_TO
			cs.setString(7, V_PO_NO);//V_PO_NO
			cs.setString(8, V_PO_SEQ);//V_PO_SEQ
			cs.setString(9, "");//V_CFM_YN
			cs.setString(10, "");//V_CHG_PO_QTY
			cs.setString(11, "");//V_CHG_PO_PRC
			cs.setString(12, "");//V_CHG_PO_AMT
			cs.setString(13, "");//V_CHG_DLV_DT
			cs.setString(14, "");//V_CUR
			cs.setString(15, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(17, V_PO_USR_NM);//V_PO_USR_NM
			cs.executeQuery();

			if (V_TYPE.equals("SH")) {

				rs = (ResultSet) cs.getObject(16);
				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("MAST_PO_NO", rs.getString("MAST_PO_NO"));
					subObject.put("BP_CD", rs.getString("BP_CD"));
					subObject.put("BP_NM", rs.getString("BP_NM"));
					subObject.put("PO_DT", rs.getString("PO_DT"));
					subObject.put("PAY_METH", rs.getString("PAY_METH"));
					subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
					subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
					subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
					subObject.put("CUR", rs.getString("CUR"));
					subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
					subObject.put("DLV_TYPE", rs.getString("DLV_TYPE"));
					subObject.put("DLV_TYPE_NM", rs.getString("DLV_TYPE_NM"));
					subObject.put("REMARK", rs.getString("REMARK"));
					subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
					subObject.put("GR_TYPE_NM", rs.getString("GR_TYPE_NM"));
					subObject.put("SYS_TYPE", rs.getString("SYS_TYPE"));
					subObject.put("SYS_TYPE_NM", rs.getString("SYS_TYPE_NM"));
					subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
					subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
					subObject.put("CHG_YN", rs.getString("CHG_YN"));
					subObject.put("OF_CFM_YN", rs.getString("OF_CFM_YN"));
					subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));

					jsonArray.add(subObject);
				}

				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

				// 								System.out.println(jsonObject);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
			}
			if (V_TYPE.equals("SD")) {

				rs = (ResultSet) cs.getObject(16);
				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("MAST_PO_NO", rs.getString("MAST_PO_NO"));
					subObject.put("PO_NO", rs.getString("PO_NO"));
					subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
					subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("MAKER", rs.getString("MAKER"));
					subObject.put("AGENT", rs.getString("AGENT"));
					subObject.put("SPEC", rs.getString("SPEC"));
					subObject.put("UNIT", rs.getString("UNIT"));
					subObject.put("PO_QTY", rs.getString("PO_QTY"));
					subObject.put("PO_PRC", rs.getString("PO_PRC"));
					subObject.put("PO_AMT", rs.getString("PO_AMT"));
					subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
					subObject.put("CHG_PO_QTY", rs.getString("CHG_PO_QTY"));
					subObject.put("CHG_PO_PRC", rs.getString("CHG_PO_PRC"));
					subObject.put("CHG_PO_AMT", rs.getString("CHG_PO_AMT"));
					subObject.put("CHG_DLV_DT", rs.getString("CHG_DLV_DT"));
					subObject.put("OFFERNO", rs.getString("OFFERNO"));
					subObject.put("OF_CFM_YN", rs.getString("OF_CFM_YN"));

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
			if (V_TYPE.equals("CF")) {

				rs = (ResultSet) cs.getObject(16);
				String OF_CFM_YN = "";
				while (rs.next()) {
					OF_CFM_YN = rs.getString("OF_CFM_YN");
				}
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(OF_CFM_YN);
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

			// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {

					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_MAST_PO_NO = hashMap.get("MAST_PO_NO") == null ? "" : hashMap.get("MAST_PO_NO").toString();
					V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_CHG_PO_PRC = hashMap.get("CHG_PO_PRC") == null ? "" : hashMap.get("CHG_PO_PRC").toString();
					String V_CHG_PO_QTY = hashMap.get("CHG_PO_QTY") == null ? "" : hashMap.get("CHG_PO_QTY").toString();
					String V_CHG_PO_AMT = hashMap.get("CHG_PO_AMT") == null ? "" : hashMap.get("CHG_PO_AMT").toString();
					String V_CHG_DLV_DT = hashMap.get("CHG_DLV_DT") == null ? "" : hashMap.get("CHG_DLV_DT").toString().substring(0, 10);
					String V_OFFERNO = hashMap.get("OFFERNO") == null ? "" : hashMap.get("OFFERNO").toString();

					// 					System.out.println("V_CHG_DLV_DT:"  + V_CHG_DLV_DT);

					cs = conn.prepareCall("call USP_003_M_OFFER_CFM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//
					cs.setString(3, V_MAST_PO_NO);//V_MAST_PO_NO
					cs.setString(4, V_M_BP_CD);//V_BP_CD
					cs.setString(5, "");//V_PUR_DT_FR
					cs.setString(6, "");//V_PUR_DT_TO
					cs.setString(7, V_PO_NO);//V_PO_NO
					cs.setString(8, V_PO_SEQ);//V_PO_SEQ
					cs.setString(9, "");//V_CFM_YN
					cs.setString(10, V_CHG_PO_QTY);//V_CHG_PO_QTY
					cs.setString(11, V_CHG_PO_PRC);//V_CHG_PO_PRC
					cs.setString(12, V_CHG_PO_AMT);//V_CHG_PO_AMT
					cs.setString(13, V_CHG_DLV_DT);//V_CHG_DLV_DT
					cs.setString(14, V_OFFERNO);//V_CUR
					cs.setString(15, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(17, "");//V_PO_USR_NM
					cs.executeQuery();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_MAST_PO_NO = jsondata.get("MAST_PO_NO") == null ? "" : jsondata.get("MAST_PO_NO").toString();
				V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_CHG_PO_PRC = jsondata.get("CHG_PO_PRC") == null ? "" : jsondata.get("CHG_PO_PRC").toString();
				String V_CHG_PO_QTY = jsondata.get("CHG_PO_QTY") == null ? "" : jsondata.get("CHG_PO_QTY").toString();
				String V_CHG_PO_AMT = jsondata.get("CHG_PO_AMT") == null ? "" : jsondata.get("CHG_PO_AMT").toString();
				String V_CHG_DLV_DT = jsondata.get("CHG_DLV_DT") == null ? "" : jsondata.get("CHG_DLV_DT").toString().substring(0, 10);
				String V_OFFERNO = jsondata.get("OFFERNO") == null ? "" : jsondata.get("OFFERNO").toString();

				cs = conn.prepareCall("call USP_003_M_OFFER_CFM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//
				cs.setString(3, V_MAST_PO_NO);//V_MAST_PO_NO
				cs.setString(4, V_M_BP_CD);//V_BP_CD
				cs.setString(5, "");//V_PUR_DT_FR
				cs.setString(6, "");//V_PUR_DT_TO
				cs.setString(7, V_PO_NO);//V_PO_NO
				cs.setString(8, V_PO_SEQ);//V_PO_SEQ
				cs.setString(9, "");//V_CFM_YN
				cs.setString(10, V_CHG_PO_QTY);//V_CHG_PO_QTY
				cs.setString(11, V_CHG_PO_PRC);//V_CHG_PO_PRC
				cs.setString(12, V_CHG_PO_AMT);//V_CHG_PO_AMT
				cs.setString(13, V_CHG_DLV_DT);//V_CHG_DLV_DT
				cs.setString(14, V_OFFERNO);//V_CUR
				cs.setString(15, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(17, "");//V_PO_USR_NM
				cs.executeQuery();
			}
		}

	} catch (Exception e) {
		System.out.println("======PO_ERROR=====");
		System.out.println("PO_NO: " + V_PO_NO);
		System.out.println("PO_SEQ: " + V_PO_SEQ);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

		e.printStackTrace();
	} finally {
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (cs2 != null)
			try {
				cs2.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>


