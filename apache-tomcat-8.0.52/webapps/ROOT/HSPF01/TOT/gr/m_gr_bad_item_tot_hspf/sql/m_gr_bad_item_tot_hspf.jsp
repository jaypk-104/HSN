<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

		if (V_TYPE.equals("S")) {
			String V_BAD_DT_FR = request.getParameter("V_BAD_DT_FR") == null ? "" : request.getParameter("V_BAD_DT_FR");
			String V_BAD_DT_TO = request.getParameter("V_BAD_DT_TO") == null ? "" : request.getParameter("V_BAD_DT_TO");
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
			
			if(V_BAD_DT_FR.length() > 10){
				V_BAD_DT_FR = V_BAD_DT_FR.substring(0,10);
			}
			if(V_BAD_DT_TO.length() > 10){
				V_BAD_DT_TO = V_BAD_DT_TO.substring(0,10);
			}
			
			cs = conn.prepareCall("call USP_003_M_GR_BAD_ITEM_SELECT(?,?,?,?,?)");
			cs.setString(1, V_BAD_DT_FR);//V_BAD_DT_FR
			cs.setString(2, V_BAD_DT_TO);//V_BAD_DT_TO
			cs.setString(3, V_ITEM_CD);//V_ITEM_CD
			cs.setString(4, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BAD_MGM_NO", rs.getString("BAD_MGM_NO"));
				subObject.put("BAD_DT", rs.getString("BAD_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("BAD_QTY", rs.getString("BAD_QTY"));
				subObject.put("BAD_REASON", rs.getString("BAD_REASON"));
				subObject.put("ANSWER", rs.getString("ANSWER"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("GR_SEQ", rs.getString("GR_SEQ"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("INSRT_USR_NM", rs.getString("INSRT_USR_NM"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
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
		else if (V_TYPE.equals("POP_S")) {
			String V_GR_DT_FR = request.getParameter("V_GR_DT_FR") == null ? "" : request.getParameter("V_GR_DT_FR");
			String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null ? "" : request.getParameter("V_GR_DT_TO");
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
			
			
			if(V_GR_DT_FR.length() > 10){
				V_GR_DT_FR = V_GR_DT_FR.substring(0,10);
			}
			if(V_GR_DT_TO.length() > 10){
				V_GR_DT_TO = V_GR_DT_TO.substring(0,10);
			}
			
			
			cs = conn.prepareCall("call USP_003_M_GR_BAD_ITEM_REF_SELECT(?,?,?,?,?)");
			cs.setString(1, V_GR_DT_FR);//
			cs.setString(2, V_GR_DT_TO);//
			cs.setString(3, V_ITEM_CD);//
			cs.setString(4, V_ITEM_NM);//
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("GR_SEQ", rs.getString("GR_SEQ"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
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

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String BAD_MGM_NO = hashMap.get("BAD_MGM_NO") == null ? "" : hashMap.get("BAD_MGM_NO").toString();
					String BAD_DT = hashMap.get("BAD_DT") == null ? "" : hashMap.get("BAD_DT").toString();
					String ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String LOT_NO = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
					String GR_QTY = hashMap.get("GR_QTY") == null ? "" : hashMap.get("GR_QTY").toString();
					String BAD_QTY = hashMap.get("BAD_QTY") == null ? "" : hashMap.get("BAD_QTY").toString();
					String BAD_REASON = hashMap.get("BAD_REASON") == null ? "" : hashMap.get("BAD_REASON").toString();
					String ANSWER = hashMap.get("ANSWER") == null ? "" : hashMap.get("ANSWER").toString();
					String REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String MVMT_DT = hashMap.get("MVMT_DT") == null ? "" : hashMap.get("MVMT_DT").toString();
					String MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
					String GR_SEQ = hashMap.get("GR_SEQ") == null ? "" : hashMap.get("GR_SEQ").toString();
					String PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					
					if(BAD_DT.length() > 10){
						BAD_DT = BAD_DT.substring(0,10);
					}
					if(MVMT_DT.length() > 10){
						MVMT_DT = MVMT_DT.substring(0,10);
					}
					
					cs = conn.prepareCall("call USP_003_M_GR_BAD_ITEM_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, BAD_MGM_NO);//V_BAD_MGM_NO
					cs.setString(4, BAD_DT);//V_BAD_DT
					cs.setString(5, PO_NO);//V_PO_NO
					cs.setString(6, PO_SEQ);//V_PO_SEQ
					cs.setString(7, MVMT_NO);//V_MVMT_NO
					cs.setString(8, GR_NO);//V_GR_NO
					cs.setString(9, GR_SEQ);//V_GR_SEQ
					cs.setString(10, ITEM_CD);//V_ITEM_CD
					cs.setString(11, LOT_NO);//V_LOT_NO
					cs.setString(12, GR_QTY);//V_GR_QTY
					cs.setString(13, BAD_QTY);//V_BAD_QTY
					cs.setString(14, BAD_REASON);//V_BAD_REASON
					cs.setString(15, ANSWER);//V_ANSWER
					cs.setString(16, REMARK);//V_REMARK
					cs.setString(17, V_USR_ID);//V_USR_ID
					cs.setString(18, MVMT_DT);//V_MVMT_DT
					cs.executeQuery();
					
				}
				
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String BAD_MGM_NO = jsondata.get("BAD_MGM_NO") == null ? "" : jsondata.get("BAD_MGM_NO").toString();
				String BAD_DT = jsondata.get("BAD_DT") == null ? "" : jsondata.get("BAD_DT").toString();
				String ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String LOT_NO = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
				String GR_QTY = jsondata.get("GR_QTY") == null ? "" : jsondata.get("GR_QTY").toString();
				String BAD_QTY = jsondata.get("BAD_QTY") == null ? "" : jsondata.get("BAD_QTY").toString();
				String BAD_REASON = jsondata.get("BAD_REASON") == null ? "" : jsondata.get("BAD_REASON").toString();
				String ANSWER = jsondata.get("ANSWER") == null ? "" : jsondata.get("ANSWER").toString();
				String REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String MVMT_DT = jsondata.get("MVMT_DT") == null ? "" : jsondata.get("MVMT_DT").toString();
				String MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();
				String GR_SEQ = jsondata.get("GR_SEQ") == null ? "" : jsondata.get("GR_SEQ").toString();
				String PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				
				if(BAD_DT.length() > 10){
					BAD_DT = BAD_DT.substring(0,10);
				}
				if(MVMT_DT.length() > 10){
					MVMT_DT = MVMT_DT.substring(0,10);
				}
				
				cs = conn.prepareCall("call USP_003_M_GR_BAD_ITEM_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, BAD_MGM_NO);//V_BAD_MGM_NO
				cs.setString(4, BAD_DT);//V_BAD_DT
				cs.setString(5, PO_NO);//V_PO_NO
				cs.setString(6, PO_SEQ);//V_PO_SEQ
				cs.setString(7, MVMT_NO);//V_MVMT_NO
				cs.setString(8, GR_NO);//V_GR_NO
				cs.setString(9, GR_SEQ);//V_GR_SEQ
				cs.setString(10, ITEM_CD);//V_ITEM_CD
				cs.setString(11, LOT_NO);//V_LOT_NO
				cs.setString(12, GR_QTY);//V_GR_QTY
				cs.setString(13, BAD_QTY);//V_BAD_QTY
				cs.setString(14, BAD_REASON);//V_BAD_REASON
				cs.setString(15, ANSWER);//V_ANSWER
				cs.setString(16, REMARK);//V_REMARK
				cs.setString(17, V_USR_ID);//V_USR_ID
				cs.setString(18, MVMT_DT);//V_MVMT_DT
				cs.executeQuery();
				

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



