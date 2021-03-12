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
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
		
		
		if (V_TYPE.equals("S")) {
			String V_HOPE_DT_FROM = request.getParameter("V_HOPE_DT_FROM") == null ? "" : request.getParameter("V_HOPE_DT_FROM").substring(0,10);
			String V_HOPE_DT_TO = request.getParameter("V_HOPE_DT_TO") == null ? "" : request.getParameter("V_HOPE_DT_TO").substring(0,10);
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			
			cs = conn.prepareCall("call USP_003_SAMPLE_GR_DN_SELECT(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);// V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_HOPE_DT_FROM);//V_HOPE_DT_FROM
			cs.setString(4, V_HOPE_DT_TO);//V_HOPE_DT_TO
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MGM_NO", rs.getString("MGM_NO"));
				subObject.put("MONEY_YN", rs.getString("MONEY_YN"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("HOPE_SL_CD", rs.getString("HOPE_SL_CD"));
				subObject.put("HOPE_GR_DT", rs.getString("HOPE_GR_DT"));
				subObject.put("HOPE_GR_QTY", rs.getString("HOPE_GR_QTY"));
				subObject.put("HOPE_USR_NM", rs.getString("HOPE_USR_NM"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("SPEC", rs.getString("SPEC"));
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
		else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");
			String errorMsg = "";
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String MGM_NO = hashMap.get("MGM_NO") == null ? "" : hashMap.get("MGM_NO").toString();
					String MONEY_YN = hashMap.get("MONEY_YN") == null ? "" : hashMap.get("MONEY_YN").toString();
					String ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String SPEC = hashMap.get("SPEC") == null ? "" : hashMap.get("SPEC").toString();
					String BP_NM = hashMap.get("BP_NM") == null ? "" : hashMap.get("BP_NM").toString();
					String DEPT_NM = hashMap.get("DEPT_NM") == null ? "" : hashMap.get("DEPT_NM").toString();
					String HOPE_SL_CD = hashMap.get("HOPE_SL_CD") == null ? "" : hashMap.get("HOPE_SL_CD").toString();
					String HOPE_GR_DT = hashMap.get("HOPE_GR_DT") == null ? "" : hashMap.get("HOPE_GR_DT").toString();
					String HOPE_GR_QTY = hashMap.get("HOPE_GR_QTY") == null ? "" : hashMap.get("HOPE_GR_QTY").toString();
					String HOPE_USR_NM = hashMap.get("HOPE_USR_NM") == null ? "" : hashMap.get("HOPE_USR_NM").toString();
					String SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String GR_DT = hashMap.get("GR_DT") == null ? "" : hashMap.get("GR_DT").toString();
					String GR_QTY = hashMap.get("GR_QTY") == null ? "" : hashMap.get("GR_QTY").toString();
					String REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
		
					if(HOPE_GR_DT.length() > 10){
						HOPE_GR_DT = HOPE_GR_DT.substring(0,10);
					}
					if(GR_DT.length() > 10){
						GR_DT = GR_DT.substring(0,10);
					}
					
					cs = conn.prepareCall("call USP_003_SAMPLE_GR_DN_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //V_TYPE
					cs.setString(2, V_COMP_ID); //V_COMP_ID
					cs.setString(3, MGM_NO); //V_MGM_NO
					cs.setString(4, MONEY_YN); //V_MONEY_YN
					cs.setString(5, ITEM_NM); //V_ITEM_NM
					cs.setString(6, SPEC); //V_ITEM_NM
					cs.setString(7, BP_NM); //V_BP_NM
					cs.setString(8, DEPT_NM); //V_DEPT_NM
					cs.setString(9, HOPE_SL_CD); //V_HOPE_SL_CD
					cs.setString(10, HOPE_GR_DT); //V_HOPE_GR_DT
					cs.setString(11, HOPE_GR_QTY); //V_HOPE_GR_QTY
					cs.setString(12, HOPE_USR_NM); //V_HOPE_USR_ID
					cs.setString(13, SL_CD); //V_SL_CD
					cs.setString(14, GR_DT); //V_GR_DT
					cs.setString(15, GR_QTY); //V_GR_QTY
					cs.setString(16, REMARK); //V_REMARK
					cs.setString(17, V_USR_ID); //V_USR_ID
					
					cs.executeQuery();
						
				}
			} 
			else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);					
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String MGM_NO = jsondata.get("MGM_NO") == null ? "" : jsondata.get("MGM_NO").toString();
				String MONEY_YN = jsondata.get("MONEY_YN") == null ? "" : jsondata.get("MONEY_YN").toString();
				String ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String SPEC = jsondata.get("SPEC") == null ? "" : jsondata.get("SPEC").toString();
				String BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
				String DEPT_NM = jsondata.get("DEPT_NM") == null ? "" : jsondata.get("DEPT_NM").toString();
				String HOPE_SL_CD = jsondata.get("HOPE_SL_CD") == null ? "" : jsondata.get("HOPE_SL_CD").toString();
				String HOPE_GR_DT = jsondata.get("HOPE_GR_DT") == null ? "" : jsondata.get("HOPE_GR_DT").toString();
				String HOPE_GR_QTY = jsondata.get("HOPE_GR_QTY") == null ? "" : jsondata.get("HOPE_GR_QTY").toString();
				String HOPE_USR_NM = jsondata.get("HOPE_USR_NM") == null ? "" : jsondata.get("HOPE_USR_NM").toString();
				String SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String GR_DT = jsondata.get("GR_DT") == null ? "" : jsondata.get("GR_DT").toString();
				String GR_QTY = jsondata.get("GR_QTY") == null ? "" : jsondata.get("GR_QTY").toString();
				String REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
	
				if(HOPE_GR_DT.length() > 10){
					HOPE_GR_DT = HOPE_GR_DT.substring(0,10);
				}
				if(GR_DT.length() > 10){
					GR_DT = GR_DT.substring(0,10);
				}
				
				cs = conn.prepareCall("call USP_003_SAMPLE_GR_DN_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //V_TYPE
				cs.setString(2, V_COMP_ID); //V_COMP_ID
				cs.setString(3, MGM_NO); //V_MGM_NO
				cs.setString(4, MONEY_YN); //V_MONEY_YN
				cs.setString(5, ITEM_NM); //V_ITEM_NM
				cs.setString(6, SPEC); //V_ITEM_NM
				cs.setString(7, BP_NM); //V_BP_NM
				cs.setString(8, DEPT_NM); //V_DEPT_NM
				cs.setString(9, HOPE_SL_CD); //V_HOPE_SL_CD
				cs.setString(10, HOPE_GR_DT); //V_HOPE_GR_DT
				cs.setString(11, HOPE_GR_QTY); //V_HOPE_GR_QTY
				cs.setString(12, HOPE_USR_NM); //V_HOPE_USR_ID
				cs.setString(13, SL_CD); //V_SL_CD
				cs.setString(14, GR_DT); //V_GR_DT
				cs.setString(15, GR_QTY); //V_GR_QTY
				cs.setString(16, REMARK); //V_REMARK
				cs.setString(17, V_USR_ID); //V_USR_ID
				
				cs.executeQuery();
					
					
				
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
		jsonObject.put("success", false);
		jsonObject.put("resultList", e);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
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

<%!
// 	void callProcedure(CallableStatement cs, String V_COMP_ID, String V_TYPE) throws Exception {

// 	}

%>


