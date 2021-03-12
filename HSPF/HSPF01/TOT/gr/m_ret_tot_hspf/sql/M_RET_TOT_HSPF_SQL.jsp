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

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? ""	: request.getParameter("V_USR_ID").toUpperCase();

// 		System.out.println("V_TYPE :" + V_TYPE);

		//상단
		if (V_TYPE.equals("SH")) {
			String V_GR_DT = request.getParameter("V_GR_DT") == null ? ""	: request.getParameter("V_GR_DT").toUpperCase();
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? ""	: request.getParameter("V_ITEM_CD").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? ""	: request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? ""	: request.getParameter("V_M_BP_NM").toUpperCase();

			if(V_GR_DT.length() > 10){
				V_GR_DT = V_GR_DT.substring(0,10);
			}
			
			cs = conn.prepareCall("call USP_003_M_RET_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_DN_DT
			cs.setString(4, "");//V_S_RET_DN_DT
			cs.setString(5, V_GR_DT);//V_MVMT_DT
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD
			cs.setString(7, V_M_BP_NM);//V_M_BP_CD
			cs.setString(8, "");//V_S_RET_YN
			cs.setString(9, "");//V_M_RET_NO2
			cs.setString(10, "");//V_M_RET_DT
			cs.setString(11, "");//V_M_RET_QTY
			cs.setString(12, "");//V_REF_MVMT_NO
			cs.setString(13, "");//V_USR_ID
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("S_RET_YN", rs.getString("S_RET_YN"));
				subObject.put("S_RET_QTY", rs.getString("S_RET_QTY"));
				subObject.put("IV_DT", rs.getString("IV_DT"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("M_RET_DT", rs.getString("M_RET_DT"));
				subObject.put("M_RET_QTY", rs.getString("M_RET_QTY"));
// 				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("STOCK_QTY", rs.getString("STOCK_QTY"));
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
		else if (V_TYPE.equals("SD")) {
			String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? ""	: request.getParameter("V_MVMT_NO").toUpperCase();
			
			
			cs = conn.prepareCall("call USP_003_M_RET_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_DN_DT
			cs.setString(4, "");//V_S_RET_DN_DT
			cs.setString(5, "");//V_MVMT_DT
			cs.setString(6, "");//V_ITEM_CD
			cs.setString(7, "");//V_M_BP_CD
			cs.setString(8, "");//V_S_RET_YN
			cs.setString(9, "");//V_M_RET_NO2
			cs.setString(10, "");//V_M_RET_DT
			cs.setString(11, "");//V_M_RET_QTY
			cs.setString(12, V_MVMT_NO);//V_REF_MVMT_NO
			cs.setString(13, "");//V_USR_ID
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_RET_NO", rs.getString("M_RET_NO"));
				subObject.put("M_RET_DT", rs.getString("M_RET_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("RET_QTY", rs.getString("RET_QTY"));
				subObject.put("IV_DT", rs.getString("IV_DT"));
				subObject.put("RET_IV_DT", rs.getString("RET_IV_DT"));
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
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			String V_DN_SEQ = "";

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String M_RET_DT = hashMap.get("M_RET_DT") == null ? "" : hashMap.get("M_RET_DT").toString();
					String M_RET_QTY = hashMap.get("M_RET_QTY") == null ? "" : hashMap.get("M_RET_QTY").toString();
					String ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();

					if(M_RET_DT.length() > 10){
						M_RET_DT = M_RET_DT.substring(0,10);
					}
					
					if (!V_TYPE.equals("")) {

						cs = conn.prepareCall("call USP_003_M_RET_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, "");//V_DN_DT
						cs.setString(4, "");//V_S_RET_DN_DT
						cs.setString(5, "");//V_MVMT_DT
						cs.setString(6, ITEM_CD);//V_ITEM_CD
						cs.setString(7, "");//V_M_BP_CD
						cs.setString(8, "");//V_S_RET_YN
						cs.setString(9, "");//V_M_RET_NO2
						cs.setString(10, M_RET_DT);//V_M_RET_DT
						cs.setString(11, M_RET_QTY);//V_M_RET_QTY
						cs.setString(12, MVMT_NO);//V_REF_MVMT_NO
						cs.setString(13, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
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
				String MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String M_RET_DT = jsondata.get("M_RET_DT") == null ? "" : jsondata.get("M_RET_DT").toString();
				String M_RET_QTY = jsondata.get("M_RET_QTY") == null ? "" : jsondata.get("M_RET_QTY").toString();
				String ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();

				if(M_RET_DT.length() > 10){
					M_RET_DT = M_RET_DT.substring(0,10);
				}
				
				
				if (!V_TYPE.equals("")) {

					cs = conn.prepareCall("call USP_003_M_RET_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_DN_DT
					cs.setString(4, "");//V_S_RET_DN_DT
					cs.setString(5, "");//V_MVMT_DT
					cs.setString(6, ITEM_CD);//V_ITEM_CD
					cs.setString(7, "");//V_M_BP_CD
					cs.setString(8, "");//V_S_RET_YN
					cs.setString(9, "");//V_M_RET_NO2
					cs.setString(10, M_RET_DT);//V_M_RET_DT
					cs.setString(11, M_RET_QTY);//V_M_RET_QTY
					cs.setString(12, MVMT_NO);//V_REF_MVMT_NO
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
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
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (cs2 != null)
			try {
				cs2.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>


