<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").toUpperCase().substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase().substring(0, 10);
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();

		//상단
		if (V_TYPE.equals("R")) {

			cs = conn.prepareCall("call USP_002_S_EX_BILL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, "");//V_BILL_DT
			cs.setString(5, V_DN_DT_FR);//V_DN_DT_FR
			cs.setString(6, V_DN_DT_TO);//V_DN_DT_TO
			cs.setString(7, V_S_BP_NM);//V_S_BP_CD
			cs.setString(8, "");//V_R_BP_CD
			cs.setString(9, "");//V_IN_TERMS
			cs.setString(10, "");//V_PAY_METH
			cs.setString(11, "");//V_SALE_TYPE
			cs.setString(12, "");//V_CUR
			cs.setString(13, "");//V_XCHG_RT
			cs.setString(14, "");//V_VAT_INC
			cs.setString(15, "");//V_DN_ISSUE_DT
			cs.setString(16, "");//V_TAX_CD
			cs.setString(17, "");//V_CFM_YN
			cs.setString(18, "");//V_REF_BILL_NO
			cs.setString(19, "");//V_TEMP_GL_NO
			cs.setString(20, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(21);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("BILL_NO", rs.getString("BILL_NO"));
				subObject.put("BILL_SEQ", rs.getString("BILL_SEQ"));
				subObject.put("BILL_DT", rs.getString("BILL_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("BILL_QTY", rs.getString("BILL_QTY"));
				subObject.put("BILL_PRC", rs.getString("BILL_PRC"));
				subObject.put("BILL_AMT", rs.getString("BILL_AMT"));
				
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("VAT_RATE", rs.getString("VAT_RATE"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				
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

			cs = conn.prepareCall("call USP_002_S_EX_BILL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, "");//V_BILL_DT
			cs.setString(5, V_DN_DT_FR);//V_DN_DT_FR
			cs.setString(6, V_DN_DT_TO);//V_DN_DT_TO
			cs.setString(7, V_S_BP_CD);//V_S_BP_CD
			cs.setString(8, "");//V_R_BP_CD
			cs.setString(9, "");//V_IN_TERMS
			cs.setString(10, "");//V_PAY_METH
			cs.setString(11, "");//V_SALE_TYPE
			cs.setString(12, "");//V_CUR
			cs.setString(13, "");//V_XCHG_RT
			cs.setString(14, "");//V_VAT_INC
			cs.setString(15, "");//V_DN_ISSUE_DT
			cs.setString(16, "");//V_TAX_CD
			cs.setString(17, "");//V_CFM_YN
			cs.setString(18, "");//V_REF_BILL_NO
			cs.setString(19, "");//V_TEMP_GL_NO
			cs.setString(20, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(21);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BILL_NO", rs.getString("BILL_NO"));
				subObject.put("BILL_DT", rs.getString("BILL_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("R_BP_CD", rs.getString("R_BP_CD"));
				subObject.put("R_BP_NM", rs.getString("R_BP_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
				subObject.put("VAT_INC", rs.getString("VAT_INC"));
				subObject.put("DN_ISSUE_DT", rs.getString("DN_ISSUE_DT").substring(0, 10));
				subObject.put("TAX_CD", rs.getString("TAX_CD"));
				subObject.put("TAX_NM", rs.getString("TAX_NM"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("REF_BILL_NO", rs.getString("REF_BILL_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("P")) {

			cs = conn.prepareCall("call USP_002_S_EX_BILL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, "");//V_BILL_DT
			cs.setString(5, V_DN_DT_FR);//V_DN_DT_FR
			cs.setString(6, V_DN_DT_TO);//V_DN_DT_TO
			cs.setString(7, V_S_BP_CD);//V_S_BP_CD
			cs.setString(8, "");//V_R_BP_CD
			cs.setString(9, "");//V_IN_TERMS
			cs.setString(10, "");//V_PAY_METH
			cs.setString(11, "");//V_SALE_TYPE
			cs.setString(12, "");//V_CUR
			cs.setString(13, "");//V_XCHG_RT
			cs.setString(14, "");//V_VAT_INC
			cs.setString(15, "");//V_DN_ISSUE_DT
			cs.setString(16, "");//V_TAX_CD
			cs.setString(17, "");//V_CFM_YN
			cs.setString(18, "");//V_REF_BILL_NO
			cs.setString(19, "");//V_TEMP_GL_NO
			cs.setString(20, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(21);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BILL_NO", rs.getString("BILL_NO"));
				subObject.put("BILL_DT", rs.getString("BILL_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("R_BP_CD", rs.getString("R_BP_CD"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("VAT_INC", rs.getString("VAT_INC"));
				subObject.put("DN_ISSUE_DT", rs.getString("DN_ISSUE_DT").substring(0, 10));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("BILL_LOC_AMT", rs.getString("BILL_LOC_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

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

// 			String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
// 					V_BILL_NO = hashMap.get("BILL_NO") == null ? "" : hashMap.get("BILL_NO").toString();
					String V_BILL_SEQ = hashMap.get("BILL_SEQ") == null ? "" : hashMap.get("BILL_SEQ").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_COST_CD = hashMap.get("COST_CD") == null ? "" : hashMap.get("COST_CD").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String V_VAT_RATE = hashMap.get("VAT_RATE") == null ? "" : hashMap.get("VAT_RATE").toString();
					String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
					String V_DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString();
					String V_VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_BILL_QTY = hashMap.get("BILL_QTY") == null ? "" : hashMap.get("BILL_QTY").toString();
					String V_BILL_AMT = hashMap.get("BILL_LOC_AMT") == null ? "" : hashMap.get("BILL_LOC_AMT").toString();
					String V_BILL_LOC_AMT = hashMap.get("BILL_LOC_AMT") == null ? "" : hashMap.get("BILL_LOC_AMT").toString();
					String V_BILL_PRC = hashMap.get("BILL_PRC") == null ? "" : hashMap.get("BILL_PRC").toString();

					// [20200211 HDH] PRC 등록시 수량이 0 이면 0, 수량이 0이상이면 ROUND(금액/수량,2)
					Double billPrc = 0.0d;
					Double billAmt = Double.parseDouble(V_BILL_AMT);
					Double billQty = Double.parseDouble(V_BILL_QTY);
					if(billQty != 0){
						billPrc = Math.round((billAmt/billQty)*100)/100.0;
					} 
					V_BILL_PRC = billPrc.toString();
					
					cs = conn.prepareCall("call USP_002_S_BILL_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
// 				V_BILL_NO = jsondata.get("BILL_NO") == null ? "" : jsondata.get("BILL_NO").toString();
				String V_BILL_SEQ = jsondata.get("BILL_SEQ") == null ? "" : jsondata.get("BILL_SEQ").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_BILL_QTY = jsondata.get("BILL_QTY") == null ? "" : jsondata.get("BILL_QTY").toString();
				String V_BILL_AMT = jsondata.get("BILL_LOC_AMT") == null ? "" : jsondata.get("BILL_LOC_AMT").toString();
				String V_BILL_LOC_AMT = jsondata.get("BILL_LOC_AMT") == null ? "" : jsondata.get("BILL_LOC_AMT").toString();
				String V_BILL_PRC = jsondata.get("BILL_PRC") == null ? "" : jsondata.get("BILL_PRC").toString();
				String V_COST_CD = jsondata.get("COST_CD") == null ? "" : jsondata.get("COST_CD").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String V_VAT_RATE = jsondata.get("VAT_RATE") == null ? "" : jsondata.get("VAT_RATE").toString();
				String V_VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
				String V_DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString();
				
				// [20200211 HDH] PRC등록시 수량이 0 이면 0, 수량이 0이상이면 ROUND(금액/수량,2)
				Double billPrc = 0.0d;
				Double billAmt = Double.parseDouble(V_BILL_AMT);
				Double billQty = Double.parseDouble(V_BILL_QTY);
				if(billQty != 0){
					billPrc = Math.round((billAmt/billQty)*100)/100.0;
				} 
				V_BILL_PRC = billPrc.toString();
				
				cs = conn.prepareCall("call USP_002_S_BILL_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}

// 			/*하단 헤더 I / U*/
		} else if (V_TYPE.equals("IH") || V_TYPE.equals("UH")) {

// 			String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
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
			String V_REF_BILL_NO = request.getParameter("V_REF_BILL_NO") == null ? "" : request.getParameter("V_REF_BILL_NO").toUpperCase();
			String V_TEMP_GL_NO = request.getParameter("V_TEMP_GL_NO") == null ? "" : request.getParameter("V_TEMP_GL_NO").toUpperCase();

			cs = conn.prepareCall("call USP_002_S_EX_BILL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BILL_NO);//V_BILL_NO
			cs.setString(4, V_BILL_DT);//V_BILL_DT
			cs.setString(5, V_DN_DT_FR);//V_DN_DT_FR
			cs.setString(6, V_DN_DT_TO);//V_DN_DT_TO
			cs.setString(7, V_S_BP_CD2);//V_S_BP_CD
			cs.setString(8, V_R_BP_CD);//V_R_BP_CD
			cs.setString(9, V_IN_TERMS);//V_IN_TERMS
			cs.setString(10, V_PAY_METH);//V_PAY_METH
			cs.setString(11, V_SALE_TYPE);//V_SALE_TYPE
			cs.setString(12, V_CUR);//V_CUR
			cs.setString(13, V_XCHG_RT);//V_XCHG_RT
			cs.setString(14, V_VAT_INC);//V_VAT_INC
			cs.setString(15, V_DN_ISSUE_DT);//V_DN_ISSUE_DT
			cs.setString(16, V_TAX_CD);//V_TAX_CD
			cs.setString(17, V_CFM_YN);//V_CFM_YN
			cs.setString(18, V_REF_BILL_NO);//V_REF_BILL_NO
			cs.setString(19, V_TEMP_GL_NO);//V_TEMP_GL_NO
			cs.setString(20, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();

			if (V_TYPE.equals("IH")) {
				rs = (ResultSet) cs.getObject(21);
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
		
		} else if (V_TYPE.equals("I") || V_TYPE.equals("D")) {

			cs = conn.prepareCall("call DISTR_TEMP_GL.USP_A_TEMP_BN_EX(?,?,?,?,?)");

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
// 				/*애니링크 시작*/
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
		} else if (V_TYPE.equals("SD")) {

			cs = conn.prepareCall("call USP_002_S_BILL_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
				subObject.put("BILL_AMT", rs.getString("BILL_AMT"));
				subObject.put("BILL_QTY", rs.getString("BILL_QTY"));
				subObject.put("BILL_PRC", rs.getString("BILL_PRC"));
				subObject.put("BILL_AMT", rs.getString("BILL_AMT"));
				subObject.put("BILL_LOC_AMT", rs.getString("BILL_LOC_AMT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("VAT_RATE", rs.getString("VAT_RATE"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
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


