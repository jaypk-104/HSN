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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		//조회
		if (V_TYPE.equals("HS")) {
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			
			cs = conn.prepareCall("call USP_Q_BASE_MASTER(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_ITEM_CD); //V_ITEM_CD
			cs.setString(4, ""); //V_M_BP_CD
			cs.setString(5, ""); //V_HS_USR_ID
			cs.setString(6, ""); //V_USE_YN
			cs.setString(7, ""); //V_USR_ID
			
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("Q_ID", rs.getString("Q_ID"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("REV_NO", rs.getString("REV_NO"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("HS_USR_ID", rs.getString("HS_USR_ID"));
				subObject.put("INSRT_USR_ID", rs.getString("INSRT_USR_ID"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				

				jsonArray.add(subObject);
			}
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}
		else if(V_TYPE.equals("HI")){
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			if (data.contains("%")) {
				data = data.replaceAll("%", "percent");
			} else if (data.contains("/")) {
				data = data.replaceAll("/", ",");
			}
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String ITEM_CD  = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String M_BP_CD  = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String HS_USR_ID  = hashMap.get("HS_USR_ID") == null ? "" : hashMap.get("HS_USR_ID").toString();
					String REV_NO  = hashMap.get("REV_NO") == null ? "" : hashMap.get("REV_NO").toString();

					if(V_TYPE.equals("HI")){
						cs = conn.prepareCall("call USP_Q_BASE_MASTER(?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);
						cs.setString(2, V_COMP_ID);
						cs.setString(3, ITEM_CD); //V_ITEM_CD
						cs.setString(4, M_BP_CD); //V_M_BP_CD
						cs.setString(5, HS_USR_ID); //V_HS_USR_ID
						cs.setString(6, ""); //V_USE_YN
						cs.setString(7, V_USR_ID); //V_USR_ID
						
						cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String ITEM_CD  = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String M_BP_CD  = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String HS_USR_ID  = jsondata.get("HS_USR_ID") == null ? "" : jsondata.get("HS_USR_ID").toString();
				String REV_NO  = jsondata.get("REV_NO") == null ? "" : jsondata.get("REV_NO").toString();

				if(V_TYPE.equals("HI")){
					cs = conn.prepareCall("call USP_Q_BASE_MASTER(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_COMP_ID);
					cs.setString(3, ITEM_CD); //V_ITEM_CD
					cs.setString(4, M_BP_CD); //V_M_BP_CD
					cs.setString(5, HS_USR_ID); //V_HS_USR_ID
					cs.setString(6, ""); //V_USE_YN
					cs.setString(7, V_USR_ID); //V_USR_ID
					
					cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
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


