<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD");
		String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM");

		//조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_B_BIZ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BP_CD);//W_BP_CD
			cs.setString(4, V_BP_NM);//W_BP_NM
			cs.setString(5, "");//W_REG_NO
			cs.setString(6, "");//W_REG_NM
			cs.setString(7, "");//W_IND_TYPE
			cs.setString(8, "");//W_IND_CLASS
			cs.setString(9, "");//W_ADDRESS
			cs.setString(10, "");//W_TEL_NO
			cs.setString(11, "");//W_FAX_NO
			cs.setString(12, "");//W_EMAIL
			cs.setString(13, "");//W_BIZ_TYPE
			cs.setString(14, "");//V_REMARK
			cs.setString(15, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BP_REGNO", rs.getString("BP_REGNO"));
				subObject.put("REG_NM", rs.getString("REG_NM"));
				subObject.put("IND_TYPE", rs.getString("IND_TYPE"));
				subObject.put("IND_CLASS", rs.getString("IND_CLASS"));
				subObject.put("ADDRESS", rs.getString("ADDRESS"));
				subObject.put("TEL_NO", rs.getString("TEL_NO"));
				subObject.put("FAX_NO", rs.getString("FAX_NO"));
				subObject.put("EMAIL", rs.getString("EMAIL"));
				subObject.put("BIZ_TYPE", rs.getString("BIZ_TYPE"));
				subObject.put("BIZ_TYPE_NM", rs.getString("BIZ_TYPE_NM"));
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
			//수정
		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString().toUpperCase();
					V_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString().toUpperCase();
					V_BP_NM = hashMap.get("BP_NM") == null ? "" : hashMap.get("BP_NM").toString().toUpperCase();
					String V_ADDRESS = hashMap.get("ADDRESS") == null ? "" : hashMap.get("ADDRESS").toString().toUpperCase();
					String V_TEL_NO = hashMap.get("TEL_NO") == null ? "" : hashMap.get("TEL_NO").toString().toUpperCase();
					String V_FAX_NO = hashMap.get("FAX_NO") == null ? "" : hashMap.get("FAX_NO").toString().toUpperCase();
					String V_EMAIL = hashMap.get("EMAIL") == null ? "" : hashMap.get("EMAIL").toString();
					String V_BIZ_TYPE = hashMap.get("BIZ_TYPE") == null ? "" : hashMap.get("BIZ_TYPE").toString().toUpperCase();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString().toUpperCase();
					
					String V_BP_REGNO = hashMap.get("BP_REGNO") == null ? "" : hashMap.get("BP_REGNO").toString().toUpperCase();
					String V_REG_NM = hashMap.get("REG_NM") == null ? "" : hashMap.get("REG_NM").toString().toUpperCase();
					String V_IND_TYPE = hashMap.get("IND_TYPE") == null ? "" : hashMap.get("IND_TYPE").toString().toUpperCase();
					String V_IND_CLASS = hashMap.get("IND_CLASS") == null ? "" : hashMap.get("IND_CLASS").toString().toUpperCase();
					

					cs = conn.prepareCall("call USP_B_BIZ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_BP_CD);//V_BP_CD
					cs.setString(4, V_BP_NM);//V_BP_NM
					cs.setString(5, V_BP_REGNO);//W_REG_NO
					cs.setString(6, V_REG_NM);//W_REG_NM
					cs.setString(7, V_IND_TYPE);//W_IND_TYPE
					cs.setString(8, V_IND_CLASS);//W_IND_CLASS
					cs.setString(9, V_ADDRESS);//V_ADDRESS
					cs.setString(10, V_TEL_NO);//V_TEL_NO
					cs.setString(11, V_FAX_NO);//V_FAX_NO
					cs.setString(12, V_EMAIL);//V_EMAIL
					cs.setString(13, V_BIZ_TYPE);//V_BIZ_TYPE
					cs.setString(14, V_REMARK);//V_REMARK
					cs.setString(15, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString().toUpperCase();
				V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString().toUpperCase();
				V_BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString().toUpperCase();
				String V_ADDRESS = jsondata.get("ADDRESS") == null ? "" : jsondata.get("ADDRESS").toString().toUpperCase();
				String V_TEL_NO = jsondata.get("TEL_NO") == null ? "" : jsondata.get("TEL_NO").toString().toUpperCase();
				String V_FAX_NO = jsondata.get("FAX_NO") == null ? "" : jsondata.get("FAX_NO").toString().toUpperCase();
				String V_EMAIL = jsondata.get("EMAIL") == null ? "" : jsondata.get("EMAIL").toString();
				String V_BIZ_TYPE = jsondata.get("BIZ_TYPE") == null ? "" : jsondata.get("BIZ_TYPE").toString().toUpperCase();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString().toUpperCase();

				String V_BP_REGNO = jsondata.get("BP_REGNO") == null ? "" : jsondata.get("BP_REGNO").toString().toUpperCase();
				String V_REG_NM = jsondata.get("REG_NM") == null ? "" : jsondata.get("REG_NM").toString().toUpperCase();
				String V_IND_TYPE = jsondata.get("IND_TYPE") == null ? "" : jsondata.get("IND_TYPE").toString().toUpperCase();
				String V_IND_CLASS = jsondata.get("IND_CLASS") == null ? "" : jsondata.get("IND_CLASS").toString().toUpperCase();
				
				
				cs = conn.prepareCall("call USP_B_BIZ_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_BP_CD);//V_BP_CD
				cs.setString(4, V_BP_NM);//V_BP_NM
				cs.setString(5, V_BP_REGNO);//W_REG_NO
				cs.setString(6, V_REG_NM);//W_REG_NM
				cs.setString(7, V_IND_TYPE);//W_IND_TYPE
				cs.setString(8, V_IND_CLASS);//W_IND_CLASS
				cs.setString(9, V_ADDRESS);//V_ADDRESS
				cs.setString(10, V_TEL_NO);//V_TEL_NO
				cs.setString(11, V_FAX_NO);//V_FAX_NO
				cs.setString(12, V_EMAIL);//V_EMAIL
				cs.setString(13, V_BIZ_TYPE);//V_BIZ_TYPE
				cs.setString(14, V_REMARK);//V_REMARK
				cs.setString(15, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
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


