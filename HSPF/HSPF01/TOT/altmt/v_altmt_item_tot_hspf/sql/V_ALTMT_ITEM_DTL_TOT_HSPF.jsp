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
		String V_BS_YEAR = request.getParameter("V_YEAR") == null ? "" : request.getParameter("V_YEAR").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_V_ALTMT_ITEM_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 			
			cs.setString(2, V_TYPE); //V_TYPE 				
			cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
			cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
			cs.setString(5, ""); //V_SEQ 			
			cs.setString(6, ""); //V_MIX_ROLL 	
			cs.setString(7, ""); //V_LST_APPLY_PROD 			
			cs.setString(8, ""); //V_FR_INFO			
			cs.setString(9, ""); //V_ALTMT_MAKER 			
			cs.setString(10, ""); //V_ALTMT_M_BP_NM 			
			cs.setString(11, ""); //V_ALTMT_GRADE 		
			cs.setString(12, ""); //V_ALTMT_ORIGIN 		
			cs.setString(13, ""); //V_USE_YN 		
			cs.setString(14, ""); //V_NO_POS_TXT 		
			cs.setString(15, ""); //V_PROD_YN 			
			cs.setString(16, ""); //V_QC_PERIOD 			
			cs.setString(17, ""); //V_QC_DEPT 			
			cs.setString(18, ""); //V_QC_REMARK 			
			cs.setString(19, V_USR_ID); //V_USR_ID 		
			cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(20);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BS_YEAR", rs.getString("BS_YEAR"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
// 				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("MIX_ROLL", rs.getString("MIX_ROLL"));
				subObject.put("LST_APPLY_PROD", rs.getString("LST_APPLY_PROD"));
				subObject.put("FR_INFO", rs.getString("FR_INFO"));
				subObject.put("ALTMT_MAKER", rs.getString("ALTMT_MAKER"));
				subObject.put("ALTMT_M_BP_NM", rs.getString("ALTMT_M_BP_NM"));
				subObject.put("ALTMT_GRADE", rs.getString("ALTMT_GRADE"));
				subObject.put("ALTMT_ORIGIN", rs.getString("ALTMT_ORIGIN"));
				subObject.put("USE_YN", rs.getString("USE_YN"));
				subObject.put("NO_POS_TXT", rs.getString("NO_POS_TXT"));
				subObject.put("PROD_YN", rs.getString("PROD_YN"));
				subObject.put("QC_PERIOD", rs.getString("QC_PERIOD"));
				subObject.put("QC_DEPT", rs.getString("QC_DEPT"));
				subObject.put("QC_REMARK", rs.getString("QC_REMARK"));
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
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_MIX_ROLL = hashMap.get("MIX_ROLL") == null ? "" : hashMap.get("MIX_ROLL").toString();
					String V_LST_APPLY_PROD = hashMap.get("LST_APPLY_PROD") == null ? "" : hashMap.get("LST_APPLY_PROD").toString();
					String V_FR_INFO = hashMap.get("FR_INFO") == null ? "" : hashMap.get("FR_INFO").toString();
					String V_ALTMT_MAKER = hashMap.get("ALTMT_MAKER") == null ? "" : hashMap.get("ALTMT_MAKER").toString();
					String V_ALTMT_M_BP_NM = hashMap.get("ALTMT_M_BP_NM") == null ? "" : hashMap.get("ALTMT_M_BP_NM").toString();
					String V_ALTMT_GRADE = hashMap.get("ALTMT_GRADE") == null ? "" : hashMap.get("ALTMT_GRADE").toString();
					String V_ALTMT_ORIGIN = hashMap.get("ALTMT_ORIGIN") == null ? "" : hashMap.get("ALTMT_ORIGIN").toString();
					String V_USE_YN = hashMap.get("USE_YN") == null ? "" : hashMap.get("USE_YN").toString();
					String V_NO_POS_TXT = hashMap.get("NO_POS_TXT") == null ? "" : hashMap.get("NO_POS_TXT").toString();
					String V_PROD_YN = hashMap.get("PROD_YN") == null ? "" : hashMap.get("PROD_YN").toString();
					String V_QC_PERIOD = hashMap.get("QC_PERIOD") == null ? "" : hashMap.get("QC_PERIOD").toString();
					String V_QC_DEPT = hashMap.get("QC_DEPT") == null ? "" : hashMap.get("QC_DEPT").toString();
					String V_QC_REMARK = hashMap.get("QC_REMARK") == null ? "" : hashMap.get("QC_REMARK").toString();

					cs = conn.prepareCall("call USP_V_ALTMT_ITEM_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID); //V_COMP_ID 			
					cs.setString(2, V_TYPE); //V_TYPE 				
					cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
					cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
					cs.setString(5, V_SEQ); //V_SEQ 			
					cs.setString(6, V_MIX_ROLL); //V_MIX_ROLL 	
					cs.setString(7, V_LST_APPLY_PROD ); //V_LST_APPLY_PROD 			
					cs.setString(8, V_FR_INFO); //V_FR_INFO			
					cs.setString(9, V_ALTMT_MAKER); //V_ALTMT_MAKER 			
					cs.setString(10, V_ALTMT_M_BP_NM); //V_ALTMT_M_BP_NM 			
					cs.setString(11, V_ALTMT_GRADE); //V_ALTMT_GRADE 		
					cs.setString(12, V_ALTMT_ORIGIN); //V_ALTMT_ORIGIN 		
					cs.setString(13, V_USE_YN); //V_USE_YN 		
					cs.setString(14, V_NO_POS_TXT); //V_NO_POS_TXT 		
					cs.setString(15, V_PROD_YN); //V_PROD_YN 			
					cs.setString(16, V_QC_PERIOD); //V_QC_PERIOD 			
					cs.setString(17, V_QC_DEPT); //V_QC_DEPT 			
					cs.setString(18, V_QC_REMARK); //V_QC_REMARK 			
					cs.setString(19, V_USR_ID); //V_USR_ID 		
					cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_MIX_ROLL = jsondata.get("MIX_ROLL") == null ? "" : jsondata.get("MIX_ROLL").toString();
				String V_LST_APPLY_PROD = jsondata.get("LST_APPLY_PROD") == null ? "" : jsondata.get("LST_APPLY_PROD").toString();
				String V_FR_INFO = jsondata.get("FR_INFO") == null ? "" : jsondata.get("FR_INFO").toString();
				String V_ALTMT_MAKER = jsondata.get("ALTMT_MAKER") == null ? "" : jsondata.get("ALTMT_MAKER").toString();
				String V_ALTMT_M_BP_NM = jsondata.get("ALTMT_M_BP_NM") == null ? "" : jsondata.get("ALTMT_M_BP_NM").toString();
				String V_ALTMT_GRADE = jsondata.get("ALTMT_GRADE") == null ? "" : jsondata.get("ALTMT_GRADE").toString();
				String V_ALTMT_ORIGIN = jsondata.get("ALTMT_ORIGIN") == null ? "" : jsondata.get("ALTMT_ORIGIN").toString();
				String V_USE_YN = jsondata.get("USE_YN") == null ? "" : jsondata.get("USE_YN").toString();
				String V_NO_POS_TXT = jsondata.get("NO_POS_TXT") == null ? "" : jsondata.get("NO_POS_TXT").toString();
				String V_PROD_YN = jsondata.get("PROD_YN") == null ? "" : jsondata.get("PROD_YN").toString();
				String V_QC_PERIOD = jsondata.get("QC_PERIOD") == null ? "" : jsondata.get("QC_PERIOD").toString();
				String V_QC_DEPT = jsondata.get("QC_DEPT") == null ? "" : jsondata.get("QC_DEPT").toString();
				String V_QC_REMARK = jsondata.get("QC_REMARK") == null ? "" : jsondata.get("QC_REMARK").toString();
				
				cs = conn.prepareCall("call USP_V_ALTMT_ITEM_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID); //V_COMP_ID 			
				cs.setString(2, V_TYPE); //V_TYPE 				
				cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
				cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
				cs.setString(5, V_SEQ); //V_SEQ 			
				cs.setString(6, V_MIX_ROLL); //V_MIX_ROLL 	
				cs.setString(7, V_LST_APPLY_PROD ); //V_LST_APPLY_PROD 			
				cs.setString(8, V_FR_INFO); //V_FR_INFO			
				cs.setString(9, V_ALTMT_MAKER); //V_ALTMT_MAKER 			
				cs.setString(10, V_ALTMT_M_BP_NM); //V_ALTMT_M_BP_NM 			
				cs.setString(11, V_ALTMT_GRADE); //V_ALTMT_GRADE 		
				cs.setString(12, V_ALTMT_ORIGIN); //V_ALTMT_ORIGIN 		
				cs.setString(13, V_USE_YN); //V_USE_YN 		
				cs.setString(14, V_NO_POS_TXT); //V_NO_POS_TXT 		
				cs.setString(15, V_PROD_YN); //V_PROD_YN 			
				cs.setString(16, V_QC_PERIOD); //V_QC_PERIOD 			
				cs.setString(17, V_QC_DEPT); //V_QC_DEPT 			
				cs.setString(18, V_QC_REMARK); //V_QC_REMARK 			
				cs.setString(19, V_USR_ID); //V_USR_ID 		
				cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
			pw.flush();
			pw.close();
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

<%!

%>


