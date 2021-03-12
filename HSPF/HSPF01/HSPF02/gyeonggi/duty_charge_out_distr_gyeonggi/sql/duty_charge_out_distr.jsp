<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

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
		
		if(V_TYPE.equals("NEW")){
			//자동 마스터번호 채번.
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_H_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, null); //
			cs.setString(3, null); //
			cs.setString(4, null); //
			cs.setString(5, null); //
			cs.setString(6, null); //
			cs.setString(7, null); //
			cs.setString(8, null); //
			cs.setString(9, null); //
			cs.setString(10, null); //
			cs.setString(11, null); //
			cs.setString(12, null ); // 
			cs.setString(13, null ); // 
			cs.setString(14, null ); // 
			cs.setString(15, null ); // 
			cs.setString(16, V_USR_ID ); //
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(17);
			
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("NEW_M_CHARGE_NO", rs.getString("NEW_M_CHARGE_NO"));
				
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
		else if(V_TYPE.equals("HU")){
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			String V_VESSEL_NM = request.getParameter("V_VESSEL_NM") == null ? "" : request.getParameter("V_VESSEL_NM").toUpperCase();
			String V_IN_DT = request.getParameter("V_IN_DT") == null ? "" : request.getParameter("V_IN_DT").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			String V_QTY = request.getParameter("V_QTY") == null ? "" : request.getParameter("V_QTY").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_TEMP_SL_NM = request.getParameter("V_TEMP_SL_NM") == null ? "" : request.getParameter("V_TEMP_SL_NM").toUpperCase();
			String V_IN_NO = request.getParameter("V_IN_NO") == null ? "" : request.getParameter("V_IN_NO").toUpperCase();
			String V_TAX_DT = request.getParameter("V_TAX_DT") == null ? "" : request.getParameter("V_TAX_DT").toUpperCase();
			String V_ACCEPT_DT = request.getParameter("V_ACCEPT_DT") == null ? "" : request.getParameter("V_ACCEPT_DT").toUpperCase();
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String V_TOTAL_AMT = request.getParameter("V_TOTAL_AMT") == null ? "" : request.getParameter("V_TOTAL_AMT").toUpperCase();
			
			if(V_IN_DT.length() >= 10){
				V_IN_DT = V_IN_DT.substring(0,10);
			}
			if(V_TAX_DT.length() >= 10){
				V_TAX_DT = V_TAX_DT.substring(0,10);
			}
			if(V_ACCEPT_DT.length() >= 10){
				V_ACCEPT_DT = V_ACCEPT_DT.substring(0,10);
			}
			
			
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_H_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, V_VESSEL_NM); //
			cs.setString(4, V_IN_DT); //
			cs.setString(5, V_ITEM_NM); //
			cs.setString(6, V_QTY); //
			cs.setString(7, V_BL_DOC_NO); //
			cs.setString(8, V_TEMP_SL_NM); //
			cs.setString(9, V_IN_NO); //
			cs.setString(10,V_TAX_DT ); //
			cs.setString(11,V_ACCEPT_DT ); //
			cs.setString(12, "" ); // 
			cs.setString(13, "" ); // 
			cs.setString(14, V_BP_CD ); // 
			cs.setString(15, V_TOTAL_AMT ); // 
			cs.setString(16, V_USR_ID ); // 
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			
		}
		else if(V_TYPE.equals("HS")){
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_H_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, ""); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, ""); //
			cs.setString(9, ""); //
			cs.setString(10,"" ); //
			cs.setString(11,"" ); //
			cs.setString(12, "" ); // 
			cs.setString(13, "" ); // 
			cs.setString(14,  V_BP_CD); // 
			cs.setString(15, "" ); //
			cs.setString(16, V_USR_ID ); //
			
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(17);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("TEMP_SL_NM", rs.getString("TEMP_SL_NM"));
				subObject.put("IN_NO", rs.getString("IN_NO"));
				subObject.put("TAX_DT", rs.getString("TAX_DT"));
				subObject.put("ACCEPT_DT", rs.getString("ACCEPT_DT"));
				subObject.put("ERP_YN", rs.getString("ERP_YN"));
				subObject.put("TOTAL_AMT", rs.getString("TOTAL_AMT"));
				
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
		else if (V_TYPE.equals("GRID_S")) {
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, ""); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, ""); //
			cs.setString(9, ""); //
			cs.setString(10, ""); //
			cs.setString(11, ""); //
			cs.setString(12, ""); //
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(13);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("CHARGE_SEQ", rs.getString("CHARGE_SEQ"));
				subObject.put("CHARGE_TYPE", rs.getString("CHARGE_TYPE"));
				subObject.put("CHARGE_NAME", rs.getString("CHARGE_NAME"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("REG_NO", rs.getString("BP_RGST_NO"));
				subObject.put("VAT_CD", rs.getString("VAT_CD"));
				subObject.put("CHARGE_AMT", rs.getString("CHARGE_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("CHARGE_DT", rs.getString("CHARGE_DT"));
				subObject.put("VAT_REF_AMT", rs.getString("VAT_REF_AMT"));
				
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
		else if(V_TYPE.equals("DU")) {
			request.setCharacterEncoding("utf-8");
// 			String data = request.getParameter("data");
// 			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };
			
			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
// 					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_CHARGE_SEQ  = hashMap.get("CHARGE_SEQ") == null ? "" : hashMap.get("CHARGE_SEQ").toString();
					String V_CHARGE_TYPE  = hashMap.get("CHARGE_TYPE") == null ? "" : hashMap.get("CHARGE_TYPE").toString();
					String V_CHARGE_NAME  = hashMap.get("CHARGE_NAME") == null ? "" : hashMap.get("CHARGE_NAME").toString();
					String V_CHARGE_DT  = hashMap.get("CHARGE_DT") == null ? "" : hashMap.get("CHARGE_DT").toString();
					String V_M_BP_CD  = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String V_VAT_CD  = hashMap.get("VAT_CD") == null ? "" : hashMap.get("VAT_CD").toString();
					String V_CHARGE_AMT  = hashMap.get("CHARGE_AMT") == null ? "" : hashMap.get("CHARGE_AMT").toString();
					String V_VAT_AMT  = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_REMARK  = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_VAT_REF_AMT  = hashMap.get("VAT_REF_AMT") == null ? "" : hashMap.get("VAT_REF_AMT").toString();
					
					if(V_CHARGE_DT.length() > 10){
						V_CHARGE_DT = V_CHARGE_DT.substring(0,10);
					}
					
					String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
					
					cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //
					cs.setString(2, V_M_CHARGE_NO); //V_M_CHARGE_NO
					cs.setString(3, V_CHARGE_SEQ); //V_CHARGE_NO
					cs.setString(4, V_CHARGE_TYPE); //V_CHARGE_TYPE
					cs.setString(5, V_CHARGE_DT); //V_CHARGE_DT
					cs.setString(6, V_M_BP_CD); //V_M_BP_CD
					cs.setString(7, V_VAT_CD); //V_VAT_CD
					cs.setString(8, V_CHARGE_AMT); //V_CHARGE_AMT
					cs.setString(9, V_VAT_AMT); //V_VAT_AMT
					cs.setString(10, ""); //V_ERP_YN
					cs.setString(11, V_VAT_REF_AMT); //V_VAT_REF_AMT
					cs.setString(12, V_USR_ID); //V_USR_ID
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					
					
					cs.executeQuery();
					
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
// 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_CHARGE_SEQ  = jsondata.get("CHARGE_SEQ") == null ? "" : jsondata.get("CHARGE_SEQ").toString();
				String V_CHARGE_TYPE  = jsondata.get("CHARGE_TYPE") == null ? "" : jsondata.get("CHARGE_TYPE").toString();
				String V_CHARGE_NAME  = jsondata.get("CHARGE_NAME") == null ? "" : jsondata.get("CHARGE_NAME").toString();
				String V_CHARGE_DT  = jsondata.get("CHARGE_DT") == null ? "" : jsondata.get("CHARGE_DT").toString();
				String V_M_BP_CD  = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String V_VAT_CD  = jsondata.get("VAT_CD") == null ? "" : jsondata.get("VAT_CD").toString();
				String V_CHARGE_AMT  = jsondata.get("CHARGE_AMT") == null ? "" : jsondata.get("CHARGE_AMT").toString();
				String V_VAT_AMT  = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String V_REMARK  = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_VAT_REF_AMT  = jsondata.get("VAT_REF_AMT") == null ? "" : jsondata.get("VAT_REF_AMT").toString();
				
				if(V_CHARGE_DT.length() > 10){
					V_CHARGE_DT = V_CHARGE_DT.substring(0,10);
				}
				
				String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //
				cs.setString(2, V_M_CHARGE_NO); //V_M_CHARGE_NO
				cs.setString(3, V_CHARGE_SEQ); //V_CHARGE_NO
				cs.setString(4, V_CHARGE_TYPE); //V_CHARGE_TYPE
				cs.setString(5, V_CHARGE_DT); //V_CHARGE_DT
				cs.setString(6, V_M_BP_CD); //V_M_BP_CD
				cs.setString(7, V_VAT_CD); //V_VAT_CD
				cs.setString(8, V_CHARGE_AMT); //V_CHARGE_AMT
				cs.setString(9, V_VAT_AMT); //V_VAT_AMT
				cs.setString(10, ""); //V_ERP_YN
				cs.setString(11, V_VAT_REF_AMT); //V_VAT_REF_AMT
				cs.setString(12, V_USR_ID); //V_USR_ID
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				
				
				cs.executeQuery();
				
			}
		}
		else if(V_TYPE.equals("DD")) {
			request.setCharacterEncoding("utf-8");
// 			String data = request.getParameter("data");
// 			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };
			
			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
// 					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_CHARGE_TYPE  = hashMap.get("CHARGE_TYPE") == null ? "" : hashMap.get("CHARGE_TYPE").toString();
					String V_CHARGE_SEQ  = hashMap.get("CHARGE_SEQ") == null ? "" : hashMap.get("CHARGE_SEQ").toString();
					String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
					
					cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //
					cs.setString(2, V_M_CHARGE_NO); //V_M_CHARGE_NO
					cs.setString(3, V_CHARGE_SEQ); //V_CHARGE_NO
					cs.setString(4, V_CHARGE_TYPE); //V_CHARGE_TYPE
					cs.setString(5, ""); //V_CHARGE_DT
					cs.setString(6, ""); //V_M_BP_CD
					cs.setString(7, ""); //V_VAT_CD
					cs.setString(8, ""); //V_CHARGE_AMT
					cs.setString(9, ""); //V_VAT_AMT
					cs.setString(10, ""); //V_ERP_YN
					cs.setString(11, ""); //
					cs.setString(12, V_USR_ID); //V_USR_ID
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					
					cs.executeQuery();
					
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
// 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_CHARGE_TYPE  = jsondata.get("CHARGE_TYPE") == null ? "" : jsondata.get("CHARGE_TYPE").toString();
				String V_CHARGE_SEQ  = jsondata.get("CHARGE_SEQ") == null ? "" : jsondata.get("CHARGE_SEQ").toString();
				String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //
				cs.setString(2, V_M_CHARGE_NO); //V_M_CHARGE_NO
				cs.setString(3, V_CHARGE_SEQ); //V_CHARGE_NO
				cs.setString(4, V_CHARGE_TYPE); //V_CHARGE_TYPE
				cs.setString(5, ""); //V_CHARGE_DT
				cs.setString(6, ""); //V_M_BP_CD
				cs.setString(7, ""); //V_VAT_CD
				cs.setString(8, ""); //V_CHARGE_AMT
				cs.setString(9, ""); //V_VAT_AMT
				cs.setString(10, ""); //V_ERP_YN
				cs.setString(11, ""); //
				cs.setString(12, V_USR_ID); //V_USR_ID
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				
				cs.executeQuery();
				
			}
		}
		
		
		

		else if (V_TYPE.equals("GRID")) {
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, ""); //
			cs.setString(3, ""); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, ""); //
			cs.setString(9, ""); //
			cs.setString(10, ""); //
			cs.setString(11, "");
			cs.setString(12, "");
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(13);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CHARGE_TYPE", rs.getString("CHARGE_TYPE"));
				subObject.put("CHARGE_NAME", rs.getString("CHARGE_NAME"));
				subObject.put("VAT_CD", rs.getString("VAT_CD"));
				subObject.put("M_BP_CD", "");
				
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


