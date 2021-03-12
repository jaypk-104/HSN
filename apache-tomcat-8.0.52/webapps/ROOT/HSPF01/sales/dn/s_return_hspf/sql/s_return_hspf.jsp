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
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD");
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");

		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");
		String V_RE_DN_YN = request.getParameter("V_RE_DN_YN") == null ? "" : request.getParameter("V_RE_DN_YN");
		String V_RE_GN_YN = request.getParameter("V_RE_GN_YN") == null ? "" : request.getParameter("V_RE_GN_YN");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");

		String V_RE_NO = request.getParameter("V_RE_NO") == null ? "" : request.getParameter("V_RE_NO");
		String V_RE_SEQ = request.getParameter("V_RE_SEQ") == null ? "" : request.getParameter("V_RE_SEQ");

		String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").substring(0, 10);;
		String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO");
		String V_GR_SEQ = request.getParameter("V_GR_SEQ") == null ? "" : request.getParameter("V_GR_SEQ");

		// 		System.out.println("V_RE_DT_FR :" + V_RE_DT_FR);
		// 		System.out.println("V_RE_DT_TO :" + V_RE_DT_TO);
		// 		System.out.println("V_S_BP_CD :" + V_S_BP_CD);
		// 		System.out.println("V_RE_DN_YN :" + V_RE_DN_YN);
		// 		System.out.println("V_RE_GN_YN :" + V_RE_GN_YN);
		// 		System.out.println("V_ITEM_CD :" + V_ITEM_CD);

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_S_RETURN_BCD_PC(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_RE_DT_FR);//V_RE_DT_FR
			cs.setString(4, V_RE_DT_TO);//V_RE_DT_TO
			cs.setString(5, V_S_BP_CD);//V_S_BP_CD
			cs.setString(6, V_S_BP_NM);//V_S_BP_NM
			cs.setString(7, V_RE_DN_YN);//V_RE_DN_YN
			cs.setString(8, V_RE_GN_YN);//V_RE_GN_YN
			cs.setString(9, V_ITEM_CD);//V_ITEM_CD
			cs.setString(10, V_RE_NO);//V_RE_NO
			cs.setString(11, V_RE_SEQ);//V_RE_SEQ
			cs.setString(12, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(14, "");//RE_QTY
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("RE_DT", rs.getString("RE_DT"));
				subObject.put("RE_NO", rs.getString("RE_NO"));
				subObject.put("RE_SEQ", rs.getString("RE_SEQ"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("NEW_PAL_BC_NO", rs.getString("NEW_PAL_BC_NO"));
				subObject.put("NEW_BOX_BC_NO", rs.getString("NEW_BOX_BC_NO"));
				subObject.put("NEW_LOT_BC_NO", rs.getString("NEW_LOT_BC_NO"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("LC_CD", rs.getString("LC_CD"));
				subObject.put("LC_NM", rs.getString("LC_NM"));
				subObject.put("RACK_CD", rs.getString("RACK_CD"));
				subObject.put("RE_QTY", rs.getString("RE_QTY"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("RE_YN", rs.getString("RE_YN"));
				subObject.put("RE_GR_YN", rs.getString("RE_GR_YN"));
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
			V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT");
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
			String V_LOT_NO = request.getParameter("V_LOT_NO") == null ? "" : request.getParameter("V_LOT_NO");
			String V_BC_NO = request.getParameter("V_BC_NO") == null ? "" : request.getParameter("V_BC_NO");
			
			if(V_DN_DT.length() > 10){
				V_DN_DT = V_DN_DT.substring(0,10);
			}
			
			cs = conn.prepareCall("call USP_S_RETURN_BCD_PC_POP(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//
			cs.setString(2, V_DN_DT);//
			cs.setString(3, V_LOT_NO);//
			cs.setString(4, V_BC_NO);//
			cs.setString(5, V_ITEM_NM);//
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
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

					
					cs = conn.prepareCall("call USP_S_RETURN_BCD_PC(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, RE_DT);//V_RE_DT_FR
					cs.setString(4, V_RE_DT_TO);//V_RE_DT_TO
					cs.setString(5, V_S_BP_CD);//V_S_BP_CD
					cs.setString(6, V_S_BP_NM);//V_S_BP_NM
					cs.setString(7, V_RE_DN_YN);//V_RE_DN_YN
					cs.setString(8, V_RE_GN_YN);//V_RE_GN_YN
					cs.setString(9, LOT_BC_NO);//V_ITEM_CD
					cs.setString(10, V_RE_NO);//V_RE_NO
					cs.setString(11, V_RE_SEQ);//V_RE_SEQ
					cs.setString(12, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(14, RE_QTY);//RE_QTY
					cs.executeQuery();
					
					if(V_TYPE.equals("CF")){
						rs = (ResultSet) cs.getObject(13);
						while (rs.next()) {
							subObject = new JSONObject();
							subObject.put("NEW_LOT_BC_NO", rs.getString("NEW_LOT_BC_NO"));
							
							jsonArray.add(subObject);
							
						}
					}
				}
				if(V_TYPE.equals("CF")){
					jsonObject.put("success", true);
					jsonObject.put("resultList", jsonArray);

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(jsonObject);
					pw.flush();
					pw.close();
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
				
				
				cs = conn.prepareCall("call USP_S_RETURN_BCD_PC(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, RE_DT);//V_RE_DT_FR
				cs.setString(4, V_RE_DT_TO);//V_RE_DT_TO
				cs.setString(5, V_S_BP_CD);//V_S_BP_CD
				cs.setString(6, V_S_BP_NM);//V_S_BP_NM
				cs.setString(7, V_RE_DN_YN);//V_RE_DN_YN
				cs.setString(8, V_RE_GN_YN);//V_RE_GN_YN
				cs.setString(9, LOT_BC_NO);//V_ITEM_CD
				cs.setString(10, V_RE_NO);//V_RE_NO
				cs.setString(11, V_RE_SEQ);//V_RE_SEQ
				cs.setString(12, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(14, RE_QTY);//RE_QTY
				cs.executeQuery();
				
				if(V_TYPE.equals("CF")){
					rs = (ResultSet) cs.getObject(13);
					while (rs.next()) {
						subObject = new JSONObject();
						subObject.put("NEW_LOT_BC_NO", rs.getString("NEW_LOT_BC_NO"));
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



