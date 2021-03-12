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
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		
		if(V_TYPE.equals("S")){
			String V_TAX_FROM_DT = request.getParameter("V_TAX_FROM_DT") == null ? "" : request.getParameter("V_TAX_FROM_DT").toUpperCase();
			String V_TAX_TO_DT = request.getParameter("V_TAX_TO_DT") == null ? "" : request.getParameter("V_TAX_TO_DT").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_PAY_YN = request.getParameter("V_PAY_YN") == null ? "" : request.getParameter("V_PAY_YN").toUpperCase();
			String V_ERP_YN = request.getParameter("V_ERP_YN") == null ? "" : request.getParameter("V_ERP_YN").toUpperCase();
			String V_GL_YN = request.getParameter("V_GL_YN") == null ? "" : request.getParameter("V_GL_YN").toUpperCase();
			
			if(V_TAX_FROM_DT.length() > 10){
				V_TAX_FROM_DT = V_TAX_FROM_DT.substring(0,10);
			}
			else{
				V_TAX_FROM_DT = "1900-01-01";
			}
			
			if(V_TAX_TO_DT.length() > 10){
				V_TAX_TO_DT = V_TAX_TO_DT.substring(0,10);
			}
			else{
				V_TAX_TO_DT = "2900-01-01";
			}
			
			
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, ""); //
			cs.setString(3, V_GL_YN); //
			cs.setString(4, V_TAX_FROM_DT); //
			cs.setString(5, V_TAX_TO_DT); //
			cs.setString(6, V_BL_DOC_NO); //
			cs.setString(7, V_PAY_YN); //
			cs.setString(8, V_ERP_YN); //
			cs.setString(9, V_BP_CD ); //  경기관세만쓰니까 경기관세로 고정
			cs.setString(10, V_USR_ID ); //  
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("TAX_DT", rs.getString("TAX_DT"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("TOTAL_CHARGE_AMOUNT", rs.getString("TOTAL_CHARGE_AMOUNT"));
				subObject.put("TOTAL_VAT_AMOUNT", rs.getString("TOTAL_VAT_AMOUNT"));
				subObject.put("TOTAL_AMOUNT", rs.getString("TOTAL_AMOUNT"));
				subObject.put("ERP_YN", rs.getString("ERP_YN"));
				subObject.put("ACCEPT_YN", rs.getString("HSPF_YN"));
				subObject.put("PAY_YN", rs.getString("PAY_YN"));
				subObject.put("FILE_YN", rs.getString("FILE_YN"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("GL_YN", rs.getString("GL_YN"));
				subObject.put("HSPF_YN", rs.getString("HSPF_YN"));
				subObject.put("IN_NO", rs.getString("IN_NO"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				
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
		else if(V_TYPE.equals("WS")){
			
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			
			
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, ""); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, ""); //
			cs.setString(9, ""); //
			cs.setString(10, V_USR_ID ); // 
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);
			
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("W_M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("W_VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("W_IN_DT", rs.getString("IN_DT"));
				subObject.put("W_ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("W_QTY", rs.getString("QTY"));
				subObject.put("W_BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("W_TEMP_SL_NM", rs.getString("TEMP_SL_NM"));
				subObject.put("W_IN_NO", rs.getString("IN_NO"));
				subObject.put("W_TAX_DT", rs.getString("TAX_DT"));
				subObject.put("W_ACCEPT_DT", rs.getString("ACCEPT_DT"));
				subObject.put("W_TOTAL_AMT", rs.getString("TOTAL_AMT"));
				
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
		else if(V_TYPE.equals("W_GRID")){
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			
			
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, ""); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, ""); //
			cs.setString(9, ""); //
			cs.setString(10, V_USR_ID ); // 
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);
			
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CHARGE_TYPE", rs.getString("CHARGE_TYPE"));
				subObject.put("CHARGE_NAME", rs.getString("CHARGE_NAME"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("CHARGE_DT", rs.getString("CHARGE_DT"));
				subObject.put("VAT_NAME", rs.getString("VAT_NAME"));
				subObject.put("VAT_CD", rs.getString("VAT_CD"));
				subObject.put("CHARGE_AMT", rs.getInt("CHARGE_AMT"));
				subObject.put("VAT_AMT", rs.getInt("VAT_AMT"));
				subObject.put("REG_NO", rs.getString("BP_RGST_NO"));
				subObject.put("VAT_REF_AMT", rs.getInt("VAT_REF_AMT"));
				
				
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
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");
			String errorMsg = "";
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String M_CHARGE_NO = hashMap.get("M_CHARGE_NO") == null ? "" : hashMap.get("M_CHARGE_NO").toString();
					
					if(V_TYPE.equals("SEND") || V_TYPE.equals("CANCEL")){
						cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_SEND(?,?,?,?)");
						cs.setString(1, V_TYPE); //
						cs.setString(2, M_CHARGE_NO); //
						cs.setString(3, V_USR_ID); //
						cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
						
						cs.executeQuery();
						
					}
					else if(V_TYPE.equals("D")){
						cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE); //
						cs.setString(2, M_CHARGE_NO); //
						cs.setString(3, ""); //
						cs.setString(4, ""); //
						cs.setString(5, ""); //
						cs.setString(6, ""); //
						cs.setString(7, ""); //
						cs.setString(8, ""); //
						cs.setString(9, ""); //
						cs.setString(10, V_USR_ID); //
						cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
						
						cs.executeQuery();
						rs = (ResultSet) cs.getObject(11);
						
						while (rs.next()) {
							errorMsg += M_CHARGE_NO + " : " + rs.getString("MSG") + "<br>";
						}

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print(errorMsg);
						pw.flush();
						pw.close();
					}
				}
			} 
			else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String M_CHARGE_NO = jsondata.get("M_CHARGE_NO") == null ? "" : jsondata.get("M_CHARGE_NO").toString();
				
				if(V_TYPE.equals("SEND") || V_TYPE.equals("CANCEL")){
					cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_SEND(?,?,?,?)");
					cs.setString(1, V_TYPE); //
					cs.setString(2, M_CHARGE_NO); //
					cs.setString(3, V_USR_ID); //
					cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
					
					cs.executeQuery();
					
				}
				else if(V_TYPE.equals("D")){
					cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //
					cs.setString(2, M_CHARGE_NO); //
					cs.setString(3, ""); //
					cs.setString(4, ""); //
					cs.setString(5, ""); //
					cs.setString(6, ""); //
					cs.setString(7, ""); //
					cs.setString(8, ""); //
					cs.setString(9, ""); //
					cs.setString(10, V_USR_ID); //
					cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
					
					cs.executeQuery();
					rs = (ResultSet) cs.getObject(11);
					
					while (rs.next()) {
						errorMsg += M_CHARGE_NO + " : " + rs.getString("MSG") + "<br>";
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(errorMsg);
					pw.flush();
					pw.close();
				}
			}
		}
			
			
		
		else if (V_TYPE.equals("W_SEND")) {
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_M_BP_DUTY_CHARGE_SEND(?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, V_USR_ID); //
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
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


