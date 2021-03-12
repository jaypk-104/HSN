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
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_A_BIZ_ACCT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BP_CD);//V_BP_CD
			cs.setString(4, "");//V_BP_NM
			cs.setString(5, "");//V_BP_ADDRESS 
			cs.setString(6, "");//V_SWIFT_BIC
			cs.setString(7, "");//V_BANK_CD
			cs.setString(8, "");//V_BANK_NM
			cs.setString(9, "");//V_ACCT_CD
			cs.setString(10, "");//V_BANK_ADDRESS 
			cs.setString(11, "");//V_REMARK
			cs.setString(12, "");//V_SEQ
			cs.setString(13, "");//V_PARAM
			cs.setString(14, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(15);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BP_ADDRESS", rs.getString("BP_ADDRESS"));
				subObject.put("SWIFT_BIC", rs.getString("SWIFT_BIC"));
				subObject.put("ACCT_CD", rs.getString("ACCT_CD"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BANK_ADDRESS", rs.getString("BANK_ADDRESS"));
				subObject.put("REMARK", rs.getString("REMARK1"));
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
					V_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString();
					String V_BP_NM = hashMap.get("BP_NM") == null ? "" : hashMap.get("BP_NM").toString();
					String V_BP_ADDRESS = hashMap.get("BP_ADDRESS") == null ? "" : hashMap.get("BP_ADDRESS").toString();
					String V_SWIFT_BIC = hashMap.get("SWIFT_BIC") == null ? "" : hashMap.get("SWIFT_BIC").toString();
					String V_BANK_CD = hashMap.get("BANK_CD") == null ? "" : hashMap.get("BANK_CD").toString();
					String V_BANK_NM = hashMap.get("BANK_NM") == null ? "" : hashMap.get("BANK_NM").toString();
					String V_ACCT_CD = hashMap.get("ACCT_CD") == null ? "" : hashMap.get("ACCT_CD").toString();
					String V_BANK_ADDRESS = hashMap.get("BANK_ADDRESS") == null ? "" : hashMap.get("BANK_ADDRESS").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();

					cs = conn.prepareCall("call USP_A_BIZ_ACCT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_BP_CD);//V_BP_CD
					cs.setString(4, V_BP_NM);//V_BP_NM
					cs.setString(5, V_BP_ADDRESS);//V_BP_ADDRESS 
					cs.setString(6, V_SWIFT_BIC);//V_SWIFT_BIC
					cs.setString(7, V_BANK_CD);//V_BANK_CD
					cs.setString(8, V_BANK_NM);//V_BANK_NM
					cs.setString(9, V_ACCT_CD);//V_ACCT_CD
					cs.setString(10, V_BANK_ADDRESS);//V_BANK_ADDRESS 
					cs.setString(11, V_REMARK);//V_REMARK
					cs.setString(12, V_SEQ);//V_SEQ
					cs.setString(13, "");//V_PARAM
					cs.setString(14, V_USR_ID);//V_USR_ID 
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String V_BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
				String V_BP_ADDRESS = jsondata.get("BP_ADDRESS") == null ? "" : jsondata.get("BP_ADDRESS").toString();
				String V_SWIFT_BIC = jsondata.get("SWIFT_BIC") == null ? "" : jsondata.get("SWIFT_BIC").toString();
				String V_BANK_CD = jsondata.get("BANK_CD") == null ? "" : jsondata.get("BANK_CD").toString();
				String V_BANK_NM = jsondata.get("BANK_NM") == null ? "" : jsondata.get("BANK_NM").toString();
				String V_ACCT_CD = jsondata.get("ACCT_CD") == null ? "" : jsondata.get("ACCT_CD").toString();
				String V_BANK_ADDRESS = jsondata.get("BANK_ADDRESS") == null ? "" : jsondata.get("BANK_ADDRESS").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();

				cs = conn.prepareCall("call USP_A_BIZ_ACCT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_BP_CD);//V_BP_CD
				cs.setString(4, V_BP_NM);//V_BP_NM
				cs.setString(5, V_BP_ADDRESS);//V_BP_ADDRESS 
				cs.setString(6, V_SWIFT_BIC);//V_SWIFT_BIC
				cs.setString(7, V_BANK_CD);//V_BANK_CD
				cs.setString(8, V_BANK_NM);//V_BANK_NM
				cs.setString(9, V_ACCT_CD);//V_ACCT_CD
				cs.setString(10, V_BANK_ADDRESS);//V_BANK_ADDRESS 
				cs.setString(11, V_REMARK);//V_REMARK
				cs.setString(12, V_SEQ);//V_SEQ
				cs.setString(13, "");//V_PARAM
				cs.setString(14, V_USR_ID);//V_USR_ID 
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
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


