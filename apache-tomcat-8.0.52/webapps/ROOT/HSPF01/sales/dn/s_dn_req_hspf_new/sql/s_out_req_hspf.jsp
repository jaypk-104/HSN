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
<%@ include file="/HSPF01/common/DB_Connection_TEST.jsp"%>
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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_SO_DT_FROM = request.getParameter("V_SO_DT_FROM") == null ? "" : request.getParameter("V_SO_DT_FROM").substring(0, 10);
		String V_SO_DT_TO = request.getParameter("V_SO_DT_TO") == null ? "" : request.getParameter("V_SO_DT_TO").substring(0, 10);
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD");
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		String V_DR_DT = request.getParameter("V_DR_DT") == null ? "" : request.getParameter("V_DR_DT").substring(0, 10);
		String V_DR_NO = request.getParameter("V_DR_NO") == null ? "" : request.getParameter("V_DR_NO");

		//왼쪽수주조회
		if (V_TYPE.equals("LS")) {
			cs = conn.prepareCall("call USP_S_OUT_REQ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_SO_DT_FROM);//V_SO_DT_FR
			cs.setString(4, V_SO_DT_TO);//V_SO_DT_TO
			cs.setString(5, V_S_BP_CD);//V_S_BP_CD
			cs.setString(6, V_S_BP_NM);//V_S_BP_NM
			cs.setString(7, V_ITEM_CD);//V_ITEM_CD
			cs.setString(8, "");//V_SO_NO
			cs.setString(9, "");//V_SO_SEQ
			cs.setString(10, "");//V_DR_NO
			cs.setString(11, "");//V_DR_SEQ
			cs.setString(12, "");//V_DR_DT
			cs.setString(13, "");//V_DR_QTY
			cs.setString(14, "");//V_SL_CD
			cs.setString(15, "");//V_DIR_YN
			cs.setString(16, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(17);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SO_NO", rs.getString("SO_NO"));
				subObject.put("SO_SEQ", rs.getString("SO_SEQ"));
				subObject.put("SO_DT", rs.getString("SO_DT").substring(0, 10));
				subObject.put("S_BP_CD", rs.getString("BP_CD"));
				subObject.put("S_BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("SO_TYPE", rs.getString("SO_TYPE"));
				subObject.put("SO_QTY", rs.getString("SO_QTY"));
				subObject.put("SO_REMAIN", rs.getString("SO_REMAIN"));
				subObject.put("DR_QTY", rs.getString("DR_QTY"));
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

			// 	출고요청채번
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

					//출하요청번호채번
					if (V_TYPE.equals("DI")) {
						cs = conn.prepareCall("call USP_S_OUT_REQ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, "AI");//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, "");//V_SO_DT_FR
						cs.setString(4, "");//V_SO_DT_TO
						cs.setString(5, "");//V_S_BP_CD
						cs.setString(6, "");//V_S_BP_NM
						cs.setString(7, "");//V_ITEM_CD
						cs.setString(8, "");//V_SO_NO
						cs.setString(9, "");//V_SO_SEQ
						cs.setString(10, "");//V_DR_NO
						cs.setString(11, "");//V_DR_SEQ
						cs.setString(12, V_DR_DT);//V_DR_DT
						cs.setString(13, "");//V_DR_QTY
						cs.setString(14, "");//V_TO_SL_CD
						cs.setString(15, "");//V_DIR_YN
						cs.setString(16, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(17);
						while (rs.next()) {
							V_DR_NO = rs.getString("DR_NO");
						}
					}

					V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_DR_QTY = hashMap.get("DR_QTY") == null ? "" : hashMap.get("DR_QTY").toString();
					String V_TO_SL_CD = hashMap.get("TO_SL_CD") == null ? "" : hashMap.get("TO_SL_CD").toString();
					String V_SO_NO = hashMap.get("SO_NO") == null ? "" : hashMap.get("SO_NO").toString();
					String V_SO_SEQ = hashMap.get("SO_SEQ") == null ? "" : hashMap.get("SO_SEQ").toString();

					// 					System.out.println("V_TYPE" + V_TYPE);
					// 					System.out.println("V_COMP_ID" + V_COMP_ID);
					// 					System.out.println("V_S_BP_CD" + V_S_BP_CD);
					// 					System.out.println("V_ITEM_CD" + V_ITEM_CD);
					// 					System.out.println("V_SO_NO" + V_SO_NO);
					// 					System.out.println("V_SO_SEQ" + V_SO_SEQ);
					// 					System.out.println("V_DR_NO" + V_DR_NO);
					// 					System.out.println("V_DR_DT" + V_DR_DT);
					// 					System.out.println("V_DR_QTY" + V_DR_QTY);
					// 					System.out.println("V_SL_CD" + V_SL_CD);
					// 					System.out.println("V_USR_ID" + V_USR_ID);

					cs = conn.prepareCall("call USP_S_OUT_REQ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, "");//V_SO_DT_FR
					cs.setString(4, "");//V_SO_DT_TO
					cs.setString(5, V_S_BP_CD);//V_S_BP_CD
					cs.setString(6, V_S_BP_NM);//V_S_BP_NM
					cs.setString(7, V_ITEM_CD);//V_ITEM_CD
					cs.setString(8, V_SO_NO);//V_SO_NO
					cs.setString(9, V_SO_SEQ);//V_SO_SEQ
					cs.setString(10, V_DR_NO);//V_DR_NO
					cs.setString(11, "");//V_DR_SEQ
					cs.setString(12, V_DR_DT);//V_DR_DT
					cs.setString(13, V_DR_QTY);//V_DR_QTY
					cs.setString(14, V_TO_SL_CD);//V_TO_SL_CD
					cs.setString(15, "");//V_DIR_YN
					cs.setString(16, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();

				//출하요청채번
				if (V_TYPE.equals("DI")) {
					cs = conn.prepareCall("call USP_S_OUT_REQ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "AI");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, "");//V_SO_DT_FR
					cs.setString(4, "");//V_SO_DT_TO
					cs.setString(5, "");//V_S_BP_CD
					cs.setString(6, "");//V_S_BP_NM
					cs.setString(7, "");//V_ITEM_CD
					cs.setString(8, "");//V_SO_NO
					cs.setString(9, "");//V_SO_SEQ
					cs.setString(10, "");//V_DR_NO
					cs.setString(11, "");//V_DR_SEQ
					cs.setString(12, V_DR_DT);//V_DR_DT
					cs.setString(13, "");//V_DR_QTY
					cs.setString(14, "");//V_TO_SL_CD
					cs.setString(15, "");//V_DIR_YN
					cs.setString(16, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(17);
					while (rs.next()) {
						V_DR_NO = rs.getString("DR_NO");
					}
				}

				V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_DR_QTY = jsondata.get("DR_QTY") == null ? "" : jsondata.get("DR_QTY").toString();
				String V_TO_SL_CD = jsondata.get("TO_SL_CD") == null ? "" : jsondata.get("TO_SL_CD").toString();
				String V_SO_NO = jsondata.get("SO_NO") == null ? "" : jsondata.get("SO_NO").toString();
				String V_SO_SEQ = jsondata.get("SO_SEQ") == null ? "" : jsondata.get("SO_SEQ").toString();

// 				System.out.println("V_TYPE" + V_TYPE);
// 				System.out.println("V_COMP_ID" + V_COMP_ID);
// 				System.out.println("V_S_BP_CD" + V_S_BP_CD);
// 				System.out.println("V_ITEM_CD" + V_ITEM_CD); 
// 				System.out.println("V_SO_NO" + V_SO_NO);
// 				System.out.println("V_SO_SEQ" + V_SO_SEQ);
// 				System.out.println("V_DR_NO" + V_DR_NO);
// 				System.out.println("V_DR_DT" + V_DR_DT);
// 				System.out.println("V_DR_QTY" + V_DR_QTY);
// 				System.out.println("V_USR_ID" + V_USR_ID);

				cs = conn.prepareCall("call USP_S_OUT_REQ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, "");//V_SO_DT_FR
				cs.setString(4, "");//V_SO_DT_TO
				cs.setString(5, V_S_BP_CD);//V_S_BP_CD
				cs.setString(6, V_S_BP_NM);//V_S_BP_NM
				cs.setString(7, V_ITEM_CD);//V_ITEM_CD
				cs.setString(8, V_SO_NO);//V_SO_NO
				cs.setString(9, V_SO_SEQ);//V_SO_SEQ
				cs.setString(10, V_DR_NO);//V_DR_NO
				cs.setString(11, "");//V_DR_SEQ
				cs.setString(12, V_DR_DT);//V_DR_DT
				cs.setString(13, V_DR_QTY);//V_DR_QTY
				cs.setString(14, V_TO_SL_CD);//V_TO_SL_CD
				cs.setString(15, "");//V_DIR_YN
				cs.setString(16, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
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



