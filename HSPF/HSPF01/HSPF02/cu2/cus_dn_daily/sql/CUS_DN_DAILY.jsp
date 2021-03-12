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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").substring(0, 10);
		String V_SP_TYPE = request.getParameter("V_SP_TYPE") == null ? "" : request.getParameter("V_SP_TYPE").toUpperCase();

		// 		System.out.println("V_BL_DOC_NO" + V_BL_DOC_NO);

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call DISTR_CUST.USP_CUST_DN(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_TYPE
			cs.setString(2, V_DN_DT);//V_COMP_ID
			cs.setString(3, V_S_BP_CD);//V_SL_CD
			cs.setString(4, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("REGION_NM", rs.getString("REGION_NM"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
				subObject.put("DN_BOX_WGT_UNIT", rs.getString("DN_BOX_WGT_UNIT"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_REAL_QTY", rs.getString("DN_REAL_QTY"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_REQ_PRC", rs.getString("DN_REQ_PRC"));
				subObject.put("DN_LOC_AMT", rs.getString("DN_LOC_AMT"));
				subObject.put("DN_FINAL_AMT", rs.getString("DN_FINAL_AMT"));
				subObject.put("IN_AMT", rs.getString("IN_AMT"));
				subObject.put("NON_IN_AMT", rs.getString("NON_IN_AMT"));
				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
				subObject.put("DIFF_AMT", rs.getString("DIFF_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

// 			System.out.println(jsonObject);

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

			// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String V_BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null || hashMap.get("DN_QTY").equals("null") ? "0" : hashMap.get("DN_QTY").toString();
					String V_DN_BOX_QTY = hashMap.get("DN_REQ_BOX_QTY") == null || hashMap.get("DN_REQ_BOX_QTY").equals("null") ? "0" : hashMap.get("DN_REQ_BOX_QTY").toString();
					String V_DN_REQ_DT = hashMap.get("DN_REQ_DT") == null ? "" : hashMap.get("DN_REQ_DT").toString().substring(0, 10);

					if (V_SP_TYPE.equals("DN_REQ")) {
						cs = conn.prepareCall("call DISTR_CUST.USP_CUST_DN_REQ(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_TYPE
						cs.setString(2, V_TYPE);//V_COMP_ID
						cs.setString(3, V_S_BP_CD);//V_SL_CD
						cs.setString(4, "");//V_BL_DOC_NO
						cs.setString(5, V_ITEM_NM);//V_SL_DT
						cs.setString(6, V_SL_CD);//V_SL_LOC
						cs.setString(7, V_BL_NO);//V_BL_NO
						cs.setString(8, V_BL_SEQ);//V_BL_SEQ
						cs.setString(9, V_MVMT_NO);//V_MVMT_NO
						cs.setString(10, V_DN_QTY);//V_DN_QTY
						cs.setString(11, V_DN_BOX_QTY);//V_DN_BOX_QTY
						cs.setString(12, V_DN_REQ_DT);//V_DN_REQ_DT
						cs.setString(13, V_USR_ID);//V_REF_NO
						cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					} else if (V_SP_TYPE.equals("CC_REQ")) {
						cs = conn.prepareCall("call DISTR_CUST.USP_CUST_CC_REQ(?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_TYPE
						cs.setString(2, V_S_BP_CD);//V_S_BP_CD
						cs.setString(3, V_BL_NO);//V_BL_NO
						cs.setString(4, V_BL_SEQ);//V_BL_SEQ
						cs.setString(5, V_USR_ID);//V_USR_ID
						cs.executeQuery();
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String V_BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null || jsondata.get("DN_QTY").equals("null") ? "0" : jsondata.get("DN_QTY").toString();
				String V_DN_BOX_QTY = jsondata.get("DN_REQ_BOX_QTY") == null || jsondata.get("DN_REQ_BOX_QTY").equals("null") ? "0" : jsondata.get("DN_REQ_BOX_QTY").toString();
				String V_DN_REQ_DT = jsondata.get("DN_REQ_DT") == null ? "" : jsondata.get("DN_REQ_DT").toString().substring(0, 10);

				if (V_SP_TYPE.equals("DN_REQ")) {
					cs = conn.prepareCall("call DISTR_CUST.USP_CUST_DN_REQ(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_TYPE
					cs.setString(2, V_TYPE);//V_COMP_ID
					cs.setString(3, V_S_BP_CD);//V_SL_CD
					cs.setString(4, "");//V_BL_DOC_NO
					cs.setString(5, V_ITEM_NM);//V_SL_DT
					cs.setString(6, V_SL_CD);//V_SL_LOC
					cs.setString(7, V_BL_NO);//V_BL_NO
					cs.setString(8, V_BL_SEQ);//V_BL_SEQ
					cs.setString(9, V_MVMT_NO);//V_MVMT_NO
					cs.setString(10, V_DN_QTY);//V_DN_QTY
					cs.setString(11, V_DN_BOX_QTY);//V_DN_BOX_QTY
					cs.setString(12, V_DN_REQ_DT);//V_DN_REQ_DT
					cs.setString(13, V_USR_ID);//V_REF_NO
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				} else if (V_SP_TYPE.equals("CC_REQ")) {
					cs = conn.prepareCall("call DISTR_CUST.USP_CUST_CC_REQ(?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_TYPE
					cs.setString(2, V_S_BP_CD);//V_S_BP_CD
					cs.setString(3, V_BL_NO);//V_BL_NO
					cs.setString(4, V_BL_SEQ);//V_BL_SEQ
					cs.setString(5, V_USR_ID);//V_USR_ID
					cs.executeQuery();
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


