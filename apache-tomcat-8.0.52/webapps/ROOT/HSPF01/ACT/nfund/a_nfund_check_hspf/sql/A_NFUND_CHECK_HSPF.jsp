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
		String V_BANK_DT_FR = request.getParameter("V_BANK_DT_FR") == null ? "" : request.getParameter("V_BANK_DT_FR").toUpperCase().substring(0, 10);
		String V_BANK_DT_TO = request.getParameter("V_BANK_DT_TO") == null ? "" : request.getParameter("V_BANK_DT_TO").toUpperCase().substring(0, 10);
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_BANK_CD = request.getParameter("V_BANK_CD") == null ? "" : request.getParameter("V_BANK_CD").toUpperCase();
		String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_A_NFUND_CHECK_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BANK_DT_FR);//V_BANK_DT_FR
			cs.setString(4, V_BANK_DT_TO);//V_BANK_DT_TO 
			cs.setString(5, V_REMARK);//V_REMARK 
			cs.setString(6, "");//V_BC_NO
			cs.setString(7, "");//V_DEPT_CD
			cs.setString(8, V_BP_CD);//V_BP_CD
			cs.setString(9, V_BANK_CD);//V_BANK_CD
			cs.setString(10, "");//V_USR_ID 
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(11);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BC_NO", rs.getString("BC_NO"));
				subObject.put("BANK_DT", rs.getString("BANK_DT"));
				subObject.put("BANK_ACCT_NO", rs.getString("BANK_ACCT_NO"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("ACCT_KIND_NM", rs.getString("ACCT_KIND_NM"));
				subObject.put("IN_AMT", rs.getString("IN_AMT"));
				subObject.put("OUT_AMT", rs.getString("OUT_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("REMARK2", rs.getString("REMARK2"));
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
					String V_BC_NO = hashMap.get("BC_NO") == null ? "" : hashMap.get("BC_NO").toString();
					String V_DEPT_CD = hashMap.get("DEPT_CD") == null ? "" : hashMap.get("DEPT_CD").toString();
					String V_REMARK2 = hashMap.get("REMARK2") == null ? "" : hashMap.get("REMARK2").toString();

					cs = conn.prepareCall("call USP_A_NFUND_CHECK_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_BANK_DT_FR
					cs.setString(4, "");//V_BANK_DT_TO 
					cs.setString(5, V_REMARK2);//V_REMARK 
					cs.setString(6, V_BC_NO);//V_BC_NO
					cs.setString(7, V_DEPT_CD);//V_DEPT_CD
					cs.setString(8, V_BP_CD);//V_BP_CD
					cs.setString(9, "");//V_BANK_CD
					cs.setString(10, V_USR_ID);//V_USR_ID 
					cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String V_BC_NO = jsondata.get("BC_NO") == null ? "" : jsondata.get("BC_NO").toString();
				String V_DEPT_CD = jsondata.get("DEPT_CD") == null ? "" : jsondata.get("DEPT_CD").toString();
				String V_REMARK2 = jsondata.get("REMARK2") == null ? "" : jsondata.get("REMARK2").toString();

				cs = conn.prepareCall("call USP_A_NFUND_CHECK_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_BANK_DT_FR
				cs.setString(4, "");//V_BANK_DT_TO 
				cs.setString(5, V_REMARK2);//V_REMARK 
				cs.setString(6, V_BC_NO);//V_BC_NO
				cs.setString(7, V_DEPT_CD);//V_DEPT_CD
				cs.setString(8, V_BP_CD);//V_BP_CD
				cs.setString(9, "");//V_BANK_CD
				cs.setString(10, V_USR_ID);//V_USR_ID 
				cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
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


