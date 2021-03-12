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
		String V_PROD_DN_DT_FR = request.getParameter("V_PROD_DN_DT_FR") == null ? "" : request.getParameter("V_PROD_DN_DT_FR").substring(0, 10);
		String V_PROD_DN_DT_TO = request.getParameter("V_PROD_DN_DT_TO") == null ? "" : request.getParameter("V_PROD_DN_DT_TO").substring(0, 10);
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");

		// 		System.out.println("V_TYPE :" + V_TYPE);
		// 		System.out.println("V_COMP_ID :" + V_COMP_ID);
		// 		System.out.println("V_USR_ID :" + V_USR_ID);
		// 		System.out.println("V_PROD_DN_DT_FR :" + V_PROD_DN_DT_FR);
		// 		System.out.println("V_PROD_DN_DT_TO :" + V_PROD_DN_DT_TO);
		// 		System.out.println("V_S_BP_NM :" + V_S_BP_NM);
		// 		System.out.println("V_ITEM_CD :" + V_ITEM_CD);
		// 		System.out.println("V_CUST_ORDER_NO :" + V_CUST_ORDER_NO);

		// 		조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_M_PROD_DN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PROD_DN_DT_FR);//V_PROD_DN_DT_FR
			cs.setString(4, V_PROD_DN_DT_TO);//V_PROD_DN_DT_TO
			cs.setString(5, "");//V_PROD_DN_NO
			cs.setString(6, "");//V_PROD_DN_SEQ
			cs.setString(7, "");//V_S_BP_CD
			cs.setString(8, V_S_BP_NM);//V_S_BP_NM
			cs.setString(9, "");//V_BP_ITEM_CD
			cs.setString(10, "");//V_BP_ITEM_NM
			cs.setString(11, "");//V_PROD_DN_DT
			cs.setString(12, "");//V_LINE_CD
			cs.setString(13, "");//V_LINE_NM
			cs.setString(14, "");//V_DN_QTY
			cs.setString(15, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("PROD_DN_NO", rs.getString("PROD_DN_NO"));
				subObject.put("PROD_DN_SEQ", rs.getString("PROD_DN_SEQ"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("BP_ITEM_NM", rs.getString("BP_ITEM_NM"));
				subObject.put("PROD_DN_DT", rs.getString("PROD_DN_DT").substring(0, 10));
				subObject.put("LINE_CD", rs.getString("LINE_CD"));
				subObject.put("LINE_NM", rs.getString("LINE_NM"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
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

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_PROD_DN_NO = hashMap.get("PROD_DN_NO") == null ? "" : hashMap.get("PROD_DN_NO").toString();
					String V_PROD_DN_SEQ = hashMap.get("PROD_DN_SEQ") == null ? "" : hashMap.get("PROD_DN_SEQ").toString();
					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					V_S_BP_NM = hashMap.get("S_BP_NM") == null ? "" : hashMap.get("S_BP_NM").toString();
					String V_BP_ITEM_CD = hashMap.get("BP_ITEM_CD") == null ? "" : hashMap.get("BP_ITEM_CD").toString();
					String V_BP_ITEM_NM = hashMap.get("BP_ITEM_NM") == null ? "" : hashMap.get("BP_ITEM_NM").toString();
					String V_PROD_DN_DT = hashMap.get("PROD_DN_DT") == null ? "" : hashMap.get("PROD_DN_DT").toString();
					String V_LINE_CD = hashMap.get("PROD_DN_NO") == null ? "" : hashMap.get("LINE_CD").toString();
					String V_LINE_NM = hashMap.get("LINE_NM") == null ? "" : hashMap.get("LINE_NM").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();

					//생산출고등록
					cs = conn.prepareCall("call USP_M_PROD_DN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_PROD_DN_DT_FR);//V_PROD_DN_DT_FR
					cs.setString(4, V_PROD_DN_DT_TO);//V_PROD_DN_DT_TO
					cs.setString(5, V_PROD_DN_NO);//V_PROD_DN_NO
					cs.setString(6, V_PROD_DN_SEQ);//V_PROD_DN_SEQ
					cs.setString(7, V_S_BP_CD);//V_S_BP_CD
					cs.setString(8, V_S_BP_NM);//V_S_BP_NM
					cs.setString(9, V_BP_ITEM_CD);//V_BP_ITEM_CD
					cs.setString(10, V_BP_ITEM_NM);//V_BP_ITEM_NM
					cs.setString(11, V_PROD_DN_DT);//V_PROD_DN_DT
					cs.setString(12, V_LINE_CD);//V_LINE_CD
					cs.setString(13, V_LINE_NM);//V_LINE_NM
					cs.setString(14, V_DN_QTY);//V_DN_QTY
					cs.setString(15, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_PROD_DN_NO = jsondata.get("PROD_DN_NO") == null ? "" : jsondata.get("PROD_DN_NO").toString();
				String V_PROD_DN_SEQ = jsondata.get("PROD_DN_SEQ") == null ? "" : jsondata.get("PROD_DN_SEQ").toString();
				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				V_S_BP_NM = jsondata.get("S_BP_NM") == null ? "" : jsondata.get("S_BP_NM").toString();
				String V_BP_ITEM_CD = jsondata.get("BP_ITEM_CD") == null ? "" : jsondata.get("BP_ITEM_CD").toString();
				String V_BP_ITEM_NM = jsondata.get("BP_ITEM_NM") == null ? "" : jsondata.get("BP_ITEM_NM").toString();
				String V_PROD_DN_DT = jsondata.get("PROD_DN_DT") == null ? "" : jsondata.get("PROD_DN_DT").toString();
				String V_LINE_CD = jsondata.get("PROD_DN_NO") == null ? "" : jsondata.get("LINE_CD").toString();
				String V_LINE_NM = jsondata.get("LINE_NM") == null ? "" : jsondata.get("LINE_NM").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();

				// 				System.out.println(V_TYPE);
				// 				System.out.println(V_BP_ITEM_CD);
				// 				System.out.println(V_PROD_DN_NO);
				// 				System.out.println(V_PROD_DN_SEQ);

				//생산출고등록
				cs = conn.prepareCall("call USP_M_PROD_DN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_PROD_DN_DT_FR);//V_PROD_DN_DT_FR
				cs.setString(4, V_PROD_DN_DT_TO);//V_PROD_DN_DT_TO
				cs.setString(5, V_PROD_DN_NO);//V_PROD_DN_NO
				cs.setString(6, V_PROD_DN_SEQ);//V_PROD_DN_SEQ
				cs.setString(7, V_S_BP_CD);//V_S_BP_CD
				cs.setString(8, V_S_BP_NM);//V_S_BP_NM
				cs.setString(9, V_BP_ITEM_CD);//V_BP_ITEM_CD
				cs.setString(10, V_BP_ITEM_NM);//V_BP_ITEM_NM
				cs.setString(11, V_PROD_DN_DT);//V_PROD_DN_DT
				cs.setString(12, V_LINE_CD);//V_LINE_CD
				cs.setString(13, V_LINE_NM);//V_LINE_NM
				cs.setString(14, V_DN_QTY);//V_DN_QTY
				cs.setString(15, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
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



