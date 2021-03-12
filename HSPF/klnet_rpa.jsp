<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%-- <%@page import="net.sf.json.JSONObject"%> --%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>
<%@ page import="java.util.Enumeration"%>

<%@page import="java.io.BufferedReader"%>
<%@page import="sun.misc.BASE64Decoder"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	JSONObject jsonObject = new JSONObject();
	
	try {
		
// 		Enumeration params = request.getParameterNames();
// 	 	System.out.println("--------------KLNET JSON 데이터 확인 로그--------------");
// 	 	while (params.hasMoreElements()){
// 	 	    String name = (String)params.nextElement();
// 	 	    System.out.println(name + " : " +request.getParameter(name));
// 	 	}
// 	 	System.out.println("----------------------------");
	 	
		/*
		String sql = "";
		String FILE_SID = request.getParameter("FILE_SID") == null ? "" : request.getParameter("FILE_SID");
		String DOC_NO = request.getParameter("DOC_NO") == null ? "" : request.getParameter("DOC_NO");
		String DOC_TYPE = request.getParameter("DOC_TYPE") == null ? "" : request.getParameter("DOC_TYPE");
		
		
// 		System.out.println("FILE_SID : " + FILE_SID);
// 		System.out.println("DOC_NO : " + DOC_NO);
		
		cs = conn.prepareCall("call USP_TEMP_RPA_TEST(?,?,?)");
		cs.setString(1, DOC_NO);//
		cs.setString(2, DOC_TYPE);//
		cs.setString(3, FILE_SID);//
		cs.executeQuery();
		*/
		
		request.setCharacterEncoding("utf-8");
		String[] findList = { "#", "+", "&", "%", " " };
		String[] replList = { "%23", "%2B", "%26", "%25", "%20" };
		
		String data = request.getParameter("id");
		data = new String(new BASE64Decoder().decodeBuffer(data));
		data = StringUtils.replaceEach(data, findList, replList);
		String jsonData = URLDecoder.decode(data, "UTF-8");
		
		System.out.println("--------------KLNET JSON 데이터 원본--------------");
		System.out.println(jsonData);
		System.out.println("----------------------------");
		
// 		String jsonData = "[{\"result_msg\":\"SUCCESS\",\"resultCnt\":\"1\"},{\"Invoice_number\":\"ASANVTPY-19-5303\",\"ocr_status_cd\":\"CO\",\"ocr_status_nm\":\"검증완료\",\"error_reason\":null,\"doc_value\":\"Bill of Lading\",\"file_sid\":\"20200304183528829854\",\"file_name\":\"20200302180424065360_1.pdf\",\"manage_no\":null}]";
		
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 1; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					String V_INV_NO = hashMap.get("InvoiceNumber") == null ? "" : hashMap.get("InvoiceNumber").toString();
					String V_BL_NO = hashMap.get("BlNo") == null ? "" : hashMap.get("BlNo").toString();
					String V_PACKING_NO = hashMap.get("PackingListNo") == null ? "" : hashMap.get("PackingListNo").toString();
					String V_OCR_STATUS_CD = hashMap.get("ocr_status_cd") == null ? "" : hashMap.get("ocr_status_cd").toString();
					String V_OCR_STATUS_NM = hashMap.get("ocr_status_nm") == null ? "" : hashMap.get("ocr_status_nm").toString();
					String V_ERROR_REASON = hashMap.get("error_reason") == null ? "" : hashMap.get("error_reason").toString();
					String V_DOC_TYPE = hashMap.get("doc_value") == null ? "" : hashMap.get("doc_value").toString();
					String V_FILE_SID = hashMap.get("file_sid") == null ? "" : hashMap.get("file_sid").toString();
					String V_FILE_NAME = hashMap.get("file_name") == null ? "" : hashMap.get("file_name").toString();
					String V_MANAGE_NO = hashMap.get("manage_no") == null ? "" : hashMap.get("manage_no").toString();
					
					System.out.println("--------------KLNET JSON 데이터 확인 로그 디테일--------------");
					System.out.println("V_INV_NO : " + V_INV_NO);
					System.out.println("V_BL_NO : " + V_BL_NO);
					System.out.println("V_PACKING_NO : " + V_PACKING_NO);
					System.out.println("V_OCR_STATUS_CD : " + V_OCR_STATUS_CD);
					System.out.println("V_OCR_STATUS_NM : " + V_OCR_STATUS_NM);
					System.out.println("V_ERROR_REASON : " + V_ERROR_REASON);
					System.out.println("V_DOC_TYPE : " + V_DOC_TYPE);
					System.out.println("V_FILE_SID : " + V_FILE_SID);
					System.out.println("V_FILE_NAME : " + V_FILE_NAME);
					System.out.println("V_MANAGE_NO : " + V_MANAGE_NO);
					System.out.println("----------------------------");
					
					
					cs = conn.prepareCall("call USP_KLNET_RPA(?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_INV_NO);//
					cs.setString(2, V_BL_NO);//
					cs.setString(3, V_OCR_STATUS_CD);//
					cs.setString(4, V_OCR_STATUS_NM);//
					cs.setString(5, V_ERROR_REASON);//
					cs.setString(6, V_DOC_TYPE);//
					cs.setString(7, V_FILE_SID);//
					cs.setString(8, V_FILE_NAME);//
					cs.setString(9, V_MANAGE_NO);//
					cs.setString(10, V_PACKING_NO);//
					cs.executeQuery();

				}
				
				jsonObject.put("result_cd", "0000");
				jsonObject.put("result_msg", "정상");
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
			} 
			else{
				jsonObject.put("result_cd", "-1");
				jsonObject.put("result_msg", "입력데이터없음");
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
			}
			
		


	} catch (Exception e) {
		e.printStackTrace();
// 		System.out.println(e);
		
		jsonObject.put("result_cd", "-1");
		jsonObject.put("result_msg", e);
		
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	} finally {
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>
