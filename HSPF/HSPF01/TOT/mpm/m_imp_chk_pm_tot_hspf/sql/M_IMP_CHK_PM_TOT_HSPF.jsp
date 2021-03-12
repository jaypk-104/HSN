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
		String V_YYYYMMDD = request.getParameter("V_YYYYMMDD") == null ? "" : request.getParameter("V_YYYYMMDD").replace("-", "").substring(0, 8);
		String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_M_IMP_CHK_PM_TOT_HSPF(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMMDD);//V_YYYYMMDD
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.setString(6, V_BP_NM);//V_BP_NM
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(9, V_BP_CD);//V_BP_CD
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PM_NO", rs.getString("PM_NO"));
				subObject.put("PM_SEQ", rs.getString("PM_SEQ"));
				subObject.put("YYYYMMDD", rs.getString("YYYYMMDD"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("FR_M_QTY", rs.getString("FR_M_QTY"));
				subObject.put("FR_D_QTY", rs.getString("FR_D_QTY"));
				subObject.put("SF_QTY", rs.getString("SF_QTY"));
				subObject.put("MIN_PO_QTY", rs.getString("MIN_PO_QTY"));
				subObject.put("PACK_QTY", rs.getString("PACK_QTY"));
				subObject.put("MIN_PACK_UNIT", rs.getString("MIN_PACK_UNIT"));
				subObject.put("MIN_PACK_QTY", rs.getString("MIN_PACK_QTY"));
				subObject.put("ST_QTY", rs.getString("ST_QTY"));
				subObject.put("GR_SUM_QTY", rs.getString("GR_SUM_QTY"));
				subObject.put("DN_SUM_QTY", rs.getString("DN_SUM_QTY"));
				subObject.put("DN_RT", rs.getString("DN_RT"));
				subObject.put("SL_QTY", rs.getString("SL_QTY"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("TP_QTY", rs.getString("TP_QTY"));
				subObject.put("M_PRICE", rs.getString("M_PRICE"));
				subObject.put("MAKER", rs.getString("MAKER"));
				subObject.put("REMARK", rs.getString("REMARK"));
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
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

// 			if (jsonData.lastIndexOf("},{") > 0) { //배열인 경우
// 				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
// 				for (int i = 0; i < jsonAr.size(); i++) {
// 					HashMap hashMap = (HashMap) jsonAr.get(i);

// 					String PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
// 					String PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
// 					String ETA = hashMap.get("ETA") == null || hashMap.get("ETA").equals("null") ? "" : hashMap.get("ETA").toString().substring(0, 10);
// 					String ETD = hashMap.get("ETD") == null || hashMap.get("ETD").equals("null") ? "" : hashMap.get("ETD").toString().substring(0, 10);
// 					String INBOARD_DT = hashMap.get("INBOARD_DT") == null || hashMap.get("INBOARD_DT").equals("null") ? "" : hashMap.get("INBOARD_DT").toString().substring(0, 10);
					
// 					cs = conn.prepareCall("call USP_003_M_IMP_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 			 		cs.setString(1, V_COMP_ID);//V_COMP_ID
// 			 		cs.setString(2, V_TYPE);//V_TYPE
// 			 		cs.setString(3, "");//V_PO_DT_FR
// 			 		cs.setString(4, "");//V_PO_DT_TO
// 			 		cs.setString(5, "");//V_BP_CD
// 			 		cs.setString(6, "");//V_LC_DOC_NO
// 			 		cs.setString(7, "");//V_BL_DOC_NO
// 			 		cs.setString(8, V_BAS_NO);//V_BAS_NO
// 			 		cs.setString(9, V_BAS_SEQ);//V_BAS_SEQ
// 			 		cs.setString(10, V_BAS_TYPE);//V_BAS_TYPE
// 			 		cs.setString(11, V_IMP_CD);//V_IMP_CD
// 			 		cs.setString(12, V_IMP_VAL);//V_IMP_VAL
// 			 		cs.setString(13, V_REMARK);//V_REMARK
// 			 		cs.setString(14, V_USR_ID);//V_USR_ID
// 			 		cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
// 			 		cs.setString(16, "");//V_PO_NO
// 			 		cs.setString(17, "");//V_ITEM_CD
// 			 		cs.setString(18, "");//V_GR_TYPE
// 			 		cs.executeQuery();
					
// 					response.setContentType("text/plain; charset=UTF-8");
// 					PrintWriter pw = response.getWriter();
// 					pw.print("success");
// 					pw.flush();
// 					pw.close();
// 				}
// 			} else {
// 				JSONParser parser = new JSONParser();
// 				Object obj = parser.parse(jsonData);
// 				JSONObject jsonItem = (JSONObject) obj;

// 				String PO_NO = jsonItem.get("PO_NO") == null ? "" : jsonItem.get("PO_NO").toString();
// 				String PO_SEQ = jsonItem.get("PO_SEQ") == null ? "" : jsonItem.get("PO_SEQ").toString();
// 				String ETA = jsonItem.get("ETA") == null || jsonItem.get("ETA").equals("null") ? "" : jsonItem.get("ETA").toString().substring(0, 10);
// 				String ETD = jsonItem.get("ETD") == null || jsonItem.get("ETD").equals("null") ? "" : jsonItem.get("ETD").toString().substring(0, 10);
// 				String INBOARD_DT = jsonItem.get("INBOARD_DT") == null || jsonItem.get("INBOARD_DT").equals("null") ? "" : jsonItem.get("INBOARD_DT").toString().substring(0, 10);
				
// 				cs = conn.prepareCall("call USP_003_M_IMP_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 				cs.setString(1, V_COMP_ID);//V_COMP_ID
// 		 		cs.setString(2, V_TYPE);//V_TYPE
// 		 		cs.setString(3, "");//V_PO_DT_FR
// 		 		cs.setString(4, "");//V_PO_DT_TO
// 		 		cs.setString(5, "");//V_BP_CD
// 		 		cs.setString(6, "");//V_LC_DOC_NO
// 		 		cs.setString(7, "");//V_BL_DOC_NO
// 		 		cs.setString(8, V_BAS_NO);//V_BAS_NO
// 		 		cs.setString(9, V_BAS_SEQ);//V_BAS_SEQ
// 		 		cs.setString(10, V_BAS_TYPE);//V_BAS_TYPE
// 		 		cs.setString(11, V_IMP_CD);//V_IMP_CD
// 		 		cs.setString(12, V_IMP_VAL);//V_IMP_VAL
// 		 		cs.setString(13, V_REMARK);//V_REMARK
// 		 		cs.setString(14, V_USR_ID);//V_USR_ID
// 		 		cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
// 		 		cs.setString(16, "");//V_PO_NO
// 		 		cs.setString(17, "");//V_ITEM_CD
// 		 		cs.setString(18, "");//V_GR_TYPE
// 		 		cs.executeQuery();
				
// 				response.setContentType("text/plain; charset=UTF-8");
// 				PrintWriter pw = response.getWriter();
// 				pw.print("success");
// 				pw.flush();
// 				pw.close();
// 			}

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
// 	void callProcedure(CallableStatement cs, String V_COMP_ID, String V_TYPE) throws Exception {

// 	}

%>


