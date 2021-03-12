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
		String V_YYYYMMDD = request.getParameter("V_STOCK_DT") == null ? "" : request.getParameter("V_STOCK_DT").substring(0, 10).replaceAll("-", "");
		// 		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();

		// 		System.out.println("V_TYPE" + V_TYPE);
		// 		System.out.println("V_COMP_ID" + V_COMP_ID);
		// 		System.out.println("V_STOCK_DT" + V_STOCK_DT);

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_I_STOCK_KI(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_YYYYMMDD);//V_YYYYMMDD
			cs.setString(3, "");//V_ITEM_CD
			cs.setString(4, "");//V_BL_NO
			cs.setString(5, "");//V_GR_DT
			cs.setString(6, "");//V_STOCK_QTY
			cs.setString(7, "");//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("YYYYMMDD", rs.getString("YYYYMMDD"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("STOCK_QTY", rs.getString("STOCK_QTY"));
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

		}

		else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");

			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { // 배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String V_GR_DT = hashMap.get("GR_DT") == null ? "" : hashMap.get("GR_DT").toString().substring(0, 10);
					String V_STOCK_QTY = hashMap.get("STOCK_QTY") == null ? "" : hashMap.get("STOCK_QTY").toString();
					V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

					cs = conn.prepareCall("call USP_I_STOCK_KI(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_YYYYMMDD);//V_YYYYMMDD
					cs.setString(3, V_ITEM_CD);//V_ITEM_CD
					cs.setString(4, V_BL_NO);//V_BL_NO
					cs.setString(5, V_GR_DT);//V_GR_DT
					cs.setString(6, V_STOCK_QTY);//V_STOCK_QTY
					cs.setString(7, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}

			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String V_GR_DT = jsondata.get("GR_DT") == null ? "" : jsondata.get("GR_DT").toString().substring(0, 10);
				String V_STOCK_QTY = jsondata.get("STOCK_QTY") == null ? "" : jsondata.get("STOCK_QTY").toString();
				V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

// 				System.out.println(V_YYYYMMDD);
// 				System.out.println(V_ITEM_CD);
// 				System.out.println(V_BL_NO);
// 				System.out.println(V_GR_DT);
				
				cs = conn.prepareCall("call USP_I_STOCK_KI(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_YYYYMMDD);//V_YYYYMMDD
				cs.setString(3, V_ITEM_CD);//V_ITEM_CD
				cs.setString(4, V_BL_NO);//V_BL_NO
				cs.setString(5, V_GR_DT);//V_GR_DT
				cs.setString(6, V_STOCK_QTY);//V_STOCK_QTY
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
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


