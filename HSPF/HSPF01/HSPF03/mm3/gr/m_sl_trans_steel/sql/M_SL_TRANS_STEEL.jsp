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

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TAB_TYPE = request.getParameter("V_TAB_TYPE") == null ? "" : request.getParameter("V_TAB_TYPE");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_GR_DT_FR = request.getParameter("V_GR_DT_FR") == null ? "" : request.getParameter("V_GR_DT_FR").toUpperCase().substring(0, 10);
		String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null ? "" : request.getParameter("V_GR_DT_TO").toUpperCase().substring(0, 10);
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
		String V_FR_SL_CD = request.getParameter("V_FR_SL_CD") == null ? "" : request.getParameter("V_FR_SL_CD").toUpperCase();
		String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		
		if (V_FR_SL_CD.equals("T")) {
			V_FR_SL_CD = "";
		}
		if (V_IV_TYPE.equals("T")) {
			V_IV_TYPE = "";
		}

		/*이고료등록*/
		if (V_TAB_TYPE.equals("T1") && V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_001_I_SL_MV_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_MV_NO
			cs.setString(4, "");//V_MV_DT
			cs.setString(5, V_PO_NO);//V_PO_NO
			cs.setString(6, V_APPROV_NO);//V_APPROV_NO
			cs.setString(7, "");//V_APPROV_SEQ
			cs.setString(8, "");//V_GR_NO
			cs.setString(9, "");//V_M_BP_CD
			cs.setString(10, "");//V_S_BP_CD
			cs.setString(11, V_FR_SL_CD);//V_FR_SL_CD
			cs.setString(12, "");//V_TO_SL_CD
			cs.setString(13, "");//V_MV_BP_CD
			cs.setString(14, "");//V_MV_AMT
			cs.setString(15, "");//V_MV_VAT_TYPE
			cs.setString(16, "");//V_MV_VAT_AMT
			cs.setString(17, "");//V_SALE_YN
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(20, V_BP_NM);//V_BP_NM
			cs.setString(21, V_GR_DT_FR);//V_GR_DT_FR
			cs.setString(22, V_GR_DT_TO);//V_GR_DT_TO
			cs.setString(23, V_IV_TYPE);//V_IV_TYPE
			cs.setString(24, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("APPROV_SEQ", rs.getString("APPROV_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("FR_SL_CD", rs.getString("FR_SL_CD"));
				subObject.put("FR_SL_NM", rs.getString("FR_SL_NM"));
				subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("TO_SL_NM", rs.getString("TO_SL_NM"));
				subObject.put("MV_BP_CD", rs.getString("MV_BP_CD"));
				subObject.put("MV_BP_NM", rs.getString("MV_BP_NM"));
				subObject.put("MV_DT", rs.getString("MV_DT"));
				subObject.put("MV_AMT", rs.getString("MV_AMT"));
				subObject.put("MV_VAT_AMT", rs.getString("MV_VAT_AMT"));
				subObject.put("MV_VAT_TYPE", rs.getString("MV_VAT_TYPE"));
				subObject.put("MV_VAT_TYPE_NM", rs.getString("MV_VAT_TYPE_NM"));
				if (rs.getString("SALE_YN") != null) {
					subObject.put("SALE_YN", rs.getString("SALE_YN").equals("Y") ? true : false);
				}
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("MV_NO", rs.getString("MV_NO"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
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

		} else if (V_TAB_TYPE.equals("T1") && V_TYPE.equals("SD")) {
			String V_MV_NO = request.getParameter("V_MV_NO") == null ? "" : request.getParameter("V_MV_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_001_I_SL_MV_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_MV_NO);//V_MV_NO
			cs.setString(4, "");//V_MV_DT
			cs.setString(5, V_PO_NO);//V_PO_NO
			cs.setString(6, V_APPROV_NO);//V_APPROV_NO
			cs.setString(7, "");//V_APPROV_SEQ
			cs.setString(8, "");//V_GR_NO
			cs.setString(9, "");//V_M_BP_CD
			cs.setString(10, "");//V_S_BP_CD
			cs.setString(11, V_FR_SL_CD);//V_FR_SL_CD
			cs.setString(12, "");//V_TO_SL_CD
			cs.setString(13, "");//V_MV_BP_CD
			cs.setString(14, "");//V_MV_AMT
			cs.setString(15, "");//V_MV_VAT_TYPE
			cs.setString(16, "");//V_MV_VAT_AMT
			cs.setString(17, "");//V_SALE_YN
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(20, V_BP_NM);//V_BP_NM
			cs.setString(21, V_GR_DT_FR);//V_GR_DT_FR
			cs.setString(22, V_GR_DT_TO);//V_GR_DT_TO
			cs.setString(23, "");//V_IV_TYPE
			cs.setString(24, "");//V_BL_DOC_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MV_NO", rs.getString("MV_NO"));
				subObject.put("MV_SEQ", rs.getString("MV_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("STOCK_QTY", rs.getString("STOCK_QTY"));
				subObject.put("BAE_AMT", rs.getString("BAE_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TAB_TYPE.equals("T1") && V_TYPE.equals("SYNC")) {
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
					String V_MV_NO = hashMap.get("MV_NO") == null ? "" : hashMap.get("MV_NO").toString();
					V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					V_APPROV_NO = hashMap.get("APPROV_NO") == null ? "" : hashMap.get("APPROV_NO").toString();
					String V_APPROV_SEQ = hashMap.get("APPROV_SEQ") == null ? "" : hashMap.get("APPROV_SEQ").toString();
					String V_GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					V_FR_SL_CD = hashMap.get("FR_SL_CD") == null ? "" : hashMap.get("FR_SL_CD").toString();
					String V_MV_DT = hashMap.get("MV_DT") == null ? "" : hashMap.get("MV_DT").toString().substring(0, 10);
					String V_TO_SL_CD = hashMap.get("TO_SL_CD") == null ? "" : hashMap.get("TO_SL_CD").toString();
					String V_MV_BP_CD = hashMap.get("MV_BP_CD") == null ? "" : hashMap.get("MV_BP_CD").toString();
					String V_MV_AMT = hashMap.get("MV_AMT") == null ? "" : hashMap.get("MV_AMT").toString();
					String V_MV_VAT_TYPE = hashMap.get("MV_VAT_TYPE") == null ? "" : hashMap.get("MV_VAT_TYPE").toString();
					String V_MV_VAT_AMT = hashMap.get("MV_VAT_AMT") == null ? "" : hashMap.get("MV_VAT_AMT").toString();
					String V_SALE_YN = hashMap.get("SALE_YN") == null ? "" : hashMap.get("SALE_YN").toString();
					if (V_SALE_YN.equals("true")) {
						V_SALE_YN = "Y";
					} else {
						V_SALE_YN = "N";
					}

					cs = conn.prepareCall("call USP_001_I_SL_MV_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_MV_NO);//V_MV_NO
					cs.setString(4, V_MV_DT);//V_MV_DT
					cs.setString(5, V_PO_NO);//V_PO_NO
					cs.setString(6, V_APPROV_NO);//V_APPROV_NO
					cs.setString(7, V_APPROV_SEQ);//V_APPROV_SEQ
					cs.setString(8, V_GR_NO);//V_GR_NO
					cs.setString(9, V_M_BP_CD);//V_M_BP_CD
					cs.setString(10, V_S_BP_CD);//V_S_BP_CD
					cs.setString(11, V_FR_SL_CD);//V_FR_SL_CD
					cs.setString(12, V_TO_SL_CD);//V_TO_SL_CD
					cs.setString(13, V_MV_BP_CD);//V_MV_BP_CD
					cs.setString(14, V_MV_AMT);//V_MV_AMT
					cs.setString(15, V_MV_VAT_TYPE);//V_MV_VAT_TYPE
					cs.setString(16, V_MV_VAT_AMT);//V_MV_VAT_AMT
					cs.setString(17, V_SALE_YN);//V_SALE_YN
					cs.setString(18, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(20, V_BP_NM);//V_BP_NM
					cs.setString(21, V_GR_DT_FR);//V_GR_DT_FR
					cs.setString(22, V_GR_DT_TO);//V_GR_DT_TO
					cs.setString(23, "");//V_IV_TYPE
					cs.setString(24, "");//V_BL_DOC_NO
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
				String V_MV_NO = jsondata.get("MV_NO") == null ? "" : jsondata.get("MV_NO").toString();
				V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				V_APPROV_NO = jsondata.get("APPROV_NO") == null ? "" : jsondata.get("APPROV_NO").toString();
				String V_APPROV_SEQ = jsondata.get("APPROV_SEQ") == null ? "" : jsondata.get("APPROV_SEQ").toString();
				String V_GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				V_FR_SL_CD = jsondata.get("FR_SL_CD") == null ? "" : jsondata.get("FR_SL_CD").toString();
				String V_MV_DT = jsondata.get("MV_DT") == null ? "" : jsondata.get("MV_DT").toString().substring(0, 10);
				String V_TO_SL_CD = jsondata.get("TO_SL_CD") == null ? "" : jsondata.get("TO_SL_CD").toString();
				String V_MV_BP_CD = jsondata.get("MV_BP_CD") == null ? "" : jsondata.get("MV_BP_CD").toString();
				String V_MV_AMT = jsondata.get("MV_AMT") == null ? "" : jsondata.get("MV_AMT").toString();
				String V_MV_VAT_TYPE = jsondata.get("MV_VAT_TYPE") == null ? "" : jsondata.get("MV_VAT_TYPE").toString();
				String V_MV_VAT_AMT = jsondata.get("MV_VAT_AMT") == null ? "" : jsondata.get("MV_VAT_AMT").toString();
				String V_SALE_YN = jsondata.get("SALE_YN") == null ? "" : jsondata.get("SALE_YN").toString();
				if (V_SALE_YN.equals("true")) {
					V_SALE_YN = "Y";
				} else {
					V_SALE_YN = "N";
				}

				// 				System.out.println("V_SALE_YN" + V_SALE_YN);

				cs = conn.prepareCall("call USP_001_I_SL_MV_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_MV_NO);//V_MV_NO
				cs.setString(4, V_MV_DT);//V_MV_DT
				cs.setString(5, V_PO_NO);//V_PO_NO
				cs.setString(6, V_APPROV_NO);//V_APPROV_NO
				cs.setString(7, V_APPROV_SEQ);//V_APPROV_SEQ
				cs.setString(8, V_GR_NO);//V_GR_NO
				cs.setString(9, V_M_BP_CD);//V_M_BP_CD
				cs.setString(10, V_S_BP_CD);//V_S_BP_CD
				cs.setString(11, V_FR_SL_CD);//V_FR_SL_CD
				cs.setString(12, V_TO_SL_CD);//V_TO_SL_CD
				cs.setString(13, V_MV_BP_CD);//V_MV_BP_CD
				cs.setString(14, V_MV_AMT);//V_MV_AMT
				cs.setString(15, V_MV_VAT_TYPE);//V_MV_VAT_TYPE
				cs.setString(16, V_MV_VAT_AMT);//V_MV_VAT_AMT
				cs.setString(17, V_SALE_YN);//V_SALE_YN
				cs.setString(18, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(20, V_BP_NM);//V_BP_NM
				cs.setString(21, V_GR_DT_FR);//V_GR_DT_FR
				cs.setString(22, V_GR_DT_TO);//V_GR_DT_TO
				cs.setString(23, "");//V_IV_TYPE
				cs.setString(24, "");//V_BL_DOC_NO
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
		}

		/*항운노조비등록*/
		else if (V_TAB_TYPE.equals("T3") && V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_001_I_PORT_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_PH_NO
			cs.setString(4, "");//V_PH_DT
			cs.setString(5, "");//V_CC_NO
			cs.setString(6, "");//V_PH_AMT
			cs.setString(7, "");//V_REMARK
			cs.setString(8, "");//V_PH_DT_FR
			cs.setString(9, "");//V_PH_DT_TO
			cs.setString(10, "");//V_LC_DOC_NO
			cs.setString(11, "");//V_BL_DOC_NO
			cs.setString(12, "");//V_USR_ID
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PH_DT", rs.getString("PH_DT"));
				subObject.put("PH_AMT", rs.getString("PH_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("PH_NO", rs.getString("PH_NO"));
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
		} else if (V_TAB_TYPE.equals("T3") && V_TYPE.equals("SD")) {
			String V_PH_NO = request.getParameter("V_PH_NO") == null ? "" : request.getParameter("V_PH_NO");

			cs = conn.prepareCall("call USP_001_I_PORT_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PH_NO);//V_PH_NO
			cs.setString(4, "");//V_PH_DT
			cs.setString(5, "");//V_CC_NO
			cs.setString(6, "");//V_PH_AMT
			cs.setString(7, "");//V_REMARK
			cs.setString(8, "");//V_PH_DT_FR
			cs.setString(9, "");//V_PH_DT_TO
			cs.setString(10, "");//V_LC_DOC_NO
			cs.setString(11, "");//V_BL_DOC_NO
			cs.setString(12, "");//V_USR_ID
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("BLITEM_CD"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("PH_DIS_AMT", rs.getString("PH_DIS_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		} else if (V_TAB_TYPE.equals("T3") && V_TYPE.equals("SYNC")) {
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
					V_BL_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
					String V_LC_DOC_NO = hashMap.get("LC_DOC_NO") == null ? "" : hashMap.get("LC_DOC_NO").toString();
					String V_CC_NO = hashMap.get("CC_NO") == null ? "" : hashMap.get("CC_NO").toString();
					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					String V_PH_DT = hashMap.get("PH_DT") == null ? "" : hashMap.get("PH_DT").toString().substring(0, 10);
					String V_PH_AMT = hashMap.get("PH_AMT") == null ? "" : hashMap.get("PH_AMT").toString();
					String V_PH_NO = hashMap.get("PH_NO") == null ? "" : hashMap.get("PH_NO").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();

					cs = conn.prepareCall("call USP_001_I_PORT_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_PH_NO);//V_PH_NO
					cs.setString(4, V_PH_DT);//V_PH_DT
					cs.setString(5, V_CC_NO);//V_CC_NO
					cs.setString(6, V_PH_AMT);//V_PH_AMT
					cs.setString(7, V_REMARK);//V_REMARK
					cs.setString(8, "");//V_PH_DT_FR
					cs.setString(9, "");//V_PH_DT_TO
					cs.setString(10, V_LC_DOC_NO);//V_LC_DOC_NO
					cs.setString(11, V_BL_DOC_NO);//V_BL_DOC_NO
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
// 				JSONObject jsondata = JSONObject.fromObject(jsonData);
				//큰수에 소수점이 있는경우 숫자계산이 이상해서 수정함. 20200108 김장운

				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);					
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_BL_DOC_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
				String V_LC_DOC_NO = jsondata.get("LC_DOC_NO") == null ? "" : jsondata.get("LC_DOC_NO").toString();
				String V_CC_NO = jsondata.get("CC_NO") == null ? "" : jsondata.get("CC_NO").toString();
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
				String V_PH_DT = jsondata.get("PH_DT") == null ? "" : jsondata.get("PH_DT").toString().substring(0, 10);
				String V_PH_AMT = jsondata.get("PH_AMT") == null ? "" : jsondata.get("PH_AMT").toString();
				String V_PH_NO = jsondata.get("PH_NO") == null ? "" : jsondata.get("PH_NO").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();

				cs = conn.prepareCall("call USP_001_I_PORT_H_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_PH_NO);//V_PH_NO
				cs.setString(4, V_PH_DT);//V_PH_DT
				cs.setString(5, V_CC_NO);//V_CC_NO
				cs.setString(6, V_PH_AMT);//V_PH_AMT
				cs.setString(7, V_REMARK);//V_REMARK
				cs.setString(8, "");//V_PH_DT_FR
				cs.setString(9, "");//V_PH_DT_TO
				cs.setString(10, V_LC_DOC_NO);//V_LC_DOC_NO
				cs.setString(11, V_BL_DOC_NO);//V_BL_DOC_NO
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


