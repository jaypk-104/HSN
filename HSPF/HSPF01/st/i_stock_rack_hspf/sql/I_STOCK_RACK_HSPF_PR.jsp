<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="java.net.URLDecoder"%>


<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toString();
		String V_BASE_DATE = request.getParameter("V_BASE_DATE") == null ? "" : request.getParameter("V_BASE_DATE").toString().substring(0,10);
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toString();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toString();
		
		request.setCharacterEncoding("utf-8");
		String data = request.getParameter("data");
		String jsonData = URLDecoder.decode(data, "UTF-8");
// 		System.out.println("-------------------------------Asdf------------------");
		if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
			
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);
				V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
				String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
				String V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
				String V_GR_SL_CD = hashMap.get("GR_SL_CD") == null ? "" : hashMap.get("GR_SL_CD").toString();
				String V_SL_NM = hashMap.get("SL_NM") == null ? "" : hashMap.get("SL_NM").toString();
				String V_LC_NM = hashMap.get("LC_NM") == null ? "" : hashMap.get("LC_NM").toString();
				String V_GR_RACK_CD = hashMap.get("GR_RACK_CD") == null ? "" : hashMap.get("GR_RACK_CD").toString();
				String V_GR_QTY = hashMap.get("GR_QTY") == null ? "" : hashMap.get("GR_QTY").toString();
				String V_GR_AMT = hashMap.get("GR_AMT") == null ? "" : hashMap.get("GR_AMT").toString();
				String V_DN_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();
				String V_STK_QTY = hashMap.get("STK_QTY") == null ? "" : hashMap.get("STK_QTY").toString();
				String V_STK_AMT = hashMap.get("STK_AMT") == null ? "" : hashMap.get("STK_AMT").toString();
				
				cs = conn.prepareCall("call USP_I_RACK_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_BASE_DATE);//V_BS_DATE
				cs.setString(3, V_COMP_ID);//V_COMP_ID
				cs.setString(4, V_ITEM_CD);//V_ITEM_CD
				cs.setString(5, V_ITEM_NM);//V_ITEM_NM
				cs.setString(6, "");//V_SL_CD
				cs.setString(7, "");//V_RACK_NO
				cs.setString(8, "");//V_PAL_BC_NO
				cs.setString(9, "");//V_BOX_BC_NO
				cs.setString(10, "");//V_LOT_BC_NO
				cs.setString(11, "");//V_LOT_NO
				cs.setString(12, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
		}
		else{
			JSONObject jsondata = JSONObject.fromObject(jsonData);
			
			V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
			String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
			String V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
			String V_GR_SL_CD = jsondata.get("GR_SL_CD") == null ? "" : jsondata.get("GR_SL_CD").toString();
			String V_SL_NM = jsondata.get("SL_NM") == null ? "" : jsondata.get("SL_NM").toString();
			String V_LC_NM = jsondata.get("LC_NM") == null ? "" : jsondata.get("LC_NM").toString();
			String V_GR_RACK_CD = jsondata.get("GR_RACK_CD") == null ? "" : jsondata.get("GR_RACK_CD").toString();
			String V_GR_QTY = jsondata.get("GR_QTY") == null ? "" : jsondata.get("GR_QTY").toString();
			String V_GR_AMT = jsondata.get("GR_AMT") == null ? "" : jsondata.get("GR_AMT").toString();
			String V_DN_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();
			String V_STK_QTY = jsondata.get("STK_QTY") == null ? "" : jsondata.get("STK_QTY").toString();
			String V_STK_AMT = jsondata.get("STK_AMT") == null ? "" : jsondata.get("STK_AMT").toString();
			
// 			System.out.println("V_TYPE : " + V_TYPE);
// 			System.out.println("V_ITEM_CD : " + V_ITEM_CD);
// 			System.out.println("V_ITEM_NM : " + V_ITEM_NM);
// 			System.out.println("V_GR_SL_CD : " + V_GR_SL_CD);
// 			System.out.println("V_SL_NM : " + V_SL_NM);
// 			System.out.println("V_LC_NM : " + V_LC_NM);
// 			System.out.println("V_GR_RACK_CD : " + V_GR_RACK_CD);
// 			System.out.println("V_GR_QTY : " + V_GR_QTY);
// 			System.out.println("V_GR_AMT : " + V_GR_AMT);
// 			System.out.println("V_DN_QTY : " + V_DN_QTY);
// 			System.out.println("V_STK_QTY : " + V_STK_QTY);
// 			System.out.println("V_STK_AMT : " + V_STK_AMT);
			
			cs = conn.prepareCall("call USP_I_RACK_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_BASE_DATE);//V_BS_DATE
			cs.setString(3, V_COMP_ID);//V_COMP_ID
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.setString(6, "");//V_SL_CD
			cs.setString(7, "");//V_RACK_NO
			cs.setString(8, "");//V_PAL_BC_NO
			cs.setString(9, "");//V_BOX_BC_NO
			cs.setString(10, "");//V_LOT_BC_NO
			cs.setString(11, "");//V_LOT_NO
			cs.setString(12, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			
		}
		
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>
