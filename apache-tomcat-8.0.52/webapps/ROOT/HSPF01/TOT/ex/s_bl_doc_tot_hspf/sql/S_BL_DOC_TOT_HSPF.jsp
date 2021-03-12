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

<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.reflect.InvocationTargetException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Properties"%>
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
		String V_INV_NO = request.getParameter("V_INV_NO") == null ? "" : request.getParameter("V_INV_NO").toUpperCase();

		if (V_TYPE.equals("T1S")) {
			cs = conn.prepareCall("call USP_003_S_INV_PT_HDR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 
			cs.setString(2, V_TYPE);//V_TYPE 
			cs.setString(3, V_INV_NO);//V_INV_NO 
			cs.setString(4, "");//V_INV_DT 
			cs.setString(5, "");//V_LC_DOC_NO 
			cs.setString(6, "");//V_LC_DT 
			cs.setString(7, "");//V_BP_CD 
			cs.setString(8, "");//V_BL_DOC_NO 
			cs.setString(9, "");//V_LOADING_DT
			cs.setString(10, "");//V_CONSIGNEE 
			cs.setString(11, "");//V_BUYER_ADDR 
			cs.setString(12, "");//V_SHIP_MARK 
			cs.setString(13, "");//V_NOTIFY 
			cs.setString(14, "");//V_SELLER 
			cs.setString(15, "");//V_TRANS_TYPE
			cs.setString(16, "");//V_VESSEL 
			cs.setString(17, "");//V_PAY_METH 
			cs.setString(18, "");//V_IN_TERMS 
			cs.setString(19, "");//V_INVOICE_NO
			cs.setString(20, "");//V_ETD
			cs.setString(21, "");//V_ETA
			cs.setString(22, "");//V_LOADING_PORT
			cs.setString(23, "");//V_DISCHGE_PORT
			cs.setString(24, "");//V_CFM_YN 
			cs.setString(25, "");//V_REMARK 
			cs.setString(26, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, "");//V_IV_DT_FR
			cs.setString(29, "");//V_IV_DT_TO
			cs.setString(30, "");//V_INSUR_AMT
			cs.setString(31, "");//V_TERMINAL
			cs.setString(32, "");//V_CUR
			cs.setString(33, "");//V_CNTR_QTY
			cs.setString(34, "");//V_CNTR_SZTP
			cs.setString(35, "");//V_TITLE
			cs.setString(36, "");//V_PARAM1
			cs.setString(37, "");//V_PARAM2
			cs.setString(38, "");//V_PARAM3
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(27);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("INV_NO", rs.getString("INV_NO"));
				subObject.put("INV_DT", rs.getString("INV_DT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_DT", rs.getString("LC_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("CONSIGNEE", rs.getString("CONSIGNEE"));
				subObject.put("BUYER_ADDR", rs.getString("BUYER_ADDR"));
				subObject.put("SHIP_MARK", rs.getString("SHIP_MARK"));
				subObject.put("NOTIFY", rs.getString("NOTIFY"));
				subObject.put("SELLER", rs.getString("SELLER"));
				subObject.put("TRANS_TYPE", rs.getString("TRANS_TYPE"));
				subObject.put("TITLE", rs.getString("TITLE"));
				subObject.put("VESSEL", rs.getString("VESSEL"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("INVOICE_NO", rs.getString("INVOICE_NO"));
				subObject.put("ETD", rs.getString("ETD"));
				subObject.put("ETA", rs.getString("ETA"));
				subObject.put("LOADING_PORT", rs.getString("LOADING_PORT"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
// 				subObject.put("CNTR_NO", rs.getString("CNTR_NO"));
				subObject.put("TERMINAL", rs.getString("TERMINAL"));
				subObject.put("INSUR_AMT", rs.getString("INSUR_AMT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("CNTR_QTY", rs.getString("CNTR_QTY"));
				subObject.put("CNTR_SZTP", rs.getString("CNTR_SZTP"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("REMARK", rs.getString("REMARK"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("IH") || V_TYPE.equals("DH")) {

			String V_INVOICE_NO = request.getParameter("V_INVOICE_NO") == null ? "" : request.getParameter("V_INVOICE_NO").toUpperCase();
			String V_INV_DT = request.getParameter("V_INV_DT") == null ? "" : request.getParameter("V_INV_DT") == "" ? "" : request.getParameter("V_INV_DT").toUpperCase().substring(0, 10);
			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
			String V_LC_DT = request.getParameter("V_LC_DT") == null ? "" : request.getParameter("V_LC_DT") == "" ? "" : request.getParameter("V_LC_DT").toUpperCase().substring(0, 10);
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_LOADING_DT = request.getParameter("V_LOADING_DT") == null ? "" : request.getParameter("V_LOADING_DT") == "" ? "" : request.getParameter("V_LOADING_DT").toUpperCase().substring(0, 10);
			String V_CONSIGNEE = request.getParameter("V_CONSIGNEE") == null ? "" : request.getParameter("V_CONSIGNEE").toUpperCase();
			String V_BUYER_ADDR = request.getParameter("V_BUYER_ADDR") == null ? "" : request.getParameter("V_BUYER_ADDR").toUpperCase();
			String V_SHIP_MARK = request.getParameter("V_SHIP_MARK") == null ? "" : request.getParameter("V_SHIP_MARK").toUpperCase();
			String V_NOTIFY = request.getParameter("V_NOTIFY") == null ? "" : request.getParameter("V_NOTIFY").toUpperCase();
			String V_SELLER = request.getParameter("V_SELLER") == null ? "" : request.getParameter("V_SELLER").toUpperCase();
// 			String V_DEP_DT = request.getParameter("V_DEP_DT") == null ? "" : request.getParameter("V_DEP_DT") == "" ? "" : request.getParameter("V_DEP_DT").toUpperCase().substring(0, 10);
			String V_TRANS_TYPE = request.getParameter("V_TRANS_TYPE") == null ? "" : request.getParameter("V_TRANS_TYPE").toUpperCase();
			String V_TITLE = request.getParameter("V_TITLE") == null ? "" : request.getParameter("V_TITLE").toUpperCase();
			String V_VESSEL = request.getParameter("V_VESSEL") == null ? "" : request.getParameter("V_VESSEL").toUpperCase();
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
			String V_PAY_CONDITION = request.getParameter("V_PAY_CONDITION") == null ? "" : request.getParameter("V_PAY_CONDITION").toUpperCase();
			String V_LOADING_PORT = request.getParameter("V_LOADING_PORT") == null ? "" : request.getParameter("V_LOADING_PORT").toUpperCase();
			String V_DISCHGE_PORT = request.getParameter("V_DISCHGE_PORT") == null ? "" : request.getParameter("V_DISCHGE_PORT").toUpperCase();
			String V_INSUR_AMT = request.getParameter("V_INSUR_AMT") == null ? "" : request.getParameter("V_INSUR_AMT").toUpperCase();
			String V_TERMINAL = request.getParameter("V_TERMINAL") == null ? "" : request.getParameter("V_TERMINAL").toUpperCase();
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_CNTR_QTY = request.getParameter("V_CNTR_QTY") == null ? "" : request.getParameter("V_CNTR_QTY").toUpperCase();
			String V_CNTR_SZTP = request.getParameter("V_CNTR_SZTP") == null ? "" : request.getParameter("V_CNTR_SZTP").toUpperCase();
			String V_ETD = request.getParameter("V_ETD") == null ? "" : request.getParameter("V_ETD") == "" ? "" : request.getParameter("V_ETD").toUpperCase().substring(0, 10);
			String V_ETA = request.getParameter("V_ETA") == null ? "" : request.getParameter("V_ETA") == "" ? "" : request.getParameter("V_ETA").toUpperCase().substring(0, 10);
			String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toUpperCase();
			
			cs = conn.prepareCall("call USP_003_S_INV_PT_HDR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 
			cs.setString(2, V_TYPE);//V_TYPE 
			cs.setString(3, V_INV_NO);//V_INV_NO 
			cs.setString(4, V_INV_DT);//V_INV_DT 
			cs.setString(5, V_LC_DOC_NO);//V_LC_DOC_NO 
			cs.setString(6, V_LC_DT);//V_LC_DT 
			cs.setString(7, V_BP_CD);//V_BP_CD 
			cs.setString(8, V_BL_DOC_NO);//V_BL_DOC_NO 
			cs.setString(9, V_LOADING_DT);//V_LOADING_DT
			cs.setString(10, V_CONSIGNEE);//V_CONSIGNEE 
			cs.setString(11, V_BUYER_ADDR);//V_BUYER_ADDR 
			cs.setString(12, V_SHIP_MARK);//V_SHIP_MARK 
			cs.setString(13, V_NOTIFY);//V_NOTIFY 
			cs.setString(14, V_SELLER);//V_SELLER 
			cs.setString(15, V_TRANS_TYPE);//V_TRANS_TYPE
			cs.setString(16, V_VESSEL);//V_VESSEL 
			cs.setString(17, V_PAY_METH);//V_PAY_METH 
			cs.setString(18, V_IN_TERMS);//V_IN_TERMS 
			cs.setString(19, V_INVOICE_NO);//V_INVOICE_NO 
			cs.setString(20, V_ETD);//V_ETD
			cs.setString(21, V_ETA);//V_ETA
			cs.setString(22, V_LOADING_PORT);//V_LOADING_PORT
			cs.setString(23, V_DISCHGE_PORT);//V_DISCHGE_PORT
			cs.setString(24, "N");//V_CFM_YN 
			cs.setString(25, V_REMARK);//V_REMARK 
			cs.setString(26, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, "");//V_IV_DT_FR
			cs.setString(29, "");//V_IV_DT_TO
			cs.setString(30, V_INSUR_AMT);//V_INSUR_AMT
			cs.setString(31, V_TERMINAL);//V_TERMINAL
			cs.setString(32, V_CUR);//V_CUR
			cs.setString(33, V_CNTR_QTY);//V_CNTR_QTY
			cs.setString(34, V_CNTR_SZTP);//V_CNTR_SZTP
			cs.setString(35, V_TITLE);//V_TITLE
			cs.setString(36, "");//V_PARAM1
			cs.setString(37, "");//V_PARAM2
			cs.setString(38, "");//V_PARAM3
			cs.executeQuery();
			
			String result = "";
			rs = (ResultSet) cs.getObject(27);
			if (rs.next()) {
				result = rs.getString("RESULT");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(result);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("T2S") || V_TYPE.equals("T3S")) {
			cs = conn.prepareCall("call USP_003_S_INV_PT_DTL_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_INV_NO);//V_INV_NO
			cs.setString(4, "");//V_INV_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_ITEM_NM
			cs.setString(7, "");//V_UNIT
			cs.setString(8, "");//V_QTY
			cs.setString(9, "");//V_PRICE
			cs.setString(10, "");//V_DOC_AMT
			cs.setString(11, "");//V_REF_NO
			cs.setString(12, "");//V_REF_SEQ
			cs.setString(13, "");//V_REF_TYPE
			cs.setString(14, "");//V_BL_DOC_NO
			cs.setString(15, "");//V_GROSS_WGT
			cs.setString(16, "");//V_NET_WGT
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, "");//V_HS_CD
			cs.setString(20, "");//V_ORIGIN
			cs.setString(21, "");//V_PALLET_QTY
			cs.setString(22, "");//V_PALLET_KIND
			cs.setString(23, "");//V_PALLET_TYPE
			cs.setString(24, "");//V_PILAMENT_CD
			cs.setString(25, "");//V_UNIT_WGT
			cs.setString(26, "");//V_MAKER
			cs.setString(27, "");//V_CNTR_NO
			cs.setString(28, "");//V_MATERIAL_CD
			cs.setString(29, "");//V_CNTR_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("INV_NO", rs.getString("INV_NO"));
				subObject.put("INV_SEQ", rs.getString("INV_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("PALLET_QTY", rs.getString("PALLET_QTY"));
				subObject.put("PALLET_KIND", rs.getString("PALLET_KIND"));
				subObject.put("PALLET_TYPE", rs.getString("PALLET_TYPE"));
				subObject.put("PILAMENT_CD", rs.getString("PILAMENT_CD"));
				subObject.put("HS_CD", rs.getString("HS_CD"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("NET_WGT", rs.getString("NET_WGT"));
				subObject.put("GROSS_WGT", rs.getString("GROSS_WGT"));
				subObject.put("UNIT_WGT", rs.getString("UNIT_WGT"));
				subObject.put("REF_TYPE", rs.getString("REF_TYPE"));
				subObject.put("REF_NO", rs.getString("REF_NO"));
				subObject.put("REF_SEQ", rs.getString("REF_SEQ"));
				subObject.put("MAKER", rs.getString("MAKER"));
				subObject.put("CNTR_NO", rs.getString("CNTR_NO"));
				subObject.put("MATERIAL_CD", rs.getString("MATERIAL_CD"));
				subObject.put("CNTR_TYPE", rs.getString("CNTR_TYPE"));
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
			String W_DN_TYPE = request.getParameter("W_DN_TYPE") == null ? "" : request.getParameter("W_DN_TYPE").toUpperCase();
			String W_DN_DT_FR = request.getParameter("W_DN_DT_FR") == null ? "" : request.getParameter("W_DN_DT_FR").toUpperCase().substring(0, 10);
			String W_DN_DT_TO = request.getParameter("W_DN_DT_TO") == null ? "" : request.getParameter("W_DN_DT_TO").toUpperCase().substring(0, 10);
			String W_S_BP_NM = request.getParameter("W_S_BP_NM") == null ? "" : request.getParameter("W_S_BP_NM").toUpperCase();
			
			cs = conn.prepareCall("call USP_003_S_BL_MST_DTL_REF(?,?,?,?,?,?)");
			cs.setString(1, W_DN_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, W_DN_DT_FR);//V_DN_DT_FROM
			cs.setString(4, W_DN_DT_TO);//V_DN_DT_TO
			cs.setString(5, W_S_BP_NM);//S_BP_NM
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("HS_CD", rs.getString("HS_CD"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("AMOUNT", rs.getString("AMOUNT"));
				
				subObject.put("REF_NO", rs.getString("REF_NO"));
				subObject.put("REF_SEQ", rs.getString("REF_SEQ"));
				subObject.put("REF_TYPE", rs.getString("REF_TYPE"));
				subObject.put("UNIT_WGT", rs.getString("UNIT_WGT"));
				subObject.put("MAKER", rs.getString("MAKER"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SP2")) {
			String W_IV_DT_FR = request.getParameter("W_IV_DT_FR") == null ? "" : request.getParameter("W_IV_DT_FR").toUpperCase().substring(0, 10);
			String W_IV_DT_TO = request.getParameter("W_IV_DT_TO") == null ? "" : request.getParameter("W_IV_DT_TO").toUpperCase().substring(0, 10);
			String W_S_BP_NM = request.getParameter("W_S_BP_NM") == null ? "" : request.getParameter("W_S_BP_NM").toUpperCase();
			String W_INVOICE_NO = request.getParameter("W_INVOICE_NO") == null ? "" : request.getParameter("W_INVOICE_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_003_S_INV_PT_HDR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 
			cs.setString(2, V_TYPE);//V_TYPE 
			cs.setString(3, "");//V_INV_NO 
			cs.setString(4, "");//V_INV_DT 
			cs.setString(5, "");//V_LC_DOC_NO 
			cs.setString(6, "");//V_LC_DT 
			cs.setString(7, W_S_BP_NM);//V_BP_CD 
			cs.setString(8, "");//V_BL_DOC_NO 
			cs.setString(9, "");//V_LOADING_DT
			cs.setString(10, "");//V_CONSIGNEE
			cs.setString(11, "");//V_BUYER_ADDR 
			cs.setString(12, "");//V_SHIP_MARK 
			cs.setString(13, "");//V_NOTIFY 
			cs.setString(14, "");//V_SELLER 
			cs.setString(15, "");//V_TRANS_TYPE
			cs.setString(16, "");//V_VESSEL 
			cs.setString(17, "");//V_PAY_METH 
			cs.setString(18, "");//V_IN_TERMS 
			cs.setString(19, W_INVOICE_NO);//V_INVOICE_NO 
			cs.setString(20, "");//V_ETD
			cs.setString(21, "");//V_ETA
			cs.setString(22, "");//V_LOADING_PORT
			cs.setString(23, "");//V_DISCHGE_PORT
			cs.setString(24, "");//V_CFM_YN 
			cs.setString(25, "");//V_REMARK 
			cs.setString(26, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, W_IV_DT_FR);//V_IV_DT_FR
			cs.setString(29, W_IV_DT_TO);//V_IV_DT_TO
			cs.setString(30, "");//V_INSUR_AMT
			cs.setString(31, "");//V_TERMINAL
			cs.setString(32, "");//V_CUR
			cs.setString(33, "");//V_CNTR_QTY
			cs.setString(34, "");//V_CNTR_SZTP
			cs.setString(35, "");//V_TITLE
			cs.setString(36, "");//V_PARAM1
			cs.setString(37, "");//V_PARAM2
			cs.setString(38, "");//V_PARAM3
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(27);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("INV_NO", rs.getString("INV_NO"));
				subObject.put("INV_DT", rs.getString("INV_DT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_DT", rs.getString("LC_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("CONSIGNEE", rs.getString("CONSIGNEE"));
				subObject.put("BUYER_ADDR", rs.getString("BUYER_ADDR"));
				subObject.put("SHIP_MARK", rs.getString("SHIP_MARK"));
				subObject.put("NOTIFY", rs.getString("NOTIFY"));
				subObject.put("SELLER", rs.getString("SELLER"));
				subObject.put("TRANS_TYPE", rs.getString("TRANS_TYPE"));
				subObject.put("TITLE", rs.getString("TITLE"));
				subObject.put("VESSEL", rs.getString("VESSEL"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("INVOICE_NO", rs.getString("INVOICE_NO"));
				subObject.put("ETD", rs.getString("ETD"));
				subObject.put("ETA", rs.getString("ETA"));
				subObject.put("LOADING_PORT", rs.getString("LOADING_PORT"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("REMARK", rs.getString("REMARK"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SYNC1")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_INV_SEQ = hashMap.get("INV_SEQ") == null ? "" : hashMap.get("INV_SEQ").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String V_UNIT = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
					String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					String V_PRICE = hashMap.get("PRICE") == null ? "" : hashMap.get("PRICE").toString();
					String V_DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
					
					String V_HS_CD = hashMap.get("HS_CD") == null ? "" : hashMap.get("HS_CD").toString();
					String V_ORIGIN = hashMap.get("ORIGIN") == null ? "" : hashMap.get("ORIGIN").toString();
					String V_PILAMENT_CD = hashMap.get("PILAMENT_CD") == null ? "" : hashMap.get("PILAMENT_CD").toString();
					String V_UNIT_WGT = hashMap.get("UNIT_WGT") == null ? "" : hashMap.get("UNIT_WGT").toString();
					
					String V_REF_NO = hashMap.get("REF_NO") == null ? "" : hashMap.get("REF_NO").toString();
					String V_REF_SEQ = hashMap.get("REF_SEQ") == null ? "" : hashMap.get("REF_SEQ").toString();
					String V_REF_TYPE = hashMap.get("REF_TYPE") == null ? "" : hashMap.get("REF_TYPE").toString();
					String V_MAKER = hashMap.get("MAKER") == null ? "" : hashMap.get("MAKER").toString();
					
					String V_CNTR_NO = hashMap.get("CNTR_NO") == null ? "" : hashMap.get("CNTR_NO").toString();
					String V_MATERIAL_CD = hashMap.get("MATERIAL_CD") == null ? "" : hashMap.get("MATERIAL_CD").toString();
					String V_CNTR_TYPE = hashMap.get("CNTR_TYPE") == null ? "" : hashMap.get("CNTR_TYPE").toString();

					cs = conn.prepareCall("call USP_003_S_INV_PT_DTL_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, "T2I");//V_TYPE
					cs.setString(3, V_INV_NO);//V_INV_NO
					cs.setString(4, V_INV_SEQ);//V_INV_SEQ
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, V_ITEM_NM);//V_ITEM_NM
					cs.setString(7, V_UNIT);//V_UNIT
					cs.setString(8, V_QTY);//V_QTY
					cs.setString(9, V_PRICE);//V_PRICE
					cs.setString(10, V_DOC_AMT);//V_DOC_AMT
					cs.setString(11, V_REF_NO);//V_REF_NO
					cs.setString(12, V_REF_SEQ);//V_REF_SEQ
					cs.setString(13, V_REF_TYPE);//V_REF_TYPE
					cs.setString(14, "");//V_BL_DOC_NO
					cs.setString(15, "");//V_GROSS_WGT
					cs.setString(16, "");//V_NET_WGT
					cs.setString(17, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(19, V_HS_CD);//V_HS_CD
					cs.setString(20, V_ORIGIN);//V_ORIGIN
					cs.setString(21, "");//V_PALLET_QTY
					cs.setString(22, "");//V_PALLET_KIND
					cs.setString(23, "");//V_PALLET_TYPE
					cs.setString(24, V_PILAMENT_CD);//V_PILAMENT_CD
					cs.setString(25, V_UNIT_WGT);//V_UNIT_WGT
					cs.setString(26, V_MAKER);//V_MAKER
					cs.setString(27, V_CNTR_NO);//V_CNTR_NO
					cs.setString(28, V_MATERIAL_CD);//V_MATERIAL_CD
					cs.setString(29, V_CNTR_TYPE);//V_CNTR_TYPE
					cs.executeQuery();
					
					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_INV_SEQ = jsondata.get("INV_SEQ") == null ? "" : jsondata.get("INV_SEQ").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String V_UNIT = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
				String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
				String V_PRICE = jsondata.get("PRICE") == null ? "" : jsondata.get("PRICE").toString();
				String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
				
				String V_HS_CD = jsondata.get("HS_CD") == null ? "" : jsondata.get("HS_CD").toString();
				String V_ORIGIN = jsondata.get("ORIGIN") == null ? "" : jsondata.get("ORIGIN").toString();
				String V_PILAMENT_CD = jsondata.get("PILAMENT_CD") == null ? "" : jsondata.get("PILAMENT_CD").toString();
				String V_UNIT_WGT = jsondata.get("UNIT_WGT") == null ? "" : jsondata.get("UNIT_WGT").toString();
				
				String V_REF_NO = jsondata.get("REF_NO") == null ? "" : jsondata.get("REF_NO").toString();
				String V_REF_SEQ = jsondata.get("REF_SEQ") == null ? "" : jsondata.get("REF_SEQ").toString();
				String V_REF_TYPE = jsondata.get("REF_TYPE") == null ? "" : jsondata.get("REF_TYPE").toString();
				String V_MAKER = jsondata.get("MAKER") == null ? "" : jsondata.get("MAKER").toString();
				
				String V_CNTR_NO = jsondata.get("CNTR_NO") == null ? "" : jsondata.get("CNTR_NO").toString();
				String V_MATERIAL_CD = jsondata.get("MATERIAL_CD") == null ? "" : jsondata.get("MATERIAL_CD").toString();
				String V_CNTR_TYPE = jsondata.get("CNTR_TYPE") == null ? "" : jsondata.get("CNTR_TYPE").toString();
				
				cs = conn.prepareCall("call USP_003_S_INV_PT_DTL_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "T2I");//V_TYPE
				cs.setString(3, V_INV_NO);//V_INV_NO
				cs.setString(4, V_INV_SEQ);//V_INV_SEQ
				cs.setString(5, V_ITEM_CD);//V_ITEM_CD
				cs.setString(6, V_ITEM_NM);//V_ITEM_NM
				cs.setString(7, V_UNIT);//V_UNIT
				cs.setString(8, V_QTY);//V_QTY
				cs.setString(9, V_PRICE);//V_PRICE
				cs.setString(10, V_DOC_AMT);//V_DOC_AMT
				cs.setString(11, V_REF_NO);//V_REF_NO
				cs.setString(12, V_REF_SEQ);//V_REF_SEQ
				cs.setString(13, V_REF_TYPE);//V_REF_TYPE
				cs.setString(14, "");//V_BL_DOC_NO
				cs.setString(15, "");//V_GROSS_WGT
				cs.setString(16, "");//V_NET_WGT
				cs.setString(17, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(19, V_HS_CD);//V_HS_CD
				cs.setString(20, V_ORIGIN);//V_ORIGIN
				cs.setString(21, "");//V_PALLET_QTY
				cs.setString(22, "");//V_PALLET_KIND
				cs.setString(23, "");//V_PALLET_TYPE
				cs.setString(24, V_PILAMENT_CD);//V_PILAMENT_CD
				cs.setString(25, V_UNIT_WGT);//V_UNIT_WGT
				cs.setString(26, V_MAKER);//V_MAKER
				cs.setString(27, V_CNTR_NO);//V_CNTR_NO
				cs.setString(28, V_MATERIAL_CD);//V_MATERIAL_CD
				cs.setString(29, V_CNTR_TYPE);//V_CNTR_TYPE
				cs.executeQuery();
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			}
			
		} else if (V_TYPE.equals("SYNC2")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_INV_SEQ = hashMap.get("INV_SEQ") == null ? "" : hashMap.get("INV_SEQ").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String V_UNIT = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
					String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					
					String V_BL_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
					String V_GROSS_WGT = hashMap.get("GROSS_WGT") == null ? "" : hashMap.get("GROSS_WGT").toString();
					String V_NET_WGT = hashMap.get("NET_WGT") == null ? "" : hashMap.get("NET_WGT").toString();
					
					String V_HS_CD = hashMap.get("HS_CD") == null ? "" : hashMap.get("HS_CD").toString();
					String V_ORIGIN = hashMap.get("ORIGIN") == null ? "" : hashMap.get("ORIGIN").toString();
					String V_PALLET_QTY = hashMap.get("PALLET_QTY") == null ? "" : hashMap.get("PALLET_QTY").toString();
					String V_PALLET_KIND = hashMap.get("PALLET_KIND") == null ? "" : hashMap.get("PALLET_KIND").toString();
					String V_PALLET_TYPE = hashMap.get("PALLET_TYPE") == null ? "" : hashMap.get("PALLET_TYPE").toString();
					String V_PILAMENT_CD = hashMap.get("PILAMENT_CD") == null ? "" : hashMap.get("PILAMENT_CD").toString();
					String V_UNIT_WGT = hashMap.get("UNIT_WGT") == null ? "" : hashMap.get("UNIT_WGT").toString();
					
					String V_REF_NO = hashMap.get("REF_NO") == null ? "" : hashMap.get("REF_NO").toString();
					String V_REF_SEQ = hashMap.get("REF_SEQ") == null ? "" : hashMap.get("REF_SEQ").toString();
					String V_REF_TYPE = hashMap.get("REF_TYPE") == null ? "" : hashMap.get("REF_TYPE").toString();
					String V_CNTR_TYPE = hashMap.get("CNTR_TYPE") == null ? "" : hashMap.get("CNTR_TYPE").toString();

					cs = conn.prepareCall("call USP_003_S_INV_PT_DTL_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_INV_NO);//V_INV_NO
					cs.setString(4, V_INV_SEQ);//V_INV_SEQ
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, V_ITEM_NM);//V_ITEM_NM
					cs.setString(7, V_UNIT);//V_UNIT
					cs.setString(8, V_QTY);//V_QTY
					cs.setString(9, "");//V_PRICE
					cs.setString(10, "");//V_DOC_AMT
					cs.setString(11, V_REF_NO);//V_REF_NO
					cs.setString(12, V_REF_SEQ);//V_REF_SEQ
					cs.setString(13, V_REF_TYPE);//V_REF_TYPE
					cs.setString(14, V_BL_DOC_NO);//V_BL_DOC_NO
					cs.setString(15, V_GROSS_WGT);//V_GROSS_WGT
					cs.setString(16, V_NET_WGT);//V_NET_WGT
					cs.setString(17, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(19, V_HS_CD);//V_HS_CD
					cs.setString(20, V_ORIGIN);//V_ORIGIN
					cs.setString(21, V_PALLET_QTY);//V_PALLET_QTY
					cs.setString(22, V_PALLET_KIND);//V_PALLET_KIND
					cs.setString(23, V_PALLET_TYPE);//V_PALLET_TYPE
					cs.setString(24, V_PILAMENT_CD);//V_PILAMENT_CD
					cs.setString(25, V_UNIT_WGT);//V_UNIT_WGT
					cs.setString(26, "");//V_MAKER
					cs.setString(27, "");//V_CNTR_NO
					cs.setString(28, "");//V_MATERIAL_CD
					cs.setString(29, V_CNTR_TYPE);//V_CNTR_TYPE
					cs.executeQuery();
					
					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_INV_SEQ = jsondata.get("INV_SEQ") == null ? "" : jsondata.get("INV_SEQ").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String V_UNIT = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
				String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();

				String V_BL_DOC_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
				String V_GROSS_WGT = jsondata.get("GROSS_WGT") == null ? "" : jsondata.get("GROSS_WGT").toString();
				String V_NET_WGT = jsondata.get("NET_WGT") == null ? "" : jsondata.get("NET_WGT").toString();
				
				String V_HS_CD = jsondata.get("HS_CD") == null ? "" : jsondata.get("HS_CD").toString();
				String V_ORIGIN = jsondata.get("ORIGIN") == null ? "" : jsondata.get("ORIGIN").toString();
				String V_PALLET_QTY = jsondata.get("PALLET_QTY") == null ? "" : jsondata.get("PALLET_QTY").toString();
				String V_PALLET_KIND = jsondata.get("PALLET_KIND") == null ? "" : jsondata.get("PALLET_KIND").toString();
				String V_PALLET_TYPE = jsondata.get("PALLET_TYPE") == null ? "" : jsondata.get("PALLET_TYPE").toString();
				String V_PILAMENT_CD = jsondata.get("PILAMENT_CD") == null ? "" : jsondata.get("PILAMENT_CD").toString();
				String V_UNIT_WGT = jsondata.get("UNIT_WGT") == null ? "" : jsondata.get("UNIT_WGT").toString();
				
				String V_REF_NO = jsondata.get("REF_NO") == null ? "" : jsondata.get("REF_NO").toString();
				String V_REF_SEQ = jsondata.get("REF_SEQ") == null ? "" : jsondata.get("REF_SEQ").toString();
				String V_REF_TYPE = jsondata.get("REF_TYPE") == null ? "" : jsondata.get("REF_TYPE").toString();
				String V_CNTR_TYPE = jsondata.get("CNTR_TYPE") == null ? "" : jsondata.get("CNTR_TYPE").toString();
				
				cs = conn.prepareCall("call USP_003_S_INV_PT_DTL_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_INV_NO);//V_INV_NO
				cs.setString(4, V_INV_SEQ);//V_INV_SEQ
				cs.setString(5, V_ITEM_CD);//V_ITEM_CD
				cs.setString(6, V_ITEM_NM);//V_ITEM_NM
				cs.setString(7, V_UNIT);//V_UNIT
				cs.setString(8, V_QTY);//V_QTY
				cs.setString(9, "");//V_PRICE
				cs.setString(10, "");//V_DOC_AMT
				cs.setString(11, V_REF_NO);//V_REF_NO
				cs.setString(12, V_REF_SEQ);//V_REF_SEQ
				cs.setString(13, V_REF_TYPE);//V_REF_TYPE
				cs.setString(14, V_BL_DOC_NO);//V_BL_DOC_NO
				cs.setString(15, V_GROSS_WGT);//V_GROSS_WGT
				cs.setString(16, V_NET_WGT);//V_NET_WGT
				cs.setString(17, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(19, V_HS_CD);//V_HS_CD
				cs.setString(20, V_ORIGIN);//V_ORIGIN
				cs.setString(21, V_PALLET_QTY);//V_PALLET_QTY
				cs.setString(22, V_PALLET_KIND);//V_PALLET_KIND
				cs.setString(23, V_PALLET_TYPE);//V_PALLET_TYPE
				cs.setString(24, V_PILAMENT_CD);//V_PILAMENT_CD
				cs.setString(25, V_UNIT_WGT);//V_UNIT_WGT
				cs.setString(26, "");//V_MAKER
				cs.setString(27, "");//V_CNTR_NO
				cs.setString(28, "");//V_MATERIAL_CD
				cs.setString(29, V_CNTR_TYPE);//V_CNTR_TYPE
				cs.executeQuery();
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			}
			
		} else if (V_TYPE.equals("CFM")) {
			String V_CFM_YN = request.getParameter("V_CFM_YN") == null ? "" : request.getParameter("V_CFM_YN").toUpperCase();
			
			cs = conn.prepareCall("call USP_003_S_INV_PT_HDR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 
			cs.setString(2, V_TYPE);//V_TYPE 
			cs.setString(3, V_INV_NO);//V_INV_NO 
			cs.setString(4, "");//V_INV_DT 
			cs.setString(5, "");//V_LC_DOC_NO 
			cs.setString(6, "");//V_LC_DT 
			cs.setString(7, "");//V_BP_CD 
			cs.setString(8, "");//V_BL_DOC_NO 
			cs.setString(9, "");//V_LOADING_DT
			cs.setString(10, "");//V_CONSIGNEE 
			cs.setString(11, "");//V_BUYER_ADDR 
			cs.setString(12, "");//V_SHIP_MARK 
			cs.setString(13, "");//V_NOTIFY 
			cs.setString(14, "");//V_SELLER 
			cs.setString(15, "");//V_TRANS_TYPE
			cs.setString(16, "");//V_VESSEL 
			cs.setString(17, "");//V_PAY_METH 
			cs.setString(18, "");//V_IN_TERMS 
			cs.setString(19, "");//V_INVOICE_NO
			cs.setString(20, "");//V_ETD
			cs.setString(21, "");//V_ETA
			cs.setString(22, "");//V_LOADING_PORT
			cs.setString(23, "");//V_DISCHGE_PORT
			cs.setString(24, V_CFM_YN);//V_CFM_YN 
			cs.setString(25, "");//V_REMARK 
			cs.setString(26, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, "");//V_IV_DT_FR
			cs.setString(29, "");//V_IV_DT_TO
			cs.setString(30, "");//V_INSUR_AMT
			cs.setString(31, "");//V_TERMINAL
			cs.setString(32, "");//V_CUR
			cs.setString(33, "");//V_CNTR_QTY
			cs.setString(34, "");//V_CNTR_SZTP
			cs.setString(35, "");//V_TITLE
			cs.setString(36, "");//V_PARAM1
			cs.setString(37, "");//V_PARAM2
			cs.setString(38, "");//V_PARAM3
			cs.executeQuery();

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
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


