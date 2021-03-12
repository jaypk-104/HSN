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
		String V_DT_FR = request.getParameter("V_BANK_DT_FR") == null ? "" : request.getParameter("V_BANK_DT_FR").toUpperCase().substring(0, 10);
		String V_DT_TO = request.getParameter("V_BANK_DT_TO") == null ? "" : request.getParameter("V_BANK_DT_TO").toUpperCase().substring(0, 10);
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
// 		String V_BANK_CD = request.getParameter("V_BANK_CD") == null ? "" : request.getParameter("V_BANK_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_A_NOTE_STAT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DT_FR);//V_DT_FR
			cs.setString(4, V_DT_TO);//V_DT_TO
			cs.setString(5, "");//V_DEPT_CD
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(7, V_BP_CD);//V_BP_CD
			cs.setString(8, "");//V_REMARK
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("NOTE_NO", rs.getString("NOTE_NO"));
				subObject.put("ISSUE_DT", rs.getString("ISSUE_DT"));
				subObject.put("DUE_DT", rs.getString("DUE_DT"));
				subObject.put("BAE_DT", rs.getString("BAE_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BP_REG_NO", rs.getString("BP_REG_NO"));
				subObject.put("BANK_ACCT_NO", rs.getString("BANK_ACCT_NO"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("NOTE_AMT", rs.getString("NOTE_AMT"));
				subObject.put("BAE_AMT", rs.getString("BAE_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("TEMP_GL_YN", rs.getString("TEMP_GL_YN"));
				subObject.put("FNOTE_YN", rs.getString("FNOTE_YN"));
				subObject.put("PAPER_YN", rs.getString("PAPER_YN"));
				subObject.put("REMARK", rs.getString("REMARK"));
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
					String V_NOTE_NO = hashMap.get("NOTE_NO") == null ? "" : hashMap.get("NOTE_NO").toString();
					String V_PAPER_YN = hashMap.get("PAPER_YN") == null ? "" : hashMap.get("PAPER_YN").toString();
					String V_NOTE_AMT = hashMap.get("NOTE_AMT") == null ? "" : hashMap.get("NOTE_AMT").toString();
					String V_BAE_AMT = hashMap.get("BAE_AMT") == null ? "" : hashMap.get("BAE_AMT").toString();
					String V_BP_NM = hashMap.get("BP_NM") == null ? "" : hashMap.get("BP_NM").toString();
					String V_BANK_CD = hashMap.get("BANK_CD") == null ? "" : hashMap.get("BANK_CD").toString();
					String V_BANK_NM = hashMap.get("BANK_NM") == null ? "" : hashMap.get("BANK_NM").toString();
					String V_DEPT_CD = hashMap.get("DEPT_CD") == null ? "" : hashMap.get("DEPT_CD").toString();
					String V_DEPT_NM = hashMap.get("DEPT_NM") == null ? "" : hashMap.get("DEPT_NM").toString();
					String V_BANK_ACCT_NO = hashMap.get("BANK_ACCT_NO") == null ? "" : hashMap.get("BANK_ACCT_NO").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					
					String V_ISSUE_DT = hashMap.get("ISSUE_DT") == null ? "" : hashMap.get("ISSUE_DT").toString();
					String V_BAE_DT = hashMap.get("BAE_DT") == null ? "" : hashMap.get("BAE_DT").toString();
					String V_DUE_DT = hashMap.get("DUE_DT") == null ? "" : hashMap.get("DUE_DT").toString();

					if(V_ISSUE_DT.length() > 10 ){
						V_ISSUE_DT = V_ISSUE_DT.substring(0,10);
					}
					else {
						V_ISSUE_DT = "";
					}
					if(V_BAE_DT.length() > 10 ){
						V_BAE_DT = V_BAE_DT.substring(0,10);
					}
					else {
						V_BAE_DT = "";
					}
					if(V_DUE_DT.length() > 10 ){
						V_DUE_DT = V_DUE_DT.substring(0,10);
					}
					else {
						V_DUE_DT = "";
					}
					
					cs = conn.prepareCall("call USP_A_FNOTE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_NOTE_NO);//V_NOTE_NO 
					cs.setString(4, V_PAPER_YN);//V_PAPER_YN
					cs.setString(5, V_NOTE_AMT);//V_NOTE_AMT
					cs.setString(6, V_BAE_AMT);//V_BAE_AMT
					cs.setString(7, V_ISSUE_DT);//V_ISSUE_DT
					cs.setString(8, V_BAE_DT);//V_BAE_DT
					cs.setString(9, V_DUE_DT);//V_DUE_DT
					cs.setString(10, V_BP_CD);//V_BP_CD
					cs.setString(11, V_BP_NM);//V_BP_NM
					cs.setString(12, V_BANK_CD);//V_BANK_CD
					cs.setString(13, V_BANK_NM);//V_BANK_NM
					cs.setString(14, V_BANK_ACCT_NO);//V_BANK_ACCT_NO
					cs.setString(15, V_DEPT_CD);//V_DEPT_CD
					cs.setString(16, V_DEPT_NM);//V_DEPT_NM
					cs.setString(17, V_REMARK);//V_REMARK
					cs.setString(18, V_USR_ID);//V_USR_ID
					cs.executeQuery();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String V_NOTE_NO = jsondata.get("NOTE_NO") == null ? "" : jsondata.get("NOTE_NO").toString();
				String V_PAPER_YN = jsondata.get("PAPER_YN") == null ? "" : jsondata.get("PAPER_YN").toString();
				String V_NOTE_AMT = jsondata.get("NOTE_AMT") == null ? "" : jsondata.get("NOTE_AMT").toString();
				String V_BAE_AMT = jsondata.get("BAE_AMT") == null ? "" : jsondata.get("BAE_AMT").toString();
				String V_BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
				String V_BANK_CD = jsondata.get("BANK_CD") == null ? "" : jsondata.get("BANK_CD").toString();
				String V_BANK_NM = jsondata.get("BANK_NM") == null ? "" : jsondata.get("BANK_NM").toString();
				String V_DEPT_CD = jsondata.get("DEPT_CD") == null ? "" : jsondata.get("DEPT_CD").toString();
				String V_DEPT_NM = jsondata.get("DEPT_NM") == null ? "" : jsondata.get("DEPT_NM").toString();
				String V_BANK_ACCT_NO = jsondata.get("BANK_ACCT_NO") == null ? "" : jsondata.get("BANK_ACCT_NO").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				
				String V_ISSUE_DT = jsondata.get("ISSUE_DT") == null ? "" : jsondata.get("ISSUE_DT").toString();
				String V_BAE_DT = jsondata.get("BAE_DT") == null ? "" : jsondata.get("BAE_DT").toString();
				String V_DUE_DT = jsondata.get("DUE_DT") == null ? "" : jsondata.get("DUE_DT").toString();

				if(V_ISSUE_DT.length() > 10 ){
					V_ISSUE_DT = V_ISSUE_DT.substring(0,10);
				}
				else {
					V_ISSUE_DT = "";
				}
				if(V_BAE_DT.length() > 10 ){
					V_BAE_DT = V_BAE_DT.substring(0,10);
				}
				else {
					V_BAE_DT = "";
				}
				if(V_DUE_DT.length() > 10 ){
					V_DUE_DT = V_DUE_DT.substring(0,10);
				}
				else {
					V_DUE_DT = "";
				}
				
				cs = conn.prepareCall("call USP_A_FNOTE_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_NOTE_NO);//V_NOTE_NO 
				cs.setString(4, V_PAPER_YN);//V_PAPER_YN
				cs.setString(5, V_NOTE_AMT);//V_NOTE_AMT
				cs.setString(6, V_BAE_AMT);//V_BAE_AMT
				cs.setString(7, V_ISSUE_DT);//V_ISSUE_DT
				cs.setString(8, V_BAE_DT);//V_BAE_DT
				cs.setString(9, V_DUE_DT);//V_DUE_DT
				cs.setString(10, V_BP_CD);//V_BP_CD
				cs.setString(11, V_BP_NM);//V_BP_NM
				cs.setString(12, V_BANK_CD);//V_BANK_CD
				cs.setString(13, V_BANK_NM);//V_BANK_NM
				cs.setString(14, V_BANK_ACCT_NO);//V_BANK_ACCT_NO
				cs.setString(15, V_DEPT_CD);//V_DEPT_CD
				cs.setString(16, V_DEPT_NM);//V_DEPT_NM
				cs.setString(17, V_REMARK);//V_REMARK
				cs.setString(18, V_USR_ID);//V_USR_ID
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


