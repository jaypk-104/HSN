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
<%@ include file="/HSPF01/common/DB_Connection_ERP_TEMP.jsp"%>
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
		
		
		if (V_TYPE.equals("S")) {
			String V_BASE_FROM_DT = request.getParameter("V_BASE_FROM_DT") == null ? "" : request.getParameter("V_BASE_FROM_DT");
			String V_BASE_TO_DT = request.getParameter("V_BASE_TO_DT") == null ? "" : request.getParameter("V_BASE_TO_DT");
			String V_PAY_YN = request.getParameter("V_PAY_YN") == null ? "" : request.getParameter("V_PAY_YN").toUpperCase();
			String V_ERP_YN = request.getParameter("V_ERP_YN") == null ? "" : request.getParameter("V_ERP_YN").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_GL_YN = request.getParameter("V_GL_YN") == null ? "" : request.getParameter("V_GL_YN").toUpperCase();
			
			if(V_BASE_FROM_DT.length() > 10){
				V_BASE_FROM_DT = V_BASE_FROM_DT.substring(0,10);
			}
			if(V_BASE_TO_DT.length() > 10){
				V_BASE_TO_DT = V_BASE_TO_DT.substring(0,10);
			}
			/*
			//ERP 기준 조회
			e_cs = e_conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?)}");
			e_cs.setString(1, V_TYPE); //
			e_cs.setString(2, ""); //
			e_cs.setString(3, V_BASE_FROM_DT); //
			e_cs.setString(4, V_BASE_TO_DT); //
			e_cs.setString(5, V_PAY_YN); //
			e_cs.setString(6, V_ERP_YN); //
			e_cs.setString(7, "00132"); //어짜피 조광만 쓰는거니까 조광 BP_CD 고정으로 넣음.
			e_cs.setString(8, V_BL_DOC_NO); //
			e_cs.setString(9, V_GL_YN); //
			e_cs.setString(10, V_USR_ID); //
			
			rs = e_cs.executeQuery();
			*/
			
			
			//플랫폼 기준 조회
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, ""); //
			cs.setString(3, V_BASE_FROM_DT); //
			cs.setString(4, V_BASE_TO_DT); //
			cs.setString(5, V_PAY_YN); //
			cs.setString(6, V_ERP_YN); //
			cs.setString(7, "00132"); //어짜피 조광만 쓰는거니까 조광 BP_CD 고정으로 넣음.
			cs.setString(8, V_BL_DOC_NO); //
			cs.setString(9, V_GL_YN); //
			cs.setString(10, V_USR_ID); //
			
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);
			

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("BASE_DT", rs.getString("BASE_DT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("TOTAL_CHARGE_AMT", rs.getString("TOTAL_CHARGE_AMT"));
				subObject.put("TOTAL_VAT_AMT", rs.getString("TOTAL_VAT_AMT"));
				subObject.put("TOTAL_AMT", rs.getString("TOTAL_AMT"));
				subObject.put("ACCEPT_YN", rs.getString("ERP_YN"));
				subObject.put("ERP_YN", rs.getString("ERP_YN"));
				subObject.put("PAY_YN", rs.getString("PAY_YN"));
				subObject.put("FILE_YN", rs.getString("FILE_YN"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("GL_YN", rs.getString("GL_YN"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				
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
		else if (V_TYPE.equals("WS")){
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			/*
			//ERP 기준 조회
			e_cs = e_conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?)}");
			e_cs.setString(1, V_TYPE); //
			e_cs.setString(2, V_M_CHARGE_NO); //
			e_cs.setString(3, ""); //
			e_cs.setString(4, ""); //
			e_cs.setString(5, ""); //
			e_cs.setString(6, ""); //
			e_cs.setString(7, V_BP_CD); //
			e_cs.setString(8, V_BP_CD); //
			e_cs.setString(9, ""); //
			e_cs.setString(10, V_USR_ID); //
			
			rs = e_cs.executeQuery();
			*/
			
			
			//플랫폼 기준 조회
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, ""); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, V_BP_CD); //
			cs.setString(8, V_BP_CD); //
			cs.setString(9, ""); //
			cs.setString(10, V_USR_ID); //
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);
			
			

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("W_M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("W_BASE_DT", rs.getString("BASE_DT"));
				subObject.put("W_BP_CD", rs.getString("BP_CD"));
				subObject.put("W_VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("W_ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("W_TAX_DT", rs.getString("TAX_DT"));
				subObject.put("W_IN_DT", rs.getString("IN_DT"));
				subObject.put("W_QTY", rs.getString("QTY"));
				subObject.put("W_IN_NO", rs.getString("IN_NO"));
				subObject.put("W_BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("W_ISSUE_AMT", rs.getString("ISSUE_AMT"));
				subObject.put("W_ID_DT", rs.getString("ID_DT"));
				subObject.put("W_IN_NM", rs.getString("IN_NM"));
				subObject.put("W_CK_AMT", rs.getString("CK_AMT"));
				subObject.put("W_AV_NM", rs.getString("AV_NM"));
				subObject.put("W_AV_DT", rs.getString("AV_DT"));
				subObject.put("W_TR_AMT", rs.getString("TR_AMT"));
				subObject.put("W_JD_AMT", rs.getString("JD_AMT"));
				subObject.put("W_JD_RM_AMT", rs.getString("JD_RM_AMT"));
				subObject.put("W_REF_CHARGE_NO", rs.getString("REF_CHARGE_NO"));
				subObject.put("W_IN_TOT_AMT", rs.getString("IN_TOT_AMT"));
				subObject.put("W_SD_AMT", rs.getString("SD_AMT"));
				subObject.put("W_RM_AMT", rs.getString("RM_AMT"));
				subObject.put("W_RK_AMT", rs.getString("RK_AMT"));
				subObject.put("W_SHIP_NM", rs.getString("SHIP_NM"));
				subObject.put("W_ERP_YN", rs.getString("ERP_YN"));
				
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
		else if (V_TYPE.equals("W_GRID")){
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			
			/*
			//ERP 기준 조회
			e_cs = e_conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?)}");
			e_cs.setString(1, V_TYPE); //
			e_cs.setString(2, V_M_CHARGE_NO); //
			e_cs.setString(3, ""); //
			e_cs.setString(4, ""); //
			e_cs.setString(5, ""); //
			e_cs.setString(6, ""); //
			e_cs.setString(7, V_BP_CD); //
			e_cs.setString(8, ""); //
			e_cs.setString(9, ""); //
			e_cs.setString(10, V_USR_ID); //
			
			rs = e_cs.executeQuery();
			*/
			
			
			//플랫폼 기준 조회
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, ""); //
			cs.setString(4, ""); //
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, V_BP_CD); //
			cs.setString(8, ""); //
			cs.setString(9, ""); //
			cs.setString(10, V_USR_ID); //
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
				subObject.put("REG_NO", rs.getString("REG_NO"));
				
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
					
					
					/*
					//ERP 전송
					e_cs = e_conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?)}");
					e_cs.setString(1, V_TYPE); //
					e_cs.setString(2, M_CHARGE_NO); //
					e_cs.setString(3, ""); //
					e_cs.setString(4, ""); //
					e_cs.setString(5, ""); //
					e_cs.setString(6, ""); //
					e_cs.setString(7, ""); //
					e_cs.setString(8, ""); //
					e_cs.setString(9, ""); //
					e_cs.setString(10, V_USR_ID); //
					
					if(V_TYPE.equals("D") || V_TYPE.equals("ERPCancel")){
						rs = e_cs.executeQuery();
						
						while (rs.next()) {
							errorMsg += M_CHARGE_NO + " : " + rs.getString("MSG") + "<br>";
						}

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print(errorMsg);
						pw.flush();
						pw.close();
					}
					else{
						e_cs.execute();
					}
					*/
					
					//플랫폼 전송
					if(V_TYPE.equals("ERP") || V_TYPE.equals("ERPCancel")){
						cs = conn.prepareCall("call USP_003_M_BP_CHARGE_SEND(?,?,?,?)");
						cs.setString(1, V_TYPE); //
						cs.setString(2, M_CHARGE_NO); //
						cs.setString(3, V_USR_ID); //
						cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
						
						cs.executeQuery();
						
					}
					
					cs = conn.prepareCall("call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)");
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
					
					
					
					
					/*
					//플랫폼 기준
					if(V_TYPE.equals("D")){
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
					*/
				}
			} 
			else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String M_CHARGE_NO = jsondata.get("M_CHARGE_NO") == null ? "" : jsondata.get("M_CHARGE_NO").toString();
				
				
				/*
				//ERP 전송
				e_cs = e_conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, V_TYPE); //
				e_cs.setString(2, M_CHARGE_NO); //
				e_cs.setString(3, ""); //
				e_cs.setString(4, ""); //
				e_cs.setString(5, ""); //
				e_cs.setString(6, ""); //
				e_cs.setString(7, ""); //
				e_cs.setString(8, ""); //
				e_cs.setString(9, ""); //
				e_cs.setString(10, V_USR_ID); //
				
				if(V_TYPE.equals("D") || V_TYPE.equals("ERPCancel")){
					rs = e_cs.executeQuery();
					
					while (rs.next()) {
						errorMsg += M_CHARGE_NO + " : " + rs.getString("MSG") + "<br>";
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(errorMsg);
					pw.flush();
					pw.close();
				}
				else{
					e_cs.execute();
				}
				*/
				
				
				//플랫폼 전송
				if(V_TYPE.equals("ERP") || V_TYPE.equals("ERPCancel")){
					cs = conn.prepareCall("call USP_003_M_BP_CHARGE_SEND(?,?,?,?)");
					cs.setString(1, V_TYPE); //
					cs.setString(2, M_CHARGE_NO); //
					cs.setString(3, V_USR_ID); //
					cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
					
					cs.executeQuery();
					
				}
				
				cs = conn.prepareCall("call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?,?)");
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
				
				
				/*
				//플랫폼 기준
				if(V_TYPE.equals("D")){
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
				*/
			}
		}
		else if(V_TYPE.equals("ERP")){
			//팝업 윈도우에서 ERP 전송버튼
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO");
			
			
			/*
			//ERP 전송
			e_cs = e_conn.prepareCall("{call USP_M_BP_CHARGE_SELECT_MGM(?,?,?,?,?,?,?,?,?,?)}");
			e_cs.setString(1, V_TYPE); //
			e_cs.setString(2, V_M_CHARGE_NO); //
			e_cs.setString(3, ""); //
			e_cs.setString(4, ""); //
			e_cs.setString(5, ""); //
			e_cs.setString(6, ""); //
			e_cs.setString(7, ""); //
			e_cs.setString(8, ""); //
			e_cs.setString(9, ""); //
			e_cs.setString(10, V_USR_ID); //
			
			e_cs.execute();
			
			*/
			
			
			//플랫폼 전송
			cs = conn.prepareCall("call USP_003_M_BP_CHARGE_SEND(?,?,?,?)");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, V_USR_ID); //
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
		}
		
		
	} catch (Exception e) {

		e.printStackTrace();
// 		jsonObject.put("success", false);
// 		jsonObject.put("resultList", e.printStackTrace());

// 		response.setContentType("text/plain; charset=UTF-8");
// 		PrintWriter pw = response.getWriter();
// 		pw.print(jsonObject);
// 		pw.flush();
// 		pw.close();
		
		
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
		
		//MSSQL
				if (e_cs != null) try {
					e_cs.close();
				} catch (SQLException ex) {}
				if (e_rs != null) try {
					e_rs.close();
				} catch (SQLException ex) {}
				if (e_stmt != null) try {
					e_stmt.close();
				} catch (SQLException ex) {}
				if (e_conn != null) try {
					e_conn.close();
				} catch (SQLException ex) {}
		
	}
%>


