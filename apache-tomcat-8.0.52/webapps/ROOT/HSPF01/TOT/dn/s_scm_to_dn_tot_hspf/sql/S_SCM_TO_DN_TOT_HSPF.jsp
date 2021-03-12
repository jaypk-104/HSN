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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase().substring(0, 10);
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");
		String V_GR_YN = request.getParameter("V_GR_YN") == null ? "" : request.getParameter("V_GR_YN");

		if (V_TYPE.equals("SL")) {
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
			
			cs = conn.prepareCall("call USP_003_S_SCM_TO_DN_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DN_DT);//V_DN_DT
			cs.setString(4, "");//V_DN_NO
			cs.setString(5, "");//V_DN_TYPE
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.setString(8, "");//V_DN_NO_DEL
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(10, V_S_BP_NM);//V_S_BP_NM
			cs.setString(11, V_GR_YN);//V_GR_YN
			cs.setString(12, V_DN_DT_TO);//V_DN_DT_TO
			cs.setString(13, V_ITEM_NM);//V_ITEM_NM
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(9);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("DN_TYPE", rs.getString("DN_TYPE"));
				subObject.put("DN_TYPE_NM", rs.getString("DN_TYPE_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("GR_CFM_YN", rs.getString("GR_CFM_YN"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SR")) {
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
			
			cs = conn.prepareCall("call USP_003_S_SCM_TO_DN_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DN_DT);//V_DN_DT
			cs.setString(4, "");//V_DN_NO
			cs.setString(5, "");//V_DN_TYPE
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.setString(8, "");//V_DN_NO_DEL
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(10, V_S_BP_NM);//V_S_BP_NM
			cs.setString(11, "");//V_GR_YN
			cs.setString(12, V_DN_DT_TO);//V_DN_DT_TO
			cs.setString(13, V_ITEM_NM);//V_ITEM_NM
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(9);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_DT", rs.getString("DN_DT"));
// 				subObject.put("DN_TYPE", rs.getString("DN_TYPE"));
// 				subObject.put("DN_TYPE_NM", rs.getString("DN_TYPE_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				
				subObject.put("DN_NO", rs.getString("DN_NO"));
// 				subObject.put("CC_QTY", rs.getString("CC_QTY"));
// 				subObject.put("BILL_YN", rs.getString("BILL_YN"));

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
					V_DN_DT = hashMap.get("DN_DT") == null ? "" : hashMap.get("DN_DT").toString().substring(0, 10);
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					
					if(V_TYPE.equals("LI")){
						
						cs = conn.prepareCall("call USP_003_S_SCM_TO_DN_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_DN_DT);//V_DN_DT
						cs.setString(4, "");//V_DN_NO
						cs.setString(5, "");//V_DN_TYPE
						cs.setString(6, V_ITEM_CD);//V_ITEM_CD
						cs.setString(7, V_USR_ID);//V_USR_ID
						cs.setString(8, "");//V_DN_NO_DEL
						cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(10, "");//V_S_BP_NM
						cs.setString(11, "");//V_GR_YN
						cs.setString(12, "");//
						cs.setString(13, "");//
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();
						
					} else if(V_TYPE.equals("RD")){
						String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
						
						cs = conn.prepareCall("call USP_003_S_SCM_TO_DN_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, "");//V_DN_DT
						cs.setString(4, "");//V_DN_NO
						cs.setString(5, "");//V_DN_TYPE
						cs.setString(6, V_ITEM_CD);//V_ITEM_CD
						cs.setString(7, V_USR_ID);//V_USR_ID
						cs.setString(8, V_DN_NO);//V_DN_NO_DEL
						cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(10, "");//V_S_BP_NM
						cs.setString(11, "");//V_GR_YN
						cs.setString(12, "");//
						cs.setString(13, "");//
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();
					}
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_DN_DT = jsondata.get("DN_DT") == null ? "" : jsondata.get("DN_DT").toString().substring(0, 10);
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();

				if(V_TYPE.equals("LI")){
					
					cs = conn.prepareCall("call USP_003_S_SCM_TO_DN_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_DN_DT);//V_DN_DT
					cs.setString(4, "");//V_DN_NO
					cs.setString(5, "");//V_DN_TYPE
					cs.setString(6, V_ITEM_CD);//V_ITEM_CD
					cs.setString(7, V_USR_ID);//V_USR_ID
					cs.setString(8, "");//V_DN_NO_DEL
					cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(10, "");//V_S_BP_NM
					cs.setString(11, "");//V_GR_YN
					cs.setString(12, "");//
					cs.setString(13, "");//
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
					
				} else if(V_TYPE.equals("RD")){
					String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
					
					cs = conn.prepareCall("call USP_003_S_SCM_TO_DN_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_DN_DT
					cs.setString(4, "");//V_DN_NO
					cs.setString(5, "");//V_DN_TYPE
					cs.setString(6, V_ITEM_CD);//V_ITEM_CD
					cs.setString(7, V_USR_ID);//V_USR_ID
					cs.setString(8, V_DN_NO);//V_DN_NO_DEL
					cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(10, "");//V_S_BP_NM
					cs.setString(11, "");//V_GR_YN
					cs.setString(12, "");//
					cs.setString(13, "");//
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
				}
				
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


