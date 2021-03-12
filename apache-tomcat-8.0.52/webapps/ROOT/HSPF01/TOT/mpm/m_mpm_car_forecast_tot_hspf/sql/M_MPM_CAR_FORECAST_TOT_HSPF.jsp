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
		String V_YYYYMM = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE").replace("-", "").substring(0, 6);
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_M_MPM_CAR_FORECAST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_UPLOAD_NO
			cs.setString(4, V_YYYYMM);//V_YYYYMM
			cs.setString(5, V_ITEM_CD);//V_ITEM_CD
			cs.setString(6, V_ITEM_NM);//V_ITEM_NM
			cs.setString(7, "");//V_QTY
			cs.setString(8, "");//V_NEXT1_QTY
			cs.setString(9, "");//V_NEXT2_QTY
			cs.setString(10, "");//V_NEXT3_QTY
			cs.setString(11, "");//V_NEXT4_QTY
			cs.setString(12, "");//V_NEXT5_QTY
			cs.setString(13, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(14);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("YYYYMM", rs.getString("YYYYMM"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("NEXT1_QTY", rs.getString("NEXT1_QTY"));
				subObject.put("NEXT2_QTY", rs.getString("NEXT2_QTY"));
				subObject.put("NEXT3_QTY", rs.getString("NEXT3_QTY"));
				subObject.put("NEXT4_QTY", rs.getString("NEXT4_QTY"));
				subObject.put("NEXT5_QTY", rs.getString("NEXT5_QTY"));
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
			String V_UPLOAD_NO = "";
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					String V_NEXT1_QTY = hashMap.get("NEXT1_QTY") == null ? "" : hashMap.get("NEXT1_QTY").toString();
					String V_NEXT2_QTY = hashMap.get("NEXT2_QTY") == null ? "" : hashMap.get("NEXT2_QTY").toString();
					String V_NEXT3_QTY = hashMap.get("NEXT3_QTY") == null ? "" : hashMap.get("NEXT3_QTY").toString();
					String V_NEXT4_QTY = hashMap.get("NEXT4_QTY") == null ? "" : hashMap.get("NEXT4_QTY").toString();
					String V_NEXT5_QTY = hashMap.get("NEXT5_QTY") == null ? "" : hashMap.get("NEXT5_QTY").toString();
					
					if(V_TYPE.equals("I") && i==0){
						cs = conn.prepareCall("call USP_003_M_MPM_CAR_FORECAST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, "H");//V_TYPE
						cs.setString(3, "");//V_UPLOAD_NO
						cs.setString(4, V_YYYYMM);//V_YYYYMM
						cs.setString(5, V_ITEM_CD);//V_ITEM_CD
						cs.setString(6, "");//V_ITEM_NM
						cs.setString(7, "");//V_QTY
						cs.setString(8, "");//V_NEXT1_QTY
						cs.setString(9, "");//V_NEXT2_QTY
						cs.setString(10, "");//V_NEXT3_QTY
						cs.setString(11, "");//V_NEXT4_QTY
						cs.setString(12, "");//V_NEXT5_QTY
						cs.setString(13, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(14);
						if (rs.next()) {
							V_UPLOAD_NO = rs.getString("res");
						}
					}
					
					cs = conn.prepareCall("call USP_003_M_MPM_CAR_FORECAST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_UPLOAD_NO);//V_UPLOAD_NO
					cs.setString(4, V_YYYYMM);//V_YYYYMM
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, "");//V_ITEM_NM
					cs.setString(7, V_QTY);//V_QTY
					cs.setString(8, V_NEXT1_QTY);//V_NEXT1_QTY
					cs.setString(9, V_NEXT2_QTY);//V_NEXT2_QTY
					cs.setString(10, V_NEXT3_QTY);//V_NEXT3_QTY
					cs.setString(11, V_NEXT4_QTY);//V_NEXT4_QTY
					cs.setString(12, V_NEXT5_QTY);//V_NEXT5_QTY
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
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

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
				String V_NEXT1_QTY = jsondata.get("NEXT1_QTY") == null ? "" : jsondata.get("NEXT1_QTY").toString();
				String V_NEXT2_QTY = jsondata.get("NEXT2_QTY") == null ? "" : jsondata.get("NEXT2_QTY").toString();
				String V_NEXT3_QTY = jsondata.get("NEXT3_QTY") == null ? "" : jsondata.get("NEXT3_QTY").toString();
				String V_NEXT4_QTY = jsondata.get("NEXT4_QTY") == null ? "" : jsondata.get("NEXT4_QTY").toString();
				String V_NEXT5_QTY = jsondata.get("NEXT5_QTY") == null ? "" : jsondata.get("NEXT5_QTY").toString();
				
				if(V_TYPE.equals("I")){
					cs = conn.prepareCall("call USP_003_M_MPM_CAR_FORECAST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, "H");//V_TYPE
					cs.setString(3, "");//V_UPLOAD_NO
					cs.setString(4, V_YYYYMM);//V_YYYYMM
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, "");//V_ITEM_NM
					cs.setString(7, "");//V_QTY
					cs.setString(8, "");//V_NEXT1_QTY
					cs.setString(9, "");//V_NEXT2_QTY
					cs.setString(10, "");//V_NEXT3_QTY
					cs.setString(11, "");//V_NEXT4_QTY
					cs.setString(12, "");//V_NEXT5_QTY
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
					
					rs = (ResultSet) cs.getObject(14);
					if (rs.next()) {
						V_UPLOAD_NO = rs.getString("res");
					}
				}
				
				cs = conn.prepareCall("call USP_003_M_MPM_CAR_FORECAST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_UPLOAD_NO);//V_UPLOAD_NO
				cs.setString(4, V_YYYYMM);//V_YYYYMM
				cs.setString(5, V_ITEM_CD);//V_ITEM_CD
				cs.setString(6, "");//V_ITEM_NM
				cs.setString(7, V_QTY);//V_QTY
				cs.setString(8, V_NEXT1_QTY);//V_NEXT1_QTY
				cs.setString(9, V_NEXT2_QTY);//V_NEXT2_QTY
				cs.setString(10, V_NEXT3_QTY);//V_NEXT3_QTY
				cs.setString(11, V_NEXT4_QTY);//V_NEXT4_QTY
				cs.setString(12, V_NEXT5_QTY);//V_NEXT5_QTY
				cs.setString(13, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			}

		} else if (V_TYPE.equals("C")) {
			cs = conn.prepareCall("call USP_003_M_MPM_CAR_FORECAST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_UPLOAD_NO
			cs.setString(4, V_YYYYMM);//V_YYYYMM
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_ITEM_NM
			cs.setString(7, "");//V_QTY
			cs.setString(8, "");//V_NEXT1_QTY
			cs.setString(9, "");//V_NEXT2_QTY
			cs.setString(10, "");//V_NEXT3_QTY
			cs.setString(11, "");//V_NEXT4_QTY
			cs.setString(12, "");//V_NEXT5_QTY
			cs.setString(13, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
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
