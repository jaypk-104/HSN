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
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").toUpperCase().substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase().substring(0, 10);
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();

		if (V_IV_TYPE.equals("T")) V_IV_TYPE = "";
		
		//상단
		if (V_TYPE.equals("SH")) {

			cs = conn.prepareCall("call USP_003_S_BILL_DN_REF_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_S_BP_NM);//V_S_BP_CD
			cs.setString(3, V_DN_DT_FR);//V_DN_DT_FR
			cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD
			cs.setString(7, V_ITEM_NM);//V_ITEM_NM
			cs.setString(8, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(9, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(10, V_IV_TYPE);//V_IV_TYPE
			cs.setString(11, V_M_BP_NM);//V_M_BP_NM
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_LOC_AMT", rs.getString("DN_LOC_AMT"));
				subObject.put("FORWARD_XCH_RT", rs.getString("FORWARD_XCH_RT"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("VAT_RATE", rs.getString("VAT_RATE"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_DUR", rs.getString("PAY_DUR"));
// 				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("TO_SALES_GRP", rs.getString("TO_SALES_GRP"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//하단헤더조회
		} else if (V_TYPE.equals("S")) {

			String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
			// 			System.out.println("하단헤더" + V_BILL_NO);

			cs = conn.prepareCall("call USP_003_S_BILL_H_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, "");//V_BILL_DT
			cs.setString(5, "");//V_S_BP_CD
			cs.setString(6, "");//V_R_BP_CD
			cs.setString(7, "");//V_IN_TERMS
			cs.setString(8, "");//V_PAY_METH
			cs.setString(9, "");//V_SALE_TYPE
			cs.setString(10, "");//V_CUR
			cs.setString(11, "");//V_XCHG_RT
			cs.setString(12, "");//V_VAT_INC
			cs.setString(13, "");//V_DN_ISSUE_DT
			cs.setString(14, "");//V_TAX_CD
			cs.setString(15, "");//V_CFM_YN
			cs.setString(16, "");//V_TEMP_GL_NO
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, "");//V_TO_SALES_GRP
			cs.setString(20, "");//V_REMARK

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BILL_NO", rs.getString("BILL_NO"));
				subObject.put("BILL_DT", rs.getString("BILL_DT").substring(0, 10));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("R_BP_CD", rs.getString("R_BP_CD"));
				subObject.put("R_BP_NM", rs.getString("R_BP_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
				subObject.put("VAT_INC", rs.getString("VAT_INC"));
				subObject.put("DN_ISSUE_DT", rs.getString("DN_ISSUE_DT").substring(0, 10));
				subObject.put("TAX_CD", rs.getString("TAX_CD"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("TO_SALES_GRP", rs.getString("TO_SALES_GRP"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("BILL_LOC_AMT", rs.getString("BILL_LOC_AMT"));
				subObject.put("TAX_BILL_YN", rs.getString("TAX_BILL_YN"));
				subObject.put("TAX_BILL_SEND_YN", rs.getString("TAX_BILL_SEND_YN"));
				subObject.put("CR_TYPE", rs.getString("CR_TYPE"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//하단상세조회
		} else if (V_TYPE.equals("SD")) {

			String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
			// 			System.out.println("V_BILL_NO" + V_BILL_NO);
			cs = conn.prepareCall("call USP_003_S_BILL_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, "");//V_BILL_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_BILL_QTY
			cs.setString(7, "");//V_BILL_PRC
			cs.setString(8, "");//V_BILL_AMT
			cs.setString(9, "");//V_BILL_LOC_AMT
			cs.setString(10, "");//V_COST_CD
			cs.setString(11, "");//V_VAT_TYPE
			cs.setString(12, "");//V_VAT_AMT
			cs.setString(13, "");//V_DN_NO
			cs.setString(14, "");//V_DN_SEQ
			cs.setString(15, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(16);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BILL_NO", rs.getString("BILL_NO"));
				subObject.put("BILL_SEQ", rs.getString("BILL_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("FORWARD_XCH_RT", rs.getString("FORWARD_XCH_RT"));
				subObject.put("BILL_AMT", rs.getString("BILL_AMT"));
// 				subObject.put("GR_BOX_QTY", rs.getString("GR_BOX_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
// 				subObject.put("MG_RT", rs.getString("MG_RT"));
// 				subObject.put("MG_AMT", rs.getString("MG_AMT"));
				subObject.put("BILL_QTY", rs.getString("BILL_QTY"));
				subObject.put("BILL_PRC", rs.getString("BILL_PRC"));
				subObject.put("BILL_LOC_AMT", rs.getString("BILL_LOC_AMT"));
				subObject.put("VAT_INC", rs.getString("VAT_INC"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("VAT_RATE", rs.getString("VAT_RATE"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
// 				subObject.put("DN_ISSUE_DT", rs.getString("DN_ISSUE_DT"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			// 			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);

			String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {

					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_BILL_SEQ = hashMap.get("BILL_SEQ") == null ? "" : hashMap.get("BILL_SEQ").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_COST_CD = hashMap.get("COST_CD") == null ? "" : hashMap.get("COST_CD").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String V_VAT_RATE = hashMap.get("VAT_RATE") == null ? "" : hashMap.get("VAT_RATE").toString();
					String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
					String V_DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString();

					String V_VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_BILL_QTY = hashMap.get("BILL_QTY") == null ? "" : hashMap.get("BILL_QTY").toString();
					String V_BILL_AMT = hashMap.get("BILL_AMT") == null ? "" : hashMap.get("BILL_AMT").toString();
					String V_BILL_LOC_AMT = hashMap.get("BILL_LOC_AMT") == null ? "" : hashMap.get("BILL_LOC_AMT").toString();
					String V_BILL_PRC = hashMap.get("BILL_PRC") == null ? "" : hashMap.get("BILL_PRC").toString();

					if(V_CUR.equals("KRW")){
						V_BILL_AMT = V_BILL_LOC_AMT;
					}
					
					cs = conn.prepareCall("call USP_003_S_BILL_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_BILL_NO);//V_BILL_NO
					cs.setString(4, V_BILL_SEQ);//V_BILL_SEQ
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, V_BILL_QTY);//V_BILL_QTY
					cs.setString(7, V_BILL_PRC);//V_BILL_PRC
					cs.setString(8, V_BILL_AMT);//V_BILL_AMT
					cs.setString(9, V_BILL_LOC_AMT);//V_BILL_LOC_AMT
					cs.setString(10, V_COST_CD);//V_COST_CD
					cs.setString(11, V_VAT_TYPE);//V_VAT_TYPE
					cs.setString(12, V_VAT_AMT);//V_VAT_AMT
					cs.setString(13, V_DN_NO);//V_DN_NO
					cs.setString(14, V_DN_SEQ);//V_DN_SEQ
					cs.setString(15, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_BILL_SEQ = jsondata.get("BILL_SEQ") == null ? "" : jsondata.get("BILL_SEQ").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_COST_CD = jsondata.get("COST_CD") == null ? "" : jsondata.get("COST_CD").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String V_VAT_RATE = jsondata.get("VAT_RATE") == null ? "" : jsondata.get("VAT_RATE").toString();
				String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
				String V_DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString();
				
				String V_VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String V_BILL_QTY = jsondata.get("BILL_QTY") == null ? "" : jsondata.get("BILL_QTY").toString();
				String V_BILL_AMT = jsondata.get("BILL_AMT") == null ? "" : jsondata.get("BILL_AMT").toString();
				String V_BILL_LOC_AMT = jsondata.get("BILL_LOC_AMT") == null ? "" : jsondata.get("BILL_LOC_AMT").toString();
				String V_BILL_PRC = jsondata.get("BILL_PRC") == null ? "" : jsondata.get("BILL_PRC").toString();

				if(V_CUR.equals("KRW")){
					V_BILL_AMT = V_BILL_LOC_AMT;
				}
				
				cs = conn.prepareCall("call USP_003_S_BILL_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, V_BILL_SEQ);//V_BILL_SEQ
				cs.setString(5, V_ITEM_CD);//V_ITEM_CD
				cs.setString(6, V_BILL_QTY);//V_BILL_QTY
				cs.setString(7, V_BILL_PRC);//V_BILL_PRC
				cs.setString(8, V_BILL_AMT);//V_BILL_AMT
				cs.setString(9, V_BILL_LOC_AMT);//V_BILL_LOC_AMT
				cs.setString(10, V_COST_CD);//V_COST_CD
				cs.setString(11, V_VAT_TYPE);//V_VAT_TYPE
				cs.setString(12, V_VAT_AMT);//V_VAT_AMT
				cs.setString(13, V_DN_NO);//V_DN_NO
				cs.setString(14, V_DN_SEQ);//V_DN_SEQ
				cs.setString(15, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
			cs = conn.prepareCall("call USP_A_AR_MST_HSPF(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "D");//V_TYPE
			cs.setString(3, "");//V_DEPT_CD
			cs.setString(4, V_BILL_NO);//V_REF_NO
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.executeQuery();
			
			cs = conn.prepareCall("call USP_A_AR_MST_HSPF(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_DEPT_CD
			cs.setString(4, V_BILL_NO);//V_REF_NO
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.executeQuery();

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
			pw.flush();
			pw.close();

			/*하단 헤더 I / U*/
		} else if (V_TYPE.equals("IH") || V_TYPE.equals("UH")) {

			String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
			String V_BILL_DT = request.getParameter("V_BILL_DT") == null ? "" : request.getParameter("V_BILL_DT").toUpperCase().substring(0, 10);
			String V_S_BP_CD2 = request.getParameter("V_S_BP_CD2") == null ? "" : request.getParameter("V_S_BP_CD2").toUpperCase();
			String V_R_BP_CD = request.getParameter("V_R_BP_CD") == null ? "" : request.getParameter("V_R_BP_CD").toUpperCase();
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_SALE_TYPE = request.getParameter("V_SALE_TYPE") == null ? "" : request.getParameter("V_SALE_TYPE").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_XCHG_RT = request.getParameter("V_XCHG_RT") == null ? "" : request.getParameter("V_XCHG_RT").toUpperCase();
			String V_VAT_INC = request.getParameter("V_VAT_INC") == null ? "" : request.getParameter("V_VAT_INC").toUpperCase();
			String V_DN_ISSUE_DT = request.getParameter("V_DN_ISSUE_DT") == null ? "" : request.getParameter("V_DN_ISSUE_DT").toUpperCase().substring(0, 10);
			String V_TAX_CD = request.getParameter("V_TAX_CD") == null ? "" : request.getParameter("V_TAX_CD").toUpperCase();
			String V_CFM_YN = request.getParameter("V_CFM_YN") == null ? "" : request.getParameter("V_CFM_YN").toUpperCase();
			String V_TEMP_GL_NO = request.getParameter("V_TEMP_GL_NO") == null ? "" : request.getParameter("V_TEMP_GL_NO").toUpperCase();
			String V_TO_SALES_GRP = request.getParameter("V_TO_SALES_GRP") == null ? "" : request.getParameter("V_TO_SALES_GRP").toUpperCase();
			String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toUpperCase();

			cs = conn.prepareCall("call USP_003_S_BILL_H_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, V_BILL_DT);//V_BILL_DT
			cs.setString(5, V_S_BP_CD2);//V_S_BP_CD
			cs.setString(6, V_R_BP_CD);//V_R_BP_CD
			cs.setString(7, V_IN_TERMS);//V_IN_TERMS
			cs.setString(8, V_PAY_METH);//V_PAY_METH
			cs.setString(9, V_SALE_TYPE);//V_SALE_TYPE
			cs.setString(10, V_CUR);//V_CUR
			cs.setString(11, V_XCHG_RT);//V_XCHG_RT
			cs.setString(12, V_VAT_INC);//V_VAT_INC
			cs.setString(13, V_DN_ISSUE_DT);//V_DN_ISSUE_DT
			cs.setString(14, V_TAX_CD);//V_TAX_CD
			cs.setString(15, V_CFM_YN);//V_CFM_YN
			cs.setString(16, V_TEMP_GL_NO);//V_TEMP_GL_NO
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, V_TO_SALES_GRP);//V_TO_SALES_GRP
			cs.setString(20, V_REMARK);//V_REMARK

			cs.executeQuery();

			if (V_TYPE.equals("IH")) {
				rs = (ResultSet) cs.getObject(18);
				String BILL_NO = "";

				while (rs.next()) {
					BILL_NO = rs.getString("BILL_NO");
				}

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(BILL_NO);
				pw.flush();
				pw.close();
			}

		} else if (V_TYPE.equals("PS")) {

			String W_DN_DT_FR = request.getParameter("W_DN_DT_FR") == null ? "" : request.getParameter("W_DN_DT_FR").toUpperCase().substring(0, 10);
			String W_DN_DT_TO = request.getParameter("W_DN_DT_TO") == null ? "" : request.getParameter("W_DN_DT_TO").toUpperCase().substring(0, 10);
			String W_S_BP_NM = request.getParameter("W_S_BP_NM") == null ? "" : request.getParameter("W_S_BP_NM").toUpperCase();

			cs = conn.prepareCall("call USP_003_S_BILL_H_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_BILL_NO
			cs.setString(4, W_DN_DT_FR);//V_BILL_DT
			cs.setString(5, W_S_BP_NM);//V_S_BP_CD
			cs.setString(6, "");//V_R_BP_CD
			cs.setString(7, "");//V_IN_TERMS
			cs.setString(8, "");//V_PAY_METH
			cs.setString(9, "");//V_SALE_TYPE
			cs.setString(10, "");//V_CUR
			cs.setString(11, "");//V_XCHG_RT
			cs.setString(12, "");//V_VAT_INC
			cs.setString(13, W_DN_DT_TO);//V_DN_ISSUE_DT
			cs.setString(14, "");//V_TAX_CD
			cs.setString(15, "");//V_CFM_YN
			cs.setString(16, "");//V_TEMP_GL_NO
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, "");//V_TO_SALES_GRP
			cs.setString(20, "");//V_REMARK

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BILL_NO", rs.getString("BILL_NO"));
				subObject.put("BILL_DT", rs.getString("BILL_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("VAT_INC", rs.getString("VAT_INC"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("BILL_LOC_AMT", rs.getString("BILL_LOC_AMT"));
				subObject.put("TAX_BILL_YN", rs.getString("TAX_BILL_YN"));
				subObject.put("TAX_BILL_SEND_YN", rs.getString("TAX_BILL_SEND_YN"));
				subObject.put("LOGIS_STATUS", rs.getString("LOGIS_STATUS"));
				subObject.put("CR_TYPE", rs.getString("CR_TYPE"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			// 			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("I") || V_TYPE.equals("D")) {

			String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();

 			cs = conn.prepareCall("call USP_003_A_TEMP_BN_FR_TOT(?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, V_USR_ID);//V_BL_SEQ
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			String V_TEMP_GL_NO = "";
			if (rs.next()) {
				V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
			}

			if (V_TEMP_GL_NO.contains("TG")) {
				/*애니링크 시작*/
 				JSONObject anyObject = new JSONObject();
 				JSONArray anyArray = new JSONArray();
 				JSONObject anySubObject = new JSONObject();

 				URL url = null;

 				if (V_TYPE.equals("I")) { //확정
 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert");
 				} else if (V_TYPE.equals("D")) { //확정취소
 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel");
 				}
 				URLConnection con = url.openConnection();
 				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
 				con.setDoOutput(true);

 				anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
 				anySubObject.put("V_USR_ID", V_USR_ID);
 				anySubObject.put("V_DB_ID", "sa");
 				anySubObject.put("V_DB_PW", "hsnadmin");

 				anyArray.add(anySubObject);
 				anyObject.put("data", anyArray);
 				String parameter = anyObject + "";

 				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
 				wr.write(parameter);
 				wr.flush();

 				BufferedReader rd = null;

 				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
 				String line = null;
 				String result = null;
 				while ((line = rd.readLine()) != null) {
 					result = URLDecoder.decode(line, "UTF-8");
 				}

 // 				System.out.println("V_TEMP_GL_NO " + V_TEMP_GL_NO);
 // 				System.out.println(result);
				
 				response.setContentType("text/plain; charset=UTF-8");
 				PrintWriter pw = response.getWriter();
 				pw.print(result);
 				pw.flush();
 				pw.close();
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
		if (cs2 != null) try {
			cs2.close();
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


