<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%

	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject subObject = null;
	JSONArray jsonArray = new JSONArray();
	try {
		request.setCharacterEncoding("utf-8");

		String[] findList = { "#", "+", "&", "%", " " };
		String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

		String data = request.getParameter("data");
		data = StringUtils.replaceEach(data, findList, replList);
		String jsonData = URLDecoder.decode(data, "UTF-8");

// 		String V_TYPE = request.getParameter("V_TYPE"); //
		String V_USR_ID = request.getParameter("V_USR_ID");
		String V_PO_DT = request.getParameter("V_PO_DT");
		
		
		if(V_PO_DT != null && V_PO_DT.length() > 10){
			V_PO_DT = V_PO_DT.substring(0,10);
		}
	
	
		if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
			String NEW_PO_NO = "";
			String NEW_PO_FLAG = "N";
			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);
				String V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString(); // V
				String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
				String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
				String SL_QTY = hashMap.get("SL_QTY") == null ? "" : hashMap.get("SL_QTY").toString();
				String DLV_DT = hashMap.get("DLV_DT") == null ? "" : hashMap.get("DLV_DT").toString();
				
// 				System.out.println("배열인경우");
// 				System.out.println("V_TYPE : " + V_TYPE);
// 				System.out.println("V_PO_NO : " + V_PO_NO);
// 				System.out.println("V_PO_SEQ : " + V_PO_SEQ);
				
				if(DLV_DT.length() > 10){
					DLV_DT = DLV_DT.substring(0,10);
				}

				if(NEW_PO_FLAG.equals("N") && V_TYPE.equals("C")){
					cs = conn.prepareCall("{call USP_M_PREQ_TO_SURVEY(?,?,?,?,?,?,?,?,?)}");
					cs.setString(1, "CH");
					cs.setString(2, V_PO_NO);
					cs.setString(3, V_PO_SEQ);
					cs.setString(4, V_USR_ID);
					cs.setString(5, "");
					cs.registerOutParameter(6, Types.VARCHAR);
					cs.setString(7, V_PO_DT);
					cs.setString(8, SL_QTY);
					cs.setString(9, DLV_DT);

					cs.execute();
					
					NEW_PO_NO = cs.getString(6);
					
					NEW_PO_FLAG = "Y";
					
				}
				
				cs = conn.prepareCall("{call USP_M_PREQ_TO_SURVEY(?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_PO_NO);
				cs.setString(3, V_PO_SEQ);
				cs.setString(4, V_USR_ID);
				cs.setString(5, NEW_PO_NO);
				cs.registerOutParameter(6, Types.VARCHAR);
				cs.setString(7, V_PO_DT);
				cs.setString(8, SL_QTY);
				cs.setString(9, DLV_DT);

				cs.execute();
			}
		} else {
			String NEW_PO_NO = "";
			
			JSONObject jsondata = JSONObject.fromObject(jsonData);
			String V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
			String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
			String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
			String SL_QTY = jsondata.get("SL_QTY") == null ? "" : jsondata.get("SL_QTY").toString();
			String DLV_DT = jsondata.get("DLV_DT") == null ? "" : jsondata.get("DLV_DT").toString();
			
// 			System.out.println("V_TYPE : " + V_TYPE);
// 			System.out.println("V_PO_NO : " + V_PO_NO);
// 			System.out.println("V_PO_SEQ : " + V_PO_SEQ);
			
			if(DLV_DT.length() > 10){
				DLV_DT = DLV_DT.substring(0,10);
			}
			
			if(V_TYPE.equals("C")){
				cs = conn.prepareCall("{call USP_M_PREQ_TO_SURVEY(?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "CH");
				cs.setString(2, V_PO_NO);
				cs.setString(3, V_PO_SEQ);
				cs.setString(4, V_USR_ID);
				cs.setString(5, "");
				cs.registerOutParameter(6, Types.VARCHAR);
				cs.setString(7, V_PO_DT);
				cs.setString(8, SL_QTY);
				cs.setString(9, DLV_DT);
	
				cs.execute();
				
				NEW_PO_NO = cs.getString(6);
			} 

			cs = conn.prepareCall("{call USP_M_PREQ_TO_SURVEY(?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_PO_NO);
			cs.setString(3, V_PO_SEQ);
			cs.setString(4, V_USR_ID);
			cs.setString(5, NEW_PO_NO);
			cs.registerOutParameter(6, Types.VARCHAR);
			cs.setString(7, V_PO_DT);
			cs.setString(8, SL_QTY);
			cs.setString(9, DLV_DT);

			cs.execute();
			}
		
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

