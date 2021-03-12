<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
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
		String V_MAST_DB_NO = request.getParameter("V_MAST_DB_NO") == null ? "" : request.getParameter("V_MAST_DB_NO").toUpperCase();
		String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_COL_NO = request.getParameter("V_COL_NO") == null ? "" : request.getParameter("V_COL_NO").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_M_COL_CHANGE_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_DET_CD
			cs.setString(4, V_MAST_DB_NO);//V_MAST_DB_NO 
			cs.setString(5, "");//V_PROC_NO 
			cs.setString(6, "");//V_COL_NO 
			cs.setString(7, "");//V_COL_SEQ 
			cs.setString(8, "");//V_PROC_DT
			cs.setString(9, "");//V_PROC_TYPE
			cs.setString(10, "");//V_DEPT_CD
			cs.setString(11, "");//V_S_BP_CD
			cs.setString(12, "");//V_PROC_AMT
			cs.setString(13, "");//V_BF_BL_NO
			cs.setString(14, "");//V_AF_BL_NO
			cs.setString(15, "");//V_ACCT_CD
			cs.setString(16, "");//V_BANK_CD
			cs.setString(17, "");//V_BANK_ACCT_CD
			cs.setString(18, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(19);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("COL_DT", rs.getString("COL_DT"));
				subObject.put("COL_AMT", rs.getString("COL_AMT"));
				subObject.put("JAN_AMT", rs.getString("JAN_AMT"));
				subObject.put("BP_CD", rs.getString("S_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SD")) {
			cs = conn.prepareCall("call USP_M_COL_CHANGE_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_DET_CD
			cs.setString(4, V_MAST_DB_NO);//V_MAST_DB_NO 
			cs.setString(5, "");//V_PROC_NO 
			cs.setString(6, V_COL_NO);//V_COL_NO 
			cs.setString(7, "");//V_COL_SEQ 
			cs.setString(8, "");//V_PROC_DT
			cs.setString(9, "");//V_PROC_TYPE
			cs.setString(10, "");//V_DEPT_CD
			cs.setString(11, "");//V_S_BP_CD
			cs.setString(12, "");//V_PROC_AMT
			cs.setString(13, "");//V_BF_BL_NO
			cs.setString(14, "");//V_AF_BL_NO
			cs.setString(15, "");//V_ACCT_CD
			cs.setString(16, "");//V_BANK_CD
			cs.setString(17, "");//V_BANK_ACCT_CD
			cs.setString(18, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(19);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PROC_NO", rs.getString("PROC_NO"));
				subObject.put("PROC_DT", rs.getString("PROC_DT"));
				subObject.put("PROC_TYPE", rs.getString("PROC_TYPE"));
				subObject.put("PROC_NM", rs.getString("PROC_NM"));
				subObject.put("PROC_AMT", rs.getString("PROC_AMT"));
				subObject.put("BF_BL_NO", rs.getString("BF_BL_NO"));
				subObject.put("AF_BL_NO", rs.getString("AF_BL_NO"));
				subObject.put("INSRT_USR_ID", rs.getString("INSRT_USR_ID"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("PB")) {
			cs = conn.prepareCall("call USP_M_COL_CHANGE_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_DET_CD
			cs.setString(4, "");//V_MAST_DB_NO 
			cs.setString(5, "");//V_PROC_NO 
			cs.setString(6, "");//V_COL_NO 
			cs.setString(7, "");//V_COL_SEQ 
			cs.setString(8, "");//V_PROC_DT
			cs.setString(9, "");//V_PROC_TYPE
			cs.setString(10, V_DEPT_CD);//V_DEPT_CD
			cs.setString(11, V_BP_CD);//V_S_BP_CD
			cs.setString(12, "");//V_PROC_AMT
			cs.setString(13, "");//V_BF_BL_NO
			cs.setString(14, "");//V_AF_BL_NO
			cs.setString(15, "");//V_ACCT_CD
			cs.setString(16, "");//V_BANK_CD
			cs.setString(17, "");//V_BANK_ACCT_CD
			cs.setString(18, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(19);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("S_DAYS", rs.getString("S_DAYS"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("IA")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			String V_COL_SEQ = request.getParameter("V_COL_SEQ") == null ? "" : request.getParameter("V_COL_SEQ").toUpperCase();
			String V_PROC_TYPE = request.getParameter("V_PROC_TYPE") == null ? "" : request.getParameter("V_PROC_TYPE").toUpperCase();
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					String V_ACCT_CD = hashMap.get("ACCT_CD") == null ? "" : hashMap.get("ACCT_CD").toString();
					String V_BANK_CD = hashMap.get("BANK_CD") == null ? "" : hashMap.get("BANK_CD").toString();
					String V_BANK_ACCT_CD = hashMap.get("BANK_ACCT_NO") == null ? "" : hashMap.get("BANK_ACCT_NO").toString();
					String V_PROC_AMT = hashMap.get("COL_AMT") == null ? "" : hashMap.get("COL_AMT").toString();
					
					cs = conn.prepareCall("call USP_M_COL_CHANGE_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_DET_CD
					cs.setString(4, V_MAST_DB_NO);//V_MAST_DB_NO 
					cs.setString(5, "");//V_PROC_NO 
					cs.setString(6, V_COL_NO);//V_COL_NO 
					cs.setString(7, V_COL_SEQ);//V_COL_SEQ 
					cs.setString(8, "");//V_PROC_DT
					cs.setString(9, V_PROC_TYPE);//V_PROC_TYPE
					cs.setString(10, V_DEPT_CD);//V_DEPT_CD
					cs.setString(11, V_BP_CD);//V_S_BP_CD
					cs.setString(12, V_PROC_AMT);//V_PROC_AMT
					cs.setString(13, "");//V_BF_BL_NO
					cs.setString(14, "");//V_AF_BL_NO
					cs.setString(15, V_ACCT_CD);//V_ACCT_CD
					cs.setString(16, V_BANK_CD);//V_BANK_CD
					cs.setString(17, V_BANK_ACCT_CD);//V_BANK_ACCT_CD
					cs.setString(18, V_USR_ID);//V_USR_ID 		
					cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				String V_ACCT_CD = jsondata.get("ACCT_CD") == null ? "" : jsondata.get("ACCT_CD").toString();
				String V_BANK_CD = jsondata.get("BANK_CD") == null ? "" : jsondata.get("BANK_CD").toString();
				String V_BANK_ACCT_CD = jsondata.get("BANK_ACCT_NO") == null ? "" : jsondata.get("BANK_ACCT_NO").toString();
				String V_PROC_AMT = jsondata.get("COL_AMT") == null ? "" : jsondata.get("COL_AMT").toString();

				cs = conn.prepareCall("call USP_M_COL_CHANGE_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_DET_CD
				cs.setString(4, V_MAST_DB_NO);//V_MAST_DB_NO 
				cs.setString(5, "");//V_PROC_NO 
				cs.setString(6, V_COL_NO);//V_COL_NO 
				cs.setString(7, V_COL_SEQ);//V_COL_SEQ 
				cs.setString(8, "");//V_PROC_DT
				cs.setString(9, V_PROC_TYPE);//V_PROC_TYPE
				cs.setString(10, V_DEPT_CD);//V_DEPT_CD
				cs.setString(11, V_BP_CD);//V_S_BP_CD
				cs.setString(12, V_PROC_AMT);//V_PROC_AMT
				cs.setString(13, "");//V_BF_BL_NO
				cs.setString(14, "");//V_AF_BL_NO
				cs.setString(15, V_ACCT_CD);//V_ACCT_CD
				cs.setString(16, V_BANK_CD);//V_BANK_CD
				cs.setString(17, V_BANK_ACCT_CD);//V_BANK_ACCT_CD
				cs.setString(18, V_USR_ID);//V_USR_ID 		
				cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
			
		} else if (V_TYPE.equals("IB")) {
			String V_COL_SEQ = request.getParameter("V_COL_SEQ") == null ? "" : request.getParameter("V_COL_SEQ").toUpperCase();
			String V_PROC_TYPE = request.getParameter("V_PROC_TYPE") == null ? "" : request.getParameter("V_PROC_TYPE").toUpperCase();
			String V_PROC_AMT = request.getParameter("V_PROC_AMT") == null ? "" : request.getParameter("V_PROC_AMT").toUpperCase();
			String V_BF_BL_NO = request.getParameter("V_BF_BL_NO") == null ? "" : request.getParameter("V_BF_BL_NO").toUpperCase();
			String V_AF_BL_NO = request.getParameter("V_AF_BL_NO") == null ? "" : request.getParameter("V_AF_BL_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_M_COL_CHANGE_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_DET_CD
			cs.setString(4, V_MAST_DB_NO);//V_MAST_DB_NO 
			cs.setString(5, "");//V_PROC_NO 
			cs.setString(6, V_COL_NO);//V_COL_NO 
			cs.setString(7, V_COL_SEQ);//V_COL_SEQ 
			cs.setString(8, "");//V_PROC_DT
			cs.setString(9, V_PROC_TYPE);//V_PROC_TYPE
			cs.setString(10, V_DEPT_CD);//V_DEPT_CD
			cs.setString(11, V_BP_CD);//V_S_BP_CD
			cs.setString(12, V_PROC_AMT);//V_PROC_AMT
			cs.setString(13, V_BF_BL_NO);//V_BF_BL_NO
			cs.setString(14, V_AF_BL_NO);//V_AF_BL_NO
			cs.setString(15, "");//V_ACCT_CD
			cs.setString(16, "");//V_BANK_CD
			cs.setString(17, "");//V_BANK_ACCT_CD
			cs.setString(18, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("SUCCESS");
			pw.flush();
			pw.close();
			
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


