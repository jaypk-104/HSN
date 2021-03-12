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
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_DD_NO = request.getParameter("V_DD_NO") == null ? "" : request.getParameter("V_DD_NO").toUpperCase();

		//출고지시서수정 조회
		if (V_TYPE.equals("S")) {
			// 			System.out.println("S");
			String V_DD_DT_FROM = request.getParameter("V_DD_DT_FROM") == null ? "" : request.getParameter("V_DD_DT_FROM").substring(0, 10);
			String V_DD_DT_TO = request.getParameter("V_DD_DT_TO") == null ? "" : request.getParameter("V_DD_DT_TO").substring(0, 10);
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();

			cs = conn.prepareCall("call USP_S_DN_REQ_CHG_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, V_DD_DT_FROM); //V_DD_DT_FROM
			cs.setString(4, V_DD_DT_TO); //V_DD_DT_TO
			cs.setString(5, ""); //V_DR_NO
			cs.setString(6, ""); //V_DR_SEQ
			cs.setString(7, V_DD_NO); //V_DD_NO
			cs.setString(8, ""); //V_DD_SEQ
			cs.setString(9, ""); //V_DR_QTY
			cs.setString(10, V_ITEM_CD); //V_ITEM_CD
			cs.setString(11, V_S_BP_NM); //V_S_BP_CD
			cs.setString(12, ""); //V_PROD_REQ_NO
			cs.setString(13, V_USR_ID); //V_USR_ID
			cs.setString(14, ""); //V_PARAM1
			cs.setString(15, ""); //V_PARAM2
			cs.setString(16, ""); //V_PARAM3

			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(17);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DD_NO", rs.getString("DD_NO"));
				subObject.put("DD_SEQ", rs.getString("DD_SEQ"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("DD_QTY", rs.getString("DD_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DR_NO", rs.getString("DR_NO"));
				subObject.put("DR_SEQ", rs.getString("DR_SEQ"));

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

		//출고지시서 삭제
		else if (V_TYPE.equals("SYNC")) {
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
					if(V_TYPE.equals("U") || V_TYPE.equals("D")) {
						V_DD_NO = hashMap.get("DD_NO") == null ? "" : hashMap.get("DD_NO").toString();
					} 
					String DD_SEQ = hashMap.get("DD_SEQ") == null ? "" : hashMap.get("DD_SEQ").toString();
					String DR_NO = hashMap.get("DR_NO") == null ? "" : hashMap.get("DR_NO").toString();
					String DR_SEQ = hashMap.get("DR_SEQ") == null ? "" : hashMap.get("DR_SEQ").toString();
					String DR_QTY = hashMap.get("DR_QTY") == null ? "" : hashMap.get("DR_QTY").toString();
					String DD_QTY = hashMap.get("DD_QTY") == null ? "" : hashMap.get("DD_QTY").toString();
					String ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					
// 					System.out.println(V_DD_NO);
// 					System.out.println(DD_QTY);

					cs = conn.prepareCall("call USP_S_DN_REQ_CHG_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //V_TYPE
					cs.setString(2, V_COMP_ID); //V_COMP_ID
					cs.setString(3, ""); //V_DD_DT_FR
					cs.setString(4, ""); //V_DD_DT_TO
					cs.setString(5, DR_NO); //V_DR_NO
					cs.setString(6, DR_SEQ); //V_DR_SEQ
					cs.setString(7, V_DD_NO); //V_DD_NO
					cs.setString(8, DD_SEQ); //V_DD_SEQ
					cs.setString(9, DR_QTY); //V_DR_QTY
					cs.setString(10, ITEM_CD); //V_ITEM_CD
					cs.setString(11, S_BP_CD); //V_S_BP_CD
					cs.setString(12, ""); //V_PROD_REQ_NO
					cs.setString(13, V_USR_ID); //V_USR_ID
					cs.setString(14, DD_QTY); //DD_QTY
					cs.setString(15, ""); //V_PARAM2
					cs.setString(16, ""); //V_PARAM3

					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				if(V_TYPE.equals("U") || V_TYPE.equals("D")) {
					V_DD_NO = jsondata.get("DD_NO") == null ? "" : jsondata.get("DD_NO").toString();
				} 
				String DD_SEQ = jsondata.get("DD_SEQ") == null ? "" : jsondata.get("DD_SEQ").toString();
				String DR_NO = jsondata.get("DR_NO") == null ? "" : jsondata.get("DR_NO").toString();
				String DR_SEQ = jsondata.get("DR_SEQ") == null ? "" : jsondata.get("DR_SEQ").toString();
				String DR_QTY = jsondata.get("DR_QTY") == null ? "" : jsondata.get("DR_QTY").toString();
				String DD_QTY = jsondata.get("DD_QTY") == null ? "" : jsondata.get("DD_QTY").toString();
				String ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();

// 				System.out.println(V_TYPE);
// 				System.out.println(V_DD_NO);
// 				System.out.println(DD_SEQ);
// 				System.out.println(DD_QTY);
// 				System.out.println(DR_NO);
// 				System.out.println(DR_SEQ);

				cs = conn.prepareCall("call USP_S_DN_REQ_CHG_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //V_TYPE
				cs.setString(2, V_COMP_ID); //V_COMP_ID
				cs.setString(3, ""); //V_DD_DT_FR
				cs.setString(4, ""); //V_DD_DT_TO
				cs.setString(5, DR_NO); //V_DR_NO
				cs.setString(6, DR_SEQ); //V_DR_SEQ
				cs.setString(7, V_DD_NO); //V_DD_NO
				cs.setString(8, DD_SEQ); //V_DD_SEQ
				cs.setString(9, DR_QTY); //V_DR_QTY
				cs.setString(10, ITEM_CD); //V_ITEM_CD
				cs.setString(11, S_BP_CD); //V_S_BP_CD
				cs.setString(12, ""); //V_PROD_REQ_NO
				cs.setString(13, V_USR_ID); //V_USR_ID
				cs.setString(14, DD_QTY); //DD_QTY
				cs.setString(15, ""); //V_PARAM2
				cs.setString(16, ""); //V_PARAM3

				cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
		}

		//출고지시서 추가
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


