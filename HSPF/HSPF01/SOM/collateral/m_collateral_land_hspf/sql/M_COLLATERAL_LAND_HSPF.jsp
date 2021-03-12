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
		String V_COLLATERAL_NO = request.getParameter("V_COLLATERAL_NO") == null ? "" : request.getParameter("V_COLLATERAL_NO").toUpperCase();
		String V_ASGN_DT_FR = request.getParameter("V_ASGN_DT_FR") == null ? "" : request.getParameter("V_ASGN_DT_FR").substring(0, 10);
		String V_ASGN_DT_TO = request.getParameter("V_ASGN_DT_TO") == null ? "" : request.getParameter("V_ASGN_DT_TO").substring(0, 10);
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_USE_YN = request.getParameter("V_USE_YN") == null ? "" : request.getParameter("V_USE_YN").toUpperCase();
		String V_DB_TYPE = request.getParameter("V_DB_TYPE") == null ? "" : request.getParameter("V_DB_TYPE").toUpperCase();
		
		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_004_M_COLLATERAL_MST_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_COLLATERAL_NO);//V_COLLATERAL_NO 
			cs.setString(4, "");//V_BP_CD 		
			cs.setString(5, "");//V_ASGN_DT 		
			cs.setString(6, "");//V_RENEW_DT 		
			cs.setString(7, "");//V_EFFECTIVE_DT 	
			cs.setString(8, "");//V_EXPIRY_DT 	
			cs.setString(9, "");//V_ASGN_AMT 		
			cs.setString(10, "");//V_WARNT_ORG_NM 	
			cs.setString(11, "");//V_STOCK_NO 		
			cs.setString(12, "");//V_DEL_DT 		
			cs.setString(13, "");//V_REMARK 		
			cs.setString(14, "");//V_USE_YN 		
			cs.setString(15, "");//V_USE_AMT 		
			cs.setString(16, "D");//V_DB_TYPE 		
			cs.setString(17, "");//V_COLLATERAL_AMT
			cs.setString(18, "");//V_SENIOR_AMT 	
			cs.setString(19, "");//V_ACCEPTS 		
			cs.setString(20, "");//V_DEBTOR 		
			cs.setString(21, "");//V_DEBTOR_ADDR 	
			cs.setString(22, "");//V_DB_TYPE2 		
			cs.setString(23, "");//V_DEPT_CD 		
			cs.setString(24, "");//V_TYPE_CD2 		
			cs.setString(25, "");//V_SEQ_D	
			cs.setString(26, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(27);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COLLATERAL_NO", rs.getString("COLLATERAL_NO"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ASGN_DT", rs.getString("ASGN_DT"));
				subObject.put("RENEW_DT", rs.getString("RENEW_DT"));
				subObject.put("EFFECTIVE_DT", rs.getString("EFFECTIVE_DT"));
				subObject.put("EXPIRY_DT", rs.getString("EXPIRY_DT"));
				subObject.put("ASGN_AMT", rs.getString("ASGN_AMT"));
				subObject.put("WARNT_ORG_NM", rs.getString("WARNT_ORG_NM"));
				subObject.put("STOCK_NO", rs.getString("STOCK_NO"));
				subObject.put("DEL_DT", rs.getString("DEL_DT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("USE_YN", rs.getString("USE_YN"));
				subObject.put("USE_AMT", rs.getString("USE_AMT"));
				subObject.put("DB_TYPE", rs.getString("DB_TYPE"));
				subObject.put("COLLATERAL_AMT", rs.getString("COLLATERAL_AMT"));
				subObject.put("SENIOR_AMT", rs.getString("SENIOR_AMT"));
				subObject.put("ACCEPTS", rs.getString("ACCEPTS"));
				subObject.put("DEBTOR", rs.getString("DEBTOR"));
				subObject.put("DEBTOR_ADDR", rs.getString("DEBTOR_ADDR"));
				subObject.put("DB_TYPE2", rs.getString("DB_TYPE2"));
				subObject.put("DB_TYPE_NM", rs.getString("DB_TYPE_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("DS")){
			cs = conn.prepareCall("call USP_004_M_COLLATERAL_MST_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_COLLATERAL_NO);//V_COLLATERAL_NO 
			cs.setString(4, "");//V_BP_CD 		
			cs.setString(5, "");//V_ASGN_DT 		
			cs.setString(6, "");//V_RENEW_DT 		
			cs.setString(7, "");//V_EFFECTIVE_DT 	
			cs.setString(8, "");//V_EXPIRY_DT 	
			cs.setString(9, "");//V_ASGN_AMT 		
			cs.setString(10, "");//V_WARNT_ORG_NM 	
			cs.setString(11, "");//V_STOCK_NO 		
			cs.setString(12, "");//V_DEL_DT 		
			cs.setString(13, "");//V_REMARK 		
			cs.setString(14, "");//V_USE_YN 		
			cs.setString(15, "");//V_USE_AMT 		
			cs.setString(16, "D");//V_DB_TYPE 		
			cs.setString(17, "");//V_COLLATERAL_AMT
			cs.setString(18, "");//V_SENIOR_AMT 	
			cs.setString(19, "");//V_ACCEPTS 		
			cs.setString(20, "");//V_DEBTOR 		
			cs.setString(21, "");//V_DEBTOR_ADDR 	
			cs.setString(22, "");//V_DB_TYPE2 		
			cs.setString(23, "");//V_DEPT_CD 		
			cs.setString(24, "");//V_TYPE_CD2 		
			cs.setString(25, "");//V_SEQ_D	
			cs.setString(26, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(27);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COLLATERAL_NO", rs.getString("COLLATERAL_NO"));
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("S_BP_CD", rs.getString("BP_CD"));
				subObject.put("S_BP_NM", rs.getString("BP_NM"));
				subObject.put("TYPE_CD", rs.getString("TYPE_CD"));
				subObject.put("TYPE_NM", rs.getString("TYPE_NM"));
				
				subObject.put("ASGN_DT", rs.getString("ASGN_DT"));
				subObject.put("RENEW_DT", rs.getString("RENEW_DT"));
				subObject.put("EFFECTIVE_DT", rs.getString("EFFECTIVE_DT"));
				subObject.put("EXPIRY_DT", rs.getString("EXPIRY_DT"));
				
				subObject.put("ASGN_AMT", rs.getString("ASGN_AMT"));
				subObject.put("WARNT_ORG_NM", rs.getString("WARNT_ORG_NM"));
				subObject.put("STOCK_NO", rs.getString("STOCK_NO"));
				subObject.put("DEL_DT", rs.getString("DEL_DT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				
// 				subObject.put("DB_TYPE", rs.getString("DB_TYPE"));
				subObject.put("COLLATERAL_AMT", rs.getString("COLLATERAL_AMT"));
				subObject.put("SENIOR_AMT", rs.getString("SENIOR_AMT"));
				subObject.put("ACCEPTS", rs.getString("ACCEPTS"));
				subObject.put("DEBTOR", rs.getString("DEBTOR"));
				subObject.put("DEBTOR_ADDR", rs.getString("DEBTOR_ADDR"));
				subObject.put("DB_TYPE2", rs.getString("DB_TYPE2"));
				subObject.put("DB_TYPE_NM", rs.getString("DB_TYPE_NM"));
				
				subObject.put("SEQ_D", rs.getString("SEQ"));
				subObject.put("V_TYPE", "V");
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}else if (V_TYPE.equals("IH")) {
			String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
			String V_STOCK_NO = request.getParameter("V_STOCK_NO") == null ? "" : request.getParameter("V_STOCK_NO").toUpperCase();
			String V_WARNT_ORG_NM = request.getParameter("V_WARNT_ORG_NM") == null ? "" : request.getParameter("V_WARNT_ORG_NM").toUpperCase();
			String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toUpperCase();
			String V_ACCEPTS = request.getParameter("V_ACCEPTS") == null ? "" : request.getParameter("V_ACCEPTS").toUpperCase();
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String V_DEBTOR = request.getParameter("V_DEBTOR") == null ? "" : request.getParameter("V_DEBTOR").toUpperCase();
			String V_DEBTOR_ADDR = request.getParameter("V_DEBTOR_ADDR") == null ? "" : request.getParameter("V_DEBTOR_ADDR").toUpperCase();
			String V_ASGN_AMT = request.getParameter("V_ASGN_AMT") == null ? "" : request.getParameter("V_ASGN_AMT").toUpperCase();
			String V_COLLATERAL_AMT = request.getParameter("V_COLLATERAL_AMT") == null ? "" : request.getParameter("V_COLLATERAL_AMT").toUpperCase();
			String V_SENIOR_AMT = request.getParameter("V_SENIOR_AMT") == null ? "" : request.getParameter("V_SENIOR_AMT").toUpperCase();
			String V_ASGN_DT = (request.getParameter("V_ASGN_DT") == null || request.getParameter("V_ASGN_DT") == "") ? "" : request.getParameter("V_ASGN_DT").substring(0, 10);
			String V_EFFECTIVE_DT = (request.getParameter("V_EFFECTIVE_DT") == null || request.getParameter("V_EFFECTIVE_DT") == "") ? "" : request.getParameter("V_EFFECTIVE_DT").substring(0, 10);
			String V_RENEW_DT = (request.getParameter("V_RENEW_DT") == null || request.getParameter("V_RENEW_DT") == "") ? "" : request.getParameter("V_RENEW_DT").substring(0, 10);
			
			cs = conn.prepareCall("call USP_004_M_COLLATERAL_MST_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_COLLATERAL_NO);//V_COLLATERAL_NO 
			cs.setString(4, V_BP_CD);//V_BP_CD 		
			cs.setString(5, V_ASGN_DT);//V_ASGN_DT 		
			cs.setString(6, V_RENEW_DT);//V_RENEW_DT 		
			cs.setString(7, V_EFFECTIVE_DT);//V_EFFECTIVE_DT 	
			cs.setString(8, "");//V_EXPIRY_DT 	
			cs.setString(9, V_ASGN_AMT);//V_ASGN_AMT 		
			cs.setString(10, V_WARNT_ORG_NM);//V_WARNT_ORG_NM 	
			cs.setString(11, V_STOCK_NO);//V_STOCK_NO 		
			cs.setString(12, "");//V_DEL_DT 		
			cs.setString(13, V_REMARK);//V_REMARK 		
			cs.setString(14, "");//V_USE_YN 		
			cs.setString(15, "");//V_USE_AMT 		
			cs.setString(16, "D");//V_DB_TYPE 		
			cs.setString(17, V_COLLATERAL_AMT);//V_COLLATERAL_AMT
			cs.setString(18, V_SENIOR_AMT);//V_SENIOR_AMT 	
			cs.setString(19, V_ACCEPTS);//V_ACCEPTS 		
			cs.setString(20, V_DEBTOR);//V_DEBTOR 		
			cs.setString(21, V_DEBTOR_ADDR);//V_DEBTOR_ADDR 	
			cs.setString(22, "");//V_DB_TYPE2 		
			cs.setString(23, V_DEPT_CD);//V_DEPT_CD 		
			cs.setString(24, "D");//V_TYPE_CD2 		
			cs.setString(25, "");//V_SEQ_D	
			cs.setString(26, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(27);

			while (rs.next()) {
				jsonObject.put("COLLATERAL_NO", rs.getString("COLLATERAL_NO"));
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		} else if (V_TYPE.equals("ID") || V_TYPE.equals("DD")) {

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						String V_TYPE_CD = hashMap.get("TYPE_CD") == null ? "" : hashMap.get("TYPE_CD").toString();
						String V_STOCK_NO = hashMap.get("STOCK_NO") == null ? "" : hashMap.get("STOCK_NO").toString();
						String V_WARNT_ORG_NM = hashMap.get("WARNT_ORG_NM") == null ? "" : hashMap.get("WARNT_ORG_NM").toString();
						String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
						String V_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
						String V_SEQ_D = hashMap.get("SEQ_D") == null ? "" : hashMap.get("SEQ_D").toString();
						String V_DEBTOR = hashMap.get("DEBTOR") == null ? "" : hashMap.get("DEBTOR").toString();
						String V_DEBTOR_ADDR = hashMap.get("DEBTOR_ADDR") == null ? "" : hashMap.get("DEBTOR_ADDR").toString();
						String V_ASGN_AMT = hashMap.get("ASGN_AMT") == null ? "" : hashMap.get("ASGN_AMT").toString();
						String V_COLLATERAL_AMT = hashMap.get("COLLATERAL_AMT") == null ? "" : hashMap.get("COLLATERAL_AMT").toString();
						String V_SENIOR_AMT = hashMap.get("SENIOR_AMT") == null ? "" : hashMap.get("SENIOR_AMT").toString();
						String V_ASGN_DT = hashMap.get("ASGN_DT") == null ? "" : hashMap.get("ASGN_DT").toString().substring(0, 10);
						String V_EFFECTIVE_DT = hashMap.get("EFFECTIVE_DT") == null ? "" : hashMap.get("EFFECTIVE_DT").toString().substring(0, 10);
						String V_RENEW_DT = hashMap.get("RENEW_DT") == null ? "" : hashMap.get("RENEW_DT").toString().substring(0, 10);
						String V_DEL_DT = hashMap.get("DEL_DT") == null ? "" : hashMap.get("DEL_DT").toString().substring(0, 10);

						cs = conn.prepareCall("call USP_004_M_COLLATERAL_MST_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_COLLATERAL_NO);//V_COLLATERAL_NO 
						cs.setString(4, V_BP_CD);//V_BP_CD 		
						cs.setString(5, V_ASGN_DT);//V_ASGN_DT 		
						cs.setString(6, V_RENEW_DT);//V_RENEW_DT 		
						cs.setString(7, V_EFFECTIVE_DT);//V_EFFECTIVE_DT 	
						cs.setString(8, "");//V_EXPIRY_DT 	
						cs.setString(9, V_ASGN_AMT);//V_ASGN_AMT 		
						cs.setString(10, V_WARNT_ORG_NM);//V_WARNT_ORG_NM 	
						cs.setString(11, V_STOCK_NO);//V_STOCK_NO 		
						cs.setString(12, V_DEL_DT);//V_DEL_DT 		
						cs.setString(13, V_REMARK);//V_REMARK 		
						cs.setString(14, "");//V_USE_YN 		
						cs.setString(15, "");//V_USE_AMT 		
						cs.setString(16, "D");//V_DB_TYPE 		
						cs.setString(17, V_COLLATERAL_AMT);//V_COLLATERAL_AMT
						cs.setString(18, V_SENIOR_AMT);//V_SENIOR_AMT 	
						cs.setString(19, "");//V_ACCEPTS 		
						cs.setString(20, V_DEBTOR);//V_DEBTOR 		
						cs.setString(21, V_DEBTOR_ADDR);//V_DEBTOR_ADDR 	
						cs.setString(22, "");//V_DB_TYPE2 		
						cs.setString(23, V_DEPT_CD);//V_DEPT_CD 		
						cs.setString(24, V_TYPE_CD);//V_TYPE_CD2 		
						cs.setString(25, V_SEQ_D);//V_SEQ_D	
						cs.setString(26, V_USR_ID);//V_USR_ID 		
						cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}
				} else {
					JSONObject jsondata = JSONObject.fromObject(jsonData);
					String V_TYPE_CD = jsondata.get("TYPE_CD") == null ? "" : jsondata.get("TYPE_CD").toString();
					String V_STOCK_NO = jsondata.get("STOCK_NO") == null ? "" : jsondata.get("STOCK_NO").toString();
					String V_WARNT_ORG_NM = jsondata.get("WARNT_ORG_NM") == null ? "" : jsondata.get("WARNT_ORG_NM").toString();
					String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
					String V_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
					String V_SEQ_D = jsondata.get("SEQ_D") == null ? "" : jsondata.get("SEQ_D").toString();
					String V_DEBTOR = jsondata.get("DEBTOR") == null ? "" : jsondata.get("DEBTOR").toString();
					String V_DEBTOR_ADDR = jsondata.get("DEBTOR_ADDR") == null ? "" : jsondata.get("DEBTOR_ADDR").toString();
					String V_ASGN_AMT = jsondata.get("ASGN_AMT") == null ? "" : jsondata.get("ASGN_AMT").toString();
					String V_COLLATERAL_AMT = jsondata.get("COLLATERAL_AMT") == null ? "" : jsondata.get("COLLATERAL_AMT").toString();
					String V_SENIOR_AMT = jsondata.get("SENIOR_AMT") == null ? "" : jsondata.get("SENIOR_AMT").toString();
					String V_ASGN_DT = jsondata.get("ASGN_DT") == null ? "" : jsondata.get("ASGN_DT").toString().substring(0, 10);
					String V_EFFECTIVE_DT = jsondata.get("EFFECTIVE_DT") == null ? "" : jsondata.get("EFFECTIVE_DT").toString().substring(0, 10);
					String V_RENEW_DT = jsondata.get("RENEW_DT") == null ? "" : jsondata.get("RENEW_DT").toString().substring(0, 10);
					String V_DEL_DT = jsondata.get("DEL_DT") == null ? "" : jsondata.get("DEL_DT").toString().substring(0, 10);

					cs = conn.prepareCall("call USP_004_M_COLLATERAL_MST_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_COLLATERAL_NO);//V_COLLATERAL_NO 
					cs.setString(4, V_BP_CD);//V_BP_CD 		
					cs.setString(5, V_ASGN_DT);//V_ASGN_DT 		
					cs.setString(6, V_RENEW_DT);//V_RENEW_DT 		
					cs.setString(7, V_EFFECTIVE_DT);//V_EFFECTIVE_DT 	
					cs.setString(8, "");//V_EXPIRY_DT 	
					cs.setString(9, V_ASGN_AMT);//V_ASGN_AMT 		
					cs.setString(10, V_WARNT_ORG_NM);//V_WARNT_ORG_NM 	
					cs.setString(11, V_STOCK_NO);//V_STOCK_NO 		
					cs.setString(12, V_DEL_DT);//V_DEL_DT 		
					cs.setString(13, V_REMARK);//V_REMARK 		
					cs.setString(14, "");//V_USE_YN 		
					cs.setString(15, "");//V_USE_AMT 		
					cs.setString(16, "D");//V_DB_TYPE 		
					cs.setString(17, V_COLLATERAL_AMT);//V_COLLATERAL_AMT
					cs.setString(18, V_SENIOR_AMT);//V_SENIOR_AMT 	
					cs.setString(19, "");//V_ACCEPTS 		
					cs.setString(20, V_DEBTOR);//V_DEBTOR 		
					cs.setString(21, V_DEBTOR_ADDR);//V_DEBTOR_ADDR 	
					cs.setString(22, "");//V_DB_TYPE2 		
					cs.setString(23, V_DEPT_CD);//V_DEPT_CD 		
					cs.setString(24, V_TYPE_CD);//V_TYPE_CD2 		
					cs.setString(25, V_SEQ_D);//V_SEQ_D	
					cs.setString(26, V_USR_ID);//V_USR_ID 				
					cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
			}
			
		}else if (V_TYPE.equals("P")) {
			cs = conn.prepareCall("call USP_004_M_COLLATERAL_POP_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_COLLATERAL_NO 
			cs.setString(4, "");//V_BP_CD 		
			cs.setString(5, V_ASGN_DT_FR);//V_ASGN_DT_FR 		
			cs.setString(6, V_ASGN_DT_TO);//V_ASGN_DT_TO 		
			cs.setString(7, "");//V_DEL_DT 	
			cs.setString(8, V_USE_YN);//V_USE_YN 	
			cs.setString(9, V_DB_TYPE);//V_DB_TYPE 		
			cs.setString(10, "");//V_DB_TYPE2 	
			cs.setString(11, "");//V_DEPT_CD 		
			cs.setString(12, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(13);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COLLATERAL_NO", rs.getString("COLLATERAL_NO"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ASGN_DT", rs.getString("ASGN_DT"));
				subObject.put("RENEW_DT", rs.getString("RENEW_DT"));
				subObject.put("EFFECTIVE_DT", rs.getString("EFFECTIVE_DT"));
				subObject.put("EXPIRY_DT", rs.getString("EXPIRY_DT"));
				subObject.put("ASGN_AMT", rs.getString("ASGN_AMT"));
				subObject.put("WARNT_ORG_NM", rs.getString("WARNT_ORG_NM"));
				subObject.put("STOCK_NO", rs.getString("STOCK_NO"));
// 				subObject.put("DEL_DT", rs.getString("DEL_DT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("DB_TYPE2", rs.getString("DB_TYPE2"));
				subObject.put("DB_TYPE2_NM", rs.getString("DB_TYPE2_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				
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


