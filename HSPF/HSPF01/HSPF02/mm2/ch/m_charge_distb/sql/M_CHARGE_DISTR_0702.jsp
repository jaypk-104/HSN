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
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();

		String V_PR_STEP = request.getParameter("V_PR_STEP") == null ? "" : request.getParameter("V_PR_STEP").toUpperCase();
		String V_BAS_NO = request.getParameter("V_BAS_NO") == null ? "" : request.getParameter("V_BAS_NO").toUpperCase();
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_CC_DOC_NO = request.getParameter("V_CC_DOC_NO") == null ? "" : request.getParameter("V_CC_DOC_NO").toUpperCase();
		String V_ID_NO = request.getParameter("V_ID_NO") == null ? "" : request.getParameter("V_ID_NO").toUpperCase();

		String W_LC_DOC_NO = request.getParameter("W_LC_DOC_NO") == null ? "" : request.getParameter("W_LC_DOC_NO").toUpperCase();
		String W_BL_DOC_NO = request.getParameter("W_BL_DOC_NO") == null ? "" : request.getParameter("W_BL_DOC_NO").toUpperCase();
		String W_CC_DOC_NO = request.getParameter("W_CC_DOC_NO") == null ? "" : request.getParameter("W_CC_DOC_NO").toUpperCase();
		String W_ID_NO = request.getParameter("W_ID_NO") == null ? "" : request.getParameter("W_ID_NO").toUpperCase();

		String V_CHARGE_NO = request.getParameter("V_CHARGE_NO") == null ? "" : request.getParameter("V_CHARGE_NO").toUpperCase();
		String V_DT_FR = request.getParameter("V_DT_FR") == null ? "" : request.getParameter("V_DT_FR").substring(0, 10);
		String V_DT_TO = request.getParameter("V_DT_TO") == null ? "" : request.getParameter("V_DT_TO").substring(0, 10);
		String V_CHECK = "";
		if (V_TYPE.equals("SP")) {
			V_CHECK = request.getParameter("V_CHECK").equals("true") ? "ALL" : "";
		}
		//관리구분팝업조회
		if (V_TYPE.equals("SP")) {
			cs = conn.prepareCall("call DISTR_CG.USP_M_CHARGE_POPUP_DISTR(?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_PR_STEP);//V_PR_STEP
			cs.setString(2, W_LC_DOC_NO);//W_LC_DOC_NO
			cs.setString(3, W_BL_DOC_NO);//W_BL_DOC_NO
			cs.setString(4, W_ID_NO);//W_CC_DOC_NO
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(6, V_DT_FR);//V_DT_FR
			cs.setString(7, V_DT_TO);//V_DT_TO
			cs.setString(8, V_M_BP_NM);//V_M_BP_NM
			cs.setString(9, V_CHECK);//V_M_BP_NM
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();
				if (V_PR_STEP.equals("VL")) {
					subObject.put("LC_NO", rs.getString("LC_NO"));
					subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
					subObject.put("LC_AMEND_SEQ", rs.getString("LC_AMEND_SEQ"));
					subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
					subObject.put("BANK_CD", rs.getString("BANK_CD"));
					subObject.put("BANK_NM", rs.getString("BANK_NM"));
					subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
					subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
					subObject.put("CHARGE_YN", rs.getString("CHARGE_YN"));
					subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
					subObject.put("MAST_CHARGE_NO", rs.getString("MAST_CHARGE_NO"));

				} else if (V_PR_STEP.equals("VB")) {
					subObject.put("BL_NO", rs.getString("BL_NO"));
					subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
					subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
					subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
					subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
					subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
					subObject.put("CHARGE_YN", rs.getString("CHARGE_YN"));
					subObject.put("MAST_CHARGE_NO", rs.getString("MAST_CHARGE_NO"));

				} else if (V_PR_STEP.equals("VC")) {
					subObject.put("CC_NO", rs.getString("CC_NO"));
					subObject.put("ID_NO", rs.getString("ID_NO"));
					subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
					subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
					subObject.put("ID_DT", rs.getString("ID_DT"));
					subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
					subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
					subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
					subObject.put("CHARGE_YN", rs.getString("CHARGE_YN"));
					subObject.put("MAST_CHARGE_NO", rs.getString("MAST_CHARGE_NO"));
				}
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

		} else if (V_TYPE.equals("SH")) {

			cs = conn.prepareCall("call DISTR_CG.USP_M_CHARGE_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_MAST_CHARGE_NO
			cs.setString(4, "");//V_FIRST_YN
			cs.setString(5, "");//V_CHARGE_NO
			cs.setString(6, "");//V_CHARGE_SEQ
			cs.setString(7, V_PR_STEP);//V_PR_STEP
			cs.setString(8, V_BAS_NO);//V_BAS_NO
			cs.setString(9, "");//V_BAS_DOC_NO
			cs.setString(10, "");//V_CHARGE_CD
			cs.setString(11, "");//V_DISTR_FLAG
			cs.setString(12, "");//V_DISTR_TYPE
			cs.setString(13, "");//V_CUR
			cs.setString(14, "");//V_DOC_AMT
			cs.setString(15, "");//V_LOC_AMT
			cs.setString(16, "");//V_XCHG_RT
			cs.setString(17, "");//V_CHARGE_DT
			cs.setString(18, "");//V_VAT_REF_AMT
			cs.setString(19, "");//V_VAT_AMT
			cs.setString(20, "");//V_VAT_TYPE
			cs.setString(21, "");//V_VAT_RATE
			cs.setString(22, "");//V_M_BP_CD
			cs.setString(23, "");//V_TAX_BP_CD
			cs.setString(24, "");//V_M_PS_NUM
			cs.setString(25, "");//V_BANK_CD
			cs.setString(26, "");//V_BANK_ACCT
			cs.setString(27, "");//V_PAY_TYPE
			cs.setString(28, "");//V_PAY_AMT
			cs.setString(29, "");//V_PAY_DUE_DT
			cs.setString(30, "");//V_TAX_BIZ_CD
			cs.setString(31, "");//V_COST_CD
			cs.setString(32, "");//V_NOTE_NO
			cs.setString(33, "");//V_EXP_ITEM_FLG
			cs.setString(34, "");//V_TEMP_GL_NO
			cs.setString(35, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(36);

			//경비가 없는 경우 품의명만 들고 온다.
			if (V_USR_ID.equals("NEW")) {

				String APPROV_NM = "";
				while (rs.next()) {
					APPROV_NM = rs.getString("APPROV_NM");
				}

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(APPROV_NM);
				pw.flush();
				pw.close();

			} else {
				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("MAST_CHARGE_NO", rs.getString("MAST_CHARGE_NO"));
					subObject.put("CHARGE_NO", rs.getString("CHARGE_NO"));
					subObject.put("PR_STEP", rs.getString("PR_STEP"));
					subObject.put("BAS_NO", rs.getString("BAS_NO"));
					subObject.put("BAS_DOC_NO", rs.getString("BAS_DOC_NO"));
					subObject.put("ID_NO", rs.getString("ID_NO"));
					subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
					subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
					subObject.put("CHARGE_NO", rs.getString("CHARGE_NO"));
					subObject.put("CHARGE_CD", rs.getString("CHARGE_CD"));
					subObject.put("CHARGE_NM", rs.getString("CHARGE_NM"));
					subObject.put("CUR", rs.getString("CUR"));
					subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
					subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
					subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
					subObject.put("CHARGE_DT", rs.getString("CHARGE_DT"));
					subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
					subObject.put("VAT_REF_AMT", rs.getString("VAT_REF_AMT"));
					subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
					subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
					subObject.put("VAT_RATE", rs.getString("VAT_RATE"));
					subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
					subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
					subObject.put("TAX_BP_CD", rs.getString("TAX_BP_CD"));
					subObject.put("TAX_BP_NM", rs.getString("TAX_BP_NM"));
					subObject.put("M_PS_NUM", rs.getString("M_PS_NUM"));
					subObject.put("PAY_TYPE_NM", rs.getString("PAY_TYPE_NM"));
					subObject.put("M_PS_NUM", rs.getString("M_PS_NUM"));
					subObject.put("BANK_CD", rs.getString("BANK_CD"));
					subObject.put("BANK_NM", rs.getString("BANK_NM"));
					subObject.put("BANK_ACCT", rs.getString("BANK_ACCT"));
					subObject.put("PAY_TYPE", rs.getString("PAY_TYPE"));
					subObject.put("PAY_TYPE_NM", rs.getString("PAY_TYPE_NM"));
					subObject.put("PAY_DUE_DT", rs.getString("PAY_DUE_DT"));
					subObject.put("TAX_BIZ_CD", rs.getString("TAX_BIZ_CD"));
					subObject.put("NOTE_NO", rs.getString("NOTE_NO"));
					subObject.put("DISTR_TYPE", rs.getString("DISTR_TYPE"));
					subObject.put("EXP_ITEM_FLG", rs.getString("EXP_ITEM_FLG").equals("N") ? false : true);
					subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
					subObject.put("PAY_AMT", rs.getString("PAY_AMT"));
					subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
					subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
					jsonArray.add(subObject);
				}
				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

				// 				System.out.println(jsonObject);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
			}

		} else if (V_TYPE.equals("SD")) {

			cs = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_1(?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "");//V_MAST_CHARGE_NO
			cs.setString(3, V_CHARGE_NO);//V_CHARGE_NO
			cs.setString(4, V_TYPE);//V_PR_STEP == 여기선 V_TYPE
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.setString(6, V_BAS_NO);//V_BAS_NO
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_CHARGE_NO", rs.getString("MAST_CHARGE_NO"));
				subObject.put("CHARGE_NO", rs.getString("CHARGE_NO"));
				subObject.put("CHARGE_SEQ", rs.getString("CHARGE_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ITEM_QTY", rs.getString("ITEM_QTY"));
				subObject.put("ITEM_AMT", rs.getString("ITEM_AMT"));
				subObject.put("DISTR_TYPE", rs.getString("DISTR_TYPE"));
				subObject.put("BASE_CHARGE_AMT", rs.getString("BASE_CHARGE_AMT"));
				subObject.put("TOT_MVMT_QTY", rs.getString("TOT_MVMT_QTY"));
				subObject.put("TOT_DISB_AMT", rs.getString("TOT_DISB_AMT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("BAS_NO", rs.getString("BAS_NO"));
				subObject.put("BAS_SEQ", rs.getString("BAS_SEQ"));
				subObject.put("DISTR_TYPE_NM", rs.getString("DISTR_TYPE_NM"));
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

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_MAST_CHARGE_NO = hashMap.get("MAST_CHARGE_NO") == null ? "" : hashMap.get("MAST_CHARGE_NO").toString();
					String V_FIRST_YN = hashMap.get("FIRST_YN") == null ? "" : hashMap.get("FIRST_YN").toString();

					if (i == 0) {
						V_FIRST_YN = "Y";
					} else {
						V_FIRST_YN = "N";
					}

					V_CHARGE_NO = hashMap.get("CHARGE_NO") == null ? "" : hashMap.get("CHARGE_NO").toString();
					String V_CHARGE_SEQ = hashMap.get("CHARGE_SEQ") == null ? "" : hashMap.get("CHARGE_SEQ").toString();

					V_BAS_NO = hashMap.get("BAS_NO") == null ? "" : hashMap.get("BAS_NO").toString();
					String V_BAS_DOC_NO = "";
					if (V_PR_STEP.equals("VL")) {
						V_BAS_DOC_NO = hashMap.get("LC_DOC_NO") == null ? "" : hashMap.get("LC_DOC_NO").toString();
					}
					if (V_PR_STEP.equals("VB")) {
						V_BAS_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
					}
					if (V_PR_STEP.equals("VC")) {
						V_BAS_DOC_NO = hashMap.get("ID_NO") == null ? "" : hashMap.get("ID_NO").toString();
					}

					String V_CHARGE_CD = hashMap.get("CHARGE_CD") == null ? "" : hashMap.get("CHARGE_CD").toString();
					String V_DISTR_FLAG = hashMap.get("DISTR_FLAG") == null ? "" : hashMap.get("DISTR_FLAG").toString();
					String V_DISTR_TYPE = hashMap.get("DISTR_TYPE") == null ? "" : hashMap.get("DISTR_TYPE").toString();
					String V_CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String V_DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
					String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
					String V_XCHG_RT = hashMap.get("XCHG_RT") == null ? "" : hashMap.get("XCHG_RT").toString();
					String V_CHARGE_DT = hashMap.get("CHARGE_DT") == null ? "" : hashMap.get("CHARGE_DT").toString().substring(0, 10);
					String V_VAT_REF_AMT = hashMap.get("VAT_REF_AMT") == null ? "" : hashMap.get("VAT_REF_AMT").toString();
					String V_VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null || hashMap.get("VAT_TYPE").equals("null") ? "" : hashMap.get("VAT_TYPE").toString();
					String V_VAT_RATE = hashMap.get("VAT_RATE") == null ? "" : hashMap.get("VAT_RATE").toString();
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String V_TAX_BP_CD = hashMap.get("TAX_BP_CD") == null ? "" : hashMap.get("TAX_BP_CD").toString();
					String V_M_PS_NUM = hashMap.get("M_PS_NUM") == null ? "" : hashMap.get("M_PS_NUM").toString();
					String V_BANK_CD = hashMap.get("BANK_CD") == null ? "" : hashMap.get("BANK_CD").toString();
					String V_BANK_ACCT = hashMap.get("BANK_ACCT") == null ? "" : hashMap.get("BANK_ACCT").toString();
					String V_PAY_TYPE = hashMap.get("PAY_TYPE") == null ? "" : hashMap.get("PAY_TYPE").toString();
					String V_PAY_AMT = hashMap.get("PAY_AMT") == null ? "" : hashMap.get("PAY_AMT").toString();
					String V_PAY_DUE_DT = hashMap.get("PAY_DUE_DT") == null || hashMap.get("PAY_DUE_DT").equals("null") ? "" : hashMap.get("PAY_DUE_DT").toString().substring(0, 10);
					String V_TAX_BIZ_CD = hashMap.get("TAX_BIZ_CD") == null ? "" : hashMap.get("TAX_BIZ_CD").toString();
					String V_COST_CD = hashMap.get("COST_CD") == null ? "" : hashMap.get("COST_CD").toString();
					String V_NOTE_NO = hashMap.get("NOTE_NO") == null ? "" : hashMap.get("NOTE_NO").toString();
					String V_EXP_ITEM_FLG = hashMap.get("EXP_ITEM_FLG") == null ? "" : hashMap.get("EXP_ITEM_FLG").toString();
					// 					System.out.println(i + V_EXP_ITEM_FLG);

					if (V_EXP_ITEM_FLG.equals("true") || V_EXP_ITEM_FLG.equals("Y")) {
						V_EXP_ITEM_FLG = "Y";
					} else {
						V_EXP_ITEM_FLG = "N";
					}

					String V_TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString();

					if (!V_M_BP_CD.equals("")) {
						cs = conn.prepareCall("call DISTR_CG.USP_M_CHARGE_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_MAST_CHARGE_NO);//V_MAST_CHARGE_NO
						cs.setString(4, V_FIRST_YN);//V_FIRST_YN
						cs.setString(5, V_CHARGE_NO);//V_CHARGE_NO
						cs.setString(6, V_CHARGE_SEQ);//V_CHARGE_SEQ
						cs.setString(7, V_PR_STEP);//V_PR_STEP
						cs.setString(8, V_BAS_NO);//V_BAS_NO
						cs.setString(9, V_BAS_DOC_NO);//V_BAS_DOC_NO
						cs.setString(10, V_CHARGE_CD);//V_CHARGE_CD
						cs.setString(11, V_DISTR_FLAG);//V_DISTR_FLAG
						cs.setString(12, V_DISTR_TYPE);//V_DISTR_TYPE
						cs.setString(13, V_CUR);//V_CUR
						cs.setString(14, V_DOC_AMT);//V_DOC_AMT
						cs.setString(15, V_LOC_AMT);//V_LOC_AMT
						cs.setString(16, V_XCHG_RT);//V_XCHG_RT
						cs.setString(17, V_CHARGE_DT);//V_CHARGE_DT
						cs.setString(18, V_VAT_REF_AMT);//V_VAT_REF_AMT
						cs.setString(19, V_VAT_AMT);//V_VAT_AMT
						cs.setString(20, V_VAT_TYPE);//V_VAT_TYPE
						cs.setString(21, V_VAT_RATE);//V_VAT_RATE
						cs.setString(22, V_M_BP_CD);//V_M_BP_CD
						cs.setString(23, V_TAX_BP_CD);//V_TAX_BP_CD
						cs.setString(24, V_M_PS_NUM);//V_M_PS_NUM
						cs.setString(25, V_BANK_CD);//V_BANK_CD
						cs.setString(26, V_BANK_ACCT);//V_BANK_ACCT
						cs.setString(27, V_PAY_TYPE);//V_PAY_TYPE
						cs.setString(28, V_PAY_AMT);//V_PAY_AMT
						cs.setString(29, V_PAY_DUE_DT);//V_PAY_DUE_DT
						cs.setString(30, V_TAX_BIZ_CD);//V_TAX_BIZ_CD
						cs.setString(31, V_COST_CD);//V_COST_CD
						cs.setString(32, V_NOTE_NO);//V_NOTE_NO
						cs.setString(33, V_EXP_ITEM_FLG);//V_EXP_ITEM_FLG
						cs.setString(34, V_TEMP_GL_NO);//V_TEMP_GL_NO
						cs.setString(35, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(36);
						String res = "";

						while (rs.next()) {
							res = rs.getString("res");
						}

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print(res);
						pw.flush();
						pw.close();
					}

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_MAST_CHARGE_NO = jsondata.get("MAST_CHARGE_NO") == null ? "" : jsondata.get("MAST_CHARGE_NO").toString();
				String V_FIRST_YN = jsondata.get("FIRST_YN") == null ? "" : jsondata.get("FIRST_YN").toString();

				/**************************/
				V_FIRST_YN = "Y";
				/**************************/

				V_CHARGE_NO = jsondata.get("CHARGE_NO") == null ? "" : jsondata.get("CHARGE_NO").toString();
				String V_CHARGE_SEQ = jsondata.get("CHARGE_SEQ") == null ? "" : jsondata.get("CHARGE_SEQ").toString();
				//						String V_PR_STEP = jsondata.get("PR_STEP") == null ? "" : jsondata.get("PR_STEP").toString();
				V_BAS_NO = jsondata.get("BAS_NO") == null ? "" : jsondata.get("BAS_NO").toString();
				String V_BAS_DOC_NO = "";
				if (V_PR_STEP.equals("VL")) {
					V_BAS_DOC_NO = jsondata.get("LC_DOC_NO") == null ? "" : jsondata.get("LC_DOC_NO").toString();
				}
				if (V_PR_STEP.equals("VB")) {
					V_BAS_DOC_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
				}
				if (V_PR_STEP.equals("VC")) {
					V_BAS_DOC_NO = jsondata.get("ID_NO") == null ? "" : jsondata.get("ID_NO").toString();
				}
				String V_CHARGE_CD = jsondata.get("CHARGE_CD") == null ? "" : jsondata.get("CHARGE_CD").toString();
				String V_DISTR_FLAG = jsondata.get("DISTR_FLAG") == null ? "" : jsondata.get("DISTR_FLAG").toString();
				String V_DISTR_TYPE = jsondata.get("DISTR_TYPE") == null ? "" : jsondata.get("DISTR_TYPE").toString();
				String V_CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
				String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
				String V_XCHG_RT = jsondata.get("XCHG_RT") == null ? "" : jsondata.get("XCHG_RT").toString();
				String V_CHARGE_DT = jsondata.get("CHARGE_DT") == null ? "" : jsondata.get("CHARGE_DT").toString().substring(0, 10);
				String V_VAT_REF_AMT = jsondata.get("VAT_REF_AMT") == null ? "" : jsondata.get("VAT_REF_AMT").toString();
				String V_VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null || jsondata.get("VAT_TYPE").equals("null") ? "" : jsondata.get("VAT_TYPE").toString();
				String V_VAT_RATE = jsondata.get("VAT_RATE") == null ? "" : jsondata.get("VAT_RATE").toString();
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String V_TAX_BP_CD = jsondata.get("TAX_BP_CD") == null ? "" : jsondata.get("TAX_BP_CD").toString();
				String V_M_PS_NUM = jsondata.get("M_PS_NUM") == null ? "" : jsondata.get("M_PS_NUM").toString();
				String V_BANK_CD = jsondata.get("BANK_CD") == null ? "" : jsondata.get("BANK_CD").toString();
				String V_BANK_ACCT = jsondata.get("BANK_ACCT") == null ? "" : jsondata.get("BANK_ACCT").toString();
				String V_PAY_TYPE = jsondata.get("PAY_TYPE") == null ? "" : jsondata.get("PAY_TYPE").toString();
				String V_PAY_AMT = jsondata.get("PAY_AMT") == null ? "" : jsondata.get("PAY_AMT").toString();
				String V_PAY_DUE_DT = jsondata.get("PAY_DUE_DT") == null || jsondata.get("PAY_DUE_DT").equals("null") ? "" : jsondata.get("PAY_DUE_DT").toString().substring(0, 10);
				String V_TAX_BIZ_CD = jsondata.get("TAX_BIZ_CD") == null ? "" : jsondata.get("TAX_BIZ_CD").toString();
				String V_COST_CD = jsondata.get("COST_CD") == null ? "" : jsondata.get("COST_CD").toString();
				String V_NOTE_NO = jsondata.get("NOTE_NO") == null ? "" : jsondata.get("NOTE_NO").toString();
				String V_EXP_ITEM_FLG = jsondata.get("EXP_ITEM_FLG") == null ? "" : jsondata.get("EXP_ITEM_FLG").toString();

				if (V_EXP_ITEM_FLG.equals("true") || V_EXP_ITEM_FLG.equals("Y")) {
					V_EXP_ITEM_FLG = "Y";
				} else {
					V_EXP_ITEM_FLG = "N";
				}

				String V_TEMP_GL_NO = jsondata.get("TEMP_GL_NO") == null ? "" : jsondata.get("TEMP_GL_NO").toString();
				if (!V_M_BP_CD.equals("")) {
					cs = conn.prepareCall("call DISTR_CG.USP_M_CHARGE_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_MAST_CHARGE_NO);//V_MAST_CHARGE_NO
					cs.setString(4, V_FIRST_YN);//V_FIRST_YN
					cs.setString(5, V_CHARGE_NO);//V_CHARGE_NO
					cs.setString(6, V_CHARGE_SEQ);//V_CHARGE_SEQ
					cs.setString(7, V_PR_STEP);//V_PR_STEP
					cs.setString(8, V_BAS_NO);//V_BAS_NO
					cs.setString(9, V_BAS_DOC_NO);//V_BAS_DOC_NO
					cs.setString(10, V_CHARGE_CD);//V_CHARGE_CD
					cs.setString(11, V_DISTR_FLAG);//V_DISTR_FLAG
					cs.setString(12, V_DISTR_TYPE);//V_DISTR_TYPE
					cs.setString(13, V_CUR);//V_CUR
					cs.setString(14, V_DOC_AMT);//V_DOC_AMT
					cs.setString(15, V_LOC_AMT);//V_LOC_AMT
					cs.setString(16, V_XCHG_RT);//V_XCHG_RT
					cs.setString(17, V_CHARGE_DT);//V_CHARGE_DT
					cs.setString(18, V_VAT_REF_AMT);//V_VAT_REF_AMT
					cs.setString(19, V_VAT_AMT);//V_VAT_AMT
					cs.setString(20, V_VAT_TYPE);//V_VAT_TYPE
					cs.setString(21, V_VAT_RATE);//V_VAT_RATE
					cs.setString(22, V_M_BP_CD);//V_M_BP_CD
					cs.setString(23, V_TAX_BP_CD);//V_TAX_BP_CD
					cs.setString(24, V_M_PS_NUM);//V_M_PS_NUM
					cs.setString(25, V_BANK_CD);//V_BANK_CD
					cs.setString(26, V_BANK_ACCT);//V_BANK_ACCT
					cs.setString(27, V_PAY_TYPE);//V_PAY_TYPE
					cs.setString(28, V_PAY_AMT);//V_PAY_AMT
					cs.setString(29, V_PAY_DUE_DT);//V_PAY_DUE_DT
					cs.setString(30, V_TAX_BIZ_CD);//V_TAX_BIZ_CD
					cs.setString(31, V_COST_CD);//V_COST_CD
					cs.setString(32, V_NOTE_NO);//V_NOTE_NO
					cs.setString(33, V_EXP_ITEM_FLG);//V_EXP_ITEM_FLG
					cs.setString(34, V_TEMP_GL_NO);//V_TEMP_GL_NO
					cs.setString(35, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(36, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(36);
					String res = "";

					while (rs.next()) {
						res = rs.getString("res");
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(res);
					pw.flush();
					pw.close();
				}

			}
		} else if (V_TYPE.equals("SYNC2")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_MAST_CHARGE_NO = hashMap.get("MAST_CHARGE_NO") == null ? "" : hashMap.get("MAST_CHARGE_NO").toString();
					V_CHARGE_NO = hashMap.get("CHARGE_NO") == null ? "" : hashMap.get("CHARGE_NO").toString();
					String V_BAS_DOC_NO = "";
					if (V_PR_STEP.equals("VL")) {
						V_BAS_DOC_NO = hashMap.get("LC_DOC_NO") == null ? "" : hashMap.get("LC_DOC_NO").toString();
					}
					if (V_PR_STEP.equals("VB")) {
						V_BAS_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
					}
					if (V_PR_STEP.equals("VC")) {
						V_BAS_DOC_NO = hashMap.get("ID_NO") == null ? "" : hashMap.get("ID_NO").toString();
					}

					String V_EXP_ITEM_FLG = hashMap.get("EXP_ITEM_FLG") == null ? "" : hashMap.get("EXP_ITEM_FLG").toString();

					if (V_EXP_ITEM_FLG.equals("true") || V_EXP_ITEM_FLG.equals("Y")) {

						cs2 = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_1(?,?,?,?,?,?,?)");
						cs2.setString(1, V_COMP_ID);//V_COMP_ID
						cs2.setString(2, V_MAST_CHARGE_NO);//V_MAST_CHARGE_NO
						cs2.setString(3, V_CHARGE_NO);//V_CHARGE_NO
						cs2.setString(4, V_PR_STEP);//V_PR_STEP
						cs2.setString(5, V_USR_ID);//V_USR_ID
						cs2.setString(6, V_BAS_NO);//V_BAS_NO
						cs2.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
						cs2.executeQuery();
					}

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_MAST_CHARGE_NO = jsondata.get("MAST_CHARGE_NO") == null ? "" : jsondata.get("MAST_CHARGE_NO").toString();
				V_CHARGE_NO = jsondata.get("CHARGE_NO") == null ? "" : jsondata.get("CHARGE_NO").toString();
				String V_BAS_DOC_NO = "";
				if (V_PR_STEP.equals("VL")) {
					V_BAS_DOC_NO = jsondata.get("LC_DOC_NO") == null ? "" : jsondata.get("LC_DOC_NO").toString();
				}
				if (V_PR_STEP.equals("VB")) {
					V_BAS_DOC_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
				}
				if (V_PR_STEP.equals("VC")) {
					V_BAS_DOC_NO = jsondata.get("ID_NO") == null ? "" : jsondata.get("ID_NO").toString();
				}

				String V_EXP_ITEM_FLG = jsondata.get("EXP_ITEM_FLG") == null ? "" : jsondata.get("EXP_ITEM_FLG").toString();

				if (V_EXP_ITEM_FLG.equals("true") || V_EXP_ITEM_FLG.equals("Y")) {

					cs2 = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_1(?,?,?,?,?,?,?)");
					cs2.setString(1, V_COMP_ID);//V_COMP_ID
					cs2.setString(2, V_MAST_CHARGE_NO);//V_MAST_CHARGE_NO
					cs2.setString(3, V_CHARGE_NO);//V_CHARGE_NO
					cs2.setString(4, V_PR_STEP);//V_PR_STEP
					cs2.setString(5, V_USR_ID);//V_USR_ID
					cs2.setString(6, V_BAS_NO);//V_BAS_NO
					cs2.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
					cs2.executeQuery();
				}
			}
		}

		else if (V_TYPE.equals("ERP")) {

			String V_MAST_CHARGE_NO = request.getParameter("V_MAST_CHARGE_NO") == null ? "" : request.getParameter("V_MAST_CHARGE_NO").toUpperCase();
			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE").toUpperCase();
			V_PR_STEP = request.getParameter("V_PR_STEP") == null ? "" : request.getParameter("V_PR_STEP").toUpperCase();
			String flag = ""; //통합전표 1회 수행여부
			String V_TEMP_GL_NO = "";

			System.out.println("V_MAST_CHARGE_NO " + V_MAST_CHARGE_NO);
			System.out.println("U_TYPE " + U_TYPE);
			System.out.println("V_PR_STEP " + V_PR_STEP);

			JSONObject anyObject = new JSONObject();
			JSONArray anyArray = new JSONArray();

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				String V_SP_ID = "";
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					String V_CHARGE_CD = hashMap.get("CHARGE_CD") == null ? "" : hashMap.get("CHARGE_CD").toString();
					V_CHARGE_NO = hashMap.get("CHARGE_NO") == null ? "" : hashMap.get("CHARGE_NO").toString();
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString();

					/*SP ID는 최초 1회 생성*/
					if (V_TYPE.equals("I")) {
						if (i == 0) {
							V_SP_ID = System.currentTimeMillis() + "";
							System.out.println("V_SP_ID" + V_SP_ID);
						}

						cs = conn.prepareCall("call DISTR_TEMP_GL_CG.USP_TEMP_M_CHARGE_NO(?,?)");
						cs.setString(1, V_SP_ID);//V_COMP_ID	
						cs.setString(2, V_CHARGE_NO);//V_CHARGE_NO
						cs.executeQuery();

						/*제일 마지막 한번*/
						if (i == jsonAr.size() - 1) {
							cs = conn.prepareCall("call DISTR_TEMP_GL_CG.USP_A_TEMP_CH_FR(?,?,?,?,?,?,?,?)");
							cs.setString(1, V_COMP_ID);//V_COMP_ID
							cs.setString(2, V_TYPE);//V_MAST_CHARGE_NO
							cs.setString(3, V_SP_ID);//V_CHARGE_NO
							cs.setString(4, V_MAST_CHARGE_NO);//V_PR_STEP
							cs.setString(5, V_USR_ID);//V_USR_ID
							cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
							cs.setString(7, V_CHARGE_CD);//V_CHARGE_CD
							cs.setString(8, V_TEMP_GL_NO);//V_CHARGE_CD
							cs.executeQuery();

							rs = (ResultSet) cs.getObject(6);
							if (rs.next()) {
								V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
							}
						}

						JSONObject anySubObject = new JSONObject();
						anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
						anySubObject.put("V_USR_ID", V_USR_ID);
						anySubObject.put("V_DB_ID", "sa");
						anySubObject.put("V_DB_PW", "hsnadmin");

						anyArray.add(anySubObject);
					} else if (V_TYPE.equals("D")) {

						cs = conn.prepareCall("call DISTR_TEMP_GL_CG.USP_A_TEMP_CH_FR(?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_MAST_CHARGE_NO
						cs.setString(3, V_SP_ID);//V_CHARGE_NO
						cs.setString(4, V_MAST_CHARGE_NO);//V_PR_STEP
						cs.setString(5, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(7, V_CHARGE_CD);//V_CHARGE_CD
						cs.setString(8, V_TEMP_GL_NO);//V_CHARGE_CD
						cs.executeQuery();

						JSONObject anySubObject = new JSONObject();
						anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
						anySubObject.put("V_USR_ID", V_USR_ID);
						anySubObject.put("V_DB_ID", "sa");
						anySubObject.put("V_DB_PW", "hsnadmin");

						anyArray.add(anySubObject);
					}

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				String V_CHARGE_CD = jsondata.get("CHARGE_CD") == null ? "" : jsondata.get("CHARGE_CD").toString();
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_CHARGE_NO = jsondata.get("CHARGE_NO") == null ? "" : jsondata.get("CHARGE_NO").toString();
				V_TEMP_GL_NO = jsondata.get("TEMP_GL_NO") == null ? "" : jsondata.get("TEMP_GL_NO").toString();

				String V_SP_ID = System.currentTimeMillis() + "";

				if (V_TYPE.equals("I")) {
					cs = conn.prepareCall("call DISTR_TEMP_GL_CG.USP_TEMP_M_CHARGE_NO(?,?)");
					cs.setString(1, V_SP_ID);//V_COMP_ID	
					cs.setString(2, V_CHARGE_NO);//V_CHARGE_NO
					cs.executeQuery();

					cs = conn.prepareCall("call DISTR_TEMP_GL_CG.USP_A_TEMP_CH_FR(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_MAST_CHARGE_NO
					cs.setString(3, V_SP_ID);//V_CHARGE_NO
					cs.setString(4, V_MAST_CHARGE_NO);//V_PR_STEP
					cs.setString(5, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(7, V_CHARGE_CD);//V_CHARGE_CD
					cs.setString(8, V_TEMP_GL_NO);//V_CHARGE_CD
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(6);
					if (rs.next()) {
						V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
					}

					JSONObject anySubObject = new JSONObject();
					anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anySubObject.put("V_DB_ID", "sa");
					anySubObject.put("V_DB_PW", "hsnadmin");

					anyArray.add(anySubObject);
				} else if (V_TYPE.equals("D")) {
					cs = conn.prepareCall("call DISTR_TEMP_GL_CG.USP_A_TEMP_CH_FR(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_MAST_CHARGE_NO
					cs.setString(3, V_SP_ID);//V_CHARGE_NO
					cs.setString(4, V_MAST_CHARGE_NO);//V_PR_STEP
					cs.setString(5, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(7, V_CHARGE_CD);//V_CHARGE_CD
					cs.setString(8, V_TEMP_GL_NO);//V_CHARGE_CD
					cs.executeQuery();

					JSONObject anySubObject = new JSONObject();
					anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anySubObject.put("V_DB_ID", "sa");
					anySubObject.put("V_DB_PW", "hsnadmin");

					anyArray.add(anySubObject);
				}

			}

			System.out.println("V_TEMP_GL_NO : " + V_TEMP_GL_NO);
			/*애니링크 시작*/
			if (!V_TEMP_GL_NO.equals("")) {
				URL url = null;

				if (U_TYPE.equals("I")) { //확정
					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert");
				} else if (U_TYPE.equals("D")) { //확정취소
					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel");
				}

				URLConnection con = url.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

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

// 				System.out.println("parameter" + parameter);
				System.out.println("result" + result);

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


