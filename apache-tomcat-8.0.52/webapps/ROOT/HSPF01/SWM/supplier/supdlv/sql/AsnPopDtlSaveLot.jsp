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
	String V_ERR_PO_NO = "";
	String V_ERR_PO_SEQ = "";
	try {
		// 	 System.out.println("납품예정저장SQL");
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		
		
		request.setCharacterEncoding("utf-8");

		String[] findList = { "#", "+", "&", "%", " " };
		String[] replList = { "%23", "%2B", "%26", "%25", "%20" };
		
		String data = request.getParameter("data");
		data = StringUtils.replaceEach(data, findList, replList);
		String jsonData = URLDecoder.decode(data, "UTF-8");
		
		String V_TYPE = request.getParameter("V_TYPE");
		String V_USR_ID = request.getParameter("V_USR_ID");
		String NEW_NO = "";
		if(V_TYPE.equals("SYNC")){
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				String NEW_PO_NO = "";
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString(); // V
					
					String ASN_NO = hashMap.get("ASN_NO") == null ? "" : hashMap.get("ASN_NO").toString();
					String ASN_SEQ = hashMap.get("ASN_SEQ") == null ? "" : hashMap.get("ASN_SEQ").toString();
					String BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
					String LOT_NO = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
					String MAKE_DT = hashMap.get("MAKE_DT") == null ? "" : hashMap.get("MAKE_DT").toString();
					String VALID_DT = hashMap.get("VALID_DT") == null ? "" : hashMap.get("VALID_DT").toString();
					
					if(MAKE_DT.length() > 10){
						MAKE_DT = MAKE_DT.substring(0,10);
					}
					if(VALID_DT.length() > 10){
						VALID_DT = VALID_DT.substring(0,10);
					}
					
	 				 System.out.println("---------------------LOT정보 누락 체크-------------");
	 				 System.out.println("ASN_NO : " + ASN_NO);
	 				 System.out.println("ASN_SEQ : " + ASN_SEQ);
	 				 System.out.println("LOT_NO : " + LOT_NO);
	 				 System.out.println("MAKE_DT : " + MAKE_DT);
	 				 System.out.println("VALID_DT : " + VALID_DT);
	 				 System.out.println("----------------------------------");
	 				 
	 				cs = conn.prepareCall("{call USP_SUPP_ASN_LOTNO_INSRT(?,?,?,?,?,?,?)}");
	 			   	cs.setString(1, ASN_NO);
	 			   	cs.setString(2, ASN_SEQ);
	 			   	cs.setString(3, LOT_NO);
	 			   	cs.setString(4, MAKE_DT);
	 			   	cs.setString(5, VALID_DT);
	 			   	cs.setString(6, V_USR_ID);
	 			   	cs.setString(7, BOX_QTY); //과부족허용률위한 BOX QTY
					cs.execute();
					
				}
			} 
			else {
				String NEW_PO_NO = "";
				
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString(); // V
				
				String ASN_NO = jsondata.get("ASN_NO") == null ? "" : jsondata.get("ASN_NO").toString();
				String ASN_SEQ = jsondata.get("ASN_SEQ") == null ? "" : jsondata.get("ASN_SEQ").toString();
				String BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
				String LOT_NO = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
				String MAKE_DT = jsondata.get("MAKE_DT") == null ? "" : jsondata.get("MAKE_DT").toString();
				String VALID_DT = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString();
				
				if(MAKE_DT.length() > 10){
					MAKE_DT = MAKE_DT.substring(0,10);
				}
				if(VALID_DT.length() > 10){
					VALID_DT = VALID_DT.substring(0,10);
				}
				
				
				
 				 System.out.println("---------------------LOT정보 누락 체크-------------");
 				 System.out.println("ASN_NO : " + ASN_NO);
 				 System.out.println("ASN_SEQ : " + ASN_SEQ);
 				 System.out.println("LOT_NO : " + LOT_NO);
 				 System.out.println("MAKE_DT : " + MAKE_DT);
 				 System.out.println("VALID_DT : " + VALID_DT);
 				 System.out.println("----------------------------------");
 				 
	 				cs = conn.prepareCall("{call USP_SUPP_ASN_LOTNO_INSRT(?,?,?,?,?,?,?)}");
	 			   	cs.setString(1, ASN_NO);
	 			   	cs.setString(2, ASN_SEQ);
	 			   	cs.setString(3, LOT_NO);
	 			   	cs.setString(4, MAKE_DT);
	 			   	cs.setString(5, VALID_DT);
	 			   	cs.setString(6, V_USR_ID);
	 			   	cs.setString(7, BOX_QTY); //과부족허용률위한 BOX QTY
					cs.execute();
			}
		}
		
		
		

		//MyViewport
		
// 		System.out.println("V_TYPE : " + V_TYPE);


		
		/*
		if (V_TYPE != null) {
			String V_MAST_PO_NO = request.getParameter("V_MAST_PO_NO");
			String V_MAST_PO_SEQ = request.getParameter("V_MAST_PO_SEQ");
			String V_MAST_PO_SEQ_NO = request.getParameter("V_MAST_PO_SEQ_NO");
			String V_ASN_NO = (request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toString());
			String V_ASN_STS = (request.getParameter("V_ASN_STS") == null ? "" : request.getParameter("V_ASN_STS").toString());
			String V_ITEM_CD = request.getParameter("V_ITEM_CD");
			String V_DLV_AVL_DT = request.getParameter("V_DLV_AVL_DT");
			String V_DLV_AVL_QTY = request.getParameter("V_DLV_AVL_QTY");
			String V_USR_ID = request.getParameter("V_USR_ID");
			String V_NUM = request.getParameter("V_NUM");

// 				 System.out.println("V_TYPE : " + V_TYPE);
// 				 System.out.println("V_MAST_PO_NO : " + V_MAST_PO_NO);
// 				 System.out.println("V_MAST_PO_SEQ : " + V_MAST_PO_SEQ);
// 				 System.out.println("V_MAST_PO_SEQ_NO : " + V_MAST_PO_SEQ_NO);
// 				 System.out.println("V_ASN_NO : " + V_ASN_NO);
// 				 System.out.println("V_ASN_STS : " + V_ASN_STS);
// 				 System.out.println("V_ITEM_CD : " + V_ITEM_CD);
// 				 System.out.println("V_DLV_AVL_DT : " + V_DLV_AVL_DT);
// 				 System.out.println("V_DLV_AVL_QTY : " + V_DLV_AVL_QTY);
// 				 System.out.println("V_USR_ID : " + V_USR_ID);

			// 	 System.out.println("V_ASN_NO : " + V_ASN_NO);

			cs = conn.prepareCall("{call USP_SUPP_ASN_MST_INSRT(?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_MAST_PO_NO);
			cs.setString(3, V_MAST_PO_SEQ);
			cs.setString(4, V_MAST_PO_SEQ_NO);
			cs.setString(5, V_ASN_NO);
			cs.setString(6, V_ASN_STS);
			cs.setString(7, V_ITEM_CD);
			cs.setString(8, (V_DLV_AVL_DT == null ? "" : V_DLV_AVL_DT.substring(0, 10)));
			cs.setString(9, V_DLV_AVL_QTY);
			cs.setString(10, V_USR_ID);
			cs.registerOutParameter(11, Types.VARCHAR);
			cs.execute();

			// 	subObject.put("ASN_NO", cs.getString(11));
			// 	jsonArray.add(subObject);
			// 	jsonObject.put("resultList", cs.getString(11));
			// 	System.out.println(jsonObject);

			PrintWriter pw = response.getWriter();
			pw.print(cs.getString(11));
			pw.flush();
			pw.close();
			
		}
		*/

	} catch (Exception e) {
		System.out.println("V_ERR_PO_NO : " + V_ERR_PO_NO);
		System.out.println("V_ERR_PO_SEQ : " + V_ERR_PO_SEQ);
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
