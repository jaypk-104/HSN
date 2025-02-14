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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_TYPE2 = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_TAB_TYPE = request.getParameter("V_TAB_TYPE") == null ? "" : request.getParameter("V_TAB_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_RISK_NO = request.getParameter("V_RISK_NO") == null ? "" : request.getParameter("V_RISK_NO").toUpperCase();
		String V_APPROV_MGM_NO = request.getParameter("V_APPROV_MGM_NO") == null ? "" : request.getParameter("V_APPROV_MGM_NO").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_APPROV_NM = request.getParameter("V_APPROV_NM") == null ? "" : request.getParameter("V_APPROV_NM").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_APPROV_DT_FR = request.getParameter("V_APPROV_DT_FR") == null ? "" : request.getParameter("V_APPROV_DT_FR").toUpperCase().substring(0, 10);
		String V_APPROV_DT_TO = request.getParameter("V_APPROV_DT_TO") == null ? "" : request.getParameter("V_APPROV_DT_TO").toUpperCase().substring(0, 10);

		// 		System.out.println(V_TAB_TYPE);
		// 		System.out.println(V_TYPE);
		// 		System.out.println(V_APPROV_MGM_NO);

		if (V_TAB_TYPE.equals("T2")) {
			if (V_TYPE.equals("SH")) {

				cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_QUERY(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_TYPE
				cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
				cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(5, V_APPROV_NM);//V_APPROV_MGM_NO
				cs.setString(6, V_APPROV_NO);//V_APPROV_MGM_NO
				cs.setString(7, V_S_BP_NM);//V_APPROV_MGM_NO
				cs.setString(8, V_APPROV_DT_FR);//V_APPROV_MGM_NO
				cs.setString(9, V_APPROV_DT_TO);//V_APPROV_MGM_NO
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(4);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("BF_TYPE_NM", rs.getString("BF_TYPE_NM"));
					subObject.put("BRAND", rs.getString("BRAND"));
					subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
					subObject.put("SM_NM", rs.getString("SM_NM"));
					subObject.put("PO_QTY", rs.getString("PO_QTY"));
					subObject.put("MUL_AMT", rs.getString("MUL_AMT"));
					subObject.put("BU_AMT", rs.getString("BU_AMT"));
					subObject.put("WON", rs.getString("WON"));
					subObject.put("SALE_AMT", rs.getString("SALE_AMT"));
					subObject.put("S_RATE", rs.getString("S_RATE"));
					subObject.put("S_RATE_AMT", rs.getString("S_RATE_AMT"));
					subObject.put("KYUNG_RT", rs.getString("KYUNG_RT"));
					subObject.put("KYUNG_RT_AMT", rs.getString("KYUNG_RT_AMT"));
					subObject.put("PAY_METH", rs.getString("PAY_METH"));
					subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
					subObject.put("SL_LOC_NM", rs.getString("SL_LOC_NM"));
					subObject.put("REMARK", rs.getString("REMARK"));
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

			} else if (V_TYPE.equals("SP")) {

				cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_QUERY(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_TYPE
				cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
				cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(5, V_APPROV_NM);//V_APPROV_MGM_NO
				cs.setString(6, V_APPROV_NO);//V_APPROV_MGM_NO
				cs.setString(7, V_S_BP_NM);//V_APPROV_MGM_NO
				cs.setString(8, V_APPROV_DT_FR);//V_APPROV_MGM_NO
				cs.setString(9, V_APPROV_DT_TO);//V_APPROV_MGM_NO
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(4);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
					subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
					subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
					subObject.put("APPROV_SEQ", rs.getString("APPROV_SEQ"));
					subObject.put("APPROV_DT", rs.getString("APPROV_DT"));
					subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
					subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
					subObject.put("COMP_TYPE", rs.getString("COMP_TYPE"));
					subObject.put("COMP_TYPE_NM", rs.getString("COMP_TYPE_NM"));
					subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
					subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
					subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
					subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
					subObject.put("REGION", rs.getString("REGION"));
					subObject.put("REGION_NM", rs.getString("REGION_NM"));
					subObject.put("RISK_REF_NO", rs.getString("RISK_REF_NO"));
					subObject.put("PO_AMT", rs.getString("PO_AMT"));
					subObject.put("USR_NM", rs.getString("USR_NM"));
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

				//품의등록 - 헤더 등록
			} else if (V_TYPE.equals("HI") || V_TYPE.equals("D")) {
				String V_RISK_REF_NO = request.getParameter("V_RISK_REF_NO") == null ? "" : request.getParameter("V_RISK_REF_NO").toUpperCase();
				V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
				V_APPROV_NM = request.getParameter("V_APPROV_NM") == null ? "" : request.getParameter("V_APPROV_NM").toUpperCase();
				String V_APPROV_SEQ = request.getParameter("V_APPROV_SEQ") == null ? "" : request.getParameter("V_APPROV_SEQ").toString();
				String V_APPROV_DT = request.getParameter("V_APPROV_DT") == null ? "" : request.getParameter("V_APPROV_DT").toUpperCase().substring(0, 10);
				String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
				String V_COMP_TYPE = request.getParameter("V_COMP_TYPE") == null ? "" : request.getParameter("V_COMP_TYPE").toUpperCase();
				String V_SALE_TYPE = request.getParameter("V_SALE_TYPE") == null ? "" : request.getParameter("V_SALE_TYPE").toUpperCase();
				String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
				String V_REGION = request.getParameter("V_REGION") == null ? "" : request.getParameter("V_REGION").toUpperCase();
				String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toUpperCase();
				String V_ETC1_IV_TEXT = request.getParameter("V_ETC1_IV_TEXT") == null ? "" : request.getParameter("V_ETC1_IV_TEXT").toUpperCase();
				String V_ETC1_SL_TEXT = request.getParameter("V_ETC1_SL_TEXT") == null ? "" : request.getParameter("V_ETC1_SL_TEXT").toUpperCase();
				String V_ETC2_IV_TEXT = request.getParameter("V_ETC2_IV_TEXT") == null ? "" : request.getParameter("V_ETC2_IV_TEXT").toUpperCase();
				String V_ETC2_SL_TEXT = request.getParameter("V_ETC2_SL_TEXT") == null ? "" : request.getParameter("V_ETC2_SL_TEXT").toUpperCase();

				cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
				cs.setString(4, V_APPROV_NO);//V_APPROV_NO
				cs.setString(5, V_APPROV_NM);//V_APPROV_NM
				cs.setString(6, V_APPROV_SEQ);//V_APPROV_SEQ
				cs.setString(7, V_APPROV_DT);//V_APPROV_DT
				cs.setString(8, V_RISK_REF_NO);//V_RISK_REF_NO
				cs.setString(9, V_S_BP_CD);//V_S_BP_CD
				cs.setString(10, V_COMP_TYPE);//V_COMP_TYPE
				cs.setString(11, V_SALE_TYPE);//V_SALE_TYPE
				cs.setString(12, V_IV_TYPE);//V_IV_TYPE
				cs.setString(13, V_REGION);//V_REGION
				cs.setString(14, V_ETC1_IV_TEXT);//V_ETC1_IV_TEXT
				cs.setString(15, V_ETC1_SL_TEXT);//V_ETC1_SL_TEXT
				cs.setString(16, V_ETC2_IV_TEXT);//V_ETC2_IV_TEXT
				cs.setString(17, V_ETC2_SL_TEXT);//V_ETC2_SL_TEXT
				cs.setString(18, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				String res = "";
				if (V_TYPE.equals("HI")) {
					rs = (ResultSet) cs.getObject(19);
					while (rs.next()) {
						res = rs.getString("res");
					}
				} else {
					res = "success";
				}

				// 				System.out.println(res);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(res);
				pw.flush();
				pw.close();

				//상단싱크
			} else if (V_TYPE.equals("SYNC")) {
				request.setCharacterEncoding("utf-8");
				String[] findList = { "#", "+", "&", "%", " " };
				String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

				String data = request.getParameter("data");
				data = StringUtils.replaceEach(data, findList, replList);
				String jsonData = URLDecoder.decode(data, "UTF-8");

				// 				System.out.println(jsonData);

				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						String V_APPROV_MGM_SEQ = hashMap.get("APPROV_MGM_SEQ") == null ? "" : hashMap.get("APPROV_MGM_SEQ").toString();
						String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
						String V_BF_TYPE = hashMap.get("BF_TYPE") == null ? "" : hashMap.get("BF_TYPE").toString();
						String V_ST_TYPE = hashMap.get("ST_TYPE") == null ? "" : hashMap.get("ST_TYPE").toString();
						String V_ORIGIN = hashMap.get("ORIGIN") == null ? "" : hashMap.get("ORIGIN").toString();
						String V_LG_TYPE = hashMap.get("LG_TYPE") == null ? "" : hashMap.get("LG_TYPE").toString();
						String V_SM_TYPE = hashMap.get("SM_TYPE") == null ? "" : hashMap.get("SM_TYPE").toString();
						String V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
						String V_GRADE = hashMap.get("GRADE") == null ? "" : hashMap.get("GRADE").toString();
						String V_BRAND = hashMap.get("BRAND") == null ? "" : hashMap.get("BRAND").toString();
						String V_CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
						String V_PO_QTY = hashMap.get("PO_QTY") == null ? "" : hashMap.get("PO_QTY").toString();
						String V_PO_PRC = hashMap.get("PO_PRC") == null ? "" : hashMap.get("PO_PRC").toString();
						String V_TAX_RT = hashMap.get("TAX_RT") == null ? "" : hashMap.get("TAX_RT").toString();
						String V_USANCE_TYPE = hashMap.get("USANCE_TYPE") == null ? "" : hashMap.get("USANCE_TYPE").toString();
						String V_USANCE_RT = hashMap.get("USANCE_RT") == null ? "" : hashMap.get("USANCE_RT").toString();
						String V_PAY_METH = hashMap.get("PAY_METH") == null ? "" : hashMap.get("PAY_METH").toString();
						String V_INSUR_RT = hashMap.get("INSUR_RT") == null ? "" : hashMap.get("INSUR_RT").toString();
						String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();

						cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
						cs.setString(4, V_APPROV_MGM_SEQ);//V_APPROV_MGM_SEQ
						cs.setString(5, V_M_BP_CD);//V_M_BP_CD
						cs.setString(6, V_BF_TYPE);//V_BF_TYPE
						cs.setString(7, V_ST_TYPE);//V_ST_TYPE
						cs.setString(8, V_LG_TYPE);//V_LG_TYPE
						cs.setString(9, V_SM_TYPE);//V_SM_TYPE
						cs.setString(10, V_GRADE);//V_GRADE
						cs.setString(11, V_ORIGIN);//V_ORIGIN
						cs.setString(12, V_BRAND);//V_BRAND
						cs.setString(13, V_ITEM_NM);//V_ITEM_NM
						cs.setString(14, V_CUR);//V_CUR
						cs.setString(15, V_PO_QTY);//V_PO_QTY
						cs.setString(16, V_PO_PRC);//V_PO_PRC
						cs.setString(17, V_TAX_RT);//V_TAX_RT
						cs.setString(18, V_USANCE_TYPE);//V_USANCE_TYPE
						cs.setString(19, V_USANCE_RT);//V_USANCE_RT
						cs.setString(20, V_PAY_METH);//V_PAY_METH
						cs.setString(21, V_REMARK);//V_REMARK
						cs.setString(22, V_INSUR_RT);//V_INSUR_RT
						cs.setString(23, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}
				} else {
					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					String V_APPROV_MGM_SEQ = jsondata.get("APPROV_MGM_SEQ") == null ? "" : jsondata.get("APPROV_MGM_SEQ").toString();
					String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
					String V_BF_TYPE = jsondata.get("BF_TYPE") == null ? "" : jsondata.get("BF_TYPE").toString();
					String V_ST_TYPE = jsondata.get("ST_TYPE") == null ? "" : jsondata.get("ST_TYPE").toString();
					String V_ORIGIN = jsondata.get("ORIGIN") == null ? "" : jsondata.get("ORIGIN").toString();
					String V_LG_TYPE = jsondata.get("LG_TYPE") == null ? "" : jsondata.get("LG_TYPE").toString();
					String V_SM_TYPE = jsondata.get("SM_TYPE") == null ? "" : jsondata.get("SM_TYPE").toString();
					String V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
					String V_GRADE = jsondata.get("GRADE") == null ? "" : jsondata.get("GRADE").toString();
					String V_BRAND = jsondata.get("BRAND") == null ? "" : jsondata.get("BRAND").toString();
					String V_CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
					String V_PO_QTY = jsondata.get("PO_QTY") == null ? "" : jsondata.get("PO_QTY").toString();
					String V_PO_PRC = jsondata.get("PO_PRC") == null ? "" : jsondata.get("PO_PRC").toString();
					String V_TAX_RT = jsondata.get("TAX_RT") == null ? "" : jsondata.get("TAX_RT").toString();
					String V_USANCE_TYPE = jsondata.get("USANCE_TYPE") == null ? "" : jsondata.get("USANCE_TYPE").toString();
					String V_USANCE_RT = jsondata.get("USANCE_RT") == null ? "" : jsondata.get("USANCE_RT").toString();
					String V_PAY_METH = jsondata.get("PAY_METH") == null ? "" : jsondata.get("PAY_METH").toString();
					String V_INSUR_RT = jsondata.get("INSUR_RT") == null ? "" : jsondata.get("INSUR_RT").toString();
					String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();

					cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
					cs.setString(4, V_APPROV_MGM_SEQ);//V_APPROV_MGM_SEQ
					cs.setString(5, V_M_BP_CD);//V_M_BP_CD
					cs.setString(6, V_BF_TYPE);//V_BF_TYPE
					cs.setString(7, V_ST_TYPE);//V_ST_TYPE
					cs.setString(8, V_LG_TYPE);//V_LG_TYPE
					cs.setString(9, V_SM_TYPE);//V_SM_TYPE
					cs.setString(10, V_GRADE);//V_GRADE
					cs.setString(11, V_ORIGIN);//V_ORIGIN
					cs.setString(12, V_BRAND);//V_BRAND
					cs.setString(13, V_ITEM_NM);//V_ITEM_NM
					cs.setString(14, V_CUR);//V_CUR
					cs.setString(15, V_PO_QTY);//V_PO_QTY
					cs.setString(16, V_PO_PRC);//V_PO_PRC
					cs.setString(17, V_TAX_RT);//V_TAX_RT
					cs.setString(18, V_USANCE_TYPE);//V_USANCE_TYPE
					cs.setString(19, V_USANCE_RT);//V_USANCE_RT
					cs.setString(20, V_PAY_METH);//V_PAY_METH
					cs.setString(21, V_REMARK);//V_REMARK
					cs.setString(22, V_INSUR_RT);//V_INSUR_RT
					cs.setString(23, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
				}
				//품의등록디테일조회
			} else if (V_TYPE.equals("SD1")) {

				cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
				cs.setString(4, "");//V_APPROV_MGM_SEQ
				cs.setString(5, "");//V_M_BP_CD
				cs.setString(6, "");//V_BF_TYPE
				cs.setString(7, "");//V_ST_TYPE
				cs.setString(8, "");//V_LG_TYPE
				cs.setString(9, "");//V_SM_TYPE
				cs.setString(10, "");//V_GRADE
				cs.setString(11, "");//V_ORIGIN
				cs.setString(12, "");//V_BRAND
				cs.setString(13, "");//V_ITEM_NM
				cs.setString(14, "");//V_CUR
				cs.setString(15, "");//V_PO_QTY
				cs.setString(16, "");//V_PO_PRC
				cs.setString(17, "");//V_TAX_RT
				cs.setString(18, "");//V_USANCE_TYPE
				cs.setString(19, "");//V_USANCE_RT
				cs.setString(20, "");//V_PAY_METH
				cs.setString(21, "");//V_REMARK
				cs.setString(22, "");//V_INSUR_RT
				cs.setString(23, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(24, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(24);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
					subObject.put("APPROV_MGM_SEQ", rs.getString("APPROV_MGM_SEQ"));
					subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
					subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
					subObject.put("BF_TYPE", rs.getString("BF_TYPE"));
					subObject.put("BF_TYPE_NM", rs.getString("BF_TYPE_NM"));
					subObject.put("ST_TYPE", rs.getString("ST_TYPE"));
					subObject.put("ST_TYPE_NM", rs.getString("ST_TYPE_NM"));
					subObject.put("LG_TYPE", rs.getString("LG_TYPE"));
					subObject.put("LG_TYPE_NM", rs.getString("LG_TYPE_NM"));
					subObject.put("ORIGIN", rs.getString("ORIGIN"));
					subObject.put("ORIGIN_NM", rs.getString("ORIGIN_NM"));
					subObject.put("SM_TYPE", rs.getString("SM_TYPE"));
					subObject.put("SM_TYPE_NM", rs.getString("SM_TYPE_NM"));
					subObject.put("GRADE", rs.getString("GRADE"));
					subObject.put("GRADE_NM", rs.getString("GRADE_NM"));
					subObject.put("BRAND", rs.getString("BRAND"));
					subObject.put("CUR", rs.getString("CUR"));
					subObject.put("PO_QTY", rs.getString("PO_QTY"));
					subObject.put("PO_PRC", rs.getString("PO_PRC"));
					subObject.put("PO_AMT", rs.getString("PO_AMT"));
					subObject.put("TAX_RT", rs.getString("TAX_RT"));
					subObject.put("USANCE_TYPE", rs.getString("USANCE_TYPE"));
					subObject.put("USANCE_TYPE_NM", rs.getString("USANCE_TYPE_NM"));
					subObject.put("USANCE_RT", rs.getString("USANCE_RT"));
					subObject.put("INSUR_RT", rs.getString("INSUR_RT"));
					subObject.put("PAY_METH", rs.getString("PAY_METH"));
					subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("REMARK", rs.getString("REMARK"));
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

			} else if (V_TYPE.equals("SD2")) {

				V_APPROV_MGM_NO = request.getParameter("V_APPROV_MGM_NO") == null ? "" : request.getParameter("V_APPROV_MGM_NO").toString();
				String V_APPROV_MGM_SEQ = request.getParameter("V_APPROV_MGM_SEQ") == null ? "" : request.getParameter("V_APPROV_MGM_SEQ").toString();

				// 				System.out.println(V_APPROV_MGM_NO);
				// 				System.out.println(V_APPROV_MGM_SEQ);

				cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_W_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
				cs.setString(4, V_APPROV_MGM_SEQ);//V_APPROV_MGM_SEQ
				cs.setString(5, "");//V_TYPE_CD
				cs.setString(6, "");//V_COGS_CD
				cs.setString(7, "");//V_COGS_CUR
				cs.setString(8, "");//V_COGS_AMT
				cs.setString(9, "");//V_REMARK
				cs.setString(10, "");//V_SALE_TYPE
				cs.setString(11, "");//V_IV_TYPE
				cs.setString(12, "");//V_USR_ID
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(13);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
					subObject.put("APPROV_MGM_SEQ", rs.getString("APPROV_MGM_SEQ"));
					subObject.put("TYPE_CD", rs.getString("TYPE_CD"));
					subObject.put("TYPE_NM", rs.getString("TYPE_NM"));
					subObject.put("COGS_CD", rs.getString("COGS_CD"));
					subObject.put("COGS_NM", rs.getString("COGS_NM"));
					subObject.put("COGS_CUR", rs.getString("COGS_CUR"));
					subObject.put("COGS_AMT", rs.getString("COGS_AMT"));
					subObject.put("REMARK", rs.getString("REMARK"));
					subObject.put("AG_IN_TYPE", rs.getString("AG_IN_TYPE"));
					subObject.put("AG_IV_TYPE", rs.getString("AG_IV_TYPE"));
					subObject.put("DR_IN_TYPE", rs.getString("DR_IN_TYPE"));
					subObject.put("DR_BL_TYPE", rs.getString("DR_BL_TYPE"));
					subObject.put("DR_JI_TYPE", rs.getString("DR_JI_TYPE"));
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

			} else if (V_TYPE.equals("SYNC2")) {
				request.setCharacterEncoding("utf-8");
				String[] findList = { "#", "+", "&", "%", " " };
				String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

				String data = request.getParameter("data");
				data = StringUtils.replaceEach(data, findList, replList);
				String jsonData = URLDecoder.decode(data, "UTF-8");

				V_APPROV_MGM_NO = request.getParameter("V_APPROV_MGM_NO") == null ? "" : request.getParameter("V_APPROV_MGM_NO").toString();
				String V_APPROV_MGM_SEQ = request.getParameter("V_APPROV_MGM_SEQ") == null ? "" : request.getParameter("V_APPROV_MGM_SEQ").toString();

				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
					// 					System.out.println(jsonAr + "\n");

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						String V_TYPE_CD = hashMap.get("TYPE_CD") == null ? "" : hashMap.get("TYPE_CD").toString();
						String V_COGS_CD = hashMap.get("COGS_CD") == null ? "" : hashMap.get("COGS_CD").toString();
						String V_COGS_CUR = hashMap.get("COGS_CUR") == null ? "" : hashMap.get("COGS_CUR").toString();
						String V_COGS_AMT = hashMap.get("COGS_AMT") == null ? "" : hashMap.get("COGS_AMT").toString();
						String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
						String V_SALE_TYPE = hashMap.get("SALE_TYPE") == null ? "" : hashMap.get("SALE_TYPE").toString();
						String V_IV_TYPE = hashMap.get("IV_TYPE") == null ? "" : hashMap.get("IV_TYPE").toString();

						cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_W_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
						cs.setString(4, V_APPROV_MGM_SEQ);//V_APPROV_MGM_SEQ
						cs.setString(5, V_TYPE_CD);//V_TYPE_CD
						cs.setString(6, V_COGS_CD);//V_COGS_CD
						cs.setString(7, V_COGS_CUR);//V_COGS_CUR
						cs.setString(8, V_COGS_AMT);//V_COGS_AMT
						cs.setString(9, V_REMARK);//V_REMARK
						cs.setString(10, V_SALE_TYPE);//V_SALE_TYPE
						cs.setString(11, V_IV_TYPE);//V_IV_TYPE
						cs.setString(12, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}
				} else {
					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					String V_TYPE_CD = jsondata.get("TYPE_CD") == null ? "" : jsondata.get("TYPE_CD").toString();
					String V_COGS_CD = jsondata.get("COGS_CD") == null ? "" : jsondata.get("COGS_CD").toString();
					String V_COGS_CUR = jsondata.get("COGS_CUR") == null ? "" : jsondata.get("COGS_CUR").toString();
					String V_COGS_AMT = jsondata.get("COGS_AMT") == null ? "" : jsondata.get("COGS_AMT").toString();
					String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
					String V_SALE_TYPE = jsondata.get("SALE_TYPE") == null ? "" : jsondata.get("SALE_TYPE").toString();
					String V_IV_TYPE = jsondata.get("IV_TYPE") == null ? "" : jsondata.get("IV_TYPE").toString();

					cs = conn.prepareCall("call DISTR_E_APROV_DISTR.USP_E_APPROV_W_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
					cs.setString(4, V_APPROV_MGM_SEQ);//V_APPROV_MGM_SEQ
					cs.setString(5, V_TYPE_CD);//V_TYPE_CD
					cs.setString(6, V_COGS_CD);//V_COGS_CD
					cs.setString(7, V_COGS_CUR);//V_COGS_CUR
					cs.setString(8, V_COGS_AMT);//V_COGS_AMT
					cs.setString(9, V_REMARK);//V_REMARK
					cs.setString(10, V_SALE_TYPE);//V_SALE_TYPE
					cs.setString(11, V_IV_TYPE);//V_IV_TYPE
					cs.setString(12, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
				}
			}
		}

	} catch (

	Exception e) {
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


