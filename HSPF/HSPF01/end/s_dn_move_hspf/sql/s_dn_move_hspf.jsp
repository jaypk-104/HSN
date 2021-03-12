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
<%@ include file="/HSPF01/common/DB_Connection_ERP.jsp"%>

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

		//출고조회 조회
		if (V_TYPE.equals("S")) {
			String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").substring(0, 10);
			String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").substring(0, 10);
			String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();

			cs = conn.prepareCall("call USP_S_DN_MOVE(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_DN_DT_FR); //V_DN_DT_FR
			cs.setString(3, V_DN_DT_TO); //V_DN_DT_TO
			cs.setString(4, V_S_BP_NM); //V_S_BP_CD
			cs.setString(5, V_ITEM_CD); //V_ITEM_CD
			cs.setString(6, V_ITEM_NM); //V_ITEM_NM
			cs.setString(7, V_BL_NO); //V_BL_NO
			cs.setString(8, ""); //V_DN_NO
			cs.setString(9, ""); //V_DN_SEQ
			cs.setString(10, ""); //V_DN_DT
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(11);
			
// 			System.out.println(V_DN_DT_FR);
// 			System.out.println(V_DN_DT_TO);
// 			System.out.println(V_S_BP_NM);
// 			System.out.println(V_ITEM_CD);
// 			System.out.println(V_ITEM_NM);
// 			System.out.println(V_BL_NO);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));

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

			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 						System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
					String V_DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString();
					String V_DN_DT = hashMap.get("DN_DT") == null ? "" : hashMap.get("DN_DT").toString().substring(0, 10);

// 					System.out.println(V_TYPE);
// 					System.out.println(V_DN_NO);
// 					System.out.println(V_DN_SEQ);
// 					System.out.println(V_DN_DT);

					cs = conn.prepareCall("call USP_S_DN_MOVE(?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //V_TYPE
					cs.setString(2, ""); //V_DN_DT_FR
					cs.setString(3, ""); //V_DN_DT_TO
					cs.setString(4, ""); //V_S_BP_CD
					cs.setString(5, ""); //V_ITEM_CD
					cs.setString(6, ""); //V_ITEM_NM
					cs.setString(7, ""); //V_BL_NO
					cs.setString(8, V_DN_NO); //V_DN_NO
					cs.setString(9, V_DN_SEQ); //V_DN_SEQ
					cs.setString(10, V_DN_DT); //V_DN_DT
					cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					e_cs = e_conn.prepareCall("{call USP_HSPF_DN_DT_CHG(?,?,?)}");
					e_cs.setString(1, V_DN_NO);
					e_cs.setString(2, V_DN_SEQ);
					e_cs.setString(3, V_DN_DT);
					e_cs.execute();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
				String V_DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString();
				String V_DN_DT = jsondata.get("DN_DT") == null ? "" : jsondata.get("DN_DT").toString().substring(0, 10);

// 				System.out.println(1);
// 				System.out.println(V_TYPE);
// 				System.out.println(V_DN_NO);
// 				System.out.println(V_DN_SEQ);
// 				System.out.println(V_DN_DT);

				cs = conn.prepareCall("call USP_S_DN_MOVE(?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //V_TYPE
				cs.setString(2, ""); //V_DN_DT_FR
				cs.setString(3, ""); //V_DN_DT_TO
				cs.setString(4, ""); //V_S_BP_CD
				cs.setString(5, ""); //V_ITEM_CD
				cs.setString(6, ""); //V_ITEM_NM
				cs.setString(7, ""); //V_BL_NO
				cs.setString(8, V_DN_NO); //V_DN_NO
				cs.setString(9, V_DN_SEQ); //V_DN_SEQ
				cs.setString(10, V_DN_DT); //V_DN_DT
				cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				e_cs = e_conn.prepareCall("{call USP_HSPF_DN_DT_CHG(?,?,?)}");
				e_cs.setString(1, V_DN_NO);
				e_cs.setString(2, V_DN_SEQ);
				e_cs.setString(3, V_DN_DT);
				e_cs.execute();
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

		//MSSQL
		if (e_cs != null) try {
			e_cs.close();
		} catch (SQLException ex) {}
		if (e_rs != null) try {
			e_rs.close();
		} catch (SQLException ex) {}
		if (e_stmt != null) try {
			e_stmt.close();
		} catch (SQLException ex) {}
		if (e_conn != null) try {
			e_conn.close();
		} catch (SQLException ex) {}
	}
%>


