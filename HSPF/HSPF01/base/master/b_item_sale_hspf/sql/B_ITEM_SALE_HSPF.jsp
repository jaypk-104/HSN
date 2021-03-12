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
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		//조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_B_ITEM_SALE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_ITEM_CD);//V_ITEM_CD
			cs.setString(4, V_ITEM_NM);//V_ITEM_NM
			cs.setString(5, "");//V_BP_CD
			cs.setString(6, V_S_BP_NM);//V_S_BP_NM
			cs.setString(7, "");//V_BP_ITEM_CD
			cs.setString(8, "");//V_BP_ITEM_NM
			cs.setString(9, "");//V_VALID_DT
			cs.setString(10, "");//V_S_PRICE
			cs.setString(11, "");//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("BP_ITEM_NM", rs.getString("BP_ITEM_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));
				subObject.put("S_PRICE", rs.getString("S_PRICE"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//수정
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
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString().toUpperCase();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString().toUpperCase();
					V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString().toUpperCase();
					String V_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString().toUpperCase();
					String V_BP_ITEM_CD = hashMap.get("BP_ITEM_CD") == null ? "" : hashMap.get("BP_ITEM_CD").toString().toUpperCase();
					String V_BP_ITEM_NM = hashMap.get("BP_ITEM_NM") == null ? "" : hashMap.get("BP_ITEM_NM").toString().toUpperCase();
					String V_VALID_DT = hashMap.get("VALID_DT") == null ? "" : hashMap.get("VALID_DT").toString().toUpperCase().substring(0, 10);
					String V_S_PRICE = hashMap.get("S_PRICE") == null ? "" : hashMap.get("S_PRICE").toString().toUpperCase();

					cs = conn.prepareCall("call USP_B_ITEM_SALE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
					cs.setString(4, V_ITEM_NM);//V_ITEM_NM
					cs.setString(5, V_BP_CD);//V_BP_CD
					cs.setString(6, V_S_BP_NM);//V_S_BP_NM
					cs.setString(7, V_BP_ITEM_CD);//V_BP_ITEM_CD
					cs.setString(8, V_BP_ITEM_NM);//V_BP_ITEM_NM
					cs.setString(9, V_VALID_DT);//V_VALID_DT
					cs.setString(10, V_S_PRICE);//V_S_PRICE
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString().toUpperCase();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString().toUpperCase();
				V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString().toUpperCase();
				String V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString().toUpperCase();
				String V_BP_ITEM_CD = jsondata.get("BP_ITEM_CD") == null ? "" : jsondata.get("BP_ITEM_CD").toString().toUpperCase();
				String V_BP_ITEM_NM = jsondata.get("BP_ITEM_NM") == null ? "" : jsondata.get("BP_ITEM_NM").toString().toUpperCase();
				String V_VALID_DT = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString().toUpperCase().substring(0, 10);
				String V_S_PRICE = jsondata.get("S_PRICE") == null ? "" : jsondata.get("S_PRICE").toString().toUpperCase();

				cs = conn.prepareCall("call USP_B_ITEM_SALE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
				cs.setString(4, V_ITEM_NM);//V_ITEM_NM
				cs.setString(5, V_BP_CD);//V_BP_CD
				cs.setString(6, V_S_BP_NM);//V_S_BP_NM
				cs.setString(7, V_BP_ITEM_CD);//V_BP_ITEM_CD
				cs.setString(8, V_BP_ITEM_NM);//V_BP_ITEM_NM
				cs.setString(9, V_VALID_DT);//V_VALID_DT
				cs.setString(10, V_S_PRICE);//V_S_PRICE
				cs.setString(11, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
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



