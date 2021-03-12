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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_TYPE_CD = request.getParameter("V_TYPE_CD") == null ? "" : request.getParameter("V_TYPE_CD").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_B_BIZ_PAY_INFO_HSPF(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_TYPE_CD);//V_TYPE_CD
			cs.setString(4, V_BP_CD);//V_BP_CD
			cs.setString(5, "");//V_PAY_DUR 
			cs.setString(6, "");//V_PAY_METH
			cs.setString(7, "");//V_SEQ 
			cs.setString(8, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(9);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("TYPE_CD", rs.getString("TYPE_CD"));
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("PAY_DUR", rs.getString("PAY_DUR"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
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

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_TYPE_CD = hashMap.get("TYPE_CD") == null ? "" : hashMap.get("TYPE_CD").toString();
					V_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_PAY_DUR = hashMap.get("PAY_DUR") == null ? "" : hashMap.get("PAY_DUR").toString();
					String V_PAY_METH = hashMap.get("PAY_METH") == null ? "" : hashMap.get("PAY_METH").toString();

					cs = conn.prepareCall("call USP_003_B_BIZ_PAY_INFO_HSPF(?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_TYPE_CD);//V_TYPE_CD
					cs.setString(4, V_BP_CD);//V_BP_CD
					cs.setString(5, V_PAY_DUR);//V_PAY_DUR 
					cs.setString(6, V_PAY_METH);//V_PAY_METH
					cs.setString(7, V_SEQ);//V_SEQ 
					cs.setString(8, V_USR_ID);//V_USR_ID 
					cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_TYPE_CD = jsondata.get("TYPE_CD") == null ? "" : jsondata.get("TYPE_CD").toString();
				V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_PAY_DUR = jsondata.get("PAY_DUR") == null ? "" : jsondata.get("PAY_DUR").toString();
				String V_PAY_METH = jsondata.get("PAY_METH") == null ? "" : jsondata.get("PAY_METH").toString();
				
				cs = conn.prepareCall("call USP_003_B_BIZ_PAY_INFO_HSPF(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_TYPE_CD);//V_TYPE_CD
				cs.setString(4, V_BP_CD);//V_BP_CD
				cs.setString(5, V_PAY_DUR);//V_PAY_DUR 
				cs.setString(6, V_PAY_METH);//V_PAY_METH
				cs.setString(7, V_SEQ);//V_SEQ 
				cs.setString(8, V_USR_ID);//V_USR_ID 
				cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
		}

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

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


