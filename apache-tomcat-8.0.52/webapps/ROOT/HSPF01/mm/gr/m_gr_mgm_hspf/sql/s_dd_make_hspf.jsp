<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
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
		String V_DR_NO = request.getParameter("V_DR_NO") == null ? "" : request.getParameter("V_DR_NO");
		String V_CUST_ORDER_NO = request.getParameter("V_CUST_ORDER_NO") == null ? "" : request.getParameter("V_CUST_ORDER_NO");
		String V_DR_DT_FROM = request.getParameter("V_DR_DT_FROM") == null ? "" : request.getParameter("V_DR_DT_FROM").substring(0, 10);
		String V_DR_DT_TO = request.getParameter("V_DR_DT_TO") == null ? "" : request.getParameter("V_DR_DT_TO").substring(0, 10);
		String V_BP_CD_RIGHT = request.getParameter("V_BP_CD_RIGHT") == null ? "" : request.getParameter("V_BP_CD_RIGHT");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		String V_DD_NO = "";
		
// 		System.out.println("V_TYPE :" + V_TYPE);
// 		System.out.println("V_COMP_ID :" + V_COMP_ID);
// 		System.out.println("V_USR_ID :" + V_USR_ID);
// 		System.out.println("V_DR_DT_FROM :" + V_DR_DT_FROM);
// 		System.out.println("V_DR_DT_TO :" + V_DR_DT_TO);
// 		System.out.println("V_BP_CD_RIGHT :" + V_BP_CD_RIGHT);
// 		System.out.println("V_ITEM_CD :" + V_ITEM_CD);
// 		System.out.println("V_CUST_ORDER_NO :" + V_CUST_ORDER_NO);

		//오른쪽출고현황조회
		if (V_TYPE.equals("RS")) {
			cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DR_DT_FROM);//V_DR_DT_FROM
			cs.setString(4, V_DR_DT_TO);//V_DR_DT_TO
			cs.setString(5, "");//V_S_BP_CD
			cs.setString(6, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
			cs.setString(7, "");//V_DR_NO
			cs.setString(8, "");//V_DR_SEQ
			cs.setString(9, "");//V_DD_DT
			cs.setString(10, "");//V_DD_NO
			cs.setString(11, "");//V_ITEM_CD
			cs.setString(12, "");//V_DR_QTY
			cs.setString(13, "");//V_TO_SL_CD
			cs.setString(14, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(15);
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
					V_DR_NO = hashMap.get("DR_NO") == null ? "" : hashMap.get("DR_NO").toString();
					String V_DR_SEQ = hashMap.get("DR_SEQ") == null ? "" : hashMap.get("DR_SEQ").toString();
					String V_DR_QTY = hashMap.get("DR_QTY") == null ? "" : hashMap.get("DR_QTY").toString();
					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_TO_SL_CD = hashMap.get("TO_SL_CD") == null ? "" : hashMap.get("TO_SL_CD").toString();
					
					//출고지시번호채번
					if (V_TYPE.equals("DI")) {
						cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, "AI");//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, "");//V_DR_DT_FROM
						cs.setString(4, "");//V_DR_DT_TO
						cs.setString(5, "");//V_S_BP_CD
						cs.setString(6, "");//V_CUST_ORDER_NO
						cs.setString(7, "");//V_DR_NO
						cs.setString(8, "");//V_DR_SEQ
						cs.setString(9, "");//V_DD_DT
						cs.setString(10, "");//V_DD_NO
						cs.setString(11, "");//V_ITEM_CD
						cs.setString(12, "");//V_DR_QTY
						cs.setString(13, "");//V_TO_SL_CD
						cs.setString(14, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(15);
						while (rs.next()) {
							V_DD_NO = rs.getString("DD_NO");
						}
					}

// 					System.out.println("V_TYPE" + V_TYPE);
// 					System.out.println("V_DR_NO" + V_DR_NO);
// 					System.out.println("V_DR_SEQ" + V_DR_SEQ);
// 					System.out.println("V_DR_QTY" + V_DR_QTY);
// 					System.out.println("V_DD_NO" + V_DD_NO);
					
					cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_DR_DT_FROM);//V_DR_DT_FROM
					cs.setString(4, V_DR_DT_TO);//V_DR_DT_TO
					cs.setString(5, V_S_BP_CD);//V_S_BP_CD
					cs.setString(6, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
					cs.setString(7, V_DR_NO);//V_DR_NO
					cs.setString(8, V_DR_SEQ);//V_DR_SEQ
					cs.setString(9, "");//V_DD_DT
					cs.setString(10, V_DD_NO);//V_DD_NO
					cs.setString(11, "");//V_ITEM_CD
					cs.setString(12, V_DR_QTY);//V_DR_QTY
					cs.setString(13, V_TO_SL_CD);//V_TO_SL_CD
					cs.setString(14, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_DR_NO = jsondata.get("DR_NO") == null ? "" : jsondata.get("DR_NO").toString();
				String V_DR_SEQ = jsondata.get("DR_SEQ") == null ? "" : jsondata.get("DR_SEQ").toString();
				String V_DR_QTY = jsondata.get("DR_QTY") == null ? "" : jsondata.get("DR_QTY").toString();
				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_TO_SL_CD = jsondata.get("TO_SL_CD") == null ? "" : jsondata.get("TO_SL_CD").toString();

// 				System.out.println("V_TYPE" + V_TYPE);
// 				System.out.println("V_DR_NO" + V_DR_NO);
// 				System.out.println("V_DR_SEQ" + V_DR_SEQ);
// 				System.out.println("V_DR_QTY" + V_DR_QTY);
				
				//출고지시번호채번
				if (V_TYPE.equals("DI")) {
					cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "AI");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, "");//V_DR_DT_FROM
					cs.setString(4, "");//V_DR_DT_TO
					cs.setString(5, "");//V_S_BP_CD
					cs.setString(6, "");//V_CUST_ORDER_NO
					cs.setString(7, "");//V_DR_NO
					cs.setString(8, "");//V_DR_SEQ
					cs.setString(9, "");//V_DD_DT
					cs.setString(10, "");//V_DD_NO
					cs.setString(11, "");//V_ITEM_CD
					cs.setString(12, "");//V_DR_QTY
					cs.setString(13, "");//V_TO_SL_CD
					cs.setString(14, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(15);
					while (rs.next()) {
						V_DD_NO = rs.getString("DD_NO");
					}
				}
				System.out.println("V_DD_NO" + V_DD_NO);

				cs = conn.prepareCall("call USP_S_DD_MAKE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_DR_DT_FROM);//V_DR_DT_FROM
				cs.setString(4, V_DR_DT_TO);//V_DR_DT_TO
				cs.setString(5, V_S_BP_CD);//V_S_BP_CD
				cs.setString(6, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
				cs.setString(7, V_DR_NO);//V_DR_NO
				cs.setString(8, V_DR_SEQ);//V_DR_SEQ
				cs.setString(9, "");//V_DD_DT
				cs.setString(10, V_DD_NO);//V_DD_NO
				cs.setString(11, "");//V_ITEM_CD
				cs.setString(12, V_DR_QTY);//V_DR_QTY
				cs.setString(13, "");//V_TO_SL_CD
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



