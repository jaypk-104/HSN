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
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").toString().substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toString().substring(0, 10);
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_INV_NO = request.getParameter("V_INV_NO") == null ? "" : request.getParameter("V_INV_NO").toUpperCase();
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();

		if (V_TYPE.equals("SR")) {
			cs = conn.prepareCall("call USP_003_S_BL_MST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 
			cs.setString(2, V_TYPE); //V_TYPE
			cs.setString(3, V_DN_DT_FR); //V_DN_DT_FR
			cs.setString(4, V_DN_DT_TO); //V_DN_DT_TO
			cs.setString(5, V_S_BP_CD); //V_S_BP_CD 
			cs.setString(6, ""); //V_BL_NO
			cs.setString(7, ""); //V_ED_DOC_NO 
			cs.setString(8, ""); //V_BL_DOC_NO 
			cs.setString(9, ""); //V_ED_DT
			cs.setString(10, ""); //V_LOADING_DT
			cs.setString(11, ""); //V_VESSEL_NM 
			cs.setString(12, ""); //V_LOADING_PORT
			cs.setString(13, ""); //V_DISCHGE_PORT
			cs.setString(14, ""); //V_ETA
			cs.setString(15, ""); //V_ETD
			cs.setString(16, ""); //V_IN_TERMS
			cs.setString(17, ""); //V_CUR
			cs.setString(18, ""); //V_XCHG_RT
			cs.setString(19, ""); //V_SALE_GRP
			cs.setString(20, ""); //V_IN_PLAN_DT
			cs.setString(21, ""); //V_INVOICE_NO
			cs.setString(22, ""); //V_ORIGIN_CNTRY
			cs.setString(23, V_ITEM_CD); //V_ITEM_CD 
			cs.setString(24, ""); //V_BL_SEQ
			cs.setString(25, ""); //V_QTY
			cs.setString(26, ""); //V_PRC
			cs.setString(27, ""); //V_DOC_AMT 
			cs.setString(28, ""); //V_LOC_AMT 
			cs.setString(29, ""); //V_VAT_TYPE
			cs.setString(30, ""); //V_VAT_AMT 
			cs.setString(31, ""); //V_DN_NO
			cs.setString(32, ""); //V_DN_SEQ
			cs.setString(33, ""); //V_CONT_NO 
			cs.setString(34, ""); //V_CONT_QTY
			cs.setString(35, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(37, ""); //V_SALE_TYPE
			cs.setString(38, ""); //V_INVOICE_DT
			cs.setString(39, ""); //V_HS_CODE
			cs.setString(40, ""); //V_PAY_METH
			cs.setString(41, V_ITEM_NM); //V_ITEM_NM 
			cs.setString(42, V_INV_NO); //V_INV_NO 
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(36);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("S_PRICE", rs.getString("S_PRICE"));
				subObject.put("PAY_DUR", rs.getString("PAY_DUR"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("LOADING_PORT", rs.getString("LOADING_PORT"));
				subObject.put("INV_NO", rs.getString("INV_NO"));
				subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("LOAD_DT", rs.getString("LOAD_DT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("BL_LOADING_DT", rs.getString("BL_LOADING_DT"));
				subObject.put("CC_DOC_NO", rs.getString("CC_DOC_NO"));
				 
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
			cs = conn.prepareCall("call USP_003_S_BL_MST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 
			cs.setString(2, V_TYPE); //V_TYPE
			cs.setString(3, ""); //V_DN_DT_FR
			cs.setString(4, ""); //V_DN_DT_TO
			cs.setString(5, ""); //V_S_BP_CD 
			cs.setString(6, V_BL_NO); //V_BL_NO
			cs.setString(7, ""); //V_ED_DOC_NO 
			cs.setString(8, ""); //V_BL_DOC_NO 
			cs.setString(9, ""); //V_ED_DT
			cs.setString(10, ""); //V_LOADING_DT
			cs.setString(11, ""); //V_VESSEL_NM 
			cs.setString(12, ""); //V_LOADING_PORT
			cs.setString(13, ""); //V_DISCHGE_PORT
			cs.setString(14, ""); //V_ETA
			cs.setString(15, ""); //V_ETD
			cs.setString(16, ""); //V_IN_TERMS
			cs.setString(17, ""); //V_CUR
			cs.setString(18, ""); //V_XCHG_RT
			cs.setString(19, ""); //V_SALE_GRP
			cs.setString(20, ""); //V_IN_PLAN_DT
			cs.setString(21, ""); //V_INVOICE_NO
			cs.setString(22, ""); //V_ORIGIN_CNTRY
			cs.setString(23, ""); //V_ITEM_CD 
			cs.setString(24, ""); //V_BL_SEQ
			cs.setString(25, ""); //V_QTY
			cs.setString(26, ""); //V_PRC
			cs.setString(27, ""); //V_DOC_AMT 
			cs.setString(28, ""); //V_LOC_AMT 
			cs.setString(29, ""); //V_VAT_TYPE
			cs.setString(30, ""); //V_VAT_AMT 
			cs.setString(31, ""); //V_DN_NO
			cs.setString(32, ""); //V_DN_SEQ
			cs.setString(33, ""); //V_CONT_NO 
			cs.setString(34, ""); //V_CONT_QTY
			cs.setString(35, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(37, ""); //V_SALE_TYPE
			cs.setString(38, ""); //V_INVOICE_DT
			cs.setString(39, ""); //V_HS_CODE
			cs.setString(40, ""); //V_PAY_METH
			cs.setString(41, ""); //V_ITEM_NM 
			cs.setString(42, ""); //V_INV_NO 
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(36);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("ORIGIN_CNTRY", rs.getString("ORIGIN_CNTRY"));
				subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("IN_PLAN_DT", rs.getString("IN_PLAN_DT"));
				subObject.put("ETA", rs.getString("ETA"));
				subObject.put("ETD", rs.getString("ETD"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("LOADING_PORT", rs.getString("LOADING_PORT"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("SALE_GRP", rs.getString("SALE_GRP"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("INVOICE_NO", rs.getString("INVOICE_NO"));
				subObject.put("INVOICE_DT", rs.getString("INVOICE_DT"));
				subObject.put("HS_CODE", rs.getString("HS_CODE"));
				subObject.put("PAY_DUR", rs.getString("PAY_DUR"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("IH") || V_TYPE.equals("UH")) {

			V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_LOADING_DT = request.getParameter("V_LOADING_DT") == null ? "" : request.getParameter("V_LOADING_DT").substring(0, 10);
			String V_S_BP_CD2 = request.getParameter("V_S_BP_CD2") == null ? "" : request.getParameter("V_S_BP_CD2").toUpperCase();
			String V_VESSEL_NM = request.getParameter("V_VESSEL_NM") == null ? "" : request.getParameter("V_VESSEL_NM").toUpperCase();
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_XCHG_RT = request.getParameter("V_XCHG_RT") == null ? "" : request.getParameter("V_XCHG_RT").toUpperCase();
// 			String V_ED_DOC_NO = request.getParameter("V_ED_DOC_NO") == null ? "" : request.getParameter("V_ED_DOC_NO").toUpperCase();
// 			String V_ED_DT = request.getParameter("V_ED_DT") == null ? "" : request.getParameter("V_ED_DT").substring(0, 10);
// 			String V_INVOICE_NO = request.getParameter("V_INVOICE_NO") == null ? "" : request.getParameter("V_INVOICE_NO").toUpperCase();
			String V_ORIGIN_CNTRY = request.getParameter("V_ORIGIN_CNTRY") == null ? "" : request.getParameter("V_ORIGIN_CNTRY").toUpperCase();
			String V_IN_PLAN_DT = request.getParameter("V_IN_PLAN_DT") == null ? "" : request.getParameter("V_IN_PLAN_DT").substring(0, 10);
			String V_ETA = request.getParameter("V_ETA") == null ? "" : request.getParameter("V_ETA").substring(0, 10);
			String V_ETD = request.getParameter("V_ETD") == null ? "" : request.getParameter("V_ETD").substring(0, 10);
			String V_DISCHGE_PORT = request.getParameter("V_DISCHGE_PORT") == null ? "" : request.getParameter("V_DISCHGE_PORT").toUpperCase();
			String V_LOADING_PORT = request.getParameter("V_LOADING_PORT") == null ? "" : request.getParameter("V_LOADING_PORT").toUpperCase();
			String V_SALE_GRP = request.getParameter("V_SALE_GRP") == null ? "" : request.getParameter("V_SALE_GRP").toUpperCase();
			String V_SALE_TYPE = request.getParameter("V_SALE_TYPE") == null ? "" : request.getParameter("V_SALE_TYPE").toUpperCase();
			String V_HS_CODE = request.getParameter("V_HS_CODE") == null ? "" : request.getParameter("V_HS_CODE").toUpperCase();
			String V_INVOICE_NO = request.getParameter("V_INVOICE_NO") == null ? "" : request.getParameter("V_INVOICE_NO").toUpperCase();
			String V_INVOICE_DT = request.getParameter("V_INVOICE_DT") == null ? "" : request.getParameter("V_INVOICE_DT").toString().substring(0, 10);

			cs = conn.prepareCall("call USP_003_S_BL_MST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 
			cs.setString(2, V_TYPE); //V_TYPE
			cs.setString(3, ""); //V_DN_DT_FR
			cs.setString(4, ""); //V_DN_DT_TO
			cs.setString(5, V_S_BP_CD2); //V_S_BP_CD 
			cs.setString(6, V_BL_NO); //V_BL_NO
			cs.setString(7, ""); //V_ED_DOC_NO 
			cs.setString(8, V_BL_DOC_NO); //V_BL_DOC_NO 
			cs.setString(9, ""); //V_ED_DT
			cs.setString(10, V_LOADING_DT); //V_LOADING_DT
			cs.setString(11, V_VESSEL_NM); //V_VESSEL_NM 
			cs.setString(12, V_LOADING_PORT); //V_LOADING_PORT
			cs.setString(13, V_DISCHGE_PORT); //V_DISCHGE_PORT
			cs.setString(14, V_ETA); //V_ETA
			cs.setString(15, V_ETD); //V_ETD
			cs.setString(16, V_IN_TERMS); //V_IN_TERMS
			cs.setString(17, V_CUR); //V_CUR
			cs.setString(18, V_XCHG_RT); //V_XCHG_RT
			cs.setString(19, V_SALE_GRP); //V_SALE_GRP
			cs.setString(20, V_IN_PLAN_DT); //V_IN_PLAN_DT
			cs.setString(21, V_INVOICE_NO); //V_INVOICE_NO
			cs.setString(22, V_ORIGIN_CNTRY); //V_ORIGIN_CNTRY
			cs.setString(23, ""); //V_ITEM_CD 
			cs.setString(24, ""); //V_BL_SEQ
			cs.setString(25, ""); //V_QTY
			cs.setString(26, ""); //V_PRC
			cs.setString(27, ""); //V_DOC_AMT 
			cs.setString(28, ""); //V_LOC_AMT 
			cs.setString(29, ""); //V_VAT_TYPE
			cs.setString(30, ""); //V_VAT_AMT 
			cs.setString(31, ""); //V_DN_NO
			cs.setString(32, ""); //V_DN_SEQ
			cs.setString(33, ""); //V_CONT_NO 
			cs.setString(34, ""); //V_CONT_QTY
			cs.setString(35, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(37, V_SALE_TYPE); //V_SALE_TYPE
			cs.setString(38, V_INVOICE_DT); //V_INVOICE_DT
			cs.setString(39, V_HS_CODE); //V_HS_CODE
			cs.setString(40, V_PAY_METH); //V_PAY_METH
			cs.setString(41, ""); //V_ITEM_NM 
			cs.setString(42, ""); //V_INV_NO 
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(36);
			String res = "";
			if (rs.next()) {
				res = rs.getString("res");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(res);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (!V_TYPE.equals("V")) {
				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
// 						V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
						V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();

						String V_BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
						String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
						String V_PRC = hashMap.get("PRICE") == null ? "" : hashMap.get("PRICE").toString();
						String V_DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
						String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
						String V_VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
						String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
						String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
						String V_DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString();
						String V_CONT_NO = hashMap.get("CONT_NO") == null ? "" : hashMap.get("CONT_NO").toString();
						String V_CONT_QTY = hashMap.get("CONT_QTY") == null ? "" : hashMap.get("CONT_QTY").toString();
						
			 			String V_ED_DOC_NO = hashMap.get("ED_DOC_NO") == null ? "" : hashMap.get("ED_DOC_NO").toString();
			 			String V_ED_DT = hashMap.get("ED_DT") == null ? "" : hashMap.get("ED_DT").toString().substring(0, 10);
			 			String V_INVOICE_NO = hashMap.get("INVOICE_NO") == null ? "" : hashMap.get("INVOICE_NO").toString();

						cs = conn.prepareCall("call USP_003_S_BL_MST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID); //V_COMP_ID 
						cs.setString(2, V_TYPE); //V_TYPE
						cs.setString(3, ""); //V_DN_DT_FR
						cs.setString(4, ""); //V_DN_DT_TO
						cs.setString(5, ""); //V_S_BP_CD 
						cs.setString(6, V_BL_NO); //V_BL_NO
						cs.setString(7, V_ED_DOC_NO); //V_ED_DOC_NO 
						cs.setString(8, ""); //V_BL_DOC_NO 
						cs.setString(9, V_ED_DT); //V_ED_DT
						cs.setString(10, ""); //V_LOADING_DT
						cs.setString(11, ""); //V_VESSEL_NM 
						cs.setString(12, ""); //V_LOADING_PORT
						cs.setString(13, ""); //V_DISCHGE_PORT
						cs.setString(14, ""); //V_ETA
						cs.setString(15, ""); //V_ETD
						cs.setString(16, ""); //V_IN_TERMS
						cs.setString(17, ""); //V_CUR
						cs.setString(18, ""); //V_XCHG_RT
						cs.setString(19, ""); //V_SALE_GRP
						cs.setString(20, ""); //V_IN_PLAN_DT
						cs.setString(21, V_INVOICE_NO); //V_INVOICE_NO
						cs.setString(22, ""); //V_ORIGIN_CNTRY
						cs.setString(23, V_ITEM_CD); //V_ITEM_CD 
						cs.setString(24, V_BL_SEQ); //V_BL_SEQ
						cs.setString(25, V_QTY); //V_QTY
						cs.setString(26, V_PRC); //V_PRC
						cs.setString(27, V_DOC_AMT); //V_DOC_AMT 
						cs.setString(28, V_LOC_AMT); //V_LOC_AMT 
						cs.setString(29, V_VAT_TYPE); //V_VAT_TYPE
						cs.setString(30, V_VAT_AMT); //V_VAT_AMT 
						cs.setString(31, V_DN_NO); //V_DN_NO
						cs.setString(32, V_DN_SEQ); //V_DN_SEQ
						cs.setString(33, V_CONT_NO); //V_CONT_NO 
						cs.setString(34, V_CONT_QTY); //V_CONT_QTY
						cs.setString(35, V_USR_ID); //V_USR_ID
						cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(37, ""); //V_SALE_TYPE
						cs.setString(38, ""); //V_INVOICE_DT
						cs.setString(39, ""); //V_HS_CODE
						cs.setString(40, ""); //V_PAY_METH
						cs.setString(41, ""); //V_ITEM_NM 
						cs.setString(42, ""); //V_INV_NO 
						cs.executeQuery();
					}
				} else {
					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
// 					V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
					V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					
					String V_BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
					String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
					String V_PRC = jsondata.get("PRICE") == null ? "" : jsondata.get("PRICE").toString();
					String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
					String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
					String V_VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
					String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
					String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
					String V_DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString();
					String V_CONT_NO = jsondata.get("CONT_NO") == null ? "" : jsondata.get("CONT_NO").toString();
					String V_CONT_QTY = jsondata.get("CONT_QTY") == null ? "" : jsondata.get("CONT_QTY").toString();
					
					String V_ED_DOC_NO = jsondata.get("ED_DOC_NO") == null ? "" : jsondata.get("ED_DOC_NO").toString();
		 			String V_ED_DT = jsondata.get("ED_DT") == null ? "" : jsondata.get("ED_DT").toString().substring(0, 10);
		 			String V_INVOICE_NO = jsondata.get("INVOICE_NO") == null ? "" : jsondata.get("INVOICE_NO").toString();

					cs = conn.prepareCall("call USP_003_S_BL_MST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID); //V_COMP_ID 
					cs.setString(2, V_TYPE); //V_TYPE
					cs.setString(3, ""); //V_DN_DT_FR
					cs.setString(4, ""); //V_DN_DT_TO
					cs.setString(5, ""); //V_S_BP_CD 
					cs.setString(6, V_BL_NO); //V_BL_NO
					cs.setString(7, V_ED_DOC_NO); //V_ED_DOC_NO 
					cs.setString(8, ""); //V_BL_DOC_NO 
					cs.setString(9, V_ED_DT); //V_ED_DT
					cs.setString(10, ""); //V_LOADING_DT
					cs.setString(11, ""); //V_VESSEL_NM 
					cs.setString(12, ""); //V_LOADING_PORT
					cs.setString(13, ""); //V_DISCHGE_PORT
					cs.setString(14, ""); //V_ETA
					cs.setString(15, ""); //V_ETD
					cs.setString(16, ""); //V_IN_TERMS
					cs.setString(17, ""); //V_CUR
					cs.setString(18, ""); //V_XCHG_RT
					cs.setString(19, ""); //V_SALE_GRP
					cs.setString(20, ""); //V_IN_PLAN_DT
					cs.setString(21, V_INVOICE_NO); //V_INVOICE_NO
					cs.setString(22, ""); //V_ORIGIN_CNTRY
					cs.setString(23, V_ITEM_CD); //V_ITEM_CD 
					cs.setString(24, V_BL_SEQ); //V_BL_SEQ
					cs.setString(25, V_QTY); //V_QTY
					cs.setString(26, V_PRC); //V_PRC
					cs.setString(27, V_DOC_AMT); //V_DOC_AMT 
					cs.setString(28, V_LOC_AMT); //V_LOC_AMT 
					cs.setString(29, V_VAT_TYPE); //V_VAT_TYPE
					cs.setString(30, V_VAT_AMT); //V_VAT_AMT 
					cs.setString(31, V_DN_NO); //V_DN_NO
					cs.setString(32, V_DN_SEQ); //V_DN_SEQ
					cs.setString(33, V_CONT_NO); //V_CONT_NO 
					cs.setString(34, V_CONT_QTY); //V_CONT_QTY
					cs.setString(35, V_USR_ID); //V_USR_ID
					cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(37, ""); //V_SALE_TYPE
					cs.setString(38, ""); //V_INVOICE_DT
					cs.setString(39, ""); //V_HS_CODE
					cs.setString(40, ""); //V_PAY_METH
					cs.setString(41, ""); //V_ITEM_NM 
					cs.setString(42, ""); //V_INV_NO 
					cs.executeQuery();
				}

				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);
				
				cs = conn.prepareCall("call USP_A_AR_MST_HSPF(?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "D");//V_TYPE
				cs.setString(3, "");//V_DEPT_CD
				cs.setString(4, V_BL_NO);//V_REF_NO
				cs.setString(5, V_USR_ID);//V_USR_ID
				cs.executeQuery();
				
				cs = conn.prepareCall("call USP_A_AR_MST_HSPF(?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "TS");//V_TYPE
				cs.setString(3, "");//V_DEPT_CD
				cs.setString(4, V_BL_NO);//V_REF_NO
				cs.setString(5, V_USR_ID);//V_USR_ID
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
			}
		} else if (V_TYPE.equals("SD")) {
			cs = conn.prepareCall("call USP_003_S_BL_MST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 
			cs.setString(2, V_TYPE); //V_TYPE
			cs.setString(3, ""); //V_DN_DT_FR
			cs.setString(4, ""); //V_DN_DT_TO
			cs.setString(5, ""); //V_S_BP_CD 
			cs.setString(6, V_BL_NO); //V_BL_NO
			cs.setString(7, ""); //V_ED_DOC_NO 
			cs.setString(8, ""); //V_BL_DOC_NO 
			cs.setString(9, ""); //V_ED_DT
			cs.setString(10, ""); //V_LOADING_DT
			cs.setString(11, ""); //V_VESSEL_NM 
			cs.setString(12, ""); //V_LOADING_PORT
			cs.setString(13, ""); //V_DISCHGE_PORT
			cs.setString(14, ""); //V_ETA
			cs.setString(15, ""); //V_ETD
			cs.setString(16, ""); //V_IN_TERMS
			cs.setString(17, ""); //V_CUR
			cs.setString(18, ""); //V_XCHG_RT
			cs.setString(19, ""); //V_SALE_GRP
			cs.setString(20, ""); //V_IN_PLAN_DT
			cs.setString(21, ""); //V_INVOICE_NO
			cs.setString(22, ""); //V_ORIGIN_CNTRY
			cs.setString(23, ""); //V_ITEM_CD 
			cs.setString(24, ""); //V_BL_SEQ
			cs.setString(25, ""); //V_QTY
			cs.setString(26, ""); //V_PRC
			cs.setString(27, ""); //V_DOC_AMT 
			cs.setString(28, ""); //V_LOC_AMT 
			cs.setString(29, ""); //V_VAT_TYPE
			cs.setString(30, ""); //V_VAT_AMT 
			cs.setString(31, ""); //V_DN_NO
			cs.setString(32, ""); //V_DN_SEQ
			cs.setString(33, ""); //V_CONT_NO 
			cs.setString(34, ""); //V_CONT_QTY
			cs.setString(35, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(37, ""); //V_SALE_TYPE
			cs.setString(38, ""); //V_INVOICE_DT
			cs.setString(39, ""); //V_HS_CODE
			cs.setString(40, ""); //V_PAY_METH
			cs.setString(41, ""); //V_ITEM_NM 
			cs.setString(42, ""); //V_INV_NO 
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(36);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ED_DOC_NO", rs.getString("ED_DOC_NO"));
				subObject.put("ED_DT", rs.getString("ED_DT"));
				subObject.put("INVOICE_NO", rs.getString("INVOICE_NO"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("CONT_QTY", rs.getString("CONT_QTY"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SP")) {
			cs = conn.prepareCall("call USP_003_S_BL_MST_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID 
			cs.setString(2, V_TYPE); //V_TYPE
			cs.setString(3, V_DN_DT_FR); //V_DN_DT_FR
			cs.setString(4, V_DN_DT_TO); //V_DN_DT_TO
			cs.setString(5, V_S_BP_CD); //V_S_BP_CD 
			cs.setString(6, ""); //V_BL_NO
			cs.setString(7, ""); //V_ED_DOC_NO 
			cs.setString(8, V_BL_DOC_NO); //V_BL_DOC_NO 
			cs.setString(9, ""); //V_ED_DT
			cs.setString(10, ""); //V_LOADING_DT
			cs.setString(11, ""); //V_VESSEL_NM 
			cs.setString(12, ""); //V_LOADING_PORT
			cs.setString(13, ""); //V_DISCHGE_PORT
			cs.setString(14, ""); //V_ETA
			cs.setString(15, ""); //V_ETD
			cs.setString(16, ""); //V_IN_TERMS
			cs.setString(17, ""); //V_CUR
			cs.setString(18, ""); //V_XCHG_RT
			cs.setString(19, ""); //V_SALE_GRP
			cs.setString(20, ""); //V_IN_PLAN_DT
			cs.setString(21, ""); //V_INVOICE_NO
			cs.setString(22, ""); //V_ORIGIN_CNTRY
			cs.setString(23, ""); //V_ITEM_CD 
			cs.setString(24, ""); //V_BL_SEQ
			cs.setString(25, ""); //V_QTY
			cs.setString(26, ""); //V_PRC
			cs.setString(27, ""); //V_DOC_AMT 
			cs.setString(28, ""); //V_LOC_AMT 
			cs.setString(29, ""); //V_VAT_TYPE
			cs.setString(30, ""); //V_VAT_AMT 
			cs.setString(31, ""); //V_DN_NO
			cs.setString(32, ""); //V_DN_SEQ
			cs.setString(33, ""); //V_CONT_NO 
			cs.setString(34, ""); //V_CONT_QTY
			cs.setString(35, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(37, ""); //V_SALE_TYPE
			cs.setString(38, ""); //V_INVOICE_DT
			cs.setString(39, ""); //V_HS_CODE
			cs.setString(40, ""); //V_PAY_METH
			cs.setString(41, ""); //V_ITEM_NM 
			cs.setString(42, V_INV_NO); //V_INV_NO 
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(36);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
// 				subObject.put("ED_DOC_NO", rs.getString("ED_DOC_NO"));
// 				subObject.put("ED_DT", rs.getString("ED_DT"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("INVOICE_NO", rs.getString("INVOICE_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

	} else if (V_TYPE.equals("I") || V_TYPE.equals("D")) {

		
		cs = conn.prepareCall("call USP_003_A_TEMP_EB_FR_TOT(?,?,?,?,?)");

		cs.setString(1, V_COMP_ID);//V_COMP_ID
		cs.setString(2, V_TYPE);//V_TYPE
		cs.setString(3, V_BL_NO);//V_BL_NO
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


