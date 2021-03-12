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
			cs = conn.prepareCall("call USP_V_ALTMT_ITEM_MST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 			
			cs.setString(2, V_TYPE); //V_TYPE 				
			cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
			cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
			cs.setString(5, ""); //V_ITEM_NM 			
			cs.setString(6, ""); //V_GROUP_TYPE_CD 	
			cs.setString(7, ""); //V_IV_TYPE 			
			cs.setString(8, ""); //V_M_BP_CD			
			cs.setString(9, ""); //V_MAKER 			
			cs.setString(10, ""); //V_ORIGIN 			
			cs.setString(11, ""); //V_REGION_FT 		
			cs.setString(12, ""); //V_CAPA_MT_YR 		
			cs.setString(13, ""); //V_OLD_ITEM_CD 		
			cs.setString(14, ""); //V_HSM_ITEM_CD 		
			cs.setString(15, ""); //V_GRADE 			
			cs.setString(16, ""); //V_MNTH_USE 			
			cs.setString(17, ""); //V_SL_PER 			
			cs.setString(18, ""); //V_FL_PER 			
			cs.setString(19, ""); //V_MAT_DEV_PER 		
			cs.setString(20, ""); //V_TPE_PER 			
			cs.setString(21, ""); //V_EXWILL_PER 		
			cs.setString(22, ""); //V_APPLY_ITEM_CD
			cs.setString(23, V_USR_ID); //V_USR_ID 	
			cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(24);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BS_YEAR", rs.getString("BS_YEAR"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("GROUP_TYPE_CD", rs.getString("GROUP_TYPE_CD"));
				subObject.put("GROUP_TYPE_NM", rs.getString("GROUP_TYPE_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("BP_NM"));
				subObject.put("MAKER", rs.getString("MAKER"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("REGION_FT", rs.getString("REGION_FT"));
				subObject.put("CAPA_MT_YR", rs.getString("CAPA_MT_YR"));
				subObject.put("OLD_ITEM_CD", rs.getString("OLD_ITEM_CD"));
				subObject.put("HSM_ITEM_CD", rs.getString("HSM_ITEM_CD"));
				subObject.put("GRADE", rs.getString("GRADE"));
				subObject.put("MNTH_USE", rs.getString("MNTH_USE"));
				subObject.put("SL_PER", rs.getString("SL_PER"));
				subObject.put("FL_PER", rs.getString("FL_PER"));
				subObject.put("MAT_DEV_PER", rs.getString("MAT_DEV_PER"));
				subObject.put("TPE_PER", rs.getString("TPE_PER"));
				subObject.put("EXWILL_PER", rs.getString("EXWILL_PER"));
				subObject.put("APPLY_ITEM_CD", rs.getString("APPLY_ITEM_CD"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("T")) {
			cs = conn.prepareCall("call USP_V_ALTMT_ITEM_MST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 			
			cs.setString(2, V_TYPE); //V_TYPE 				
			cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
			cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
			cs.setString(5, ""); //V_ITEM_NM 			
			cs.setString(6, ""); //V_GROUP_TYPE_CD 	
			cs.setString(7, ""); //V_IV_TYPE 			
			cs.setString(8, ""); //V_M_BP_CD			
			cs.setString(9, ""); //V_MAKER 			
			cs.setString(10, ""); //V_ORIGIN 			
			cs.setString(11, ""); //V_REGION_FT 		
			cs.setString(12, ""); //V_CAPA_MT_YR 		
			cs.setString(13, ""); //V_OLD_ITEM_CD 		
			cs.setString(14, ""); //V_HSM_ITEM_CD 		
			cs.setString(15, ""); //V_GRADE 			
			cs.setString(16, ""); //V_MNTH_USE 			
			cs.setString(17, ""); //V_SL_PER 			
			cs.setString(18, ""); //V_FL_PER 			
			cs.setString(19, ""); //V_MAT_DEV_PER 		
			cs.setString(20, ""); //V_TPE_PER 			
			cs.setString(21, ""); //V_EXWILL_PER 		
			cs.setString(22, ""); //V_APPLY_ITEM_CD
			cs.setString(23, V_USR_ID); //V_USR_ID 	
			cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
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
					String V_HSM_ITEM_CD = hashMap.get("HSM_ITEM_CD") == null ? "" : hashMap.get("HSM_ITEM_CD").toString();
					String V_OLD_ITEM_CD = hashMap.get("OLD_ITEM_CD") == null ? "" : hashMap.get("OLD_ITEM_CD").toString();
					String V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String V_GROUP_TYPE_CD = hashMap.get("GROUP_TYPE_CD") == null ? "" : hashMap.get("GROUP_TYPE_CD").toString();
					String V_GRADE = hashMap.get("GRADE") == null ? "" : hashMap.get("GRADE").toString();
					String V_IV_TYPE = hashMap.get("IV_TYPE") == null ? "" : hashMap.get("IV_TYPE").toString();
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String V_MAKER = hashMap.get("MAKER") == null ? "" : hashMap.get("MAKER").toString();
					String V_ORIGIN = hashMap.get("ORIGIN") == null ? "" : hashMap.get("ORIGIN").toString();
					String V_REGION_FT = hashMap.get("REGION_FT") == null ? "" : hashMap.get("REGION_FT").toString();
					String V_CAPA_MT_YR = hashMap.get("CAPA_MT_YR") == null ? "" : hashMap.get("CAPA_MT_YR").toString();
					String V_MNTH_USE = hashMap.get("MNTH_USE") == null ? "" : hashMap.get("MNTH_USE").toString();
					
					String V_SL_PER = hashMap.get("SL_PER") == null ? "" : hashMap.get("SL_PER").toString();
					String V_FL_PER = hashMap.get("FL_PER") == null ? "" : hashMap.get("FL_PER").toString();
					String V_MAT_DEV_PER = hashMap.get("MAT_DEV_PER") == null ? "" : hashMap.get("MAT_DEV_PER").toString();
					String V_TPE_PER = hashMap.get("TPE_PER") == null ? "" : hashMap.get("TPE_PER").toString();
					String V_EXWILL_PER = hashMap.get("EXWILL_PER") == null ? "" : hashMap.get("EXWILL_PER").toString();

					cs = conn.prepareCall("call USP_V_ALTMT_ITEM_MST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID); //V_COMP_ID 			
					cs.setString(2, V_TYPE); //V_TYPE 				
					cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
					cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
					cs.setString(5, V_ITEM_NM); //V_ITEM_NM 			
					cs.setString(6, V_GROUP_TYPE_CD); //V_GROUP_TYPE_CD 	
					cs.setString(7, V_IV_TYPE); //V_IV_TYPE 			
					cs.setString(8, V_M_BP_CD); //V_M_BP_CD			
					cs.setString(9, V_MAKER); //V_MAKER 			
					cs.setString(10, V_ORIGIN); //V_ORIGIN 			
					cs.setString(11, V_REGION_FT); //V_REGION_FT 		
					cs.setString(12, V_CAPA_MT_YR); //V_CAPA_MT_YR 		
					cs.setString(13, V_OLD_ITEM_CD); //V_OLD_ITEM_CD 		
					cs.setString(14, V_HSM_ITEM_CD); //V_HSM_ITEM_CD 		
					cs.setString(15, V_GRADE); //V_GRADE 			
					cs.setString(16, V_MNTH_USE); //V_MNTH_USE 			
					cs.setString(17, V_SL_PER); //V_SL_PER 			
					cs.setString(18, V_FL_PER); //V_FL_PER 			
					cs.setString(19, V_MAT_DEV_PER); //V_MAT_DEV_PER 		
					cs.setString(20, V_TPE_PER); //V_TPE_PER 			
					cs.setString(21, V_EXWILL_PER); //V_EXWILL_PER 		
					cs.setString(22, ""); //V_APPLY_ITEM_CD
					cs.setString(23, V_USR_ID); //V_USR_ID 	
					cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_HSM_ITEM_CD = jsondata.get("HSM_ITEM_CD") == null ? "" : jsondata.get("HSM_ITEM_CD").toString();
				String V_OLD_ITEM_CD = jsondata.get("OLD_ITEM_CD") == null ? "" : jsondata.get("OLD_ITEM_CD").toString();
				String V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String V_GROUP_TYPE_CD = jsondata.get("GROUP_TYPE_CD") == null ? "" : jsondata.get("GROUP_TYPE_CD").toString();
				String V_GRADE = jsondata.get("GRADE") == null ? "" : jsondata.get("GRADE").toString();
				String V_IV_TYPE = jsondata.get("IV_TYPE") == null ? "" : jsondata.get("IV_TYPE").toString();
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String V_MAKER = jsondata.get("MAKER") == null ? "" : jsondata.get("MAKER").toString();
				String V_ORIGIN = jsondata.get("ORIGIN") == null ? "" : jsondata.get("ORIGIN").toString();
				String V_REGION_FT = jsondata.get("REGION_FT") == null ? "" : jsondata.get("REGION_FT").toString();
				String V_CAPA_MT_YR = jsondata.get("CAPA_MT_YR") == null ? "" : jsondata.get("CAPA_MT_YR").toString();
				String V_MNTH_USE = jsondata.get("MNTH_USE") == null ? "" : jsondata.get("MNTH_USE").toString();
				
				String V_SL_PER = jsondata.get("SL_PER") == null ? "" : jsondata.get("SL_PER").toString();
				String V_FL_PER = jsondata.get("FL_PER") == null ? "" : jsondata.get("FL_PER").toString();
				String V_MAT_DEV_PER = jsondata.get("MAT_DEV_PER") == null ? "" : jsondata.get("MAT_DEV_PER").toString();
				String V_TPE_PER = jsondata.get("TPE_PER") == null ? "" : jsondata.get("TPE_PER").toString();
				String V_EXWILL_PER = jsondata.get("EXWILL_PER") == null ? "" : jsondata.get("EXWILL_PER").toString();
				
				cs = conn.prepareCall("call USP_V_ALTMT_ITEM_MST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID); //V_COMP_ID 			
				cs.setString(2, V_TYPE); //V_TYPE 				
				cs.setString(3, V_BS_YEAR); //V_BS_YEAR 			
				cs.setString(4, V_ITEM_CD); //V_ITEM_CD 			
				cs.setString(5, V_ITEM_NM); //V_ITEM_NM 			
				cs.setString(6, V_GROUP_TYPE_CD); //V_GROUP_TYPE_CD 	
				cs.setString(7, V_IV_TYPE); //V_IV_TYPE 			
				cs.setString(8, V_M_BP_CD); //V_M_BP_CD			
				cs.setString(9, V_MAKER); //V_MAKER 			
				cs.setString(10, V_ORIGIN); //V_ORIGIN 			
				cs.setString(11, V_REGION_FT); //V_REGION_FT 		
				cs.setString(12, V_CAPA_MT_YR); //V_CAPA_MT_YR 		
				cs.setString(13, V_OLD_ITEM_CD); //V_OLD_ITEM_CD 		
				cs.setString(14, V_HSM_ITEM_CD); //V_HSM_ITEM_CD 		
				cs.setString(15, V_GRADE); //V_GRADE 			
				cs.setString(16, V_MNTH_USE); //V_MNTH_USE 			
				cs.setString(17, V_SL_PER); //V_SL_PER 			
				cs.setString(18, V_FL_PER); //V_FL_PER 			
				cs.setString(19, V_MAT_DEV_PER); //V_MAT_DEV_PER 		
				cs.setString(20, V_TPE_PER); //V_TPE_PER 			
				cs.setString(21, V_EXWILL_PER); //V_EXWILL_PER 		
				cs.setString(22, ""); //V_APPLY_ITEM_CD
				cs.setString(23, V_USR_ID); //V_USR_ID 	
				cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
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


