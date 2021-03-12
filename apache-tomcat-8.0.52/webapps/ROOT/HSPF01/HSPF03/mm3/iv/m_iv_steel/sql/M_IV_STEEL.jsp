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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").toUpperCase().substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").toUpperCase().substring(0, 10);
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();

		
		//상단
		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_001_M_IV_GR_REF_STEEL(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_M_BP_NM);//V_M_BP_NM
			cs.setString(3, V_MVMT_DT_FR);//V_MVMT_DT_FR
			cs.setString(4, V_MVMT_DT_TO);//V_MVMT_DT_TO
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("MVMT_SEQ", rs.getString("MVMT_SEQ"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("BON_QTY", rs.getString("BON_QTY"));
				subObject.put("BON_WGT_UNIT", rs.getString("BON_WGT_UNIT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("FORWARD_XCH_RT", rs.getString("FORWARD_XCH_RT"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));

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

			//하단헤더조회
		} else if (V_TYPE.equals("SH")) {

			String V_IV_NO = request.getParameter("V_IV_NO") == null ? "" : request.getParameter("V_IV_NO").toUpperCase();

			cs = conn.prepareCall("call USP_M_001_IV_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_IV_NO);//V_BILL_NO
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

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IV_NO", rs.getString("IV_NO"));
				subObject.put("IV_DT", rs.getString("IV_DT").substring(0, 10));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("T_BP_CD", rs.getString("T_BP_CD"));
				subObject.put("T_BP_NM", rs.getString("T_BP_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IV_TERMS_NM", rs.getString("IN_TERMS"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
				subObject.put("ELEC_VAT_YN", rs.getString("ELEC_VAT_YN"));
				subObject.put("IV_ISSUE_DT", rs.getString("IV_ISSUE_DT").substring(0, 10));
				subObject.put("TAX_CD", rs.getString("TAX_CD"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
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

			//하단상세조회
		} else if (V_TYPE.equals("SD")) {

			String V_IV_NO = request.getParameter("V_IV_NO") == null ? "" : request.getParameter("V_IV_NO").toUpperCase();
			// 			System.out.println("V_IV_NO" + V_IV_NO);
			cs = conn.prepareCall("call USP_001_M_IV_D_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_IV_NO);//V_BILL_NO
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
			cs.setString(14, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(16, "");//
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(15);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IV_NO", rs.getString("IV_NO"));
				subObject.put("IV_SEQ", rs.getString("IV_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("IV_QTY", rs.getString("IV_QTY"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("IV_AMT", rs.getString("IV_AMT"));
				subObject.put("IV_LOC_AMT", rs.getString("IV_LOC_AMT"));
				subObject.put("IV_LOC_AMT2", rs.getString("IV_LOC_AMT"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("BON_QTY", rs.getString("BON_QTY"));
				subObject.put("BON_WGT_UNIT", rs.getString("BON_WGT_UNIT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("DATA", rs.getString("DATA"));
				subObject.put("MVMT_SEQ", rs.getString("MVMT_SEQ"));
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

			String V_IV_NO = request.getParameter("V_IV_NO") == null ? "" : request.getParameter("V_IV_NO").toUpperCase();

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_IV_SEQ = hashMap.get("IV_SEQ") == null ? "" : hashMap.get("IV_SEQ").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_IV_QTY = hashMap.get("IV_QTY") == null ? "" : hashMap.get("IV_QTY").toString();
					String V_IV_PRC = hashMap.get("IV_PRC") == null ? "" : hashMap.get("IV_PRC").toString();
					String V_IV_AMT = hashMap.get("IV_AMT") == null ? "" : hashMap.get("IV_AMT").toString();
					String V_IV_LOC_AMT = hashMap.get("IV_LOC_AMT") == null ? "" : hashMap.get("IV_LOC_AMT").toString();
					String V_COST_CD = hashMap.get("COST_CD") == null ? "" : hashMap.get("COST_CD").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String V_VAT_RATE = hashMap.get("VAT_RATE") == null ? "" : hashMap.get("VAT_RATE").toString();
					String V_VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String V_MVMT_SEQ = hashMap.get("MVMT_SEQ") == null ? "" : hashMap.get("MVMT_SEQ").toString();

					cs = conn.prepareCall("call USP_001_M_IV_D_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_IV_NO);//V_BILL_NO
					cs.setString(4, V_IV_SEQ);//V_BILL_SEQ
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, V_IV_QTY);//V_BILL_QTY
					cs.setString(7, V_IV_PRC);//V_BILL_PRC
					cs.setString(8, V_IV_AMT);//V_BILL_AMT
					cs.setString(9, V_IV_LOC_AMT);//V_BILL_LOC_AMT
					cs.setString(10, V_COST_CD);//V_COST_CD
					cs.setString(11, V_VAT_TYPE);//V_VAT_TYPE
					cs.setString(12, V_VAT_AMT);//V_VAT_AMT
					cs.setString(13, V_MVMT_NO);//V_DN_NO
					cs.setString(14, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(16, V_MVMT_SEQ);//V_MVMT_SEQ

					cs.executeQuery();
					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {

// 				JSONObject jsondata = JSONObject.fromObject(jsonData);
				//큰수에 소수점이 있는경우 숫자계산이 이상해서 수정함. 20200108 김장운

				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);					
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_IV_SEQ = jsondata.get("IV_SEQ") == null ? "" : jsondata.get("IV_SEQ").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_IV_QTY = jsondata.get("IV_QTY") == null ? "" : jsondata.get("IV_QTY").toString();
				String V_IV_PRC = jsondata.get("IV_PRC") == null ? "" : jsondata.get("IV_PRC").toString();
				String V_IV_AMT = jsondata.get("IV_AMT") == null ? "" : jsondata.get("IV_AMT").toString();
				String V_IV_LOC_AMT = jsondata.get("IV_LOC_AMT") == null ? "" : jsondata.get("IV_LOC_AMT").toString();
				String V_COST_CD = jsondata.get("COST_CD") == null ? "" : jsondata.get("COST_CD").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String V_VAT_RATE = jsondata.get("VAT_RATE") == null ? "" : jsondata.get("VAT_RATE").toString();
				String V_VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String V_MVMT_SEQ = jsondata.get("MVMT_SEQ") == null ? "" : jsondata.get("MVMT_SEQ").toString();

				cs = conn.prepareCall("call USP_001_M_IV_D_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_IV_NO);//V_BILL_NO
				cs.setString(4, V_IV_SEQ);//V_BILL_SEQ
				cs.setString(5, V_ITEM_CD);//V_ITEM_CD
				cs.setString(6, V_IV_QTY);//V_BILL_QTY
				cs.setString(7, V_IV_PRC);//V_BILL_PRC
				cs.setString(8, V_IV_AMT);//V_BILL_AMT
				cs.setString(9, V_IV_LOC_AMT);//V_BILL_LOC_AMT
				cs.setString(10, V_COST_CD);//V_COST_CD
				cs.setString(11, V_VAT_TYPE);//V_VAT_TYPE
				cs.setString(12, V_VAT_AMT);//V_VAT_AMT
				cs.setString(13, V_MVMT_NO);//V_DN_NO
				cs.setString(14, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(16, V_MVMT_SEQ);//V_MVMT_SEQ

				cs.executeQuery();
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
		} else if (V_TYPE.equals("IH") || V_TYPE.equals("IU")) {

// 			System.out.println("V_TYPE" + V_TYPE);

			String V_IV_NO = request.getParameter("V_IV_NO") == null ? "" : request.getParameter("V_IV_NO").toUpperCase();
			String V_IV_DT = request.getParameter("V_IV_DT") == null ? "" : request.getParameter("V_IV_DT").toUpperCase().substring(0, 10);
			String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
			String V_M_BP_CD2 = request.getParameter("V_M_BP_CD2") == null ? "" : request.getParameter("V_M_BP_CD2").toUpperCase();
			String V_T_BP_CD = request.getParameter("V_T_BP_CD") == null ? "" : request.getParameter("V_T_BP_CD").toUpperCase();
			String V_IV_ISSUE_DT = request.getParameter("V_IV_ISSUE_DT") == null ? "" : request.getParameter("V_IV_ISSUE_DT").toUpperCase().substring(0, 10);
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_XCHG_RT = request.getParameter("V_XCHG_RT") == null ? "" : request.getParameter("V_XCHG_RT").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_TAX_CD = request.getParameter("V_TAX_CD") == null ? "" : request.getParameter("V_TAX_CD").toUpperCase();
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH").toUpperCase();
			String V_IN_TERMS = request.getParameter("V_IN_TERMS") == null ? "" : request.getParameter("V_IN_TERMS").toUpperCase();
			String V_ELEC_VAT_YN = request.getParameter("V_ELEC_VAT_YN") == null ? "" : request.getParameter("V_ELEC_VAT_YN").toUpperCase();

			cs = conn.prepareCall("call USP_001_M_IV_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_IV_NO);//V_IV_NO
			cs.setString(4, V_IV_DT);//V_BILL_DT
			cs.setString(5, V_M_BP_CD2);//V_S_BP_CD
			cs.setString(6, V_T_BP_CD);//V_R_BP_CD
			cs.setString(7, V_IV_TYPE);//V_IN_TERMS
			cs.setString(8, V_IN_TERMS);//V_PAY_METH
			cs.setString(9, V_PAY_METH);//V_SALE_TYPE
			cs.setString(10, V_BL_DOC_NO);//V_CUR
			cs.setString(11, V_CUR);//V_XCHG_RT
			cs.setString(12, V_XCHG_RT);//V_VAT_INC
			cs.setString(13, V_ELEC_VAT_YN);//V_DN_ISSUE_DT
			cs.setString(14, V_IV_ISSUE_DT);//V_TAX_CD
			cs.setString(15, V_TAX_CD);//V_CFM_YN
			cs.setString(16, "");//V_TEMP_GL_NO
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);

			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);

			String IV_NO = "";

			while (rs.next()) {
				IV_NO = rs.getString("IV_NO");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(IV_NO);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("PS")) {

			String W_IV_DT_FR = request.getParameter("W_IV_DT_FR") == null ? "" : request.getParameter("W_IV_DT_FR").toUpperCase().substring(0, 10);
			String W_IV_DT_TO = request.getParameter("W_IV_DT_TO") == null ? "" : request.getParameter("W_IV_DT_TO").toUpperCase().substring(0, 10);
			String W_M_BP_NM = request.getParameter("W_M_BP_NM") == null ? "" : request.getParameter("W_M_BP_NM").toUpperCase();

			cs = conn.prepareCall("call USP_001_M_IV_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_BILL_NO
			cs.setString(4, W_IV_DT_FR);//V_BILL_DT
			cs.setString(5, W_M_BP_NM);//V_S_BP_CD
			cs.setString(6, "");//V_R_BP_CD
			cs.setString(7, "");//V_IN_TERMS
			cs.setString(8, "");//V_PAY_METH
			cs.setString(9, "");//V_SALE_TYPE
			cs.setString(10, "");//V_CUR
			cs.setString(11, "");//V_XCHG_RT
			cs.setString(12, "");//V_VAT_INC
			cs.setString(13, "");//V_DN_ISSUE_DT
			cs.setString(14, W_IV_DT_TO);//W_IV_DT_TO
			cs.setString(15, "");//V_CFM_YN
			cs.setString(16, "");//V_TEMP_GL_NO
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IV_NO", rs.getString("IV_NO"));
				subObject.put("IV_DT", rs.getString("IV_DT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("IV_LOC_AMT", rs.getString("IV_LOC_AMT"));
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

			String V_IV_NO = request.getParameter("V_IV_NO") == null ? "" : request.getParameter("V_IV_NO").toUpperCase();
			
			
			cs = conn.prepareCall("call USP_001_A_TEMP_GOCHUL_CHECK(?,?)"); //고철인지 아닌지 체크.
			cs.setString(1, V_IV_NO);//V_BL_NO
			cs.registerOutParameter(2, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(2);

			String GOCHUL_YN = "";
			if (rs.next()) {
				GOCHUL_YN = rs.getString("GOCHUL_YN");
			}
			
			if(GOCHUL_YN.equals("N")){
				//고철이 아니면.
				cs = conn.prepareCall("call USP_001_A_TEMP_IV_FR(?,?,?,?,?)");
	
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_IV_NO);//V_BL_NO
				cs.setString(4, V_USR_ID);//V_BL_SEQ
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
	
				rs = (ResultSet) cs.getObject(5);
	
				String V_TEMP_GL_NO = "";
				if (rs.next()) {
					V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
				}
				
				if (V_TEMP_GL_NO.contains("TG")) {
					//애니링크 시작
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
			else{
				//고철인 경우.
				cs = conn.prepareCall("call USP_001_A_TEMP_GOCHUL_GL_STEEL_IV(?,?,?,?,?)");
	
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_IV_NO);//V_BL_NO
				cs.setString(4, V_USR_ID);//V_BL_SEQ
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
	
				rs = (ResultSet) cs.getObject(5);
	
				String V_TEMP_GL_NO = "";
				if (rs.next()) {
					V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
				}
				if (V_TEMP_GL_NO.contains("TG")) {
					//애니링크 시작
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


