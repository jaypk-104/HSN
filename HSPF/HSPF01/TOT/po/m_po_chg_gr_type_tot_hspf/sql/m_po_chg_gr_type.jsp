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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		// 		System.out.println("V_RE_DT_FR :" + V_RE_DT_FR);
		// 		System.out.println("V_RE_DT_TO :" + V_RE_DT_TO);
		// 		System.out.println("V_S_BP_CD :" + V_S_BP_CD);
		// 		System.out.println("V_RE_DN_YN :" + V_RE_DN_YN);
		// 		System.out.println("V_RE_GN_YN :" + V_RE_GN_YN);
		// 		System.out.println("V_ITEM_CD :" + V_ITEM_CD);

		if (V_TYPE.equals("S")) {
			String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0, 10);
			String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0, 10);
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO");
			String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
			
			cs = conn.prepareCall("call USP_003_M_PO_CHG_GR_TYPE_SELECT(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//
			cs.setString(2, V_PO_DT_FR);//
			cs.setString(3, V_PO_DT_TO);//
			cs.setString(4, V_ITEM_CD);//
			cs.setString(5, V_ITEM_NM);//
			cs.setString(6, V_BL_DOC_NO);//
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, V_PO_NO);//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("GR_YN", rs.getString("GR_YN"));
				subObject.put("ASN_YN", rs.getString("ASN_YN"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
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
					String PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String GR_TYPE = hashMap.get("GR_TYPE") == null ? "" : hashMap.get("GR_TYPE").toString();
					
					cs = conn.prepareCall("call USP_003_M_PO_CHG_GR_TYPE_MGM(?,?,?)");
					cs.setString(1, PO_NO);//
					cs.setString(2, PO_SEQ);//
					cs.setString(3, GR_TYPE);//
					cs.executeQuery();
					
				}
				
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String GR_TYPE = jsondata.get("GR_TYPE") == null ? "" : jsondata.get("GR_TYPE").toString();
				
				cs = conn.prepareCall("call USP_003_M_PO_CHG_GR_TYPE_MGM(?,?,?)");
				cs.setString(1, PO_NO);//
				cs.setString(2, PO_SEQ);//
				cs.setString(3, GR_TYPE);//
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



