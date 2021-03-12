<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	JSONObject anyObject = new JSONObject();
	JSONArray anyArray = new JSONArray();
	JSONObject anySubObject = new JSONObject();
	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "^" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "^" : request.getParameter("V_USR_ID").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "^" : request.getParameter("V_ITEM_CD").toUpperCase();
		
// 		System.out.println("V_ITEM_GRP: " + V_ITEM_GRP);
		
		//조회
		if (V_TYPE.equals("S")) {
			String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
			
			cs = conn.prepareCall("call USP_B_BIZ_EMP_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BP_NM);//V_BP_CD
			cs.setString(4, "");//V_EMP_NAME
			cs.setString(5, "");//V_TEL_NO
			cs.setString(6, "");//V_HAND_TEL
			cs.setString(7, "");//V_FAX_NO
			cs.setString(8, "");//V_EMAIL
			cs.setString(9, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("EMP_NAME", rs.getString("EMP_NAME"));
				subObject.put("TEL_NO", rs.getString("TEL_NO"));
				subObject.put("HAND_TEL", rs.getString("HAND_TEL"));
				subObject.put("FAX_NO", rs.getString("FAX_NO"));
				subObject.put("EMAIL", rs.getString("EMAIL"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

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

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString().toUpperCase();
					String BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString();
					String EMP_NAME = hashMap.get("EMP_NAME") == null ? "" : hashMap.get("EMP_NAME").toString();
					String TEL_NO = hashMap.get("TEL_NO") == null ? "" : hashMap.get("TEL_NO").toString();
					String HAND_TEL = hashMap.get("HAND_TEL") == null ? "" : hashMap.get("HAND_TEL").toString();
					String FAX_NO = hashMap.get("FAX_NO") == null ? "" : hashMap.get("FAX_NO").toString();
					String EMAIL = hashMap.get("EMAIL") == null ? "" : hashMap.get("EMAIL").toString();

					cs = conn.prepareCall("call USP_B_BIZ_EMP_HSPF(?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, BP_CD);//V_BP_CD
					cs.setString(4, EMP_NAME);//V_EMP_NAME
					cs.setString(5, TEL_NO);//V_TEL_NO
					cs.setString(6, HAND_TEL);//V_HAND_TEL
					cs.setString(7, FAX_NO);//V_FAX_NO
					cs.setString(8, EMAIL);//V_EMAIL
					cs.setString(9, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString().toUpperCase();
				String BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String EMP_NAME = jsondata.get("EMP_NAME") == null ? "" : jsondata.get("EMP_NAME").toString();
				String TEL_NO = jsondata.get("TEL_NO") == null ? "" : jsondata.get("TEL_NO").toString();
				String HAND_TEL = jsondata.get("HAND_TEL") == null ? "" : jsondata.get("HAND_TEL").toString();
				String FAX_NO = jsondata.get("FAX_NO") == null ? "" : jsondata.get("FAX_NO").toString();
				String EMAIL = jsondata.get("EMAIL") == null ? "" : jsondata.get("EMAIL").toString();

				cs = conn.prepareCall("call USP_B_BIZ_EMP_HSPF(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, BP_CD);//V_BP_CD
				cs.setString(4, EMP_NAME);//V_EMP_NAME
				cs.setString(5, TEL_NO);//V_TEL_NO
				cs.setString(6, HAND_TEL);//V_HAND_TEL
				cs.setString(7, FAX_NO);//V_FAX_NO
				cs.setString(8, EMAIL);//V_EMAIL
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}

		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (cs != null)
			try {
				cs.close();
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


