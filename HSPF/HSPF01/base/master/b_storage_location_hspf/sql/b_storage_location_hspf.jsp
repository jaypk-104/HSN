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

		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");
		String V_SL_NM = request.getParameter("V_SL_NM") == null ? "" : request.getParameter("V_SL_NM");
		String V_SL_LOC = request.getParameter("V_SL_LOC") == null ? "" : request.getParameter("V_SL_LOC");

		String V_LC_CD = request.getParameter("V_LC_CD") == null ? "" : request.getParameter("V_LC_CD");
		String V_LC_NM = request.getParameter("V_LC_NM") == null ? "" : request.getParameter("V_LC_NM");
		String V_LC_LOC = request.getParameter("V_LC_LOC") == null ? "" : request.getParameter("V_LC_LOC");

		String V_RACK_CD = request.getParameter("V_RACK_CD") == null ? "" : request.getParameter("V_RACK_CD");
		String V_RACK_NM = request.getParameter("V_RACK_NM") == null ? "" : request.getParameter("V_RACK_NM");

// 		System.out.println("V_TYPE :" + V_TYPE);
// 		System.out.println("V_COMP_ID :" + V_COMP_ID);
// 		System.out.println("V_USR_ID :" + V_USR_ID);
// 		System.out.println("V_SL_CD :" + V_SL_CD);
// 		System.out.println("V_SL_NM :" + V_SL_NM);
// 		System.out.println("V_LC_CD :" + V_LC_CD);
// 		System.out.println("V_LC_NM :" + V_LC_NM);

		//1. 창고코드, 창고명 조회
		if (V_TYPE.equals("SS")) {
			cs = conn.prepareCall("call USP_B_STORAGE_LOCATION_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_SL_CD);//V_SL_CD
			cs.setString(4, V_SL_NM);//V_SL_NM
			cs.setString(5, V_SL_LOC);//V_SL_LOC
			cs.setString(6, V_LC_CD);//V_LC_CD
			cs.setString(7, V_LC_NM);//V_LC_NM
			cs.setString(8, V_LC_LOC);//V_LC_LOC
			cs.setString(9, V_RACK_CD);//V_RACK_CD
			cs.setString(10, V_RACK_NM);//V_RACK_NM
			cs.setString(11, "");//V_MIN_QTY
			cs.setString(12, "");//V_MAX_QTY
			cs.setString(13, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("SL_LOC", rs.getString("SL_LOC"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//2. LOCATION 조회
		} else if (V_TYPE.equals("LS")) {
			cs = conn.prepareCall("call USP_B_STORAGE_LOCATION_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_SL_CD);//V_SL_CD
			cs.setString(4, V_SL_NM);//V_SL_NM
			cs.setString(5, V_SL_LOC);//V_SL_LOC
			cs.setString(6, V_LC_CD);//V_LC_CD
			cs.setString(7, V_LC_NM);//V_LC_NM
			cs.setString(8, V_LC_LOC);//V_LC_LOC
			cs.setString(9, V_RACK_CD);//V_RACK_CD
			cs.setString(10, V_RACK_NM);//V_RACK_NM
			cs.setString(11, "");//V_MIN_QTY
			cs.setString(12, "");//V_MAX_QTY
			cs.setString(13, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("LC_CD", rs.getString("LC_CD"));
				subObject.put("LC_NM", rs.getString("LC_NM"));
				subObject.put("LC_LOC", rs.getString("LC_LOC"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//3. RACK 조회
		} else if (V_TYPE.equals("RS")) {
			cs = conn.prepareCall("call USP_B_STORAGE_LOCATION_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_SL_CD);//V_SL_CD
			cs.setString(4, V_SL_NM);//V_SL_NM
			cs.setString(5, V_SL_LOC);//V_SL_LOC
			cs.setString(6, V_LC_CD);//V_LC_CD
			cs.setString(7, V_LC_NM);//V_LC_NM
			cs.setString(8, V_LC_LOC);//V_LC_LOC
			cs.setString(9, V_RACK_CD);//V_RACK_CD
			cs.setString(10, V_RACK_NM);//V_RACK_NM
			cs.setString(11, "");//V_MIN_QTY
			cs.setString(12, "");//V_MAX_QTY
			cs.setString(13, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("LC_CD", rs.getString("LC_CD"));
				subObject.put("RACK_CD", rs.getString("RACK_CD"));
				subObject.put("RACK_NM", rs.getString("RACK_NM"));
				subObject.put("MAX_QTY", rs.getString("MAX_QTY"));
				subObject.put("MIN_QTY", rs.getString("MIN_QTY"));
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
					V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					V_SL_NM = hashMap.get("SL_NM") == null ? "" : hashMap.get("SL_NM").toString();
					V_SL_LOC = hashMap.get("SL_LOC") == null ? "" : hashMap.get("SL_LOC").toString();

					V_LC_CD = hashMap.get("LC_CD") == null ? "" : hashMap.get("LC_CD").toString();
					V_LC_NM = hashMap.get("LC_NM") == null ? "" : hashMap.get("LC_NM").toString();
					V_LC_LOC = hashMap.get("LC_LOC") == null ? "" : hashMap.get("LC_LOC").toString();

					V_RACK_CD = hashMap.get("RACK_CD") == null ? "" : hashMap.get("RACK_CD").toString();
					V_RACK_NM = hashMap.get("RACK_NM") == null ? "" : hashMap.get("RACK_NM").toString();
					String V_MIN_QTY = hashMap.get("MIN_QTY") == null ? "" : hashMap.get("MIN_QTY").toString();
					String V_MAX_QTY = hashMap.get("MAX_QTY") == null ? "" : hashMap.get("MAX_QTY").toString();

					cs = conn.prepareCall("call USP_B_STORAGE_LOCATION_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_SL_CD);//V_SL_CD
					cs.setString(4, V_SL_NM);//V_SL_NM
					cs.setString(5, V_SL_LOC);//V_SL_LOC
					cs.setString(6, V_LC_CD);//V_LC_CD
					cs.setString(7, V_LC_NM);//V_LC_NM
					cs.setString(8, V_LC_LOC);//V_LC_LOC
					cs.setString(9, V_RACK_CD);//V_RACK_CD
					cs.setString(10, V_RACK_NM);//V_RACK_NM
					cs.setString(11, V_MIN_QTY);//V_MIN_QTY
					cs.setString(12, V_MAX_QTY);//V_MAX_QTY
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				V_SL_NM = jsondata.get("SL_NM") == null ? "" : jsondata.get("SL_NM").toString();
				V_SL_LOC = jsondata.get("SL_LOC") == null ? "" : jsondata.get("SL_LOC").toString();
				V_LC_CD = jsondata.get("LC_CD") == null ? "" : jsondata.get("LC_CD").toString();
				V_LC_NM = jsondata.get("LC_NM") == null ? "" : jsondata.get("LC_NM").toString();
				V_LC_LOC = jsondata.get("LC_LOC") == null ? "" : jsondata.get("LC_LOC").toString();

				V_RACK_CD = jsondata.get("RACK_CD") == null ? "" : jsondata.get("RACK_CD").toString();
				V_RACK_NM = jsondata.get("RACK_NM") == null ? "" : jsondata.get("RACK_NM").toString();
				String V_MIN_QTY = jsondata.get("MIN_QTY") == null ? "" : jsondata.get("MIN_QTY").toString();
				String V_MAX_QTY = jsondata.get("MAX_QTY") == null ? "" : jsondata.get("MAX_QTY").toString();


				cs = conn.prepareCall("call USP_B_STORAGE_LOCATION_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_SL_CD);//V_SL_CD
				cs.setString(4, V_SL_NM);//V_SL_NM
				cs.setString(5, V_SL_LOC);//V_SL_LOC
				cs.setString(6, V_LC_CD);//V_LC_CD
				cs.setString(7, V_LC_NM);//V_LC_NM
				cs.setString(8, V_LC_LOC);//V_LC_LOC
				cs.setString(9, V_RACK_CD);//V_RACK_CD
				cs.setString(10, V_RACK_NM);//V_RACK_NM
				cs.setString(11, V_MIN_QTY);//V_MIN_QTY
				cs.setString(12, V_MAX_QTY);//V_MAX_QTY
				cs.setString(13, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
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



