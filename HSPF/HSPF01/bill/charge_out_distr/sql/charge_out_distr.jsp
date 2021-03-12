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
		
		if (V_TYPE.equals("GRID_S")) {
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			cs.setString(13, ""); //
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			
			rs = cs.executeQuery();
			rs = (ResultSet) cs.getObject(14);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("M_CHARGE_SEQ", rs.getString("M_CHARGE_SEQ"));
				subObject.put("CHARGE_TYPE", rs.getString("CHARGE_TYPE"));
				subObject.put("CHARGE_NAME", rs.getString("CHARGE_NAME"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("VAT_CD", rs.getString("VAT_CD"));
				subObject.put("CHARGE_AMT", rs.getString("CHARGE_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("CHARGE_DT", rs.getString("CHARGE_DT"));
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
		else if (V_TYPE.equals("HS")) {
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_H_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
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
			cs.setString(14, null); //
			cs.setString(15, null  ); //  
			cs.setString(16, null ); // 
			cs.setString(17, null ); // 
			cs.setString(18, null ); // 
			cs.setString(19, null ); // 
			cs.setString(20, null ); // 
			cs.setString(21, null ); // 
			cs.setString(22, null); //
			cs.setString(23, null ); // 
			cs.setString(24, null); //
			cs.setString(25, null ); // 
			cs.setString(26, null); //
			cs.setString(27, null); //
			cs.setString(28, V_USR_ID ); // 
			cs.registerOutParameter(29, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(29);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("BASE_DT", rs.getString("BASE_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("TAX_DT", rs.getString("TAX_DT"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("IN_NO", rs.getString("IN_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("ISSUE_AMT", rs.getString("ISSUE_AMT"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("IN_NM", rs.getString("IN_NM"));
				subObject.put("AV_NM", rs.getString("AV_NM"));
				subObject.put("AV_DT", rs.getString("AV_DT"));
				subObject.put("TR_AMT", rs.getString("TR_AMT"));
				subObject.put("JD_AMT", rs.getString("JD_AMT"));
				subObject.put("JD_RM_AMT", rs.getString("JD_RM_AMT"));
				subObject.put("REF_CHARGE_NO", rs.getString("REF_CHARGE_NO"));
				subObject.put("IN_TOT_AMT", rs.getString("IN_TOT_AMT"));
				subObject.put("SD_AMT", rs.getString("SD_AMT"));
				subObject.put("RM_AMT", rs.getString("RM_AMT"));
				subObject.put("RK_AMT", rs.getString("RK_AMT"));
				subObject.put("SHIP_NM", rs.getString("SHIP_NM"));
				subObject.put("CK_AMT", rs.getString("CK_AMT"));
				subObject.put("ERP_YN", rs.getString("ERP_YN"));
				
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
		else if (V_TYPE.equals("WS")) {
			String V_CH_MST_NO = request.getParameter("V_CH_MST_NO") == null ? "" : request.getParameter("V_CH_MST_NO").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			String V_A_BP_CD = request.getParameter("V_A_BP_CD") == null ? "" : request.getParameter("V_A_BP_CD").toUpperCase();
			String V_VESEL = request.getParameter("V_VESEL") == null ? "" : request.getParameter("V_VESEL").toUpperCase();
			String V_VESEL_BP_NM = request.getParameter("V_VESEL_BP_NM") == null ? "" : request.getParameter("V_VESEL_BP_NM").toUpperCase();
			String V_ID_DT = request.getParameter("V_ID_DT") == null ? "" : request.getParameter("V_ID_DT");
			String V_IN_DT = request.getParameter("V_IN_DT") == null ? "" : request.getParameter("V_IN_DT");
			if(V_ID_DT.length() > 10){
				V_ID_DT = V_ID_DT.substring(0,10);
			}
			if(V_IN_DT.length() > 10){
				V_IN_DT = V_IN_DT.substring(0,10);
			}
			
			cs = conn.prepareCall("{call USP_M_CHARGE_OUT_H_DISTR_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_COMP_ID); //
			cs.setString(3, V_CH_MST_NO); //V_CH_MST_NO
			cs.setString(4, ""); //V_CH_DT
			cs.setString(5, V_A_BP_CD); //V_A_BP_CD
			cs.setString(6, V_VESEL); //V_VESEL
			cs.setString(7, V_ITEM_NM); //V_ITEM_NM
			cs.setString(8, V_ID_DT); //V_ID_DT
			cs.setString(9, V_IN_DT); //V_IN_DT
			cs.setString(10, ""); //V_QTY
			cs.setString(11, ""); //V_ID_DOC_NO
			cs.setString(12, V_BL_DOC_NO ); //V_BL_DOC_NO 
			cs.setString(13, "" ); //V_ID_AMT 
			cs.setString(14, ""); //V_LS_DT
			cs.setString(15, ""  ); //V_IN_SL_NM  
			cs.setString(16, "" ); //V_CK_AMT 
			cs.setString(17, "" ); //V_AR_NM 
			cs.setString(18, "" ); //V_AR_DT 
			cs.setString(19, "" ); //V_BF_AMT 
			cs.setString(20, "" ); //V_TR_AMT 
			cs.setString(21, "" ); //V_TR_LT_AMT 
			cs.setString(22, ""); //V_TR_REF_CH_NO
			cs.setString(23, "" ); //V_IN_AMT 
			cs.setString(24, ""); //V_OUT_AMT
			cs.setString(25, "" ); //V_RM_AMT 
			cs.setString(26, ""); //V_SH_AMT
			cs.setString(27, V_VESEL_BP_NM ); //V_VESEL_BP_NM 
			cs.setString(28, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(29, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(29);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CH_MST_NO", rs.getString("CH_MST_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("A_BP_CD", rs.getString("A_BP_CD"));
				subObject.put("VESEL", rs.getString("VESEL"));
				subObject.put("VESEL_BP_NM", rs.getString("VESEL_BP_NM"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("ID_DOC_NO", rs.getString("ID_DOC_NO"));
				
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
		else if (V_TYPE.equals("NEW")) {
			//자동 마스터번호 채번.
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_H_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			cs.setString(14, null); //
			cs.setString(15, null  ); //  
			cs.setString(16, null ); // 
			cs.setString(17, null ); // 
			cs.setString(18, null ); // 
			cs.setString(19, null ); // 
			cs.setString(20, null ); // 
			cs.setString(21, null ); // 
			cs.setString(22, null); //
			cs.setString(23, null ); // 
			cs.setString(24, null); //
			cs.setString(25, null ); // 
			cs.setString(26, null); //
			cs.setString(27, null); //
			cs.setString(28, V_USR_ID ); // 
			cs.registerOutParameter(29, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(29);
			
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
		else if (V_TYPE.equals("GRID_JK")) {
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			
		    cs = conn.prepareCall("{call USP_M_BP_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			cs.setString(13, "");
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);

// 			String sql = "select CHARGE_TYPE, CHARGE_NAME from M_BP_CHARGE_D_INFO order by CHARGE_TYPE";
			
// 			e_cs = e_conn.prepareCall("{call dbo.getData(?)}");
// 			e_cs.setString(1, sql); 
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(14);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CHARGE_TYPE", rs.getString("CHARGE_TYPE"));
				subObject.put("CHARGE_NAME", rs.getString("CHARGE_NAME"));
				subObject.put("M_BP_CD", "");
				subObject.put("REG_NO", "");
				if(rs.getString("CHARGE_TYPE").equals("SPC18")){
					//조광상사 부대경비 등록시 취급수수료에는 아래의 사항들 고정.
					subObject.put("REG_NO", "601-48-86725");
					subObject.put("M_BP_CD", "00132");
					subObject.put("VAT_CD", "V01");
					subObject.put("CHARGE_AMT", "20000");
					subObject.put("VAT_AMT", "2000");
				}
				
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

		// 저장
		else if (V_TYPE.equals("HU")) {
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			String V_BASE_DT = request.getParameter("V_BASE_DT") == null ? "" : request.getParameter("V_BASE_DT").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			
			String V_RK_AMT = request.getParameter("V_RK_AMT") == "" ? "0" : request.getParameter("V_RK_AMT").toUpperCase();
			
			if (V_BASE_DT.length() > 10){
				V_BASE_DT = V_BASE_DT.substring(0,10);
			}
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_H_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, V_BASE_DT); //
			cs.setString(4, "00132"); //관리자가 등록해도 조광이 등록한것처럼.
			cs.setString(5, null); //
			cs.setString(6, null); //
			cs.setString(7, null); //
			cs.setString(8, null); //
			cs.setInt(9, 0); //
			cs.setString(10,null); //
			cs.setString(11,V_BL_DOC_NO ); //
			cs.setInt(12, 0); // 
			cs.setString(13,null  ); // 
			cs.setString(14,null ); //
			cs.setInt(15, 0); //  
			cs.setString(16,null  ); // 
			cs.setString(17,null  ); // 
			cs.setInt(18,0); // 
			cs.setInt(19,0); // 
			cs.setInt(20,0); // 
			cs.setString(21, null  ); // 
			cs.setInt(22, 0); //
			cs.setInt(23, 0); // 
			cs.setInt(24, 0); //
			cs.setInt(25,Integer.parseInt(V_RK_AMT)); // 
			cs.setString(26,null ); //
			cs.setString(27, null ); // 
			cs.setString(28, V_USR_ID ); // 
			cs.registerOutParameter(29, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
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
					String V_M_CHARGE_SEQ  = hashMap.get("M_CHARGE_SEQ") == null ? "" : hashMap.get("M_CHARGE_SEQ").toString();
					String V_CHARGE_TYPE  = hashMap.get("CHARGE_TYPE") == null ? "" : hashMap.get("CHARGE_TYPE").toString();
					String V_CHARGE_NAME  = hashMap.get("CHARGE_NAME") == null ? "" : hashMap.get("CHARGE_NAME").toString();
					String V_CHARGE_DT  = hashMap.get("CHARGE_DT") == null ? "" : hashMap.get("CHARGE_DT").toString();
					String V_M_BP_CD  = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String V_VAT_CD  = hashMap.get("VAT_CD") == null ? "" : hashMap.get("VAT_CD").toString();
					String V_CHARGE_AMT  = hashMap.get("CHARGE_AMT") == null ? "" : hashMap.get("CHARGE_AMT").toString();
					String V_VAT_AMT  = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_REMARK  = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_REG_NO  = hashMap.get("REG_NO") == null ? "" : hashMap.get("REG_NO").toString();
					
					if(V_CHARGE_DT.length() > 10){
						V_CHARGE_DT = V_CHARGE_DT.substring(0,10);
					}
					
					String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
					
					cs = conn.prepareCall("{call USP_M_BP_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					cs.setString(1, V_TYPE); //
					cs.setString(2, V_M_CHARGE_NO); //V_M_CHARGE_NO
					cs.setString(3, V_M_CHARGE_SEQ); //V_M_CHARGE_SEQ
					cs.setString(4, V_CHARGE_TYPE); //V_CHARGE_TYPE
					cs.setString(5, V_CHARGE_DT); //V_CHARGE_DT
					cs.setString(6, V_M_BP_CD); //V_M_BP_CD
					cs.setString(7, V_VAT_CD); //V_VAT_CD
					cs.setString(8, V_CHARGE_AMT); //V_CHARGE_AMT
					cs.setString(9, V_VAT_AMT); //V_VAT_AMT
					cs.setString(10, ""); //V_ERP_YN
					cs.setString(11, V_REG_NO); //V_REG_NO
					cs.setString(12, V_REMARK); //V_REMARK
					cs.setString(13, V_USR_ID); //V_USR_ID
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					
					cs.executeQuery();
					
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
// 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_M_CHARGE_SEQ  = jsondata.get("M_CHARGE_SEQ") == null ? "" : jsondata.get("M_CHARGE_SEQ").toString();
				String V_CHARGE_TYPE  = jsondata.get("CHARGE_TYPE") == null ? "" : jsondata.get("CHARGE_TYPE").toString();
				String V_CHARGE_NAME  = jsondata.get("CHARGE_NAME") == null ? "" : jsondata.get("CHARGE_NAME").toString();
				String V_CHARGE_DT  = jsondata.get("CHARGE_DT") == null ? "" : jsondata.get("CHARGE_DT").toString();
				String V_M_BP_CD  = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String V_VAT_CD  = jsondata.get("VAT_CD") == null ? "" : jsondata.get("VAT_CD").toString();
				String V_CHARGE_AMT  = jsondata.get("CHARGE_AMT") == null ? "0" : jsondata.get("CHARGE_AMT").toString();
				String V_VAT_AMT  = jsondata.get("VAT_AMT") == null ? "0" : jsondata.get("VAT_AMT").toString();
				String V_REMARK  = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_REG_NO  = jsondata.get("REG_NO") == null ? "" : jsondata.get("REG_NO").toString();
				
				if(V_CHARGE_DT.length() > 10){
					V_CHARGE_DT = V_CHARGE_DT.substring(0,10);
				}
				
				String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
				
				cs = conn.prepareCall("{call USP_M_BP_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, V_TYPE); //
				cs.setString(2, V_M_CHARGE_NO); //V_M_CHARGE_NO
				cs.setString(3, V_M_CHARGE_SEQ); //V_M_CHARGE_SEQ
				cs.setString(4, V_CHARGE_TYPE); //V_CHARGE_TYPE
				cs.setString(5, V_CHARGE_DT); //V_CHARGE_DT
				cs.setString(6, V_M_BP_CD); //V_M_BP_CD
				cs.setString(7, V_VAT_CD); //V_VAT_CD
				cs.setString(8, V_CHARGE_AMT); //V_CHARGE_AMT
				cs.setString(9, V_VAT_AMT); //V_VAT_AMT
				cs.setString(10, ""); //V_ERP_YN
				cs.setString(11, V_REG_NO); //V_REG_NO
				cs.setString(12, V_REMARK); //V_REMARK
				cs.setString(13, V_USR_ID); //V_USR_ID
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
				
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
 					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_CHARGE_TYPE  = hashMap.get("CHARGE_TYPE") == null ? "" : hashMap.get("CHARGE_TYPE").toString();
					String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
					
					cs = conn.prepareCall("{call USP_M_BP_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					cs.setString(1, V_TYPE); //
					cs.setString(2, V_M_CHARGE_NO); //V_M_CHARGE_NO
					cs.setString(3, ""); //V_CHARGE_NO
					cs.setString(4, V_CHARGE_TYPE); //V_CHARGE_TYPE
					cs.setString(5, ""); //V_CHARGE_DT
					cs.setString(6, ""); //V_M_BP_CD
					cs.setString(7, ""); //V_VAT_CD
					cs.setString(8, ""); //V_CHARGE_AMT
					cs.setString(9, ""); //V_VAT_AMT
					cs.setString(10, ""); //V_ERP_YN
					cs.setString(11, ""); //V_REG_NO
					cs.setString(12, ""); //V_REMARK
					cs.setString(13, V_USR_ID); //V_USR_ID
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					
					cs.executeQuery();
					
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_CHARGE_TYPE  = jsondata.get("CHARGE_TYPE") == null ? "" : jsondata.get("CHARGE_TYPE").toString();
				String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
				
				cs = conn.prepareCall("{call USP_M_BP_CHARGE_D_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, V_TYPE); //
				cs.setString(2, V_M_CHARGE_NO); //V_M_CHARGE_NO
				cs.setString(3, ""); //V_CHARGE_NO
				cs.setString(4, V_CHARGE_TYPE); //V_CHARGE_TYPE
				cs.setString(5, ""); //V_CHARGE_DT
				cs.setString(6, ""); //V_M_BP_CD
				cs.setString(7, ""); //V_VAT_CD
				cs.setString(8, ""); //V_CHARGE_AMT
				cs.setString(9, ""); //V_VAT_AMT
				cs.setString(10, ""); //V_ERP_YN
				cs.setString(11, ""); //V_REG_NO
				cs.setString(12, ""); //V_REMARK
				cs.setString(13, V_USR_ID); //V_USR_ID
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
				
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


