<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_LC_AMD_NO = request.getParameter("V_LC_AMD_NO") == null ? "" : request.getParameter("V_LC_AMD_NO").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_LC_DT_FR = request.getParameter("V_LC_DT_FR") == null ? "" : request.getParameter("V_LC_DT_FR").toString().substring(0, 10);
		String V_LC_DT_TO = request.getParameter("V_LC_DT_TO") == null ? "" : request.getParameter("V_LC_DT_TO").toString().substring(0, 10);

		if (V_TYPE.equals("T1S")) {
			cs = conn.prepareCall("call USP_003_M_LC_AMEND_H_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_LC_DT_FR);//V_LC_DT_FR
			cs.setString(4, V_LC_DT_TO);//V_LC_DT_TO
			cs.setString(5, "");//V_LC_AMD_NO
			cs.setString(6, V_M_BP_NM);//V_M_BP_NM
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("CUR", rs.getString("CUR"));		
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("LC_KIND", rs.getString("LC_KIND"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2S")) {
			cs = conn.prepareCall("call USP_003_M_LC_AMEND_H_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_LC_DT_FR);//V_LC_DT_FR
			cs.setString(4, V_LC_DT_TO);//V_LC_DT_TO
			cs.setString(5, "");//V_LC_AMD_NO
			cs.setString(6, V_M_BP_NM);//V_M_BP_NM
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("CUR", rs.getString("CUR"));		
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("LC_KIND", rs.getString("LC_KIND"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_003_M_LC_AMEND_H_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_LC_DT_FR
			cs.setString(4, "");//V_LC_DT_TO
			cs.setString(5, V_LC_AMD_NO);//V_LC_AMD_NO
			cs.setString(6, "");//V_M_BP_NM
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_AMD_NO", rs.getString("LC_AMD_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_AMEND_SEQ", rs.getString("LC_AMEND_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("AMEND_DT", rs.getString("AMEND_DT"));
				subObject.put("CUR", rs.getString("CUR"));		
				subObject.put("BANK_CD", rs.getString("OPEN_BANK"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_KIND", rs.getString("LC_KIND"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SD")) {
			cs = conn.prepareCall("call USP_003_M_LC_AMEND_H_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_LC_DT_FR
			cs.setString(4, "");//V_LC_DT_TO
			cs.setString(5, V_LC_AMD_NO);//V_LC_AMD_NO
			cs.setString(6, "");//V_M_BP_NM
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("AMD_FLG", rs.getString("AMD_FLG"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("LC_KIND", rs.getString("LC_KIND"));
				subObject.put("BE_QTY", rs.getString("BE_QTY"));
				subObject.put("AT_QTY", rs.getString("AT_QTY"));
				subObject.put("BE_PRICE", rs.getString("BE_PRICE"));
				subObject.put("AT_PRICE", rs.getString("AT_PRICE"));		
				subObject.put("BE_DOC_AMT", rs.getString("BE_DOC_AMT"));
				subObject.put("AT_DOC_AMT", rs.getString("AT_DOC_AMT"));
				subObject.put("BE_LOC_AMT", rs.getString("BE_LOC_AMT"));
				subObject.put("AT_LOC_AMT", rs.getString("AT_LOC_AMT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("LC_AMD_NO", rs.getString("LC_AMD_NO"));
				subObject.put("LC_AMD_SEQ", rs.getString("LC_AMD_SEQ"));
				subObject.put("PO_REMAIN_QTY", rs.getString("PO_REMAIN_QTY"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("PS")) {
			cs = conn.prepareCall("call USP_003_M_LC_AMEND_H_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_LC_DT_FR);//V_LC_DT_FR
			cs.setString(4, V_LC_DT_TO);//V_LC_DT_TO
			cs.setString(5, V_LC_AMD_NO);//V_LC_AMD_NO
			cs.setString(6, V_M_BP_NM);//V_M_BP_NM
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_AMD_NO", rs.getString("LC_AMD_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_AMEND_SEQ", rs.getString("LC_AMEND_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("AMEND_DT", rs.getString("AMEND_DT"));
				subObject.put("CUR", rs.getString("CUR"));		
				subObject.put("OPEN_BANK", rs.getString("OPEN_BANK"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("IH")) {
			String V_OPEN_DT = request.getParameter("V_OPEN_DT") == null ? "" : request.getParameter("V_OPEN_DT").substring(0, 10);
			String V_AMEND_DT = request.getParameter("V_AMEND_DT") == null ? "" : request.getParameter("V_AMEND_DT").substring(0, 10);
			String V_M_BP_CD = request.getParameter("V_M_BP_CD2") == null ? "" : request.getParameter("V_M_BP_CD2").toUpperCase();
			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
			String V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO").toUpperCase();
			String V_BANK_CD = request.getParameter("V_BANK_CD") == null ? "" : request.getParameter("V_BANK_CD").toUpperCase();
// 			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
// 			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE").toUpperCase();
			String V_LC_KIND = request.getParameter("V_LC_KIND") == null ? "" : request.getParameter("V_LC_KIND").toUpperCase();
			
			String V_ADV_NO = "";
			String V_PRE_ADV_REF = "";
			String V_CHARGE_FLG = "";
			String V_REMARK = "";
			
			if(V_LC_NO.equals("")){
				String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
				String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
				String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
				String V_DOC_AMT = request.getParameter("V_DOC_AMT") == null ? "" : request.getParameter("V_DOC_AMT").toUpperCase();
				
				cs = conn.prepareCall("call USP_003_M_LC_H_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "I");//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, "AMEND");//V_LC_NO
				cs.setString(4, V_LC_DOC_NO);//V_LC_DOC_NO
				cs.setString(5, "");//V_LC_AMEND_SEQ 
				cs.setString(6, V_BANK_CD);//V_BANK_CD
				cs.setString(7, V_PO_NO);//V_PO_NO
				cs.setString(8, V_OPEN_DT);//V_REQ_DT
				cs.setString(9, V_OPEN_DT);//V_OPEN_DT
				cs.setString(10, V_OPEN_DT);//V_EXPIRY_DT
				cs.setString(11, V_OPEN_DT);//V_AMEND_DT
				cs.setString(12, V_CUR);//V_CUR
				cs.setString(13, V_XCH_RATE);//V_XCH_RATE
				cs.setString(14, V_DOC_AMT);//V_DOC_AMT
				cs.setString(15, "");//V_LOC_AMT
				cs.setString(16, V_PAY_METH);//V_PAY_METH
				cs.setString(17, V_IN_TERMS);//V_IN_TERMS
				cs.setString(18, V_M_BP_CD);//V_M_BP_CD
				cs.setString(19, "M");//V_LC_KIND
				cs.setString(20, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(22, "");//V_CLS_YN
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(21);
				if (rs.next()) {
					V_LC_NO = rs.getString("res");
				}
			}

			cs = conn.prepareCall("call USP_003_M_LC_AMEND_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_OPEN_DT); //V_OPEN_DT    
			cs.setString(4, V_AMEND_DT); //V_AMEND_DT   
			cs.setString(5, ""); //V_LC_AMD_NO  
			cs.setString(6, ""); //V_LC_AMD_SEQ 
			cs.setString(7, V_LC_DOC_NO); //V_LC_DOC_NO  
			cs.setString(8, V_LC_NO); //V_LC_NO    	
			cs.setString(9, ""); //V_LC_SEQ     
			cs.setString(10, ""); //V_PO_NO      
			cs.setString(11, ""); //V_PO_SEQ     
			cs.setString(12, V_ADV_NO); //V_ADV_NO     
			cs.setString(13, V_PRE_ADV_REF); //V_PRE_ADV_REF
			cs.setString(14, V_M_BP_CD); //V_M_BP_CD    
			cs.setString(15, V_CUR); //V_CUR        
			cs.setString(16, V_BANK_CD); //V_OPEN_BANK  
			cs.setString(17, V_CHARGE_FLG); //V_CHARGE_FLG 
			cs.setString(18, V_REMARK); //V_REMARK     
			cs.setString(19, V_LC_KIND); //V_LC_KIND    
			cs.setString(20, ""); //V_AMD_FLG    
			cs.setString(21, ""); //V_ITEM_CD    
			cs.setString(22, ""); //V_BE_QTY     
			cs.setString(23, ""); //V_AT_QTY     
			cs.setString(24, ""); //V_BE_PRICE   
			cs.setString(25, ""); //V_AT_PRICE   
			cs.setString(26, ""); //V_BE_DOC_AMT 
			cs.setString(27, ""); //V_AT_DOC_AMT 
			cs.setString(28, ""); //V_BE_LOC_AMT 
			cs.setString(29, ""); //V_AT_LOC_AMT 
			cs.setString(30, V_USR_ID); //V_USR_ID     
			cs.registerOutParameter(31, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(31);

			if (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_NO", V_LC_NO);
				subObject.put("LC_AMD_NO", rs.getString("res"));
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SYNC")) {

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (!V_TYPE.equals("V")) {
				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						String V_LC_DOC_NO = hashMap.get("LC_DOC_NO") == null ? "" : hashMap.get("LC_DOC_NO").toString();
						String V_LC_NO = hashMap.get("LC_NO") == null ? "" : hashMap.get("LC_NO").toString();
						String V_LC_SEQ = hashMap.get("LC_SEQ") == null ? "" : hashMap.get("LC_SEQ").toString();
						String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
						String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
						String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						String V_LC_KIND = hashMap.get("LC_KIND") == null ? "" : hashMap.get("LC_KIND").toString();
						String V_AMD_FLG = hashMap.get("AMD_FLG") == null ? "" : hashMap.get("AMD_FLG").toString();
						
						String V_BE_QTY = hashMap.get("BE_QTY") == null ? "" : hashMap.get("BE_QTY").toString();
						String V_BE_PRICE = hashMap.get("BE_PRICE") == null ? "" : hashMap.get("BE_PRICE").toString();
						String V_BE_DOC_AMT = hashMap.get("BE_DOC_AMT") == null ? "" : hashMap.get("BE_DOC_AMT").toString();
						String V_BE_LOC_AMT = hashMap.get("BE_LOC_AMT") == null ? "" :  hashMap.get("BE_LOC_AMT").toString();
						String V_AT_QTY = hashMap.get("AT_QTY") == null ? "" : hashMap.get("AT_QTY").toString();
						String V_AT_PRICE = hashMap.get("AT_PRICE") == null ? "" : hashMap.get("AT_PRICE").toString();
						String V_AT_DOC_AMT = hashMap.get("AT_DOC_AMT") == null ? "" : hashMap.get("AT_DOC_AMT").toString();
						String V_AT_LOC_AMT = hashMap.get("AT_LOC_AMT") == null ? "" :  hashMap.get("AT_LOC_AMT").toString();
						
						String V_REMARK = "";
						String V_LC_AMD_SEQ = "";
						
						if(V_TYPE.equals("D")){
							V_LC_AMD_NO = hashMap.get("LC_AMD_NO") == null ? "" : hashMap.get("LC_AMD_NO").toString();
							V_LC_AMD_SEQ = hashMap.get("LC_AMD_SEQ") == null ? "" : hashMap.get("LC_AMD_SEQ").toString();
							
							if(V_AMD_FLG.equals("I")){
								cs = conn.prepareCall("call USP_003_M_LC_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
								cs.setString(1, V_COMP_ID);//V_COMP_ID
								cs.setString(2, "D");//V_TYPE
								cs.setString(3, V_LC_NO);//V_LC_NO
								cs.setString(4, V_LC_SEQ);//V_LC_SEQ
								cs.setString(5, "");//V_HS_CD
								cs.setString(6, V_ITEM_CD);//V_ITEM_CD
								cs.setString(7, V_AT_QTY);//V_QTY
								cs.setString(8, V_AT_PRICE);//V_PRICE
								cs.setString(9, V_AT_DOC_AMT);//V_DOC_AMT
								cs.setString(10, V_AT_LOC_AMT);//V_LOC_AMT
								cs.setString(11, "");//V_UNIT
								cs.setString(12, "");//V_OVER_TOL
								cs.setString(13, "");//V_UNDER_TOL
								cs.setString(14, V_PO_NO);//V_PO_NO
								cs.setString(15, V_PO_SEQ);//V_PO_SEQ
								cs.setString(16, V_USR_ID);//V_USR_ID
								cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
								cs.setString(18, "");//V_CONT_MGM_NO
								cs.setString(19, V_LC_KIND);//V_LC_KIND
								cs.executeQuery();
							}
						} else if(V_LC_SEQ.equals("")){
							V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO").toUpperCase();
							
							cs = conn.prepareCall("call USP_003_M_LC_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, V_COMP_ID);//V_COMP_ID
							cs.setString(2, "I");//V_TYPE
							cs.setString(3, V_LC_NO);//V_LC_NO
							cs.setString(4, "");//V_LC_SEQ
							cs.setString(5, "");//V_HS_CD
							cs.setString(6, V_ITEM_CD);//V_ITEM_CD
							cs.setString(7, V_AT_QTY);//V_QTY
							cs.setString(8, V_AT_PRICE);//V_PRICE
							cs.setString(9, V_AT_DOC_AMT);//V_DOC_AMT
							cs.setString(10, V_AT_LOC_AMT);//V_LOC_AMT
							cs.setString(11, "");//V_UNIT
							cs.setString(12, "");//V_OVER_TOL
							cs.setString(13, "");//V_UNDER_TOL
							cs.setString(14, V_PO_NO);//V_PO_NO
							cs.setString(15, V_PO_SEQ);//V_PO_SEQ
							cs.setString(16, V_USR_ID);//V_USR_ID
							cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
							cs.setString(18, "");//V_CONT_MGM_NO
							cs.setString(19, V_LC_KIND);//V_LC_KIND
							cs.executeQuery();
							
							rs = (ResultSet) cs.getObject(17);
							if (rs.next()) {
								V_LC_SEQ = rs.getString("res");
							}
						}
						
						cs = conn.prepareCall("call USP_003_M_LC_AMEND_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, ""); //V_OPEN_DT    
						cs.setString(4, ""); //V_AMEND_DT   
						cs.setString(5, V_LC_AMD_NO); //V_LC_AMD_NO  
						cs.setString(6, V_LC_AMD_SEQ); //V_LC_AMD_SEQ 
						cs.setString(7, V_LC_DOC_NO); //V_LC_DOC_NO  
						cs.setString(8, V_LC_NO); //V_LC_NO    	
						cs.setString(9, V_LC_SEQ); //V_LC_SEQ     
						cs.setString(10, V_PO_NO); //V_PO_NO      
						cs.setString(11, V_PO_SEQ); //V_PO_SEQ     
						cs.setString(12, ""); //V_ADV_NO     
						cs.setString(13, ""); //V_PRE_ADV_REF
						cs.setString(14, ""); //V_M_BP_CD    
						cs.setString(15, ""); //V_CUR        
						cs.setString(16, ""); //V_OPEN_BANK  
						cs.setString(17, ""); //V_CHARGE_FLG 
						cs.setString(18, V_REMARK); //V_REMARK     
						cs.setString(19, V_LC_KIND); //V_LC_KIND    
						cs.setString(20, V_AMD_FLG); //V_AMD_FLG    
						cs.setString(21, V_ITEM_CD); //V_ITEM_CD    
						cs.setString(22, V_BE_QTY); //V_BE_QTY     
						cs.setString(23, V_AT_QTY); //V_AT_QTY     
						cs.setString(24, V_BE_PRICE); //V_BE_PRICE   
						cs.setString(25, V_AT_PRICE); //V_AT_PRICE   
						cs.setString(26, V_BE_DOC_AMT); //V_BE_DOC_AMT 
						cs.setString(27, V_AT_DOC_AMT); //V_AT_DOC_AMT 
						cs.setString(28, V_BE_LOC_AMT); //V_BE_LOC_AMT 
						cs.setString(29, V_AT_LOC_AMT); //V_AT_LOC_AMT 
						cs.setString(30, V_USR_ID); //V_USR_ID     
						cs.registerOutParameter(31, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

					}
				} else {
					JSONParser parser = new JSONParser();
					Object obj = parser.parse(jsonData);
					JSONObject jsondata = (JSONObject) obj;
							
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					String V_LC_DOC_NO = jsondata.get("LC_DOC_NO") == null ? "" : jsondata.get("LC_DOC_NO").toString();
					String V_LC_NO = jsondata.get("LC_NO") == null ? "" : jsondata.get("LC_NO").toString();
					String V_LC_SEQ = jsondata.get("LC_SEQ") == null ? "" : jsondata.get("LC_SEQ").toString();
					String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
					String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					String V_LC_KIND = jsondata.get("V_LC_KIND") == null ? "" : jsondata.get("V_LC_KIND").toString();
					String V_AMD_FLG = jsondata.get("AMD_FLG") == null ? "" : jsondata.get("AMD_FLG").toString();
					
					String V_BE_QTY = jsondata.get("BE_QTY") == null ? "" : jsondata.get("BE_QTY").toString();
					String V_BE_PRICE = jsondata.get("BE_PRICE") == null ? "" : jsondata.get("BE_PRICE").toString();
					String V_BE_DOC_AMT = jsondata.get("BE_DOC_AMT") == null ? "" : jsondata.get("BE_DOC_AMT").toString();
					String V_BE_LOC_AMT = jsondata.get("BE_LOC_AMT") == null ? "" :  jsondata.get("BE_LOC_AMT").toString();
					String V_AT_QTY = jsondata.get("AT_QTY") == null ? "" : jsondata.get("AT_QTY").toString();
					String V_AT_PRICE = jsondata.get("AT_PRICE") == null ? "" : jsondata.get("AT_PRICE").toString();
					String V_AT_DOC_AMT = jsondata.get("AT_DOC_AMT") == null ? "" : jsondata.get("AT_DOC_AMT").toString();
					String V_AT_LOC_AMT = jsondata.get("AT_LOC_AMT") == null ? "" :  jsondata.get("AT_LOC_AMT").toString();
					
					String V_REMARK = "";
					String V_LC_AMD_SEQ = "";
					
					if(V_TYPE.equals("D")){
						V_LC_AMD_NO = jsondata.get("LC_AMD_NO") == null ? "" : jsondata.get("LC_AMD_NO").toString();
						V_LC_AMD_SEQ = jsondata.get("LC_AMD_SEQ") == null ? "" : jsondata.get("LC_AMD_SEQ").toString();
						
						if(V_AMD_FLG.equals("I")){
							cs = conn.prepareCall("call USP_003_M_LC_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, V_COMP_ID);//V_COMP_ID
							cs.setString(2, "D");//V_TYPE
							cs.setString(3, V_LC_NO);//V_LC_NO
							cs.setString(4, V_LC_SEQ);//V_LC_SEQ
							cs.setString(5, "");//V_HS_CD
							cs.setString(6, V_ITEM_CD);//V_ITEM_CD
							cs.setString(7, V_AT_QTY);//V_QTY
							cs.setString(8, V_AT_PRICE);//V_PRICE
							cs.setString(9, V_AT_DOC_AMT);//V_DOC_AMT
							cs.setString(10, V_AT_LOC_AMT);//V_LOC_AMT
							cs.setString(11, "");//V_UNIT
							cs.setString(12, "");//V_OVER_TOL
							cs.setString(13, "");//V_UNDER_TOL
							cs.setString(14, V_PO_NO);//V_PO_NO
							cs.setString(15, V_PO_SEQ);//V_PO_SEQ
							cs.setString(16, V_USR_ID);//V_USR_ID
							cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
							cs.setString(18, "");//V_CONT_MGM_NO
							cs.setString(19, V_LC_KIND);//V_LC_KIND
							cs.executeQuery();
						}
					} else if(V_LC_SEQ.equals("")){
						V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_003_M_LC_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "I");//V_TYPE
						cs.setString(3, V_LC_NO);//V_LC_NO
						cs.setString(4, "");//V_LC_SEQ
						cs.setString(5, "");//V_HS_CD
						cs.setString(6, V_ITEM_CD);//V_ITEM_CD
						cs.setString(7, V_AT_QTY);//V_QTY
						cs.setString(8, V_AT_PRICE);//V_PRICE
						cs.setString(9, V_AT_DOC_AMT);//V_DOC_AMT
						cs.setString(10, V_AT_LOC_AMT);//V_LOC_AMT
						cs.setString(11, "");//V_UNIT
						cs.setString(12, "");//V_OVER_TOL
						cs.setString(13, "");//V_UNDER_TOL
						cs.setString(14, V_PO_NO);//V_PO_NO
						cs.setString(15, V_PO_SEQ);//V_PO_SEQ
						cs.setString(16, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(18, "");//V_CONT_MGM_NO
						cs.setString(19, V_LC_KIND);//V_LC_KIND
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(17);
						if (rs.next()) {
							V_LC_SEQ = rs.getString("res");
						}
					}

					cs = conn.prepareCall("call USP_003_M_LC_AMEND_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, ""); //V_OPEN_DT    
					cs.setString(4, ""); //V_AMEND_DT   
					cs.setString(5, V_LC_AMD_NO); //V_LC_AMD_NO  
					cs.setString(6, V_LC_AMD_SEQ); //V_LC_AMD_SEQ 
					cs.setString(7, V_LC_DOC_NO); //V_LC_DOC_NO  
					cs.setString(8, V_LC_NO); //V_LC_NO    	
					cs.setString(9, V_LC_SEQ); //V_LC_SEQ     
					cs.setString(10, V_PO_NO); //V_PO_NO      
					cs.setString(11, V_PO_SEQ); //V_PO_SEQ     
					cs.setString(12, ""); //V_ADV_NO     
					cs.setString(13, ""); //V_PRE_ADV_REF
					cs.setString(14, ""); //V_M_BP_CD    
					cs.setString(15, ""); //V_CUR        
					cs.setString(16, ""); //V_OPEN_BANK  
					cs.setString(17, ""); //V_CHARGE_FLG 
					cs.setString(18, V_REMARK); //V_REMARK     
					cs.setString(19, V_LC_KIND); //V_LC_KIND    
					cs.setString(20, V_AMD_FLG); //V_AMD_FLG    
					cs.setString(21, V_ITEM_CD); //V_ITEM_CD    
					cs.setString(22, V_BE_QTY); //V_BE_QTY     
					cs.setString(23, V_AT_QTY); //V_AT_QTY     
					cs.setString(24, V_BE_PRICE); //V_BE_PRICE   
					cs.setString(25, V_AT_PRICE); //V_AT_PRICE   
					cs.setString(26, V_BE_DOC_AMT); //V_BE_DOC_AMT 
					cs.setString(27, V_AT_DOC_AMT); //V_AT_DOC_AMT 
					cs.setString(28, V_BE_LOC_AMT); //V_BE_LOC_AMT 
					cs.setString(29, V_AT_LOC_AMT); //V_AT_LOC_AMT 
					cs.setString(30, V_USR_ID); //V_USR_ID     
					cs.registerOutParameter(31, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
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


