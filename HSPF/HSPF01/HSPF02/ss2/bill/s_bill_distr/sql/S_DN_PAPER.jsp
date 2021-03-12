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

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


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
		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").toUpperCase().substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").toUpperCase().substring(0, 10);
		// 		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		// 		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		// 		String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO").toUpperCase();
		// 		String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").toUpperCase().substring(0, 10);
		// 		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase().substring(0, 10);
		// 		String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);

		//상단
		if (V_TYPE.equals("S1")) {

			cs = conn.prepareCall("call DISTR_SALES.USP_DN_PRINT(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_ITS_NO
			cs.setString(4, "");//V_ITS_NO
			cs.setString(5, "");//V_DN_DT
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("BL_CN_NO", rs.getString("BL_CN_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ITEM_NM2", rs.getString("ITEM_NM2"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));

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

			String V_DN_NO = request.getParameter("V_DN_NO") == null ? "" : request.getParameter("V_DN_NO").toUpperCase();
			String V_DN_SEQ = "";

			// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_ITS_NO = hashMap.get("ITS_NO") == null ? "" : hashMap.get("ITS_NO").toString();
					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_SALE_TYPE = hashMap.get("SALE_TYPE") == null ? "" : hashMap.get("SALE_TYPE").toString();
					String V_DN_CUR = hashMap.get("DN_CUR") == null ? "" : hashMap.get("DN_CUR").toString();
					String V_DN_XCHG_RT = hashMap.get("DN_XCHG_RT") == null ? "" : hashMap.get("DN_XCHG_RT").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();
					String V_REQ_QTY = hashMap.get("REQ_QTY") == null ? "" : hashMap.get("REQ_QTY").toString();
					String V_SPEC = hashMap.get("SPEC") == null ? "" : hashMap.get("SPEC").toString();
					String V_UNIT = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
					String V_DN_BOX_QTY = hashMap.get("REQ_BOX_QTY") == null ? "" : hashMap.get("REQ_BOX_QTY").toString();
					String V_DN_BOX_WGT_UNIT = hashMap.get("DN_BOX_WGT_UNIT") == null ? "" : hashMap.get("DN_BOX_WGT_UNIT").toString();
					String V_DN_REAL_QTY = hashMap.get("DN_REAL_QTY") == null ? "" : hashMap.get("DN_REAL_QTY").toString();
					String V_DN_PRC = hashMap.get("DN_PRC") == null ? "" : hashMap.get("DN_PRC").toString();
					String V_DN_AMT = hashMap.get("DN_AMT") == null ? "" : hashMap.get("DN_AMT").toString();
					String V_DN_LOC_AMT = hashMap.get("DN_LOC_AMT") == null ? "" : hashMap.get("DN_LOC_AMT").toString();
					String V_SALE_ISSUE_DT = hashMap.get("ISSUE_DT") == null ? "" : hashMap.get("ISSUE_DT").toString().substring(0, 10);
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					// 					V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					// 					String V_DN_FINAL_AMT = hashMap.get("DN_TOTAL_AMT") == null ? "" : hashMap.get("DN_FINAL_AMT").toString();

					// 					String V_ADD_DN_AMT = hashMap.get("ADD_DN_AMT") == null ? "" : hashMap.get("ADD_DN_AMT").toString();

					// 					if (!V_TYPE.equals("IH") && !V_TYPE.equals("ID")) {
					// 						V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
					// 						V_DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString();
					// 						V_DN_DT = hashMap.get("DN_DT") == null ? "" : hashMap.get("DN_DT").toString().substring(0, 10);
					// 					}

					cs = conn.prepareCall("call DISTR_MD.USP_M_GR_TO_DN_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_ITS_NO);//V_ITS_NO
					cs.setString(4, V_MVMT_DT_FR);//V_MVMT_DT_FR
					cs.setString(5, V_MVMT_DT_TO);//V_DN_DT
					// 					cs.setString(6, V_DN_DT);//V_DN_DT
					cs.setString(7, V_DN_NO);//V_DN_NO
					cs.setString(8, V_DN_SEQ);//V_DN_SEQ
					cs.setString(9, V_S_BP_CD);//V_S_BP_CD
					cs.setString(10, V_SALE_TYPE);//V_SALE_TYPE
					cs.setString(11, V_DN_CUR);//V_CUR
					cs.setString(12, V_DN_XCHG_RT);//V_DN_XCHG_RT
					cs.setString(13, V_ITEM_CD);//V_ITEM_CD

					String DN_QTY = "";
					if (V_TYPE.equals("ID")) {
						DN_QTY = V_REQ_QTY;
					} else {
						DN_QTY = V_DN_QTY;
					}
					cs.setString(14, DN_QTY);//V_DN_BOX_QTY
					cs.setString(15, V_DN_BOX_QTY);//V_DN_BOX_QTY
					cs.setString(16, V_DN_BOX_WGT_UNIT);//V_DN_BOX_WGT_UNIT
					cs.setString(17, V_DN_REAL_QTY);//V_DN_REAL_QTY
					cs.setString(18, V_DN_PRC);//V_DN_PRC
					cs.setString(19, V_DN_AMT);//V_DN_AMT
					cs.setString(20, V_DN_LOC_AMT);//V_DN_LOC_AMT
					cs.setString(21, V_SALE_ISSUE_DT);//V_SALE_ISSUE_DT
					cs.setString(22, V_REMARK);//V_REMARK
					// 					cs.setString(23, V_MVMT_NO);//V_MVMT_NO
					// 					cs.setString(24, V_LC_DOC_NO);//V_LC_DOC_NO
					// 					cs.setString(25, V_BL_DOC_NO);//V_BL_DOC_NO
					// 					cs.setString(26, V_USR_ID);//V_USR_ID
					// 					cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
					// 					cs.setString(28, "");//V_FIRST_YN
					// 					cs.setString(29, V_DN_FINAL_AMT);//V_DN_FINAL_AMT
					// 					cs.setString(30, V_ADD_DN_AMT);//V_ADD_DN_AMT
					cs.executeQuery();

					// 					System.out.println("V_MVMT_NO :" + V_MVMT_NO);
					// 					System.out.println("V_DN_QTY :" + DN_QTY);
					// 					System.out.println("V_DN_DT :" + V_DN_DT);
					// 					System.out.println("======================");

					// 					cs2 = conn.prepareCall("call DISTR_DN.USP_DN_ABOUT_CALC(?,?,?,?,?,?,?,?)");

					// 					cs2.setString(1, "I");//V_COMP_ID
					// 					cs2.setString(2, V_COMP_ID);//MVMT_NO
					// 					cs2.setString(3, V_MVMT_NO);//V_MVMT_NO
					// 					cs2.setString(4, DN_QTY);//V_MVMT_NO
					// 					cs2.setString(5, V_DN_DT);//V_MVMT_NO
					// 					cs2.setString(6, V_DN_NO);//V_DN_NO
					// 					cs2.setString(7, V_USR_ID);//V_MVMT_NO
					// 					cs2.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
					// 					cs2.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_ITS_NO = jsondata.get("ITS_NO") == null ? "" : jsondata.get("ITS_NO").toString();
				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_SALE_TYPE = jsondata.get("SALE_TYPE") == null ? "" : jsondata.get("SALE_TYPE").toString();
				String V_DN_CUR = jsondata.get("DN_CUR") == null ? "" : jsondata.get("DN_CUR").toString();
				String V_DN_XCHG_RT = jsondata.get("DN_XCHG_RT") == null ? "" : jsondata.get("DN_XCHG_RT").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();
				String V_REQ_QTY = jsondata.get("REQ_QTY") == null ? "" : jsondata.get("REQ_QTY").toString();
				String V_SPEC = jsondata.get("SPEC") == null ? "" : jsondata.get("SPEC").toString();
				String V_UNIT = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
				String V_DN_BOX_QTY = jsondata.get("REQ_BOX_QTY") == null ? "" : jsondata.get("REQ_BOX_QTY").toString();
				String V_DN_BOX_WGT_UNIT = jsondata.get("DN_BOX_WGT_UNIT") == null ? "" : jsondata.get("DN_BOX_WGT_UNIT").toString();
				String V_DN_REAL_QTY = jsondata.get("DN_REAL_QTY") == null ? "" : jsondata.get("DN_REAL_QTY").toString();
				String V_DN_PRC = jsondata.get("DN_PRC") == null ? "" : jsondata.get("DN_PRC").toString();
				String V_DN_AMT = jsondata.get("DN_AMT") == null ? "" : jsondata.get("DN_AMT").toString();
				String V_DN_LOC_AMT = jsondata.get("DN_LOC_AMT") == null ? "" : jsondata.get("DN_LOC_AMT").toString();
				// 				String V_SALE_ISSUE_DT = jsondata.get("ISSUE_DT") == null ? "" : jsondata.get("ISSUE_DT").toString().substring(0, 10);
				// 				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				// 				V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				// 				String V_DN_FINAL_AMT = jsondata.get("DN_TOTAL_AMT") == null ? "" : jsondata.get("DN_FINAL_AMT").toString();
				// 				String V_ADD_DN_AMT = jsondata.get("ADD_DN_AMT") == null ? "" : jsondata.get("ADD_DN_AMT").toString();

				// 				if (!V_TYPE.equals("IH") && !V_TYPE.equals("ID")) {
				// 					V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
				// 					V_DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString();
				// 					V_DN_DT = jsondata.get("DN_DT") == null ? "" : jsondata.get("DN_DT").toString().substring(0, 10);
				// 				}

				// 				System.out.println("V_MVMT_NO :" + V_MVMT_NO);
				// 				System.out.println("V_DN_QTY :" + V_DN_QTY);
				// 				System.out.println("V_DN_DT :" + V_DN_DT);
				// 				System.out.println("======================");

				cs = conn.prepareCall("call DISTR_MD.USP_M_GR_TO_DN_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_ITS_NO);//V_ITS_NO
				cs.setString(4, V_MVMT_DT_FR);//V_MVMT_DT_FR
				cs.setString(5, V_MVMT_DT_TO);//V_DN_DT
				// 				cs.setString(6, V_DN_DT);//V_DN_DT
				cs.setString(7, V_DN_NO);//V_DN_NO
				cs.setString(8, V_DN_SEQ);//V_DN_SEQ
				cs.setString(9, V_S_BP_CD);//V_S_BP_CD
				cs.setString(10, V_SALE_TYPE);//V_SALE_TYPE
				cs.setString(11, V_DN_CUR);//V_CUR
				cs.setString(12, V_DN_XCHG_RT);//V_DN_XCHG_RT
				cs.setString(13, V_ITEM_CD);//V_ITEM_CD

				String DN_QTY = "";
				if (V_TYPE.equals("ID")) {
					DN_QTY = V_REQ_QTY;
				} else {
					DN_QTY = V_DN_QTY;
				}

				cs.setString(14, DN_QTY);//V_DN_BOX_QTY
				cs.setString(15, V_DN_BOX_QTY);//V_DN_BOX_QTY
				cs.setString(16, V_DN_BOX_WGT_UNIT);//V_DN_BOX_WGT_UNIT
				cs.setString(17, V_DN_REAL_QTY);//V_DN_REAL_QTY
				cs.setString(18, V_DN_PRC);//V_DN_PRC
				cs.setString(19, V_DN_AMT);//V_DN_AMT
				cs.setString(20, V_DN_LOC_AMT);//V_DN_LOC_AMT
				// 				cs.setString(21, V_SALE_ISSUE_DT);//V_SALE_ISSUE_DT
				// 				cs.setString(22, V_REMARK);//V_REMARK
				// 				cs.setString(23, V_MVMT_NO);//V_MVMT_NO
				// 				cs.setString(24, V_LC_DOC_NO);//V_LC_DOC_NO
				// 				cs.setString(25, V_BL_DOC_NO);//V_BL_DOC_NO
				// 				cs.setString(26, V_USR_ID);//V_USR_ID
				// 				cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
				// 				cs.setString(28, "");//V_FIRST_YN
				// 				cs.setString(29, V_DN_FINAL_AMT);//V_DN_FINAL_AMT
				// 				cs.setString(30, V_ADD_DN_AMT);//V_ADD_DN_AMT
				// 				cs.executeQuery();

				// 				System.out.println("V_DN_AMT :" + V_DN_AMT);
				// 				System.out.println("V_DN_LOC_AMT :" + V_DN_LOC_AMT);
				// 				System.out.println("======================");

				// 				cs2 = conn.prepareCall("call DISTR_DN.USP_DN_ABOUT_CALC(?,?,?,?,?,?,?,?)");

				// 				cs2.setString(1, "I");//V_COMP_ID
				// 				cs2.setString(2, V_COMP_ID);//MVMT_NO
				// 				cs2.setString(3, V_MVMT_NO);//V_MVMT_NO
				// 				cs2.setString(4, DN_QTY);//V_MVMT_NO
				// 				cs2.setString(5, V_DN_DT);//V_MVMT_NO
				// 				cs2.setString(6, V_DN_NO);//V_DN_NO
				// 				cs2.setString(7, V_USR_ID);//V_MVMT_NO
				// 				cs2.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				// 				cs2.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
		} else if (V_TYPE.equals("IH")) {

			// 			V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);

			// 			cs = conn.prepareCall("call DISTR_MD.USP_M_GR_TO_DN_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			// 			cs.setString(1, V_COMP_ID);//V_COMP_ID
			// 			cs.setString(2, V_TYPE);//V_TYPE
			// 			cs.setString(3, "");//V_ITS_NO
			// 			cs.setString(4, "");//V_MVMT_DT_FR
			// 			cs.setString(5, "");//V_MVMT_DT_TO
			// 			cs.setString(6, V_DN_DT);//V_DN_DT
			// 			cs.setString(7, "");//V_DN_NO
			// 			cs.setString(8, "");//V_DN_SEQ
			cs.setString(9, "");//V_S_BP_CD
			cs.setString(10, "");//V_SALE_TYPE
			cs.setString(11, "");//V_CUR
			cs.setString(12, "");//V_DN_XCHG_RT
			cs.setString(13, "");//V_ITEM_CD
			cs.setString(14, "");//V_DN_QTY
			cs.setString(15, "");//V_DN_BOX_QTY
			cs.setString(16, "");//V_DN_BOX_WGT_UNIT
			cs.setString(17, "");//V_DN_REAL_QTY
			cs.setString(18, "");//V_DN_PRC
			cs.setString(19, "");//V_DN_AMT
			cs.setString(20, "");//V_DN_LOC_AMT
			cs.setString(21, "");//V_SALE_ISSUE_DT
			cs.setString(22, "");//V_REMARK
			cs.setString(23, "");//V_MVMT_NO
			cs.setString(24, "");//V_LC_DOC_NO
			cs.setString(25, "");//V_BL_DOC_NO
			cs.setString(26, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, "");//V_FIRST_YN
			cs.setString(29, "");//V_FIRST_YN
			cs.setString(30, "");//V_FIRST_YN
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(27);
			String DN_NO = "";

			while (rs.next()) {
				DN_NO = rs.getString("DN_NO");
			}

			System.out.println("IH)DN_NO" + DN_NO);
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(DN_NO);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("DN_RECEIPT")) {

			// 			String V_DN_QTY = request.getParameter("V_DN_QTY") == null ? "" : request.getParameter("V_DN_QTY").toUpperCase();
			// 			V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);
			// 			V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO").toUpperCase();
			// 			String V_ADD_DN_AMT = request.getParameter("V_ADD_DN_AMT") == null ? "" : request.getParameter("V_ADD_DN_AMT").toUpperCase();

			// 			System.out.println("V_MVMT_NO :" + V_MVMT_NO);
			// 			System.out.println("V_DN_QTY :" + V_DN_QTY);
			// 			System.out.println("V_DN_DT :" + V_DN_DT);
			// 			System.out.println("======================");

			cs2 = conn.prepareCall("call DISTR_DN.USP_DN_ABOUT_CALC(?,?,?,?,?,?,?,?)");

			cs2.setString(1, "S");//V_COMP_ID
			cs2.setString(2, V_COMP_ID);//MVMT_NO
			// 			cs2.setString(3, V_MVMT_NO);//V_MVMT_NO
			// 			cs2.setString(4, V_DN_QTY);//V_MVMT_NO
			// 			cs2.setString(5, V_DN_DT);//V_MVMT_NO
			// 			cs2.setString(6, V_ADD_DN_AMT);//V_ADD_DN_AMT
			cs2.setString(7, V_USR_ID);//V_MVMT_NO
			cs2.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs2.executeQuery();

			rs = (ResultSet) cs2.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("DN_CL_NO", rs.getString("DN_CL_NO"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("MVMT_QTY", rs.getString("MVMT_QTY"));
				subObject.put("MVMT_AMT", rs.getString("MVMT_AMT"));
				subObject.put("DISTB_AMT", rs.getString("DISTB_AMT"));
				subObject.put("LC_OPEN_AMT", rs.getString("LC_OPEN_AMT"));
				subObject.put("LC_AMEND_AMT", rs.getString("LC_AMEND_AMT"));
				subObject.put("ETC_AMT_1", rs.getString("ETC_AMT_1"));
				subObject.put("INSUR_AMT", rs.getString("INSUR_AMT"));
				subObject.put("DISTR_CC_AMT", rs.getString("DISTR_CC_AMT"));
				subObject.put("TAX_AMT", rs.getString("TAX_AMT"));
				subObject.put("DISTR_CC_AMT", rs.getString("DISTR_CC_AMT"));
				subObject.put("REC_AMT", rs.getString("REC_AMT"));
				subObject.put("ETC_AMT_2", rs.getString("ETC_AMT_2"));
				subObject.put("COGS_AMT", rs.getString("COGS_AMT"));
				subObject.put("ST_AMT", rs.getString("ST_AMT"));
				subObject.put("IO_AMT", rs.getString("IO_AMT"));
				subObject.put("JOB_AMT", rs.getString("JOB_AMT"));
				subObject.put("WT_AMT", rs.getString("WT_AMT"));
				subObject.put("CK_AMT", rs.getString("CK_AMT"));
				subObject.put("AP_AMT", rs.getString("AP_AMT"));
				subObject.put("MV_AMT", rs.getString("MV_AMT"));
				subObject.put("PR_OV_AMT", rs.getString("PR_OV_AMT"));
				subObject.put("MG_RT", rs.getString("MG_RT"));
				subObject.put("MG_AMT", rs.getString("MG_AMT"));
				subObject.put("DN_COGS_AMT", rs.getString("DN_COGS_AMT"));
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("DN_SUM_AMT", rs.getString("DN_SUM_AMT"));

				subObject.put("COGS_AMT2", rs.getString("COGS_AMT2"));
				subObject.put("COGS_PRC", rs.getString("COGS_PRC"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("ADD_DN_AMT", rs.getString("ADD_DN_AMT"));

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
		} else if (V_TYPE.equals("DN_CALC")) {

			String DN_QTY = request.getParameter("V_DN_QTY") == null ? "" : request.getParameter("V_DN_QTY").toUpperCase();
			String V_ADD_DN_AMT = request.getParameter("V_ADD_DN_AMT") == null ? "" : request.getParameter("V_ADD_DN_AMT").toUpperCase();

			cs2 = conn.prepareCall("call DISTR_DN.USP_DN_ABOUT_CALC(?,?,?,?,?,?,?,?)");
			cs2.setString(1, "I");//V_COMP_ID
			cs2.setString(2, V_COMP_ID);//MVMT_NO
			// 			cs2.setString(3, V_MVMT_NO);//V_MVMT_NO
			// 			cs2.setString(4, DN_QTY);//V_MVMT_NO
			// 			cs2.setString(5, V_DN_DT);//V_MVMT_NO
			// 			cs2.setString(6, V_ADD_DN_AMT);//V_ADD_DN_AMT
			cs2.setString(7, V_USR_ID);//V_MVMT_NO
			cs2.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs2.executeQuery();

			rs = (ResultSet) cs2.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
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


