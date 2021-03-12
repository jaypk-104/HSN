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
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
		String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
		String V_CFM_YN = request.getParameter("V_CFM_YN") == null ? "" : request.getParameter("V_CFM_YN").toUpperCase();
		String V_MAST_DB_NO = request.getParameter("V_MAST_DB_NO") == null ? "" : request.getParameter("V_MAST_DB_NO").toUpperCase();
		String V_COL_DT_FR = request.getParameter("V_COL_DT_FR") == null ? "" : request.getParameter("V_COL_DT_FR").toString();
		String V_COL_DT_TO = request.getParameter("V_COL_DT_TO") == null ? "" : request.getParameter("V_COL_DT_TO").toString();
		
		if(V_COL_DT_FR.length() > 10){
			V_COL_DT_FR = V_COL_DT_FR.substring(0,10);
		}
		if(V_COL_DT_TO.length() > 10){
			V_COL_DT_TO = V_COL_DT_TO.substring(0,10);
		}

		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_M_COL_TOT_STATS(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "I");//V_TYPE
			cs.setString(3, "");//V_ALL_YN
			cs.setString(4, V_COL_DT_FR);//V_BS_DT
			cs.setString(5, "");//V_DEPT_CD
			cs.setString(6, "");//V_DEPT_CD
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			cs = conn.prepareCall("call USP_M_COL_TOT_STATS(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "S");//V_TYPE
			cs.setString(3, "");//V_ALL_YN
			cs.setString(4, V_COL_DT_FR);//V_BS_DT
			cs.setString(5, "");//V_DEPT_CD
			cs.setString(6, "");//V_DEPT_CD
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("COL_A_AMT", rs.getString("COL_A_AMT"));
				subObject.put("COL_B_TOT_AMT", rs.getString("COL_B_TOT_AMT"));
				subObject.put("COL_B_AMT", rs.getString("COL_B_AMT"));
				subObject.put("COL_B_RM_AMT", rs.getString("COL_B_RM_AMT"));
				subObject.put("COL_D_TOT_AMT", rs.getString("COL_D_TOT_AMT"));
				subObject.put("COL_D_AMT", rs.getString("COL_D_AMT"));
				subObject.put("COL_D_RM_AMT", rs.getString("COL_D_RM_AMT"));
				subObject.put("COL_TOT_AMT", rs.getString("COL_TOT_AMT"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));
				subObject.put("TO_DT", rs.getString("TO_DT"));
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

			cs = conn.prepareCall("call USP_M_COL_TOT_STATS(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_ALL_YN
			cs.setString(4, "");//V_BS_DT
			cs.setString(5, "");//V_DEPT_CD
			cs.setString(6, V_S_BP_CD);//V_S_BP_CD
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COL_DT", rs.getString("COL_DT"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("COL_NM", rs.getString("COL_NM"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("COL_AMT", rs.getString("COL_AMT"));
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("CLS_AMT", rs.getString("CLS_AMT"));
				subObject.put("CLS_DT", rs.getString("CLS_DT"));
				
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
						V_MAST_DB_NO = hashMap.get("MAST_DB_NO") == null ? "" : hashMap.get("MAST_DB_NO").toString();
						V_CFM_YN = hashMap.get("POST_FLG") == null ? "" : hashMap.get("POST_FLG").toString();

						cs = conn.prepareCall("call USP_004_D_COL_ACCPT_HSPF(?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, "");//V_COL_DT_FR
						cs.setString(4, "");//V_COL_DT_TO
						cs.setString(5, "");//V_DEPT_CD
						cs.setString(6, "");//V_S_BP_CD
						cs.setString(7, V_MAST_DB_NO);//V_MAST_DB_NO
						cs.setString(8, V_CFM_YN);//V_CFM_YN
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}
				} else {
					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					V_MAST_DB_NO = jsondata.get("MAST_DB_NO") == null ? "" : jsondata.get("MAST_DB_NO").toString();
					V_CFM_YN = jsondata.get("POST_FLG") == null ? "" : jsondata.get("POST_FLG").toString();

					cs = conn.prepareCall("call USP_004_D_COL_ACCPT_HSPF(?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_COL_DT_FR
					cs.setString(4, "");//V_COL_DT_TO
					cs.setString(5, "");//V_DEPT_CD
					cs.setString(6, "");//V_S_BP_CD
					cs.setString(7, V_MAST_DB_NO);//V_MAST_DB_NO
					cs.setString(8, V_CFM_YN);//V_CFM_YN
					cs.setString(9, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
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


