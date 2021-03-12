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
		String V_USR_ID2 = request.getParameter("V_USR_ID2") == null ? "" : request.getParameter("V_USR_ID2").toUpperCase();
		String V_USR_NM = request.getParameter("V_USR_NM") == null ? "" : request.getParameter("V_USR_NM").toUpperCase();

		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call DISTR_B_PR_USR.USP_B_PRINT_USR(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_USR_ID2);//V_USR_ID2
			cs.setString(4, "");//V_BP_NM
			cs.setString(5, "");//V_IND_TYPE
			cs.setString(6, "");//V_IND_CLASS
			cs.setString(7, "");//V_ADDRESS
			cs.setString(8, "");//V_TEL_NO
			cs.setString(9, "");//V_FAX_NO
			cs.setString(10, "");//V_REMARK
			cs.setString(11, "");//V_REGION
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_REGION
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("USR_ID", rs.getString("USR_ID"));
				subObject.put("NAME1", rs.getString("NAME1"));
				subObject.put("EMP_NO", rs.getString("EMP_NO"));
				subObject.put("ROLL_NM", rs.getString("ROLL_NM"));
				subObject.put("REQ_USR_YN", rs.getString("REQ_USR_YN"));
				subObject.put("CFM_USR_YN", rs.getString("CFM_USR_YN"));
				subObject.put("EMAIL", rs.getString("EMAIL"));
				subObject.put("TEL_NO", rs.getString("TEL_NO"));
				subObject.put("BIZ_TYPE", rs.getString("BIZ_TYPE"));
				subObject.put("BIZ_TYPE_NM", rs.getString("BIZ_TYPE_NM"));
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
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_USR_ID = hashMap.get("USR_ID") == null ? "" : hashMap.get("USR_ID").toString();
					String V_EMP_NO = hashMap.get("EMP_NO") == null ? "" : hashMap.get("EMP_NO").toString();
					String V_ROLL_NM = hashMap.get("ROLL_NM") == null ? "" : hashMap.get("ROLL_NM").toString();
					String V_REQ_USR_YN = hashMap.get("REQ_USR_YN") == null ? "" : hashMap.get("REQ_USR_YN").toString();
					String V_CFM_USR_YN = hashMap.get("CFM_USR_YN") == null ? "" : hashMap.get("CFM_USR_YN").toString();
					String V_EMAIL = hashMap.get("EMAIL") == null ? "" : hashMap.get("EMAIL").toString();
					String V_TEL_NO = hashMap.get("TEL_NO") == null ? "" : hashMap.get("TEL_NO").toString();
					String V_BIZ_TYPE = hashMap.get("BIZ_TYPE") == null ? "" : hashMap.get("BIZ_TYPE").toString();
					String V_NAME1 = hashMap.get("NAME1") == null ? "" : hashMap.get("NAME1").toString();

					cs = conn.prepareCall("call DISTR_B_PR_USR.USP_B_PRINT_USR(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_USR_ID);//V_USR_ID2
					cs.setString(4, V_EMP_NO);//V_EMP_NO
					cs.setString(5, V_ROLL_NM);//V_ROLL_NM
					cs.setString(6, V_REQ_USR_YN);//V_REQ_USR_YN
					cs.setString(7, V_CFM_USR_YN);//V_CFM_USR_YN
					cs.setString(8, V_EMAIL);//V_EMAIL
					cs.setString(9, V_TEL_NO);//V_TEL_NO
					cs.setString(10, V_BIZ_TYPE);//V_BIZ_TYPE
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(13, V_NAME1);//V_USR_ID
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("SUCCESS");
					pw.flush();
					pw.close();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_USR_ID = jsondata.get("USR_ID") == null ? "" : jsondata.get("USR_ID").toString();
				String V_EMP_NO = jsondata.get("EMP_NO") == null ? "" : jsondata.get("EMP_NO").toString();
				String V_ROLL_NM = jsondata.get("ROLL_NM") == null ? "" : jsondata.get("ROLL_NM").toString();
				String V_REQ_USR_YN = jsondata.get("REQ_USR_YN") == null ? "" : jsondata.get("REQ_USR_YN").toString();
				String V_CFM_USR_YN = jsondata.get("CFM_USR_YN") == null ? "" : jsondata.get("CFM_USR_YN").toString();
				String V_EMAIL = jsondata.get("EMAIL") == null ? "" : jsondata.get("EMAIL").toString();
				String V_TEL_NO = jsondata.get("TEL_NO") == null ? "" : jsondata.get("TEL_NO").toString();
				String V_BIZ_TYPE = jsondata.get("BIZ_TYPE") == null ? "" : jsondata.get("BIZ_TYPE").toString();

				String V_NAME1 = jsondata.get("NAME1") == null ? "" : jsondata.get("NAME1").toString();

				cs = conn.prepareCall("call DISTR_B_PR_USR.USP_B_PRINT_USR(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_USR_ID);//V_USR_ID2
				cs.setString(4, V_EMP_NO);//V_EMP_NO
				cs.setString(5, V_ROLL_NM);//V_ROLL_NM
				cs.setString(6, V_REQ_USR_YN);//V_REQ_USR_YN
				cs.setString(7, V_CFM_USR_YN);//V_CFM_USR_YN
				cs.setString(8, V_EMAIL);//V_EMAIL
				cs.setString(9, V_TEL_NO);//V_TEL_NO
				cs.setString(10, V_BIZ_TYPE);//V_BIZ_TYPE
				cs.setString(11, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(13, V_NAME1);//V_USR_ID
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("SUCCESS");
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


