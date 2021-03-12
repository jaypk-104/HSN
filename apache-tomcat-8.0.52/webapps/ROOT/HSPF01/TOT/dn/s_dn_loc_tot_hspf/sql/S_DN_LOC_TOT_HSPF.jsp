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
		String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").toUpperCase().substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase().substring(0, 10);
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();

		if (V_IV_TYPE.equals("T")) V_IV_TYPE = "";
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_S_DN_LOC_PRC_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DN_DT_FR);//V_DN_DT_FR
			cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO 
			cs.setString(5, V_M_BP_CD);//V_M_BP_NM 
			cs.setString(6, V_S_BP_CD);//V_S_BP_NM
			cs.setString(7, V_ITEM_CD);//V_ITEM_CD
			cs.setString(8, V_ITEM_NM);//V_ITEM_NM
			cs.setString(9, "");//V_ITS_NO
			cs.setString(10, "");//V_DN_PRC
			cs.setString(11, "");//V_DN_AMT
			cs.setString(12, "");//V_VAT_AMT
			cs.setString(13, "");//V_USR_ID
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(15, "");//V_VAT_TYPE
			cs.setString(16, "");//V_SALE_TYPE
			cs.setString(17, V_IV_TYPE);//V_IV_TYPE
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(14);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITS_NO", rs.getString("ITS_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
// 				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
// 				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("DN_LOC_AMT", rs.getString("DN_LOC_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("BILL_YN", rs.getString("BILL_YN"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
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
					String V_ITS_NO = hashMap.get("ITS_NO") == null ? "" : hashMap.get("ITS_NO").toString();
					String V_DN_PRC = hashMap.get("DN_PRC") == null ? "" : hashMap.get("DN_PRC").toString();
					String V_DN_AMT = hashMap.get("DN_AMT") == null ? "" : hashMap.get("DN_AMT").toString();
					String V_VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String V_SALE_TYPE = hashMap.get("SALE_TYPE") == null ? "" : hashMap.get("SALE_TYPE").toString();

					cs = conn.prepareCall("call USP_003_S_DN_LOC_PRC_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_DN_DT_FR
					cs.setString(4, "");//V_DN_DT_TO 
					cs.setString(5, "");//V_M_BP_NM 
					cs.setString(6, "");//V_S_BP_NM
					cs.setString(7, "");//V_ITEM_CD
					cs.setString(8, "");//V_ITEM_NM
					cs.setString(9, V_ITS_NO);//V_ITS_NO
					cs.setString(10, V_DN_PRC);//V_DN_PRC
					cs.setString(11, V_DN_AMT);//V_DN_AMT
					cs.setString(12, V_VAT_AMT);//V_VAT_AMT
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(15, V_VAT_TYPE);//V_VAT_TYPE
					cs.setString(16, V_SALE_TYPE);//V_SALE_TYPE
					cs.setString(17, "");//V_IV_TYPE
					cs.executeQuery();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_ITS_NO = jsondata.get("ITS_NO") == null ? "" : jsondata.get("ITS_NO").toString();
				String V_DN_PRC = jsondata.get("DN_PRC") == null ? "" : jsondata.get("DN_PRC").toString();
				String V_DN_AMT = jsondata.get("DN_AMT") == null ? "" : jsondata.get("DN_AMT").toString();
				String V_VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String V_SALE_TYPE = jsondata.get("SALE_TYPE") == null ? "" : jsondata.get("SALE_TYPE").toString();

				cs = conn.prepareCall("call USP_003_S_DN_LOC_PRC_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_DN_DT_FR
				cs.setString(4, "");//V_DN_DT_TO 
				cs.setString(5, "");//V_M_BP_NM 
				cs.setString(6, "");//V_S_BP_NM
				cs.setString(7, "");//V_ITEM_CD
				cs.setString(8, "");//V_ITEM_NM
				cs.setString(9, V_ITS_NO);//V_ITS_NO
				cs.setString(10, V_DN_PRC);//V_DN_PRC
				cs.setString(11, V_DN_AMT);//V_DN_AMT
				cs.setString(12, V_VAT_AMT);//V_VAT_AMT
				cs.setString(13, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(15, V_VAT_TYPE);//V_VAT_TYPE
				cs.setString(16, V_SALE_TYPE);//V_SALE_TYPE
				cs.setString(17, "");//V_IV_TYPE
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


