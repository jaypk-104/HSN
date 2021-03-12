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

		if (V_TYPE.equals("HS")) {
			String V_DT_FR = request.getParameter("V_DT_FR") == null ? "" : request.getParameter("V_DT_FR").toUpperCase();
			String V_DT_TO = request.getParameter("V_DT_TO") == null ? "" : request.getParameter("V_DT_TO").toUpperCase();
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();

			if (V_DT_FR.length() > 10) {
				V_DT_FR = V_DT_FR.substring(0, 10);
			}
			if (V_DT_TO.length() > 10) {
				V_DT_TO = V_DT_TO.substring(0, 10);
			}

			cs = conn.prepareCall("call USP_002_M_B_CON_HDR_DISTR(?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//
			cs.setString(2, V_TYPE);//
			cs.setString(3, V_DT_FR);//
			cs.setString(4, V_DT_TO);//
			cs.setString(5, V_M_BP_NM);//
			cs.setString(6, V_BL_DOC_NO);//
			cs.setString(7, V_USR_ID);//
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("KG_QTY", rs.getString("KG_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				// 				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				// 				subObject.put("DISTR_EX_AMT", rs.getString("DISTR_EX_AMT"));
				// 				subObject.put("IV_EX_AMT", rs.getString("IV_EX_AMT"));
				// 				subObject.put("MIN_S_PRC", rs.getString("MIN_S_PRC"));
				// 				subObject.put("MIN_S_AMT", rs.getString("MIN_S_AMT"));
				// 				subObject.put("S_RATE", rs.getString("S_RATE"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("FORWARD_XCH_RATE", rs.getString("FORWARD_XCH_RATE"));

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

		} else if (V_TYPE.equals("DS")) {
			String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
			String V_BL_SEQ = request.getParameter("V_BL_SEQ") == null ? "" : request.getParameter("V_BL_SEQ").toUpperCase();

			cs = conn.prepareCall("call USP_002_M_B_CON_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_NO);//V_BL_NO
			cs.setString(4, V_BL_SEQ);//V_BL_SEQ
			cs.setString(5, "");//V_SEQ
			cs.setString(6, "");//V_S_BP_CD
			cs.setString(7, "");//V_ITEM_CD
			cs.setString(8, "");//V_BOX_QTY
			cs.setString(9, "");//V_KG_QTY
			cs.setString(10, "");//V_S_CON_PRC
			cs.setString(11, "");//V_S_CON_AMT
			cs.setString(12, "");//V_BF_IN_AMT
			cs.setString(13, "");//V_CON_YN
			cs.setString(14, "");//V_SALE_DEADLINE
			cs.setString(15, "");//
			cs.setString(16, "");//
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, "");//
			cs.setString(20, "");//
			cs.setString(21, "");//
			cs.setString(22, "");//SALE_OPTION_TYPE
			cs.setString(23, "");//V_PO_TYPE
			cs.setString(24, "");//V_BC_NO

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("S_SEQ", rs.getString("S_SEQ"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("KG_QTY", rs.getString("KG_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("S_CON_PRC", rs.getString("S_CON_PRC"));
				subObject.put("S_CON_AMT", rs.getString("S_CON_AMT"));
				subObject.put("BF_IN_AMT", rs.getString("BF_IN_AMT"));
				subObject.put("SALE_DEADLINE", rs.getString("SALE_DEADLINE"));
				subObject.put("CON_YN", rs.getString("CON_YN"));
				subObject.put("FILE_NM", rs.getString("FILE_NM"));
				subObject.put("FILE_NM_PC", rs.getString("FILE_NM_PC"));
				subObject.put("BF_IN_AMT_YN", rs.getString("BF_IN_AMT_YN"));
				subObject.put("SALE_DEADLINE_DT", rs.getString("SALE_DEADLINE_DT"));
				subObject.put("EX_CON_PRC", rs.getString("EX_CON_PRC"));
				subObject.put("EX_CON_AMT", rs.getString("EX_CON_AMT"));
				subObject.put("CONTRACT_DT", rs.getString("CONTRACT_DT"));
				subObject.put("SALE_OPTION_TYPE_CD", rs.getString("SALE_OPTION_TYPE_CD"));
				subObject.put("SALE_OPTION_TYPE_NM", rs.getString("SALE_OPTION_TYPE_NM"));
				subObject.put("BC_NO", rs.getString("BC_NO"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("CLS_AR_NO", rs.getString("CLS_AR_NO"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("LOAD")) {
			String V_LOAD_BL_DOC_NO = request.getParameter("V_LOAD_BL_DOC_NO") == null ? "" : request.getParameter("V_LOAD_BL_DOC_NO").toUpperCase();

			cs = conn.prepareCall("call USP_002_M_BAND_S_PRC_DISTR(?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_LOAD_BL_DOC_NO);//
			cs.setString(3, V_USR_ID);//
			cs.executeQuery();
		}

		else if (V_TYPE.equals("SYNC")) {
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
					String BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
					String S_SEQ = hashMap.get("S_SEQ") == null ? "" : hashMap.get("S_SEQ").toString();
					String ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
					String KG_QTY = hashMap.get("KG_QTY") == null ? "" : hashMap.get("KG_QTY").toString();
					String S_CON_PRC = hashMap.get("S_CON_PRC") == null ? "" : hashMap.get("S_CON_PRC").toString();
					String S_CON_AMT = hashMap.get("S_CON_AMT") == null ? "" : hashMap.get("S_CON_AMT").toString();
					String BF_IN_AMT = hashMap.get("BF_IN_AMT") == null ? "" : hashMap.get("BF_IN_AMT").toString();
					String SALE_DEADLINE = hashMap.get("SALE_DEADLINE") == null ? "" : hashMap.get("SALE_DEADLINE").toString();
					String CON_YN = hashMap.get("CON_YN") == null ? "" : hashMap.get("CON_YN").toString();
					String FILE_NM = hashMap.get("FILE_NM") == null ? "" : hashMap.get("FILE_NM").toString();
					String FILE_NM_PC = hashMap.get("FILE_NM_PC") == null ? "" : hashMap.get("FILE_NM_PC").toString();
					String BF_IN_AMT_YN = hashMap.get("BF_IN_AMT_YN") == null ? "" : hashMap.get("BF_IN_AMT_YN").toString();
					String SALE_DEADLINE_DT = hashMap.get("SALE_DEADLINE_DT") == null ? "" : hashMap.get("SALE_DEADLINE_DT").toString();
					String CONTRACT_DT = hashMap.get("CONTRACT_DT") == null ? "" : hashMap.get("CONTRACT_DT").toString();
					String SALE_OPTION_TYPE_CD = hashMap.get("SALE_OPTION_TYPE_CD") == null ? "" : hashMap.get("SALE_OPTION_TYPE_CD").toString();
					String PO_TYPE = hashMap.get("PO_TYPE") == null ? "" : hashMap.get("PO_TYPE").toString();
					String BC_NO = hashMap.get("BC_NO") == null ? "" : hashMap.get("BC_NO").toString();
					String CLS_AR_NO = hashMap.get("CLS_AR_NO") == null ? "" : hashMap.get("CLS_AR_NO").toString();
					String REMAIN_AMT = hashMap.get("REMAIN_AMT") == null ? "" : hashMap.get("REMAIN_AMT").toString();

					if (BF_IN_AMT_YN.equals("true")) {
						BF_IN_AMT_YN = "Y";
					} else {
						BF_IN_AMT_YN = "N";
					}

					if (SALE_DEADLINE_DT.length() >= 10) {
						SALE_DEADLINE_DT = SALE_DEADLINE_DT.substring(0, 10);
					}
					if (CONTRACT_DT.length() >= 10) {
						CONTRACT_DT = CONTRACT_DT.substring(0, 10);
					}

					cs = conn.prepareCall("call USP_002_M_B_CON_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, BL_NO);//V_BL_NO
					cs.setString(4, BL_SEQ);//BL_SEQ
					cs.setString(5, S_SEQ);//V_SEQ
					cs.setString(6, S_BP_CD);//V_S_BP_CD
					cs.setString(7, ITEM_CD);//V_ITEM_CD
					cs.setString(8, BOX_QTY);//V_BOX_QTY
					cs.setString(9, KG_QTY);//V_KG_QTY
					cs.setString(10, S_CON_PRC);//V_S_CON_PRC
					cs.setString(11, S_CON_AMT);//V_S_CON_AMT
					cs.setString(12, BF_IN_AMT);//V_BF_IN_AMT
					cs.setString(13, CON_YN);//V_CON_YN
					cs.setString(14, SALE_DEADLINE);//SALE_DEADLINE
					cs.setString(15, FILE_NM);//
					cs.setString(16, FILE_NM_PC);//
					cs.setString(17, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(19, BF_IN_AMT_YN);//BF_IN_AMT_YN
					cs.setString(20, SALE_DEADLINE_DT);//
					cs.setString(21, CONTRACT_DT);//CONTRACT_DT
					cs.setString(22, SALE_OPTION_TYPE_CD);//SALE_OPTION_TYPE_CD
					cs.setString(23, PO_TYPE);//PO_TYPE
					cs.setString(24, BC_NO);//V_BC_NO
					cs.executeQuery();
					
					if(!BC_NO.equals("") && (!REMAIN_AMT.equals("") || !CLS_AR_NO.equals(""))){
						String AR_NO = BL_NO + "-" + BL_SEQ;
						String A_TYPE = "WD_BAND";
						if (V_TYPE.equals("D")){
							A_TYPE = "D";
						}
						
						cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, A_TYPE);//V_TYPE
						cs.setString(3, CLS_AR_NO);//V_CLS_AR_NO
						cs.setString(4, BC_NO);//V_BC_NO
						cs.setString(5, "F");//V_BC_TYPE
						cs.setString(6, AR_NO);//V_AR_NO
						cs.setString(7, "");//V_CLS_DT
						cs.setString(8, "");//V_CUR
						cs.setString(9, BF_IN_AMT);//V_CLS_IN_AMT
						cs.setString(10, "");//V_CLS_OUT_AMT
						cs.setString(11, REMAIN_AMT);//V_BAL_IN_AMT
						cs.setString(12, "");//V_BAL_OUT_AMT
						cs.setString(13, V_USR_ID);//V_USR_ID
						cs.setString(14, S_SEQ);//V_SEQ
						cs.executeQuery();
					}

				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
				String S_SEQ = jsondata.get("S_SEQ") == null ? "" : jsondata.get("S_SEQ").toString();
				String ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
				String KG_QTY = jsondata.get("KG_QTY") == null ? "" : jsondata.get("KG_QTY").toString();
				String S_CON_PRC = jsondata.get("S_CON_PRC") == null ? "" : jsondata.get("S_CON_PRC").toString();
				String S_CON_AMT = jsondata.get("S_CON_AMT") == null ? "" : jsondata.get("S_CON_AMT").toString();
				String BF_IN_AMT = jsondata.get("BF_IN_AMT") == null ? "" : jsondata.get("BF_IN_AMT").toString();
				String SALE_DEADLINE = jsondata.get("SALE_DEADLINE") == null ? "" : jsondata.get("SALE_DEADLINE").toString();
				String CON_YN = jsondata.get("CON_YN") == null ? "" : jsondata.get("CON_YN").toString();
				String FILE_NM = jsondata.get("FILE_NM") == null ? "" : jsondata.get("FILE_NM").toString();
				String FILE_NM_PC = jsondata.get("FILE_NM_PC") == null ? "" : jsondata.get("FILE_NM_PC").toString();
				String BF_IN_AMT_YN = jsondata.get("BF_IN_AMT_YN") == null ? "" : jsondata.get("BF_IN_AMT_YN").toString();
				String SALE_DEADLINE_DT = jsondata.get("SALE_DEADLINE_DT") == null ? "" : jsondata.get("SALE_DEADLINE_DT").toString();
				String CONTRACT_DT = jsondata.get("CONTRACT_DT") == null ? "" : jsondata.get("CONTRACT_DT").toString();
				String SALE_OPTION_TYPE_CD = jsondata.get("SALE_OPTION_TYPE_CD") == null ? "" : jsondata.get("SALE_OPTION_TYPE_CD").toString();
				String PO_TYPE = jsondata.get("PO_TYPE") == null ? "" : jsondata.get("PO_TYPE").toString();
				String BC_NO = jsondata.get("BC_NO") == null ? "" : jsondata.get("BC_NO").toString();
				String CLS_AR_NO = jsondata.get("CLS_AR_NO") == null ? "" : jsondata.get("CLS_AR_NO").toString();
				String REMAIN_AMT = jsondata.get("REMAIN_AMT") == null ? "" : jsondata.get("REMAIN_AMT").toString();

				if (BF_IN_AMT_YN.equals("true")) {
					BF_IN_AMT_YN = "Y";
				} else {
					BF_IN_AMT_YN = "N";
				}

				if (SALE_DEADLINE_DT.length() >= 10) {
					SALE_DEADLINE_DT = SALE_DEADLINE_DT.substring(0, 10);
				}
				if (CONTRACT_DT.length() >= 10) {
					CONTRACT_DT = CONTRACT_DT.substring(0, 10);
				}

				cs = conn.prepareCall("call USP_002_M_B_CON_DTL_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, BL_NO);//V_BL_NO
				cs.setString(4, BL_SEQ);//BL_SEQ
				cs.setString(5, S_SEQ);//V_SEQ
				cs.setString(6, S_BP_CD);//V_S_BP_CD
				cs.setString(7, ITEM_CD);//V_ITEM_CD
				cs.setString(8, BOX_QTY);//V_BOX_QTY
				cs.setString(9, KG_QTY);//V_KG_QTY
				cs.setString(10, S_CON_PRC);//V_S_CON_PRC
				cs.setString(11, S_CON_AMT);//V_S_CON_AMT
				cs.setString(12, BF_IN_AMT);//V_BF_IN_AMT
				cs.setString(13, CON_YN);//V_CON_YN
				cs.setString(14, SALE_DEADLINE);//SALE_DEADLINE
				cs.setString(15, FILE_NM);//
				cs.setString(16, FILE_NM_PC);//
				cs.setString(17, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(19, BF_IN_AMT_YN);//BF_IN_AMT_YN
				cs.setString(20, SALE_DEADLINE_DT);//SALE_DEADLINE_DT
				cs.setString(21, CONTRACT_DT);//CONTRACT_DT
				cs.setString(22, SALE_OPTION_TYPE_CD);//SALE_OPTION_TYPE_CD
				cs.setString(23, PO_TYPE);//PO_TYPE
				cs.setString(24, BC_NO);//V_BC_NO
				cs.executeQuery();
				
				if(!BC_NO.equals("") && (!REMAIN_AMT.equals("") || !CLS_AR_NO.equals(""))){
					String AR_NO = BL_NO + "-" + BL_SEQ;
					String A_TYPE = "WD_BAND";
					if (V_TYPE.equals("D")){
						A_TYPE = "D";
					}
					
					cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, A_TYPE);//V_TYPE
					cs.setString(3, CLS_AR_NO);//V_CLS_AR_NO
					cs.setString(4, BC_NO);//V_BC_NO
					cs.setString(5, "F");//V_BC_TYPE
					cs.setString(6, AR_NO);//V_AR_NO
					cs.setString(7, "");//V_CLS_DT
					cs.setString(8, "");//V_CUR
					cs.setString(9, BF_IN_AMT);//V_CLS_IN_AMT
					cs.setString(10, "");//V_CLS_OUT_AMT
					cs.setString(11, REMAIN_AMT);//V_BAL_IN_AMT
					cs.setString(12, "");//V_BAL_OUT_AMT
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.setString(14, S_SEQ);//V_SEQ
					cs.executeQuery();
				}
			}
			
		} else if (V_TYPE.equals("BC")) {
			String V_DT_FR = request.getParameter("V_DT_FR") == null ? "" : request.getParameter("V_DT_FR").toUpperCase().substring(0, 10);
			String V_DT_TO = request.getParameter("V_DT_TO") == null ? "" : request.getParameter("V_DT_TO").toUpperCase().substring(0, 10);
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
			
			cs = conn.prepareCall("call USP_A_DEPOSIT_STAT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "S");//V_TYPE
			cs.setString(3, V_DT_FR);//V_DT_FR
			cs.setString(4, V_DT_TO);//V_DT_TO
			cs.setString(5, "5124");//V_DEPT_CD
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(7, V_S_BP_NM);//V_BP_CD
			cs.setString(8, "");//V_REMARK
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BC_NO", rs.getString("BC_NO"));
				subObject.put("BANK_DT", rs.getString("BANK_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("IN_AMT", rs.getString("IN_AMT"));
				subObject.put("IN_LOC_AMT", rs.getString("IN_LOC_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BANK_ACCT_NO", rs.getString("BANK_ACCT_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("TEMP_GL_YN", rs.getString("TEMP_GL_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("ERP")) {
			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE").toUpperCase();
			String V_CLS_AR_NO = request.getParameter("V_CLS_AR_NO") == null ? "" : request.getParameter("V_CLS_AR_NO").toUpperCase();

			cs = conn.prepareCall("call USP_002_A_TEMP_AR_HSPF(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, U_TYPE);//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			String V_TEMP_GL_NO = "";
			if (rs.next()) {
				V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
			}

// 			if (V_TEMP_GL_NO.contains("TG")) {
// 				/*애니링크 시작*/
// 				JSONObject anyObject = new JSONObject();
// 				JSONArray anyArray = new JSONArray();
// 				JSONObject anySubObject = new JSONObject();

// 				URL url = null;
				
// 				if(V_TYPE.equals("I")) { //확정
// 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert"); 
// 				} else if(V_TYPE.equals("D")) { //확정취소
// 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel"); 
// 				}
				
// 				URLConnection con = url.openConnection();
// 				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
// 				con.setDoOutput(true);

// 				anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
// 				anySubObject.put("V_USR_ID", V_USR_ID);
// 				anySubObject.put("V_DB_ID", "sa");
// 				anySubObject.put("V_DB_PW", "hsnadmin");

// 				anyArray.add(anySubObject);
// 				anyObject.put("data", anyArray);
// 				String parameter = anyObject + "";

// 				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
// 				wr.write(parameter);
// 				wr.flush();

// 				BufferedReader rd = null;

// 				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
// 				String line = null;
// 				String result = null;
// 				while ((line = rd.readLine()) != null) {
// 					result = URLDecoder.decode(line, "UTF-8");
// 				}
				
// 				response.setContentType("text/plain; charset=UTF-8");
// 				PrintWriter pw = response.getWriter();
// 				pw.print(result);
// 				pw.flush();
// 				pw.close();
// 			}
		}

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

		e.printStackTrace();
	} finally {
		// 		System.out.println(cs);
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


