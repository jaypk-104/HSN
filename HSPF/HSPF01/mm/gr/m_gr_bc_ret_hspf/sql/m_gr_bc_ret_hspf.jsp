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
		String V_RE_DT_FR = request.getParameter("V_RE_DT_FR") == null ? "" : request.getParameter("V_RE_DT_FR").substring(0, 10);
		String V_RE_DT_TO = request.getParameter("V_RE_DT_TO") == null ? "" : request.getParameter("V_RE_DT_TO").substring(0, 10);
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD");
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM");

		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");
		String V_RE_DN_YN = request.getParameter("V_RE_DN_YN") == null ? "" : request.getParameter("V_RE_DN_YN");
		String V_RE_GN_YN = request.getParameter("V_RE_GN_YN") == null ? "" : request.getParameter("V_RE_GN_YN");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");

		String V_RE_NO = request.getParameter("V_RE_NO") == null ? "" : request.getParameter("V_RE_NO");
		String V_RE_SEQ = request.getParameter("V_RE_SEQ") == null ? "" : request.getParameter("V_RE_SEQ");

		String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO");
		String V_GR_SEQ = request.getParameter("V_GR_SEQ") == null ? "" : request.getParameter("V_GR_SEQ");
		

		// 		System.out.println("V_RE_DT_FR :" + V_RE_DT_FR);
		// 		System.out.println("V_RE_DT_TO :" + V_RE_DT_TO);
		// 		System.out.println("V_S_BP_CD :" + V_S_BP_CD);
		// 		System.out.println("V_RE_DN_YN :" + V_RE_DN_YN);
		// 		System.out.println("V_RE_GN_YN :" + V_RE_GN_YN);
		// 		System.out.println("V_ITEM_CD :" + V_ITEM_CD);

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_M_GR_RET_PC_SELECT(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_RE_DT_FR);//V_RE_DT_FR
			cs.setString(4, V_RE_DT_TO);//V_RE_DT_TO
			cs.setString(5, V_M_BP_CD);//V_M_BP_CD
			cs.setString(6, V_M_BP_NM);//V_M_BP_NM
			cs.setString(7, V_ITEM_CD);//V_ITEM_CD
			cs.setString(8, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(9);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("RE_DT", rs.getString("RE_DT"));
				subObject.put("RE_NO", rs.getString("RE_NO"));
				subObject.put("RE_SEQ", rs.getString("RE_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("RE_QTY", rs.getString("RE_QTY"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
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
			String V_GR_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT");
			V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_LOT_NO = request.getParameter("V_LOT_NO") == null ? "" : request.getParameter("V_LOT_NO");
			String V_BC_NO = request.getParameter("V_BC_NO") == null ? "" : request.getParameter("V_BC_NO");
			
			if(V_GR_DT.length() > 10){
				V_GR_DT = V_GR_DT.substring(0,10);
			}
			
			
			cs = conn.prepareCall("call USP_M_GR_RET_PC_POP(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//
			cs.setString(2, V_GR_DT);//
			cs.setString(3, V_LOT_NO);//
			cs.setString(4, V_BC_NO);//
			cs.setString(5, V_ITEM_CD);//
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT"));
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
					V_RE_NO = hashMap.get("RE_NO") == null ? "" : hashMap.get("RE_NO").toString();
					V_RE_SEQ = hashMap.get("RE_SEQ") == null ? "" : hashMap.get("RE_SEQ").toString();
					String RE_QTY = hashMap.get("RE_QTY") == null ? "" : hashMap.get("RE_QTY").toString();
					String RE_DT = hashMap.get("RE_DT") == null ? "" : hashMap.get("RE_DT").toString();
					String LOT_BC_NO = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();
					
					if(RE_DT.length() > 10){
						RE_DT = RE_DT.substring(0,10);
					}

					cs = conn.prepareCall("call USP_M_GR_RET_PC_MGM(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_RE_NO);//V_RE_NO
					cs.setString(4, V_RE_SEQ);//V_RE_SEQ
					cs.setString(5, RE_QTY);//V_RE_QTY
					cs.setString(6, RE_DT);//V_RE_DT
					cs.setString(7, LOT_BC_NO);//V_BC_NO
					cs.setString(8, V_USR_ID);//V_USR_ID
					cs.executeQuery();
					
				}
				
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_RE_NO = jsondata.get("RE_NO") == null ? "" : jsondata.get("RE_NO").toString();
				V_RE_SEQ = jsondata.get("RE_SEQ") == null ? "" : jsondata.get("RE_SEQ").toString();
				String RE_QTY = jsondata.get("RE_QTY") == null ? "" : jsondata.get("RE_QTY").toString();
				String RE_DT = jsondata.get("RE_DT") == null ? "" : jsondata.get("RE_DT").toString();
				String LOT_BC_NO = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();
				
				if(RE_DT.length() > 10){
					RE_DT = RE_DT.substring(0,10);
				}
				
				cs = conn.prepareCall("call USP_M_GR_RET_PC_MGM(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_RE_NO);//V_RE_NO
				cs.setString(4, V_RE_SEQ);//V_RE_SEQ
				cs.setString(5, RE_QTY);//V_RE_QTY
				cs.setString(6, RE_DT);//V_RE_DT
				cs.setString(7, LOT_BC_NO);//V_BC_NO
				cs.setString(8, V_USR_ID);//V_USR_ID
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



