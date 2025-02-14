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
		String V_GR_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").toUpperCase().substring(0, 10);
		String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null ? "" : request.getParameter("V_GR_DT_TO").toUpperCase().substring(0, 10);
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");
		String V_BL_YN = request.getParameter("V_BL_YN") == null ? "" : request.getParameter("V_BL_YN");
		String V_CC_YN = request.getParameter("V_CC_YN") == null ? "" : request.getParameter("V_CC_YN");

		if(V_SL_CD.equals("T")) V_SL_CD = "";
		
		if (V_TYPE.equals("SL")) {
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
			
			cs = conn.prepareCall("call USP_003_M_SCM_TO_GR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_GR_DT);//V_GR_DT
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.setString(6, "");//V_MVMT_NO_DEL
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, V_SL_CD);//V_SL_CD
			cs.setString(9, V_BL_YN);//V_BL_YN
			cs.setString(10, V_CC_YN);//V_CC_YN
			cs.setString(11, V_GR_DT_TO);//V_GR_DT_TO
			cs.setString(12, V_ITEM_NM);//V_ITEM_NM
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("BL_YN", rs.getString("BL_YN"));
				subObject.put("CC_YN", rs.getString("CC_YN"));
				subObject.put("SL_NM", rs.getString("SL_NM"));

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
			
			cs = conn.prepareCall("call USP_003_M_SCM_TO_GR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_GR_DT);//V_GR_DT
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_USR_ID);//V_USR_ID 
			cs.setString(6, "");//V_MVMT_NO_DEL
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, V_SL_CD);//V_SL_CD
			cs.setString(9, "");//V_BL_YN
			cs.setString(10, "");//V_CC_YN
			cs.setString(11, V_GR_DT_TO);//V_GR_DT_TO
			cs.setString(12, V_ITEM_NM);//
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("CC_QTY", rs.getString("CC_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("IV_YN", rs.getString("IV_YN"));
				subObject.put("SL_NM", rs.getString("SL_NM"));

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
					V_GR_DT = hashMap.get("GR_DT") == null ? "" : hashMap.get("GR_DT").toString().substring(0, 10);
					
					if(V_TYPE.equals("LI")){
						String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						
						cs = conn.prepareCall("call USP_003_M_SCM_TO_GR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_GR_DT);//V_GR_DT
						cs.setString(4, V_ITEM_CD);//V_ITEM_CD
						cs.setString(5, V_USR_ID);//V_USR_ID 
						cs.setString(6, "");//V_MVMT_NO_DEL
						cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(8, "");//V_SL_CD
						cs.setString(9, "");//V_BL_YN
						cs.setString(10, "");//V_CC_YN
						cs.setString(11, "");//
						cs.setString(12, "");//
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();
						
					} else if(V_TYPE.equals("RI")){
						String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
						
						cs = conn.prepareCall("call USP_003_M_SCM_TO_GR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, "");//V_GR_DT
						cs.setString(4, "");//V_ITEM_CD
						cs.setString(5, V_USR_ID);//V_USR_ID 
						cs.setString(6, V_MVMT_NO);//V_MVMT_NO_DEL
						cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(8, "");//V_SL_CD
						cs.setString(9, "");//V_BL_YN
						cs.setString(10, "");//V_CC_YN
						cs.setString(11, "");//
						cs.setString(12, "");//
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
				V_GR_DT = jsondata.get("GR_DT") == null ? "" : jsondata.get("GR_DT").toString().substring(0, 10);

				if(V_TYPE.equals("LI")){
					String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					
					cs = conn.prepareCall("call USP_003_M_SCM_TO_GR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_GR_DT);//V_GR_DT
					cs.setString(4, V_ITEM_CD);//V_ITEM_CD
					cs.setString(5, V_USR_ID);//V_USR_ID
					cs.setString(6, "");//V_MVMT_NO_DEL
					cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(8, "");//V_SL_CD
					cs.setString(9, "");//V_BL_YN
					cs.setString(10, "");//V_CC_YN
					cs.setString(11, "");//
					cs.setString(12, "");//
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
					
				} else if(V_TYPE.equals("RI")){
					String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
					
					cs = conn.prepareCall("call USP_003_M_SCM_TO_GR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_GR_DT
					cs.setString(4, "");//V_ITEM_CD
					cs.setString(5, V_USR_ID);//V_USR_ID 
					cs.setString(6, V_MVMT_NO);//V_MVMT_NO_DEL
					cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(8, "");//V_SL_CD
					cs.setString(9, "");//V_BL_YN
					cs.setString(10, "");//V_CC_YN
					cs.setString(11, "");//
					cs.setString(12, "");//
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


