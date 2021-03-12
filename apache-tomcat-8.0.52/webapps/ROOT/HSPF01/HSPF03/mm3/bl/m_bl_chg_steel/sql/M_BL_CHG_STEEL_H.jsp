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
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_BAS_DT = request.getParameter("V_BAS_DT") == null ? "" : request.getParameter("V_BAS_DT").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_APPROV_NM = request.getParameter("V_APPROV_NM") == null ? "" : request.getParameter("V_APPROV_NM").toUpperCase();
		String V_CHG_TYPE_CD = request.getParameter("V_CHG_TYPE_CD") == null ? "" : request.getParameter("V_CHG_TYPE_CD").toUpperCase();
		String V_CHG_REMARK = request.getParameter("V_CHG_REMARK") == null ? "" : request.getParameter("V_CHG_REMARK").toUpperCase();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_001_M_BL_CHG_STEEL(?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_BL_NO);//V_BL_NO
			cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(4, V_BAS_DT);//V_BAS_DT
			cs.setString(5, V_APPROV_NO);//V_APPROV_NO
			cs.setString(6, V_APPROV_NM);//V_APPROV_NM
			cs.setString(7, V_CHG_TYPE_CD);//V_CHG_TYPE_CD
			cs.setString(8, V_CHG_REMARK);//V_CHG_REMARK
			cs.setString(9, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(10);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("V_TYPE", V_TYPE); // 수정 예정
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("BAS_DT", rs.getString("BAS_DT"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("CHG_TYPE_CD", rs.getString("CHG_TYPE_CD"));
				subObject.put("CHG_TYPE_NM", rs.getString("CHG_TYPE_NM"));
				subObject.put("CHG_REMARK", rs.getString("CHG_REMARK"));
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("P")){
			cs = conn.prepareCall("call USP_001_M_BL_CHG_STEEL(?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_BL_NO);//V_BL_NO
			cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(4, V_BAS_DT);//V_BAS_DT
			cs.setString(5, V_APPROV_NO);//V_APPROV_NO
			cs.setString(6, V_APPROV_NM);//V_APPROV_NM
			cs.setString(7, V_CHG_TYPE_CD);//V_CHG_TYPE_CD
			cs.setString(8, V_CHG_REMARK);//V_CHG_REMARK
			cs.setString(9, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(10);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		
		}else if (V_TYPE.equals("I") || V_TYPE.equals("D")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열인 경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					V_BL_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
					V_BAS_DT = hashMap.get("BAS_DT") == null ? "" : hashMap.get("BAS_DT").toString().substring(0, 10);
					V_APPROV_NO = hashMap.get("APPROV_NO") == null ? "" : hashMap.get("APPROV_NO").toString();
					V_APPROV_NM = hashMap.get("APPROV_NM") == null ? "" : hashMap.get("APPROV_NM").toString();
					V_CHG_TYPE_CD = hashMap.get("CHG_TYPE_CD") == null ? "" : hashMap.get("CHG_TYPE_CD").toString();
					V_CHG_REMARK = hashMap.get("CHG_REMARK") == null ? "" : hashMap.get("CHG_REMARK").toString();
					
					cs = conn.prepareCall("call USP_001_M_BL_CHG_STEEL(?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_BL_NO);//V_BL_NO
					cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
					cs.setString(4, V_BAS_DT);//V_BAS_DT
					cs.setString(5, V_APPROV_NO);//V_APPROV_NO
					cs.setString(6, V_APPROV_NM);//V_APPROV_NM
					cs.setString(7, V_CHG_TYPE_CD);//V_CHG_TYPE_CD
					cs.setString(8, V_CHG_REMARK);//V_CHG_REMARK
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
				JSONObject jsonItem = JSONObject.fromObject(jsonData);
				
				V_TYPE = jsonItem.get("V_TYPE") == null ? "" : jsonItem.get("V_TYPE").toString();
				V_BL_NO = jsonItem.get("BL_NO") == null ? "" : jsonItem.get("BL_NO").toString();
				V_BL_DOC_NO = jsonItem.get("BL_DOC_NO") == null ? "" : jsonItem.get("BL_DOC_NO").toString();
				V_BAS_DT = jsonItem.get("BAS_DT") == null ? "" : jsonItem.get("BAS_DT").toString().substring(0, 10);
				V_APPROV_NO = jsonItem.get("APPROV_NO") == null ? "" : jsonItem.get("APPROV_NO").toString();
				V_APPROV_NM = jsonItem.get("APPROV_NM") == null ? "" : jsonItem.get("APPROV_NM").toString();
				V_CHG_TYPE_CD = jsonItem.get("CHG_TYPE_CD") == null ? "" : jsonItem.get("CHG_TYPE_CD").toString();
				V_CHG_REMARK = jsonItem.get("CHG_REMARK") == null ? "" : jsonItem.get("CHG_REMARK").toString();
				
				cs = conn.prepareCall("call USP_001_M_BL_CHG_STEEL(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_BL_NO);//V_BL_NO
				cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
				cs.setString(4, V_BAS_DT);//V_BAS_DT
				cs.setString(5, V_APPROV_NO);//V_APPROV_NO
				cs.setString(6, V_APPROV_NM);//V_APPROV_NM
				cs.setString(7, V_CHG_TYPE_CD);//V_CHG_TYPE_CD
				cs.setString(8, V_CHG_REMARK);//V_CHG_REMARK
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


