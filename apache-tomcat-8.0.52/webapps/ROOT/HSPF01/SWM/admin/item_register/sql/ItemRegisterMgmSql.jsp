<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		request.setCharacterEncoding("utf-8");

		String[] findList = { "#", "+", "&", "%", " " };
		String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

		String data = request.getParameter("data");
		data = StringUtils.replaceEach(data, findList, replList);
		String jsonData = URLDecoder.decode(data, "UTF-8");

		// 		String V_TYPE = request.getParameter("V_TYPE"); //
		String V_USR_ID = request.getParameter("V_USR_ID");

		if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
			String NEW_PO_NO = "";
			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);
				String BP_ITEM_CD = hashMap.get("BP_ITEM_CD") == null ? "" : hashMap.get("BP_ITEM_CD").toString();
				String ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
				String S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
				String M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
				String ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
				String UNIT = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
				String SPEC = hashMap.get("SPEC") == null ? "" : hashMap.get("SPEC").toString();
				String MID_PACK_QTY = hashMap.get("MID_PACK_QTY") == null ? "" : hashMap.get("MID_PACK_QTY").toString();
				String MAX_PACK_QTY = hashMap.get("MAX_PACK_QTY") == null ? "" : hashMap.get("MAX_PACK_QTY").toString();
				String M_PRICE = hashMap.get("M_PRICE") == null ? "" : hashMap.get("M_PRICE").toString();
				String S_PRICE = hashMap.get("S_PRICE") == null ? "" : hashMap.get("S_PRICE").toString();
				String HSCODE = hashMap.get("HSCODE") == null ? "" : hashMap.get("HSCODE").toString();
				String WEIGHT = hashMap.get("WEIGHT") == null ? "" : hashMap.get("WEIGHT").toString();

				cs = conn.prepareCall("{call USP_SWM_ITEM_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, V_USR_ID);
				cs.setString(2, ITEM_CD);
				cs.setString(3, S_BP_CD);
				cs.setString(4, M_BP_CD);
				cs.setString(5, ITEM_NM);
				cs.setString(6, UNIT);
				cs.setString(7, SPEC);
				cs.setString(8, MID_PACK_QTY);
				cs.setString(9, MAX_PACK_QTY);
				cs.setString(10, M_PRICE);
				cs.setString(11, S_PRICE);
				cs.setString(12, HSCODE);
				cs.setString(13, "");

				cs.execute();
			}
		} else {
			String NEW_PO_NO = "";

			JSONObject jsondata = JSONObject.fromObject(jsonData);
			String BP_ITEM_CD = jsondata.get("BP_ITEM_CD") == null ? "" : jsondata.get("BP_ITEM_CD").toString();
			String ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
			String S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
			String M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
			String ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
			String UNIT = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
			String SPEC = jsondata.get("SPEC") == null ? "" : jsondata.get("SPEC").toString();
			String MID_PACK_QTY = jsondata.get("MID_PACK_QTY") == null ? "" : jsondata.get("MID_PACK_QTY").toString();
			String MAX_PACK_QTY = jsondata.get("MAX_PACK_QTY") == null ? "" : jsondata.get("MAX_PACK_QTY").toString();
			String M_PRICE = jsondata.get("M_PRICE") == null ? "" : jsondata.get("M_PRICE").toString();
			String S_PRICE = jsondata.get("S_PRICE") == null ? "" : jsondata.get("S_PRICE").toString();
			String HSCODE = jsondata.get("HSCODE") == null ? "" : jsondata.get("HSCODE").toString();
			String WEIGHT = jsondata.get("WEIGHT") == null ? "" : jsondata.get("WEIGHT").toString();
			
// 			System.out.println("MID_PACK_QTY : " + MID_PACK_QTY);
// 			System.out.println("MAX_PACK_QTY : " + MAX_PACK_QTY);
// 			System.out.println("M_PRICE : " + M_PRICE);
// 			System.out.println("S_PRICE : " + S_PRICE);
// 			System.out.println("WEIGHT : " + WEIGHT);

			cs = conn.prepareCall("{call USP_SWM_ITEM_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_USR_ID);
			cs.setString(2, ITEM_CD);
			cs.setString(3, S_BP_CD);
			cs.setString(4, M_BP_CD);
			cs.setString(5, ITEM_NM);
			cs.setString(6, UNIT);
			cs.setString(7, SPEC);
			cs.setString(8, MID_PACK_QTY);
			cs.setString(9, MAX_PACK_QTY);
			cs.setString(10, M_PRICE);
			cs.setString(11, S_PRICE);
			cs.setString(12, HSCODE);
			cs.setString(13, "");

			cs.execute();
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>








