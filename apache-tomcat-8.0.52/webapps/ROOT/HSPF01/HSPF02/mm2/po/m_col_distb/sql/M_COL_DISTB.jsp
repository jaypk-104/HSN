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
<%@ include file="/HSPF01/common/DB_Connection_ERP.jsp"%>
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
		String V_COL_NO = request.getParameter("V_COL_NO") == null ? "" : request.getParameter("V_COL_NO").toUpperCase();
		String V_APPROV_MGM_NO = request.getParameter("V_APPROV_MGM_NO") == null ? "" : request.getParameter("V_APPROV_MGM_NO").toUpperCase();
		String V_BS_DT_FR = request.getParameter("V_BS_DT_FR") == null ? "" : request.getParameter("V_BS_DT_FR").substring(0, 10);
		String V_BS_DT_TO = request.getParameter("V_BS_DT_TO") == null ? "" : request.getParameter("V_BS_DT_TO").substring(0, 10);
		String V_MAST_DB_NO = request.getParameter("V_MAST_DB_NO") == null ? "" : request.getParameter("V_MAST_DB_NO").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();

		//담보헤더조회
		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_BS_DT_FR
			cs.setString(4, "");//V_BS_DT_TO
			cs.setString(5, V_MAST_DB_NO);//V_MAST_DB_NO
			cs.setString(6, "");//V_COL_DT
			cs.setString(7, "");//V_COL_AVL_AMT
			cs.setString(8, "");//V_COL_TYPE
			cs.setString(9, "");//V_M_BP_CD
			cs.setString(10, "");//V_PO_NO
			cs.setString(11, "");//V_APPROV_NO
			cs.setString(12, "");//V_REF_COL_NO
			cs.setString(13, "");//V_COL_MGM_NO
			cs.setString(14, "");//V_COL_TITLE
			cs.setString(15, "");//V_COL_TOT_AMT
			cs.setString(16, "");//V_S_BP_CD
			cs.setString(17, "");//V_COL_NON_AMT
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);

			while (rs.next()) {
				subObject = new JSONObject();
				// 				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_DT", rs.getString("COL_DT"));
				subObject.put("COL_AVL_AMT", rs.getString("COL_AVL_AMT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("REF_COL_NO", rs.getString("REF_COL_NO"));
				subObject.put("COL_MGM_NO", rs.getString("COL_MGM_NO"));
				subObject.put("COL_TITLE", rs.getString("COL_TITLE"));
				subObject.put("COL_TOT_AMT", rs.getString("COL_TOT_AMT"));
				subObject.put("COL_NON_AMT", rs.getString("COL_NON_AMT"));
				subObject.put("COL_TYPE", rs.getString("COL_TYPE"));
				subObject.put("CLS_AR_NO", rs.getString("CLS_AR_NO"));
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
		//발주팝업
		else if (V_TYPE.equals("O1")) {

			cs = conn.prepareCall("call USP_M_CONT_MGM_DISTR(?,?,?,?)");
			cs.setString(1, "I");//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_NO);//V_BS_DT_FR
			cs.setString(4, V_USR_ID);//V_BS_DT_TO
			cs.executeQuery();

		} else if (V_TYPE.equals("O")) {

			cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BS_DT_FR);//V_BS_DT_FR
			cs.setString(4, V_BS_DT_TO);//V_BS_DT_TO
			cs.setString(5, "");//V_MAST_DB_NO
			cs.setString(6, "");//V_COL_DT
			cs.setString(7, "");//V_COL_AVL_AMT
			cs.setString(8, "");//V_COL_TYPE
			cs.setString(9, "");//V_M_BP_CD
			cs.setString(10, V_PO_NO);//V_PO_NO
			cs.setString(11, "");//V_APPROV_NO
			cs.setString(12, "");//V_REF_COL_NO
			cs.setString(13, "");//V_COL_MGM_NO
			cs.setString(14, "");//V_COL_TITLE
			cs.setString(15, "");//V_COL_TOT_AMT
			cs.setString(16, "");//V_S_BP_CD
			cs.setString(17, "");//V_COL_NON_AMT
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("COL_MGM_NO", rs.getString("COL_MGM_NO"));
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

			//담보팝업
		} else if (V_TYPE.equals("P")) {

			V_MAST_DB_NO = request.getParameter("V_MAST_DB_NO") == null ? "" : request.getParameter("V_MAST_DB_NO").toUpperCase();

			cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BS_DT_FR);//V_BS_DT_FR
			cs.setString(4, V_BS_DT_TO);//V_BS_DT_TO
			cs.setString(5, V_MAST_DB_NO);//V_MAST_DB_NO
			cs.setString(6, "");//V_APPROV_SEQ
			cs.setString(7, "");//V_APPROV_DT
			cs.setString(8, "");//V_RISK_REF_NO
			cs.setString(9, "");//V_S_BP_CD
			cs.setString(10, V_PO_NO);//V_PO_NO
			cs.setString(11, "");//V_SALE_TYPE
			cs.setString(12, "");//V_IV_TYPE
			cs.setString(13, "");//V_REGION
			cs.setString(14, "");//V_PO_NO
			cs.setString(15, "");//
			cs.setString(16, V_S_BP_NM);//V_S_BP_CD
			cs.setString(17, "");//V_ETC2_SL_TEXT
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("COL_MGM_NO", rs.getString("COL_MGM_NO"));
				subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
				subObject.put("COL_TYPE", rs.getString("COL_TYPE"));
				subObject.put("COL_TYPE_NM", rs.getString("COL_TYPE_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("COL_TOT_AMT", rs.getString("COL_TOT_AMT"));
				subObject.put("COL_AVL_AMT", rs.getString("COL_AVL_AMT"));
				subObject.put("COL_DT", rs.getString("COL_DT"));
				subObject.put("COL_TITLE", rs.getString("COL_TITLE"));
				subObject.put("REF_COL_NO", rs.getString("REF_COL_NO"));
				subObject.put("ERP_CREATE_YN", rs.getString("ERP_CREATE_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("COL_DOC_AMT", rs.getString("COL_DOC_AMT"));
				subObject.put("USE_YN", rs.getString("USE_YN"));
				subObject.put("CLS_AR_NO", rs.getString("CLS_AR_NO"));
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

		} else if (V_TYPE.equals("ID")) { //발주팝업 더블클릭 시 GROUP BY...

			cs = conn.prepareCall("call DISTR_CONTAINER.USP_M_CONT_MGM_DISTR(?,?,?,?,?)");
			cs.setString(1, "I");//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_NO);//V_BS_DT_FR
			cs.setString(4, V_USR_ID);//V_BS_DT_TO
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
				subObject.put("CONT_REMARK", rs.getString("CONT_REMARK"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
				subObject.put("COL_TYPE", rs.getString("COL_TYPE_NM"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
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

		} else if (V_TYPE.equals("HI") || V_TYPE.equals("D") || V_TYPE.equals("HI_ADD")) {
			V_COL_NO = request.getParameter("V_COL_NO") == null ? "" : request.getParameter("V_COL_NO").toUpperCase();
			String V_COL_TYPE = request.getParameter("V_COL_TYPE") == null ? "" : request.getParameter("V_COL_TYPE").toUpperCase();
			V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
			String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toString();
			String V_COL_DT = request.getParameter("V_COL_DT") == null ? "" : request.getParameter("V_COL_DT").toUpperCase().substring(0, 10);
			String V_COL_AVL_AMT = request.getParameter("V_COL_AVL_AMT") == null ? "" : request.getParameter("V_COL_AVL_AMT").toUpperCase();
			String V_COL_MGM_NO = request.getParameter("V_COL_MGM_NO") == null ? "" : request.getParameter("V_COL_MGM_NO").toUpperCase();
			String V_REF_COL_NO = request.getParameter("V_REF_COL_NO") == null ? "" : request.getParameter("V_REF_COL_NO").toUpperCase();
			String V_COL_TITLE = request.getParameter("V_COL_TITLE") == null ? "" : request.getParameter("V_COL_TITLE");
			String V_COL_TOT_AMT = request.getParameter("V_COL_TOT_AMT") == null ? "" : request.getParameter("V_COL_TOT_AMT").toUpperCase();
			String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
			String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
			String V_COL_NON_AMT = request.getParameter("V_COL_NON_AMT") == null ? "" : request.getParameter("V_COL_NON_AMT").toUpperCase();

			String V_OLD_MAST_DB_NO = request.getParameter("V_OLD_MAST_DB_NO") == null ? "" : request.getParameter("V_OLD_MAST_DB_NO");

// 			System.out.println("V_TYPE: " + V_TYPE);
// 			System.out.println("V_MAST_DB_NO: " + V_MAST_DB_NO);
// 			System.out.println("V_OLD_MAST_DB_NO: " + V_OLD_MAST_DB_NO);

			cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_BS_DT_FR
			cs.setString(4, "");//V_BS_DT_TO
			cs.setString(5, V_MAST_DB_NO);//V_MAST_DB_NO
			cs.setString(6, V_COL_DT);//V_COL_DT
			cs.setString(7, V_COL_AVL_AMT);//V_COL_AVL_AMT
			cs.setString(8, V_COL_TYPE);//V_COL_TYPE
			cs.setString(9, V_M_BP_CD);//V_M_BP_CD
			cs.setString(10, V_PO_NO);//V_PO_NO
			cs.setString(11, V_APPROV_NO);//V_APPROV_NO
			cs.setString(12, V_REF_COL_NO);//V_REF_COL_NO
			cs.setString(13, V_COL_MGM_NO);//V_COL_MGM_NO

			if (V_TYPE.equals("HI_ADD")) {
				cs.setString(14, V_OLD_MAST_DB_NO);// 추가담보 등록시 입력param 변경
			} else {
				cs.setString(14, V_COL_TITLE);//V_COL_TITLE
			}
			cs.setString(15, V_COL_TOT_AMT);//V_COL_TOT_AMT
			cs.setString(16, V_S_BP_CD);//V_S_BP_CD
			cs.setString(17, V_COL_NON_AMT);//V_COL_NON_AMT
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

// 			System.out.println(res);

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

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();

					V_COL_NO = hashMap.get("COL_NO") == null ? "" : hashMap.get("COL_NO").toString();
					String V_COL_SEQ = hashMap.get("COL_SEQ") == null ? "" : hashMap.get("COL_SEQ").toString();
					String V_COL_DOC_AMT = hashMap.get("COL_DOC_AMT") == null ? "" : hashMap.get("COL_DOC_AMT").toString();
					String V_COL_LOC_AMT = hashMap.get("COL_LOC_AMT") == null ? "" : hashMap.get("COL_LOC_AMT").toString();
					String V_BL_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
					String V_USE_DT = hashMap.get("USE_DT") == null ? "" : hashMap.get("USE_DT").toString().substring(0, 10);
					String V_TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_COL_TYPE = hashMap.get("COL_TYPE") == null ? "" : hashMap.get("COL_TYPE").toString();
					String V_COL_AVL_AMT = hashMap.get("COL_AVL_AMT") == null ? "" : hashMap.get("COL_AVL_AMT").toString();
					String V_COL_AMT = hashMap.get("COL_AMT") == null ? "" : hashMap.get("COL_AMT").toString();
					String V_CONT_REMARK = hashMap.get("CONT_REMARK") == null ? "" : hashMap.get("CONT_REMARK").toString();
					String V_CONT_MGM_NO = hashMap.get("CONT_MGM_NO") == null ? "" : hashMap.get("CONT_MGM_NO").toString();
					V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();

					if (V_TYPE.equals("U") || V_TYPE.equals("D")) {
						V_MAST_DB_NO = hashMap.get("MAST_DB_NO") == null ? "" : hashMap.get("MAST_DB_NO").toString();
					}

					if (V_TYPE.equals("I_ADD")) {
						//추가 담보일 경우
						V_COL_NO = request.getParameter("V_COL_NO") == null ? "" : request.getParameter("V_COL_NO");
						V_COL_DOC_AMT = hashMap.get("COL_AMT") == null ? "" : hashMap.get("COL_AMT").toString();
						V_COL_LOC_AMT = hashMap.get("COL_AMT") == null ? "" : hashMap.get("COL_AMT").toString();
					}

					cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_COL_NO);//V_APPROCOL_NO
					cs.setString(4, V_COL_SEQ);//V_COL_SEQ
					cs.setString(5, V_COL_DOC_AMT);//V_COL_DOC_AMT
					cs.setString(6, V_COL_LOC_AMT);//V_COL_LOC_AMT
					cs.setString(7, V_BL_DOC_NO);//V_BL_DOC_NO
					cs.setString(8, "");//V_USE_YN
					cs.setString(9, V_TEMP_GL_NO);//V_TEMP_GL_NO
					cs.setString(10, V_USE_DT);//V_USE_DT
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.setString(12, V_REMARK);//V_REMARK
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(14, V_MAST_DB_NO);//V_MAST_DB_NO
					cs.setString(15, V_COL_TYPE);//V_COL_TYPE
					cs.setString(16, V_COL_AVL_AMT);//V_COL_AVL_AMT
					cs.setString(17, V_COL_AMT);//V_COL_AMT
					cs.setString(18, V_CONT_REMARK);//V_CONT_REMARK
					cs.setString(19, V_CONT_MGM_NO);//V_CONT_MGM_NO
					cs.setString(20, V_PO_NO);//V_CONT_MGM_NO
					cs.setString(21, V_PO_SEQ);//V_CONT_MGM_NO
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
				V_COL_NO = jsondata.get("COL_NO") == null ? "" : jsondata.get("COL_NO").toString();
				String V_COL_SEQ = jsondata.get("COL_SEQ") == null ? "" : jsondata.get("COL_SEQ").toString();
				String V_COL_DOC_AMT = jsondata.get("COL_DOC_AMT") == null ? "" : jsondata.get("COL_DOC_AMT").toString();
				String V_COL_LOC_AMT = jsondata.get("COL_LOC_AMT") == null ? "" : jsondata.get("COL_LOC_AMT").toString();
				String V_BL_DOC_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
				String V_USE_DT = jsondata.get("USE_DT") == null ? "" : jsondata.get("USE_DT").toString().substring(0, 10);
				String V_TEMP_GL_NO = jsondata.get("TEMP_GL_NO") == null ? "" : jsondata.get("TEMP_GL_NO").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_COL_TYPE = jsondata.get("COL_TYPE") == null ? "" : jsondata.get("COL_TYPE").toString();
				String V_COL_AVL_AMT = jsondata.get("COL_AVL_AMT") == null ? "" : jsondata.get("COL_AVL_AMT").toString();
				String V_COL_AMT = jsondata.get("COL_AMT") == null ? "" : jsondata.get("COL_AMT").toString();
				String V_CONT_REMARK = jsondata.get("CONT_REMARK") == null ? "" : jsondata.get("CONT_REMARK").toString();
				String V_CONT_MGM_NO = jsondata.get("CONT_MGM_NO") == null ? "" : jsondata.get("CONT_MGM_NO").toString();
				V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();

				if (V_TYPE.equals("U") || V_TYPE.equals("D")) {
					V_MAST_DB_NO = jsondata.get("MAST_DB_NO") == null ? "" : jsondata.get("MAST_DB_NO").toString();
				}

				if (V_TYPE.equals("I_ADD")) {
					//추가 담보일 경우
					V_COL_NO = request.getParameter("V_COL_NO") == null ? "" : request.getParameter("V_COL_NO");
					V_COL_DOC_AMT = jsondata.get("COL_AMT") == null ? "" : jsondata.get("COL_AMT").toString();
					V_COL_LOC_AMT = jsondata.get("COL_AMT") == null ? "" : jsondata.get("COL_AMT").toString();
					V_PO_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO");
					
					if(V_PO_NO.equals("")){//통관입고전 추가담보등록 GR20191127
						V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");//GR
					}
				}

// 				System.out.println("V_TYPE : " + V_TYPE);
// 				System.out.println("V_MAST_DB_NO : " + V_MAST_DB_NO);
// 				System.out.println("V_COL_NO : " + V_COL_NO);
// 				System.out.println("V_COL_TYPE : " + V_COL_TYPE);
// 				System.out.println("V_PO_NO : " + V_PO_NO);

				cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_COL_NO);//V_APPROCOL_NO
				cs.setString(4, V_COL_SEQ);//V_COL_SEQ
				cs.setString(5, V_COL_DOC_AMT);//V_COL_DOC_AMT
				cs.setString(6, V_COL_LOC_AMT);//V_COL_LOC_AMT
				cs.setString(7, V_BL_DOC_NO);//V_BL_DOC_NO
				cs.setString(8, "");//V_USE_YN
				cs.setString(9, V_TEMP_GL_NO);//V_TEMP_GL_NO
				cs.setString(10, V_USE_DT);//V_USE_DT
				cs.setString(11, V_USR_ID);//V_USR_ID
				cs.setString(12, V_REMARK);//V_REMARK
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(14, V_MAST_DB_NO);//V_MAST_DB_NO
				cs.setString(15, V_COL_TYPE);//V_COL_TYPE
				cs.setString(16, V_COL_AVL_AMT);//V_COL_AVL_AMT
				cs.setString(17, V_COL_AMT);//V_COL_AMT
				cs.setString(18, V_CONT_REMARK);//V_CONT_REMARK
				cs.setString(19, V_CONT_MGM_NO);//V_CONT_MGM_NO
				cs.setString(20, V_PO_NO);//V_CONT_MGM_NO
				cs.setString(21, V_PO_SEQ);//V_CONT_MGM_NO
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			}

			//담보등록디테일조회
		} else if (V_TYPE.equals("SD")) {

			cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_COL_NO);//V_APPROCOL_NO
			cs.setString(4, "");//V_COL_SEQ
			cs.setString(5, "");//V_COL_DOC_AMT
			cs.setString(6, "");//V_COL_LOC_AMT
			cs.setString(7, "");//V_BL_DOC_NO
			cs.setString(8, "");//VV_BL_DOC_NO
			cs.setString(9, "");//V_TEMP_GL_NO
			cs.setString(10, "");//V_USE_DT
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.setString(12, "");//V_REMARK
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(14, V_MAST_DB_NO);//V_MAST_DB_NO
			cs.setString(15, "");//V_MAST_DB_NO
			cs.setString(16, "");//V_MAST_DB_NO
			cs.setString(17, "");//V_MAST_DB_NO
			cs.setString(18, "");//V_CONT_REMARK
			cs.setString(19, "");//V_CONT_MGM_NO
			cs.setString(20, "");//V_CONT_MGM_NO
			cs.setString(21, "");//V_CONT_MGM_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("COL_DOC_AMT", rs.getString("COL_DOC_AMT"));
				subObject.put("COL_LOC_AMT", rs.getString("COL_LOC_AMT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("USE_YN", rs.getString("USE_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("USE_DT", rs.getString("USE_DT"));
				subObject.put("COL_TYPE", rs.getString("COL_TYPE"));
				subObject.put("COL_AVL_AMT", rs.getString("COL_AVL_AMT"));
				subObject.put("COL_AMT", rs.getString("COL_AMT"));
				subObject.put("CONT_REMARK", rs.getString("CONT_REMARK"));
				subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SD2")) {
			cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_D_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_COL_NO);//V_APPROCOL_NO
			cs.setString(4, "");//V_COL_SEQ
			cs.setString(5, "");//V_COL_DOC_AMT
			cs.setString(6, "");//V_COL_LOC_AMT
			cs.setString(7, "");//V_BL_DOC_NO
			cs.setString(8, "");//VV_BL_DOC_NO
			cs.setString(9, "");//V_TEMP_GL_NO
			cs.setString(10, "");//V_USE_DT
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.setString(12, "");//V_REMARK
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(14, V_MAST_DB_NO);//V_MAST_DB_NO
			cs.setString(15, "");//V_MAST_DB_NO
			cs.setString(16, "");//V_MAST_DB_NO
			cs.setString(17, "");//V_MAST_DB_NO
			cs.setString(18, "");//V_CONT_REMARK
			cs.setString(19, "");//V_CONT_MGM_NO
			cs.setString(20, V_PO_NO);//V_PO_NO
			cs.setString(21, "");//V_PO_SEQ
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("BN")) {

			cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_BS_DT_FR
			cs.setString(4, "");//V_BS_DT_TO
			cs.setString(5, V_COL_NO);//V_COL_NO
			cs.setString(6, "");//V_COL_DT
			cs.setString(7, "");//V_COL_AVL_AMT
			cs.setString(8, "");//V_COL_TYPE
			cs.setString(9, "");//V_M_BP_CD
			cs.setString(10, V_PO_NO);//V_PO_NO
			cs.setString(11, "");//V_APPROV_NO
			cs.setString(12, "");//V_REF_COL_NO
			cs.setString(13, "");//V_COL_MGM_NO
			cs.setString(14, "");//V_COL_TITLE
			cs.setString(15, "");//V_COL_TOT_AMT
			cs.setString(16, "");//V_S_BP_CD
			cs.setString(17, "");//V_COL_NON_AMT
			cs.setString(18, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DTL_CD", rs.getString("DTL_CD"));
				subObject.put("DTL_NM", rs.getString("DTL_NM"));
				subObject.put("LOAN_RT", rs.getString("LOAN_RT"));
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

		} else if (V_TYPE.equals("ERP_DB")) {

			String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
			String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
			String V_DATE = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE").substring(0, 10);

// 			System.out.println(V_S_BP_CD);
// 			System.out.println(V_DATE);

			e_cs = e_conn.prepareCall("{call USP_HSPF_DB_SELECT(?,?)}");
			e_cs.setString(1, V_S_BP_CD);
			e_cs.setString(2, V_DATE);

			e_rs = e_cs.executeQuery();

			while (e_rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", e_rs.getObject("BP_CD"));
				subObject.put("BP_NM", e_rs.getObject("BP_NM"));
				subObject.put("BO_JAN_AMT", e_rs.getObject("DBB_JAN_AMT")); //보증서
				subObject.put("BU_JAN_AMT", e_rs.getObject("DBD_JAN_AMT")); //부동산
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

		} else if (V_TYPE.equals("ERP")) {

			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE").toUpperCase();

// 			System.out.println("U_TYPE" + U_TYPE);
			V_MAST_DB_NO = request.getParameter("V_MAST_DB_NO") == null ? "" : request.getParameter("V_MAST_DB_NO").toUpperCase();
			JSONObject anyObject = new JSONObject();
			JSONArray anyArray = new JSONArray();
			JSONObject anySubObject = new JSONObject();
			URL url = null;
			String result = null;
			String V_TEMP_GL_NO = "";

			/*담보생성/취소*/
			if (U_TYPE.equals("I") || U_TYPE.equals("D")) {
				url = new URL("http://123.142.124.155:8088/http/erp_db_insert");

				anySubObject.put("V_MAST_DB_NO", V_MAST_DB_NO);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anySubObject.put("V_TYPE", U_TYPE);

				/*결의전표생성/취소*/
			} else {
				V_TYPE = U_TYPE.substring(0, 1);

				cs = conn.prepareCall("call DISTR_TEMP_GL.USP_A_TEMP_DB(?,?,?,?,?)");

				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_MAST_DB_NO);//V_BL_NO
				cs.setString(4, V_USR_ID);//V_BL_SEQ
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				if (rs.next()) {
					V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
				}

				// 				System.out.println("V_TEMP_GL_NO" + V_TEMP_GL_NO);
				if (V_TEMP_GL_NO.contains("TG")) {
					if (V_TYPE.equals("I")) { //확정
						url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert");
					} else if (V_TYPE.equals("D")) { //확정취소
						url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel");
					}

					anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anySubObject.put("V_DB_ID", "sa");
					anySubObject.put("V_DB_PW", "hsnadmin");

					result = V_TEMP_GL_NO;
				}
			}

			URLConnection con = url.openConnection();
			con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
			con.setDoOutput(true);

			anyArray.add(anySubObject);
			anyObject.put("data", anyArray);
			String parameter = anyObject + "";

			// 			System.out.println(parameter);

			OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
			wr.write(parameter);
			wr.flush();

			BufferedReader rd = null;

			rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line = null;
			while ((line = rd.readLine()) != null) {
				result = URLDecoder.decode(line, "UTF-8");
			}

			// 			System.out.println(result);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(result);
			pw.flush();
			pw.close();

			String sql = "";
			String sql2 = "";
			if (U_TYPE.equals("I_GL")) {

				System.out.println("======================================================================");
				sql = "";
				sql += "INSERT                                                                         ";
				sql += "INTO   M_DB_GL_LIST                                                            ";
				sql += "       (                                                                       ";
				sql += "              DB_NO, TEMP_GL_NO, GL_DT, ITEM_LOC_AMT, ITEM_DESC, INSRT_USER_ID, ";
				sql += "              INSRT_DT                                                          ";
				sql += "       )                                                                        ";
				sql += "SELECT REF_NO, TEMP_GL_NO, TEMP_GL_DT, CR_AMT, TEMP_GL_DESC, '" + V_USR_ID + "',  ";
				sql += "       GETDATE()                                                     ";
				sql += "FROM   A_TEMP_GL A                                                   ";
				sql += "       JOIN M_DB_HDR B                                               ";
				sql += "       ON     A.REF_NO = B.DB_NO                                     ";
				sql += "WHERE  REF_NO          = '" + V_MAST_DB_NO + "'                           ";
				sql += "AND    B.DB_TYPE       in('A','B')                                         ";

				e_stmt.execute(sql);	
				sql2 += "UPDATE M_DB_HDR SET COLLATERAL_NO = '" + V_TEMP_GL_NO + "' WHERE DB_NO = '" + V_MAST_DB_NO + "'";
				e_stmt.execute(sql2);

// 				System.out.println(sql2);

			} else if (U_TYPE.equals("D_GL")) {
				System.out.println("======================================================================");
				sql += "DELETE FROM M_DB_GL_LIST ";
				sql += " WHERE TEMP_GL_NO =  '" + V_TEMP_GL_NO + "'        ";
				e_stmt.execute(sql);

				sql2 += "UPDATE M_DB_HDR SET COLLATERAL_NO = '' WHERE DB_NO = '" + V_MAST_DB_NO + "'";
				e_stmt.execute(sql2);

// 				System.out.println(sql);
// 				System.out.println(sql2);
			}

		} /*
			else if (V_TYPE.equals("ADD_COL_S")) {
			String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO").toUpperCase();
			System.out.println("V_MVMT_NO : " + V_MVMT_NO);

			cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_ADD_REF_DISTR(?,?,?)");
			cs.setString(1, V_COMP_ID);//V_TYPE
			cs.setString(2, V_MVMT_NO);//V_COMP_ID
			cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(3);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COL_TYPE", rs.getString("COL_TYPE"));
				subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("OLD_MAST_DB_NO", rs.getString("OLD_MAST_DB_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CONT_REMARK", rs.getString("CONT_REMARK"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

// 			System.out.println("jsonObject" + jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}*/
		 else if (V_TYPE.equals("ADD_COL_S")) { //통관전 입고관리 추가담보등록 클릭시 팝업 GR20191127  ADD_COL_S2
				String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
				
				cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_ADD_REF_DISTR(?,?,?)");
				cs.setString(1, V_COMP_ID);//V_TYPE
				cs.setString(2, V_BL_DOC_NO);//V_COMP_ID
				cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(3);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("COL_TYPE", rs.getString("COL_TYPE"));
					subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
					subObject.put("COL_NO", rs.getString("COL_NO"));
					subObject.put("OLD_MAST_DB_NO", rs.getString("OLD_MAST_DB_NO"));
					subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
					subObject.put("CONT_REMARK", rs.getString("CONT_REMARK"));
					subObject.put("ADD_COL_MAST_DB_NO", rs.getString("ADD_COL_MAST_DB_NO"));
					jsonArray.add(subObject);
				}

				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();

		 } else if (V_TYPE.equals("WD_COL")) {
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
			String V_CLS_AR_NO = request.getParameter("V_CLS_AR_NO") == null ? "" : request.getParameter("V_CLS_AR_NO").toUpperCase();
			String V_CLS_DT = request.getParameter("V_CLS_DT") == null ? "" : request.getParameter("V_CLS_DT").toString().substring(0, 10);
				
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
//	 					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
						String V_BC_NO = hashMap.get("BC_NO") == null ? "" : hashMap.get("BC_NO").toString();
//	 					String V_BC_TYPE = hashMap.get("BC_TYPE") == null ? "" : hashMap.get("BC_TYPE").toString();
						String V_AR_NO = hashMap.get("AR_NO") == null ? "" : hashMap.get("AR_NO").toString();
						String V_CLS_IN_AMT = hashMap.get("COL_AMT") == null ? "" : hashMap.get("COL_AMT").toString();
//	 					String V_CLS_OUT_AMT = hashMap.get("CLS_OUT_AMT") == null ? "" : hashMap.get("CLS_OUT_AMT").toString();
						String V_BAL_IN_AMT = hashMap.get("REMAIN_AMT") == null ? "" : hashMap.get("REMAIN_AMT").toString();
//	 					String V_BAL_OUT_AMT = hashMap.get("BAL_OUT_AMT") == null ? "" : hashMap.get("BAL_OUT_AMT").toString();

						cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
						cs.setString(4, V_BC_NO);//V_BC_NO
						cs.setString(5, "B");//V_BC_TYPE
						cs.setString(6, V_MAST_DB_NO);//V_AR_NO
						cs.setString(7, V_CLS_DT);//V_CLS_DT
						cs.setString(8, V_CUR);//V_CUR
						cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
						cs.setString(10, "");//V_CLS_OUT_AMT
						cs.setString(11, V_BAL_IN_AMT);//V_BAL_IN_AMT
						cs.setString(12, "");//V_BAL_OUT_AMT
						cs.setString(13, V_USR_ID);//V_USR_ID
						cs.setString(14, "");//V_SEQ
						if(!V_BC_NO.equals("")) cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}
				} else {
					JSONObject jsondata = JSONObject.fromObject(jsonData);
					
//	 				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
					String V_BC_NO = jsondata.get("BC_NO") == null ? "" : jsondata.get("BC_NO").toString();
//	 				String V_BC_TYPE = jsondata.get("BC_TYPE") == null ? "" : jsondata.get("BC_TYPE").toString();
					String V_AR_NO = jsondata.get("AR_NO") == null ? "" : jsondata.get("AR_NO").toString();
					String V_CLS_IN_AMT = jsondata.get("COL_AMT") == null ? "" : jsondata.get("COL_AMT").toString();
//	 				String V_CLS_OUT_AMT = jsondata.get("CLS_OUT_AMT") == null ? "" : jsondata.get("CLS_OUT_AMT").toString();
					String V_BAL_IN_AMT = jsondata.get("REMAIN_AMT") == null ? "" : jsondata.get("REMAIN_AMT").toString();
//	 				String V_BAL_OUT_AMT = jsondata.get("BAL_OUT_AMT") == null ? "" : jsondata.get("BAL_OUT_AMT").toString();

					cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
					cs.setString(4, V_BC_NO);//V_BC_NO
					cs.setString(5, "B");//V_BC_TYPE
					cs.setString(6, V_MAST_DB_NO);//V_AR_NO
					cs.setString(7, V_CLS_DT);//V_CLS_DT
					cs.setString(8, V_CUR);//V_CUR
					cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
					cs.setString(10, "");//V_CLS_OUT_AMT
					cs.setString(11, V_BAL_IN_AMT);//V_BAL_IN_AMT
					cs.setString(12, "");//V_BAL_OUT_AMT
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.setString(14, "");//V_SEQ
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

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

		//MSSQL
		if (e_cs != null) try {
			e_cs.close();
		} catch (SQLException ex) {}
		if (e_rs != null) try {
			e_rs.close();
		} catch (SQLException ex) {}
		if (e_stmt != null) try {
			e_stmt.close();
		} catch (SQLException ex) {}
		if (e_conn != null) try {
			e_conn.close();
		} catch (SQLException ex) {}
	}
%>


