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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").toUpperCase().substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").toUpperCase().substring(0, 10);
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_M_GR_LOC_PRC_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_MVMT_DT_FR);//V_MVMT_DT_FR
			cs.setString(4, V_MVMT_DT_TO);//V_MVMT_DT_TO 
			cs.setString(5, V_M_BP_CD);//V_M_BP_NM 
			cs.setString(6, "");//V_MVMT_NO
			cs.setString(7, "");//V_USR_ID 
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(9, "");//V_PRC_AMT 
			cs.setString(10, "");//V_IV_TYPE 
			cs.setString(11, "");//V_CUR
			cs.setString(12, V_ITEM_CD);//V_ITEM_CD 
			cs.setString(13, V_ITEM_NM);//V_ITEM_NM
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("N_IV_QTY", rs.getString("N_IV_QTY"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("GR_USR_NM", rs.getString("GR_USR_NM"));
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
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String V_PRC_AMT = hashMap.get("IV_PRC") == null ? "" : hashMap.get("IV_PRC").toString();
					String V_IV_TYPE = hashMap.get("IV_TYPE") == null ? "" : hashMap.get("IV_TYPE").toString();
					String V_CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();

					cs = conn.prepareCall("call USP_003_M_GR_LOC_PRC_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_MVMT_DT_FR
					cs.setString(4, "");//V_MVMT_DT_TO 
					cs.setString(5, "");//V_M_BP_NM 
					cs.setString(6, V_MVMT_NO);//V_MVMT_NO
					cs.setString(7, V_USR_ID);//V_USR_ID 
					cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(9, V_PRC_AMT);//V_PRC_AMT 
					cs.setString(10, V_IV_TYPE);//V_IV_TYPE 
					cs.setString(11, V_CUR);//V_CUR 
					cs.setString(12, "");//V_ITEM_CD 
					cs.setString(13, "");//V_ITEM_NM
					cs.executeQuery();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String V_PRC_AMT = jsondata.get("IV_PRC") == null ? "" : jsondata.get("IV_PRC").toString();
				String V_IV_TYPE = jsondata.get("IV_TYPE") == null ? "" : jsondata.get("IV_TYPE").toString();
				String V_CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();

				cs = conn.prepareCall("call USP_003_M_GR_LOC_PRC_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_MVMT_DT_FR
				cs.setString(4, "");//V_MVMT_DT_TO 
				cs.setString(5, "");//V_M_BP_NM 
				cs.setString(6, V_MVMT_NO);//V_MVMT_NO
				cs.setString(7, V_USR_ID);//V_USR_ID 
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(9, V_PRC_AMT);//V_PRC_AMT 
				cs.setString(10, V_IV_TYPE);//V_IV_TYPE 
				cs.setString(11, V_CUR);//V_CUR 
				cs.setString(12, "");//V_ITEM_CD 
				cs.setString(13, "");//V_ITEM_NM
				cs.executeQuery();
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


