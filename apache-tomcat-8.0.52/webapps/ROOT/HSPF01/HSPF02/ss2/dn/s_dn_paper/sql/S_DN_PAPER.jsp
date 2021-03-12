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

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.internet.MimeBodyPart"%>
<%@ page import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.mail.BodyPart"%>
<%@ page import="javax.mail.Multipart"%>


<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	CallableStatement cs3 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").toUpperCase().substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").toUpperCase().substring(0, 10);
		String V_DN_REQ_DT = request.getParameter("V_DN_REQ_DT") == null ? "" : request.getParameter("V_DN_REQ_DT").toUpperCase().substring(0, 10);
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();

		//상단
		if (V_TYPE.equals("S1")) {

			cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DN_REQ_DT);//V_DN_DT_FR
			cs.setString(4, "");//V_DN_DT_TO
			cs.setString(5, V_S_BP_NM);//V_S_BP_NM
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
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("CUSTOM_REQ_FLAG", rs.getString("CUSTOM_REQ_FLAG"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			//출고요청서 번호 채번
		} else if (V_TYPE.equals("A")) {

			cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_DN_NO
			cs.setString(4, "");//V_DN_SEQ
			cs.setString(5, V_DN_REQ_DT);//V_DN_REQ_DT
			cs.setString(6, "");//V_DN_REQ_NO
			cs.setString(7, "");//V_PRINT_NO
			cs.setString(8, "");//V_BLCN_NO
			cs.setString(9, "");//VV_BLCN_NO
			cs.setString(10, "");//V_REMARK
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_REMARK
			cs.setString(14, "");//V_REMARK
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			String DN_PRINT_NO = "";

			while (rs.next()) {
				DN_PRINT_NO = rs.getString("V_DN_PRINT_NO");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(DN_PRINT_NO);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			String V_PRINT_NO = "";
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_DN_REQ_DT = request.getParameter("V_DN_REQ_DT") == null ? "" : request.getParameter("V_DN_REQ_DT").toUpperCase().substring(0, 10);
					if (V_TYPE.equals("I")) {
						V_PRINT_NO = request.getParameter("V_PRINT_NO") == null ? "" : request.getParameter("V_PRINT_NO").toUpperCase();
					} else {
						V_PRINT_NO = hashMap.get("PRINT_NO") == null ? "" : hashMap.get("PRINT_NO").toString().toUpperCase();
					}
					String V_BLCN_NO = hashMap.get("BL_CN_NO") == null ? "" : hashMap.get("BL_CN_NO").toString().toUpperCase();
					String V_ITEM_NM2 = hashMap.get("ITEM_NM2") == null ? "" : hashMap.get("ITEM_NM2").toString().toUpperCase();
					String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString().toUpperCase();
					String V_DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString().toUpperCase();
					String V_DN_REQ_NO = hashMap.get("DN_REQ_NO") == null ? "" : hashMap.get("DN_REQ_NO").toString().toUpperCase();
					String V_DN_TYPE = hashMap.get("DN_TYPE") == null ? "" : hashMap.get("DN_TYPE").toString().toUpperCase();
					String V_DN_REAL_QTY = hashMap.get("DN_REAL_QTY") == null ? "" : hashMap.get("DN_REAL_QTY").toString().toUpperCase();
					String V_SALE_ISSUE_DT = hashMap.get("SALE_ISSUE_DT") == null ? "" : hashMap.get("SALE_ISSUE_DT").toString().substring(0, 10);
					String V_ADD_DN_AMT = hashMap.get("ADD_DN_AMT") == null ? "" : hashMap.get("ADD_DN_AMT").toString();
					String V_ADD_DN_PRC = hashMap.get("ADD_DN_PRC") == null ? "" : hashMap.get("ADD_DN_PRC").toString();
					String V_REASON = hashMap.get("REASON") == null ? "" : hashMap.get("REASON").toString();

					if (V_TYPE.equals("T2D_U")) { //탭2의 추가매출수정
						V_REASON = hashMap.get("ADD_REASON") == null ? "" : hashMap.get("ADD_REASON").toString();
					}

					if (V_TYPE.equals("RE_CALC")) { //탭3의 출고확정
						String V_DN_REQ_NO_RC = "";
						cs = conn.prepareCall("call USP_DN_PRINT_CHECK(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, "CF");//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_PRINT_NO);//V_DN_NO
						cs.setString(4, V_DN_TYPE);//V_DN_SEQ
						cs.setString(5, V_USR_ID);//V_DN_SEQ
						cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(7, V_DN_NO);//V_DN_NO
						cs.setString(8, V_DN_SEQ);//V_DN_SEQ
						cs.setString(9, V_DN_REAL_QTY);//V_DN_REAL_QTY
						cs.setString(10, V_SALE_ISSUE_DT);//V_SALE_ISSUE_DT
						cs.setString(11, V_ADD_DN_AMT);//V_SALE_ISSUE_DT
						cs.setString(12, V_REASON);//V_REASON
						cs.setString(13, V_DN_REQ_NO_RC);//V_DN_REQ_NO
						cs.setString(14, V_DN_REQ_DT);//V_USR_ID
						cs.executeQuery();

						/*계산LOG남기기*/
						/*계산LOG남기기*/
						/*계산LOG남기기*/
						String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						String V_DN_BOX_QTY = hashMap.get("DN_BOX_QTY") == null ? "" : hashMap.get("DN_BOX_QTY").toString();
						String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();

						String V_BS_DT = V_DN_REQ_DT;
						String V_BS_BOX_QTY = V_DN_BOX_QTY;
						String V_BS_QTY = V_DN_REAL_QTY;
						String V_BAS_STEP = "S2";

						rs = (ResultSet) cs.getObject(6);

						String V_BAS_NO = "NO";
						while (rs.next()) {
							V_BAS_NO = rs.getString("BAS_NO");
						}

/* 						System.out.println("+++++++++V_BAS_NO" + V_BAS_NO);
						System.out.println("+++++++++V_BAS_STEP" + V_BAS_STEP);

						System.out.println("V_COMP_ID" + V_COMP_ID);
						System.out.println("V_TYPE" + V_TYPE);
						System.out.println("V_BS_DT" + V_BS_DT);
						System.out.println("V_BS_BOX_QTY" + V_BS_BOX_QTY);
						System.out.println("V_BS_QTY" + V_BS_QTY);
						System.out.println("V_BAS_STEP" + V_BAS_STEP);
						System.out.println("V_BAS_NO" + V_BAS_NO);
						System.out.println("V_MVMT_NO" + V_MVMT_NO);
						System.out.println("V_ITEM_CD" + V_ITEM_CD); */

						if (!V_BAS_NO.equals("NO")) {
							cs = conn.prepareCall("call USP_Z_A_LOG_DISTR(?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, V_COMP_ID);
							cs.setString(2, "I");
							cs.setString(3, V_BS_DT);
							cs.setString(4, V_BS_BOX_QTY);
							cs.setString(5, V_BS_QTY);
							cs.setString(6, V_BAS_NO);
							cs.setString(7, V_BAS_STEP);
							cs.setString(8, V_ITEM_CD);
							cs.setString(9, V_MVMT_NO);
							cs.setString(10, V_USR_ID);
							cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
							cs.executeQuery();
						}
					} else if (V_TYPE.equals("REMARK")) { /*탭2 입금비고등록*/
						String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
						String V_CHECK_YN = hashMap.get("CHECK_YN") == null ? "N" : hashMap.get("CHECK_YN").toString() == "true" ? "Y" : "N";/*GR20191219*/
						

						cs = conn.prepareCall("call DISTR_SALES2.USP_S_DN_PR_REMARK(?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_PRINT_NO);//V_DN_NO
						cs.setString(4, V_REMARK);//V_DN_SEQ
						cs.setString(5, V_CHECK_YN);//V_DN_SEQ
						cs.setString(6, V_USR_ID);//V_DN_REQ_DT
						cs.executeQuery();

					} else {
						cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_DN_NO);//V_DN_NO
						cs.setString(4, V_DN_SEQ);//V_DN_SEQ
						cs.setString(5, V_DN_REQ_DT);//V_DN_REQ_DT
						cs.setString(6, V_DN_REQ_NO);//V_DN_REQ_NO
						cs.setString(7, V_PRINT_NO);//V_PRINT_NO
						cs.setString(8, V_BLCN_NO);//V_BLCN_NO
						cs.setString(9, V_ITEM_NM2);//V_ITEM_NM2
						cs.setString(10, V_REASON);//V_REMARK
						cs.setString(11, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(13, V_ADD_DN_PRC);//V_ADD_DN_PRC
						cs.setString(14, V_ADD_DN_AMT);//V_ADD_DN_AMT
						cs.executeQuery();

					}

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				
				if (V_TYPE.equals("I")) {
					V_PRINT_NO = request.getParameter("V_PRINT_NO") == null ? "" : request.getParameter("V_PRINT_NO").toUpperCase();
					V_DN_REQ_DT = request.getParameter("V_DN_REQ_DT") == null ? "" : request.getParameter("V_DN_REQ_DT").toUpperCase().substring(0, 10);
				} else {
					V_PRINT_NO = jsondata.get("PRINT_NO") == null ? "" : jsondata.get("PRINT_NO").toString().toUpperCase();
				}
				String V_BLCN_NO = jsondata.get("BL_CN_NO") == null ? "" : jsondata.get("BL_CN_NO").toString().toUpperCase();
				String V_ITEM_NM2 = jsondata.get("ITEM_NM2") == null ? "" : jsondata.get("ITEM_NM2").toString().toUpperCase();
				String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString().toUpperCase();
				String V_DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString().toUpperCase();
				String V_DN_REQ_NO = jsondata.get("DN_REQ_NO") == null ? "" : jsondata.get("DN_REQ_NO").toString().toUpperCase();
				String V_DN_TYPE = jsondata.get("DN_TYPE") == null ? "" : jsondata.get("DN_TYPE").toString().toUpperCase();
				String V_DN_REAL_QTY = jsondata.get("DN_REAL_QTY") == null ? "" : jsondata.get("DN_REAL_QTY").toString().toUpperCase();
				String V_SALE_ISSUE_DT = jsondata.get("SALE_ISSUE_DT") == null ? "" : jsondata.get("SALE_ISSUE_DT").toString().substring(0, 10);
				String V_ADD_DN_AMT = jsondata.get("ADD_DN_AMT") == null ? "" : jsondata.get("ADD_DN_AMT").toString();
				String V_ADD_DN_PRC = jsondata.get("ADD_DN_PRC") == null ? "" : jsondata.get("ADD_DN_PRC").toString();
				String V_REASON = jsondata.get("REASON") == null ? "" : jsondata.get("REASON").toString();

				if (V_TYPE.equals("T2D_U")) { //탭2의 추가매출수정
					V_REASON = jsondata.get("ADD_REASON") == null ? "" : jsondata.get("ADD_REASON").toString();
				}

				if (V_TYPE.equals("RE_CALC")) {

					String V_DN_REQ_NO_RC = "";

					cs = conn.prepareCall("call USP_DN_PRINT_CHECK(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "CF");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_PRINT_NO);//V_DN_NO
					cs.setString(4, V_DN_TYPE);//V_DN_SEQ
					cs.setString(5, V_USR_ID);//V_DN_SEQ
					cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(7, V_DN_NO);//V_DN_NO
					cs.setString(8, V_DN_SEQ);//V_DN_SEQ
					cs.setString(9, V_DN_REAL_QTY);//V_DN_REAL_QTY
					cs.setString(10, V_SALE_ISSUE_DT);//V_SALE_ISSUE_DT
					cs.setString(11, V_ADD_DN_AMT);//V_SALE_ISSUE_DT
					cs.setString(12, V_REASON);//V_REASON
					cs.setString(13, V_DN_REQ_NO_RC);//V_DN_REQ_NO
					cs.setString(14, V_DN_REQ_DT);//V_USR_ID
					cs.executeQuery();

					/*계산LOG남기기*/
					/*계산LOG남기기*/
					/*계산LOG남기기*/
					String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					String V_DN_BOX_QTY = jsondata.get("DN_BOX_QTY") == null ? "" : jsondata.get("DN_BOX_QTY").toString();
					String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();

					String V_BS_DT = V_DN_REQ_DT;
					String V_BS_BOX_QTY = V_DN_BOX_QTY;
					String V_BS_QTY = V_DN_REAL_QTY;
					String V_BAS_STEP = "S2";

					rs = (ResultSet) cs.getObject(6);

					String V_BAS_NO = "NO";
					while (rs.next()) {
						V_BAS_NO = rs.getString("BAS_NO");
					}

/* 					System.out.println("+++++++++V_BAS_NO" + V_BAS_NO);
					System.out.println("+++++++++V_BAS_STEP" + V_BAS_STEP);

					System.out.println("V_COMP_ID" + V_COMP_ID);
					System.out.println("V_TYPE" + V_TYPE);
					System.out.println("V_BS_DT" + V_BS_DT);
					System.out.println("V_BS_BOX_QTY" + V_BS_BOX_QTY);
					System.out.println("V_BS_QTY" + V_BS_QTY);
					System.out.println("V_BAS_STEP" + V_BAS_STEP);
					System.out.println("V_BAS_NO" + V_BAS_NO);
					System.out.println("V_MVMT_NO" + V_MVMT_NO);
					System.out.println("V_ITEM_CD" + V_ITEM_CD); */

					if (!V_BAS_NO.equals("NO")) {
						cs = conn.prepareCall("call USP_Z_A_LOG_DISTR(?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);
						cs.setString(2, "I");
						cs.setString(3, V_BS_DT);
						cs.setString(4, V_BS_BOX_QTY);
						cs.setString(5, V_BS_QTY);
						cs.setString(6, V_BAS_NO);
						cs.setString(7, V_BAS_STEP);
						cs.setString(8, V_ITEM_CD);
						cs.setString(9, V_MVMT_NO);
						cs.setString(10, V_USR_ID);
						cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}

				} else if (V_TYPE.equals("REMARK")) { /*탭2 입금비고등록*/
					String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
					String V_CHECK_YN = jsondata.get("CHECK_YN") == null ? "N" : jsondata.get("CHECK_YN").toString() == "true" ? "Y" : "N";/*GR20191219*/
					
					/*
					String V_CHECK_YN = jsondata.get("V_CHECK_YN") == null ? "" : jsondata.get("V_CHECK_YN").toString();
					
					if (V_CHECK_YN.equals("true") || V_CHECK_YN.equals("Y")) {
						V_CHECK_YN = "Y";
					} else {
						V_CHECK_YN = "N";
					}
					*/

					cs = conn.prepareCall("call DISTR_SALES2.USP_S_DN_PR_REMARK(?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_PRINT_NO);//V_DN_NO
					cs.setString(4, V_REMARK);//V_DN_SEQ
					cs.setString(5, V_CHECK_YN);//V_DN_SEQ
					cs.setString(6, V_USR_ID);//V_DN_REQ_DT
					cs.executeQuery();
					

				} else {
					cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_DN_NO);//V_DN_NO
					cs.setString(4, V_DN_SEQ);//V_DN_SEQ
					cs.setString(5, V_DN_REQ_DT);//V_DN_REQ_DT
					cs.setString(6, V_DN_REQ_NO);//V_DN_REQ_NO
					cs.setString(7, V_PRINT_NO);//V_PRINT_NO
					cs.setString(8, V_BLCN_NO);//V_BLCN_NO
					cs.setString(9, V_ITEM_NM2);//V_ITEM_NM2
					cs.setString(10, V_REASON);//V_REMARK
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(13, V_ADD_DN_PRC);//V_ADD_DN_PRC
					cs.setString(14, V_ADD_DN_AMT);//V_ADD_DN_AMT
					cs.executeQuery();
				}
			}
			//탭2 조회
		} else if (V_TYPE.equals("T2H")) {
		  
			cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_S_BP_NM);//V_DN_NO
			cs.setString(4, "");//V_DN_SEQ
			cs.setString(5, V_DN_REQ_DT);//V_DN_REQ_DT
			cs.setString(6, "");//V_DN_REQ_NO
			cs.setString(7, "");//V_PRINT_NO
			cs.setString(8, "");//V_BLCN_NO
			cs.setString(9, "");//V_BLCN_NO
			cs.setString(10, "");//V_REMARK
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_REMARK
			cs.setString(14, "");//V_REMARK
			cs.executeQuery();

/* 			System.out.println("V_TYPE : " + V_TYPE);
			System.out.println("V_S_BP_NM : " + V_S_BP_NM);
			System.out.println("V_DN_REQ_DT : " + V_DN_REQ_DT);
			System.out.println("V_TYPE : " + V_TYPE); */

			
			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CHK", rs.getString("CHK"));
				subObject.put("PRINT_NO", rs.getString("PRINT_NO"));
				subObject.put("DN_TYPE", rs.getString("DN_TYPE"));
				subObject.put("DN_REQ_NO", rs.getString("DN_REQ_NO"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("REQ_CFM_USER", rs.getString("REQ_CFM_USER"));
				subObject.put("NAME1", rs.getString("NAME1"));
				subObject.put("NAME2", rs.getString("NAME2"));
				subObject.put("REQ_CFM_EMAIL", rs.getString("REQ_CFM_EMAIL"));
				subObject.put("EMAIL", rs.getString("EMAIL"));
				subObject.put("REQ_CFM_YN", rs.getString("REQ_CFM_YN"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("CHECK_YN", rs.getString("CHECK_YN").equals("N") ? false : true); /** GR20191220**/
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("BILL_YN", rs.getString("BILL_YN"));
				subObject.put("POST_FLAG", rs.getString("POST_FLAG"));
				subObject.put("FILES", rs.getString("FILES"));
				subObject.put("INCOME_PLAN_DT", rs.getString("INCOME_PLAN_DT"));
				subObject.put("MAIL_YN", rs.getString("MAIL_YN"));
				subObject.put("IN_AMT", rs.getString("IN_AMT"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("T2D")) {

			V_DN_REQ_DT = request.getParameter("V_DN_REQ_DT") == null ? "" : request.getParameter("V_DN_REQ_DT").toUpperCase().substring(0, 10);
			String V_PRINT_NO = request.getParameter("V_PRINT_NO") == null ? "" : request.getParameter("V_PRINT_NO").toUpperCase();

			cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_DN_NO
			cs.setString(4, "");//V_DN_SEQ
			cs.setString(5, V_DN_REQ_DT);//V_DN_REQ_DT
			cs.setString(6, "");//V_DN_REQ_NO
			cs.setString(7, V_PRINT_NO);//V_PRINT_NO
			cs.setString(8, "");//V_BLCN_NO
			cs.setString(9, "");//V_BLCN_NO
			cs.setString(10, "");//V_REMARK
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_USR_ID
			cs.setString(14, "");//V_USR_ID
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ITEM_NM2", rs.getString("ITEM_NM2"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("ADD_DN_PRC", rs.getString("ADD_DN_PRC"));
				subObject.put("ADD_DN_AMT", rs.getString("ADD_DN_AMT"));
				subObject.put("TOTAL_DN_AMT", rs.getString("TOTAL_DN_AMT"));
				subObject.put("TOTAL_DN_PRC", rs.getString("TOTAL_DN_PRC"));
				subObject.put("ADD_REASON", rs.getString("ADD_REASON"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("MVMT_BOX_QTY", rs.getString("MVMT_BOX_QTY"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("OWN_DT", rs.getString("OWN_DT"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("COL_AMT", rs.getString("COL_AMT"));

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

		} else if (V_TYPE.equals("T2_DN_RECEIPT")) {

			// 			System.out.println("판매금액계산내역서");

			String V_DN_QTY = request.getParameter("V_DN_QTY") == null ? "" : request.getParameter("V_DN_QTY").toUpperCase();
			String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);
			String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO").toUpperCase();
			String V_DN_NO = request.getParameter("V_DN_NO") == null ? "" : request.getParameter("V_DN_NO").toUpperCase();
			String V_DN_SEQ = request.getParameter("V_DN_SEQ") == null ? "" : request.getParameter("V_DN_SEQ").toUpperCase();

/* 			System.out.println("V_DN_NO : " + V_DN_NO);
			System.out.println("V_DN_SEQ : " + V_DN_SEQ);
			System.out.println("V_DN_DT : " + V_DN_DT);
			System.out.println("V_DN_QTY : " + V_DN_QTY);
			System.out.println("V_MVMT_NO : " + V_MVMT_NO); */

			cs = conn.prepareCall("call DISTR_SALES2.USP_DN_CHECK_POPUP(?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DN_NO);//V_DN_NO
			cs.setString(4, V_DN_SEQ);//V_DN_SEQ
			cs.setString(5, V_DN_DT);//V_DN_DT
			cs.setString(6, V_MVMT_NO);//V_MVMT_NO
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
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
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				// 				subObject.put("MVMT_BOX_QTY", rs.getString("MVMT_BOX_QTY"));
				// 				subObject.put("LO_OPEN_AMT", rs.getString("LO_OPEN_AMT"));
				// 				subObject.put("COG_GL_AMT", rs.getString("COG_GL_AMT"));

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

		} else if (V_TYPE.equals("T3")) {

			cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_S_BP_NM);//V_DN_NO
			cs.setString(4, "");//V_DN_SEQ
			cs.setString(5, V_DN_REQ_DT);//V_DN_REQ_DT
			cs.setString(6, "");//V_DN_REQ_NO
			cs.setString(7, "");//V_PRINT_NO
			cs.setString(8, "");//V_BLCN_NO
			cs.setString(9, "");//V_BLCN_NO
			cs.setString(10, "");//V_REMARK
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_REMARK
			cs.setString(14, "");//V_REMARK
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("REQ_CFM_YN", rs.getString("REQ_CFM_YN"));
				subObject.put("PRINT_NO", rs.getString("PRINT_NO"));
				subObject.put("DN_TYPE", rs.getString("DN_TYPE"));
				subObject.put("DN_REQ_NO", rs.getString("DN_REQ_NO"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("RM_BOX_QTY", rs.getString("RM_BOX_QTY"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("BL_QTY", rs.getString("BL_QTY"));
				subObject.put("DN_REAL_QTY", rs.getString("DN_REAL_QTY"));
				subObject.put("COG_PRC", rs.getString("COG_PRC"));
				subObject.put("COG_AMT", rs.getString("COG_AMT"));
				subObject.put("MARGIN_AMT", rs.getString("MARGIN_AMT"));
				subObject.put("INTER_AMT", rs.getString("INTER_AMT"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("DN_FL_AMT", rs.getString("DN_FL_AMT"));
				subObject.put("ADD_DN_PRC", rs.getString("ADD_DN_PRC"));
				subObject.put("ADD_DN_AMT", rs.getString("ADD_DN_AMT"));
				subObject.put("REASON", rs.getString("ADD_REASON"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("IN_DAY", rs.getString("IN_DAY"));
				subObject.put("DN_PER_DAY1", rs.getString("DN_PER_DAY1"));
				subObject.put("DN_PER_RT1", rs.getString("DN_PER_RT1"));
				subObject.put("DN_PER_AMT1", rs.getString("DN_PER_AMT1"));
				subObject.put("DN_PER_DAY2", rs.getString("DN_PER_DAY2"));
				subObject.put("DN_PER_RT2", rs.getString("DN_PER_RT2"));
				subObject.put("DN_PER_AMT2", rs.getString("DN_PER_AMT2"));
				subObject.put("DN_OV_DAY1", rs.getString("DN_OV_DAY1"));
				subObject.put("DN_OV_RT1", rs.getString("DN_OV_RT1"));
				subObject.put("DN_OV_AMT1", rs.getString("DN_OV_AMT1"));
				subObject.put("DN_OV_DAY2", rs.getString("DN_OV_DAY2"));
				subObject.put("DN_OV_RT2", rs.getString("DN_OV_RT2"));
				subObject.put("DN_OV_AMT2", rs.getString("DN_OV_AMT2"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("BILL_NO", rs.getString("BILL_NO"));
				subObject.put("BILL_SEQ", rs.getString("BILL_SEQ"));
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("CC_SEQ", rs.getString("CC_SEQ"));
				subObject.put("SALE_ISSUE_DT", rs.getString("SALE_ISSUE_DT"));
				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
				subObject.put("DN_FIN_AMT", rs.getString("DN_FIN_AMT"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));

				subObject.put("DN_FIN_PRC", rs.getString("DN_FIN_PRC"));

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

		} else if (V_TYPE.equals("MAIL")) {
			String V_EMAIL = "";
			String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").substring(0, 10);

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);

			String V_PRINT_NO = "";
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();

					if (!V_TYPE.equals("")) {
						V_S_BP_NM = hashMap.get("BP_NM") == null ? "" : hashMap.get("BP_NM").toString();
						V_PRINT_NO = hashMap.get("PRINT_NO") == null ? "" : hashMap.get("PRINT_NO").toString().toUpperCase();
						cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, "");//V_DN_NO
						cs.setString(4, "");//V_DN_SEQ
						cs.setString(5, "");//V_DN_REQ_DT
						cs.setString(6, "");//V_DN_REQ_NO
						cs.setString(7, V_PRINT_NO);//V_PRINT_NO
						cs.setString(8, "");//V_BLCN_NO
						cs.setString(9, "");//V_ITEM_NM2
						cs.setString(10, "");//V_REMARK
						cs.setString(11, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(13, "");//V_REMARK
						cs.setString(14, "");//V_REMARK
						cs.executeQuery();

						String status = "";
						rs = (ResultSet) cs.getObject(12);
						while (rs.next()) {
							status = rs.getString("STATUS");
						}
						if (status.equals("OK")) {

							String m1 = request.getParameter("m1") == null || request.getParameter("m1").equals("") ? "" : request.getParameter("m1") + ",";
							String m2 = request.getParameter("m2") == null || request.getParameter("m2").equals("") ? "" : request.getParameter("m2") + ",";
							String m3 = request.getParameter("m3") == null || request.getParameter("m3").equals("") ? "" : request.getParameter("m3") + ",";
							String m4 = request.getParameter("m4") == null || request.getParameter("m4").equals("") ? "" : request.getParameter("m4") + ",";
							String m5 = request.getParameter("m5") == null || request.getParameter("m5").equals("") ? "" : request.getParameter("m5") + ",";
							String m6 = request.getParameter("m6") == null || request.getParameter("m6").equals("") ? "" : request.getParameter("m6") + ",";
							String m8 = request.getParameter("m8") == null || request.getParameter("m8").equals("") ? "" : request.getParameter("m8") + ",";
							String m9 = request.getParameter("m9") == null || request.getParameter("m9").equals("") ? "" : request.getParameter("m9") + ",";

							String mr1 = request.getParameter("mr1") == null || request.getParameter("mr1").equals("") ? "" : request.getParameter("mr1") + ",";
							String mr2 = request.getParameter("mr2") == null || request.getParameter("mr2").equals("") ? "" : request.getParameter("mr2") + ",";
							String mr3 = request.getParameter("mr3") == null || request.getParameter("mr3").equals("") ? "" : request.getParameter("mr3") + ",";


						 	String m1A = m1.equals("") ? "" : m1.substring(0,m1.lastIndexOf('@'))+ ",";
							String m2A = m2.equals("") ? "" : m2.substring(0,m2.lastIndexOf('@'))+ ",";
							String m3A = m3.equals("") ? "" : m3.substring(0,m3.lastIndexOf('@'))+ ",";
							String m4A = m4.equals("") ? "" : m4.substring(0,m4.lastIndexOf('@'))+ ",";
							String m5A = m5.equals("") ? "" : m5.substring(0,m5.lastIndexOf('@'))+ ",";
							String m6A = m6.equals("") ? "" : m6.substring(0,m6.lastIndexOf('@'))+ ",";
							String m8A = m8.equals("") ? "" : m8.substring(0,m8.lastIndexOf('@'))+ ",";
							String m9A = m9.equals("") ? "" : m9.substring(0,m9.lastIndexOf('@'))+ ",";
							
	 						String mr1A = mr1.equals("") ? "" : mr1.substring(0,mr1.lastIndexOf('@'))+ ",";
							String mr2A = mr2.equals("") ? "" : mr2.substring(0,mr2.lastIndexOf('@'))+ ",";
							String mr3A = mr3.equals("") ? "" : mr3.substring(0,mr3.lastIndexOf('@'))+ ","; 
							
							V_EMAIL = m1 + m2 + m3 + m4 + m5 + m6 + m8 + m9;
							String V_MR = mr1 + mr2 + mr3;
// 							System.out.println(V_EMAIL);

							long time = System.currentTimeMillis();
							SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
							SimpleDateFormat dayTime2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							String today = dayTime.format(new Date(time));
							String now = dayTime2.format(new Date(time));

							String host = "123.142.124.146";
							int port = 25;

							final String username = "admin";
							final String password = "hsnadmin";

							String subject = "";
							String body = "";

							if (V_TYPE.equals("MAIL_CANCEL")) {
								subject = "[" + today + "]" + V_S_BP_NM + " 출하취소요청서(" + V_PRINT_NO + ")"; //메일 제목 입력해주세요. 
							} else {
								subject = "[" + today + "]" + V_S_BP_NM + " 출하요청서(" + V_PRINT_NO + ")"; //메일 제목 입력해주세요.
							}


							Properties props = System.getProperties();
							props.put("mail.smtp.host", host);
							props.put("mail.smtp.port", port);
							props.put("mail.smtp.auth", "true");
							props.put("mail.smtp.ssl.enable", "false");
							props.put("mail.smtp.ssl.trust", host);

							String[] V_EMAIL_arr = V_EMAIL.split(",");

							String V_APP =  m1A + m2A + m3A + m4A + m5A + m6A + m8A + m9A;
							String[] V_EMAIL_app = V_APP.split(",");
							
							for (int k = 0; k < V_EMAIL_arr.length; k++) {
								
								body= "";
								String apprecipient = V_EMAIL_app[k].trim();
								
								if (V_TYPE.equals("MAIL_CANCEL")) {
									body += "<SPAN style=\"FONT-SIZE: 14pt\">출하취소요청서 승인 부탁드립니다.</SPAN>";
									body += "<DIV><SPAN style=\"FONT-SIZE: 10pt\"><SPAN 9pt>※출하취소요청서 승인은 출하취소요청서보기에서 할수있습니다.</SPAN></SPAN></DIV>";
									body += "<DIV>&nbsp;</DIV>";
									body += "<STRONG><SPAN style=\"FONT-SIZE: 20pt\"><A href=\"http://123.142.124.160:8080/HSPF01/HSPF02/ss2/dn/s_dn_paper_view/S_DN_PAPER_VIEW.jsp?PRINT_NO=" + V_PRINT_NO.replaceAll("-", "") + "&MR=" + V_MR + "&APP=" + apprecipient  + "&FLAG=C\">출하취소요청서보기</A>&nbsp;<BR></SPAN></STRONG><BR><BR><BR>※바로가기를 통하여 출하요청서를 확인 할 수 없으신분은 화승네트웍스 그룹웨어에 로그인<BR>하신 후 확인 할 수 있습니다.";
								} else {
									body += "<SPAN style=\"FONT-SIZE: 14pt\">출하요청서 승인 부탁드립니다.</SPAN>";
									body += "<DIV><SPAN style=\"FONT-SIZE: 10pt\"><SPAN 9pt>※출하요청서 승인은 출하요청서보기에서 할수있습니다.</SPAN></SPAN></DIV>";
									body += "<DIV>&nbsp;</DIV>";
									body += "<STRONG><SPAN style=\"FONT-SIZE: 20pt\"><A href=\"http://123.142.124.160:8080/HSPF01/HSPF02/ss2/dn/s_dn_paper_view/S_DN_PAPER_VIEW.jsp?PRINT_NO=" + V_PRINT_NO.replaceAll("-", "") + "&MR=" + V_MR +  "&APP=" + apprecipient + "&FLAG=Y\">출하요청서보기</A>&nbsp;<BR></SPAN></STRONG><BR><BR><BR>※바로가기를 통하여 출하요청서를 확인 할 수 없으신분은 화승네트웍스 그룹웨어에 로그인<BR>하신 후 확인 할 수 있습니다.";
									}	

								int j = 1;
								body += "<br><br>감사합니다.";
								
								String recipient = V_EMAIL_arr[k].trim();
// 								System.out.println("*********************************");
// 								System.out.println("recipient" + recipient);
// 								System.out.println("V_MR : " + V_MR);
// 								System.out.println("now" + now);
// 								System.out.println("*********************************");

								Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
									String	un	= username;
									String	pw	= password;

									protected javax.mail.PasswordAuthentication getPasswordAuthentication()
									{
										return new javax.mail.PasswordAuthentication(un, pw);
									}
								});
								session2.setDebug(false); //for debug

								Message mimeMessage = new MimeMessage(session2); //MimeMessage 생성 
								mimeMessage.setFrom(new InternetAddress("admin@hsnetw.com"));
								mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

								BodyPart messageBodyPart = new MimeBodyPart();
								messageBodyPart.setContent(body, "text/html;charset=UTF-8");

								Multipart multipart = new MimeMultipart();
								multipart.addBodyPart(messageBodyPart);

								mimeMessage.setSubject(subject); //제목셋팅 
								mimeMessage.setContent(multipart);
								Transport.send(mimeMessage); //javax.mail.Transport.send() 이용

							}

						}
					}

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_S_BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
				V_PRINT_NO = jsondata.get("PRINT_NO") == null ? "" : jsondata.get("PRINT_NO").toString().toUpperCase();
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				if (!V_TYPE.equals("")) {
					cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, "");//V_DN_NO
					cs.setString(4, "");//V_DN_SEQ
					cs.setString(5, "");//V_DN_REQ_DT
					cs.setString(6, "");//V_DN_REQ_NO
					cs.setString(7, V_PRINT_NO);//V_PRINT_NO
					cs.setString(8, "");//V_BLCN_NO
					cs.setString(9, "");//V_ITEM_NM2
					cs.setString(10, "");//V_REMARK
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(13, "");//V_REMARK
					cs.setString(14, "");//V_REMARK
					cs.executeQuery();

					String status = "";
					rs = (ResultSet) cs.getObject(12);
					while (rs.next()) {
						status = rs.getString("STATUS");
					}

					if (status.equals("OK")) {

						String m1 = request.getParameter("m1") == null || request.getParameter("m1").equals("") ? "" : request.getParameter("m1") + ",";
						String m2 = request.getParameter("m2") == null || request.getParameter("m2").equals("") ? "" : request.getParameter("m2") + ",";
						String m3 = request.getParameter("m3") == null || request.getParameter("m3").equals("") ? "" : request.getParameter("m3") + ",";
						String m4 = request.getParameter("m4") == null || request.getParameter("m4").equals("") ? "" : request.getParameter("m4") + ",";
						String m5 = request.getParameter("m5") == null || request.getParameter("m5").equals("") ? "" : request.getParameter("m5") + ",";
						String m6 = request.getParameter("m6") == null || request.getParameter("m6").equals("") ? "" : request.getParameter("m6") + ",";
						String m8 = request.getParameter("m8") == null || request.getParameter("m8").equals("") ? "" : request.getParameter("m8") + ",";
						String m9 = request.getParameter("m9") == null || request.getParameter("m9").equals("") ? "" : request.getParameter("m9") + ",";

						String mr1 = request.getParameter("mr1") == null || request.getParameter("mr1").equals("") ? "" : request.getParameter("mr1") + ",";
						String mr2 = request.getParameter("mr2") == null || request.getParameter("mr2").equals("") ? "" : request.getParameter("mr2") + ",";
						String mr3 = request.getParameter("mr3") == null || request.getParameter("mr3").equals("") ? "" : request.getParameter("mr3") + ",";

					 	String m1A = m1.equals("") ? "" : m1.substring(0,m1.lastIndexOf('@'))+ ",";
						String m2A = m2.equals("") ? "" : m2.substring(0,m2.lastIndexOf('@'))+ ",";
						String m3A = m3.equals("") ? "" : m3.substring(0,m3.lastIndexOf('@'))+ ",";
						String m4A = m4.equals("") ? "" : m4.substring(0,m4.lastIndexOf('@'))+ ",";
						String m5A = m5.equals("") ? "" : m5.substring(0,m5.lastIndexOf('@'))+ ",";
						String m6A = m6.equals("") ? "" : m6.substring(0,m6.lastIndexOf('@'))+ ",";
						String m8A = m8.equals("") ? "" : m8.substring(0,m8.lastIndexOf('@'))+ ",";
						String m9A = m9.equals("") ? "" : m9.substring(0,m9.lastIndexOf('@'))+ ",";
						
 						String mr1A = mr1.equals("") ? "" : mr1.substring(0,mr1.lastIndexOf('@'))+ ",";
						String mr2A = mr2.equals("") ? "" : mr2.substring(0,mr2.lastIndexOf('@'))+ ",";
						String mr3A = mr3.equals("") ? "" : mr3.substring(0,mr3.lastIndexOf('@'))+ ","; 
						
						
						V_EMAIL = m1 + m2 + m3 + m4 + m5 + m6 + m8 + m9;
						String V_MR = mr1 + mr2 + mr3;
// 						System.out.println(V_EMAIL);

						long time = System.currentTimeMillis();
						SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
						SimpleDateFormat dayTime2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String today = dayTime.format(new Date(time));
						String now = dayTime2.format(new Date(time));

						String host = "123.142.124.146";
						int port = 25;

						final String username = "admin";
						final String password = "hsnadmin";

						String subject = "";
						String body = "";

						if (V_TYPE.equals("MAIL_CANCEL")) {
							subject = "[" + today + "]" + V_S_BP_NM + " 출하취소요청서(" + V_PRINT_NO + ")"; //메일 제목 입력해주세요. 
						} else {
							subject = "[" + today + "]" + V_S_BP_NM + " 출하요청서(" + V_PRINT_NO + ")"; //메일 제목 입력해주세요.
						}

						int j = 1;
						body += "<br><br>감사합니다.";

						Properties props = System.getProperties();
						props.put("mail.smtp.host", host);
						props.put("mail.smtp.port", port);
						props.put("mail.smtp.auth", "true");
						props.put("mail.smtp.ssl.enable", "false");
						props.put("mail.smtp.ssl.trust", host);

						String[] V_EMAIL_arr = V_EMAIL.split(",");

						String V_APP =  m1A + m2A + m3A + m4A + m5A + m6A + m8A + m9A;
						String[] V_EMAIL_app = V_APP.split(",");
						
						for (int k = 0; k < V_EMAIL_arr.length; k++) {
							body = "";
															
							/****************************************/
							String apprecipient = V_EMAIL_app[k].trim();
							
							if (V_TYPE.equals("MAIL_CANCEL")) {
							body += "<SPAN style=\"FONT-SIZE: 14pt\">출하취소요청서 승인 부탁드립니다.</SPAN>";
							body += "<DIV><SPAN style=\"FONT-SIZE: 10pt\"><SPAN 9pt>※출하취소요청서 승인은 출하취소요청서보기에서 할수있습니다.</SPAN></SPAN></DIV>";
							body += "<DIV>&nbsp;</DIV>";
							body += "<STRONG><SPAN style=\"FONT-SIZE: 20pt\"><A href=\"http://123.142.124.160:8080/HSPF01/HSPF02/ss2/dn/s_dn_paper_view/S_DN_PAPER_VIEW.jsp?PRINT_NO=" + V_PRINT_NO.replaceAll("-", "") + "&MR=" + V_MR + "&APP=" + apprecipient  + "&FLAG=C\">출하취소요청서보기</A>&nbsp;<BR></SPAN></STRONG><BR><BR><BR>※바로가기를 통하여 출하요청서를 확인 할 수 없으신분은 화승네트웍스 그룹웨어에 로그인<BR>하신 후 확인 할 수 있습니다.";
							} else {
							body += "<SPAN style=\"FONT-SIZE: 14pt\">출하요청서 승인 부탁드립니다.</SPAN>";
							body += "<DIV><SPAN style=\"FONT-SIZE: 10pt\"><SPAN 9pt>※출하요청서 승인은 출하요청서보기에서 할수있습니다.</SPAN></SPAN></DIV>";
							body += "<DIV>&nbsp;</DIV>";
							body += "<STRONG><SPAN style=\"FONT-SIZE: 20pt\"><A href=\"http://123.142.124.160:8080/HSPF01/HSPF02/ss2/dn/s_dn_paper_view/S_DN_PAPER_VIEW.jsp?PRINT_NO=" + V_PRINT_NO.replaceAll("-", "") + "&MR=" + V_MR +  "&APP=" + apprecipient + "&FLAG=Y\">출하요청서보기</A>&nbsp;<BR></SPAN></STRONG><BR><BR><BR>※바로가기를 통하여 출하요청서를 확인 할 수 없으신분은 화승네트웍스 그룹웨어에 로그인<BR>하신 후 확인 할 수 있습니다.";
							}						
							/****************************************/

							String recipient = V_EMAIL_arr[k].trim();
// 							System.out.println("*********************************");
// 							System.out.println("recipient " + recipient);
// 							System.out.println("apprecipient " + apprecipient);
// 							System.out.println("V_MR : " + V_MR);
// 							System.out.println("now " + now);
// 							System.out.println("*********************************");

							Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
								String	un	= username;
								String	pw	= password;

								protected javax.mail.PasswordAuthentication getPasswordAuthentication()
								{
									return new javax.mail.PasswordAuthentication(un, pw);
								}
							});
							session2.setDebug(false); //for debug

							Message mimeMessage = new MimeMessage(session2); //MimeMessage 생성 
							mimeMessage.setFrom(new InternetAddress("admin@hsnetw.com"));
							mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

							BodyPart messageBodyPart = new MimeBodyPart();
							messageBodyPart.setContent(body, "text/html;charset=UTF-8");

							Multipart multipart = new MimeMultipart();
							multipart.addBodyPart(messageBodyPart);

							mimeMessage.setSubject(subject); //제목셋팅 
							mimeMessage.setContent(multipart);
							Transport.send(mimeMessage); //javax.mail.Transport.send() 이용

						}
					}
				}

			}

		} else if (V_TYPE.equals("SYNC_NEW")) {

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");


			String V_PRINT_NO = "";
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_BLCN_NO = hashMap.get("BL_CN_NO") == null ? "" : hashMap.get("BL_CN_NO").toString().toUpperCase();
					String V_ITEM_NM2 = hashMap.get("ITEM_NM2") == null ? "" : hashMap.get("ITEM_NM2").toString().toUpperCase();
					String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString().toUpperCase();
					String V_DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString().toUpperCase();
					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString().toUpperCase();
					String V_S_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString().toUpperCase();
					String V_V_DN_REQ_DT = V_DN_REQ_DT;
					String V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String V_BL_CNNO = hashMap.get("BL_CN_NO") == null ? "" : hashMap.get("BL_CN_NO").toString();
					String V_BRAND = hashMap.get("BRAND") == null ? "" : hashMap.get("BRAND").toString();

					if (V_TYPE.equals("I")) {
						cs = conn.prepareCall("call DISTR_SALES2.USP_TEMP_DN_REQ(?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_TYPE
						cs.setString(2, V_DN_NO);//V_COMP_ID
						cs.setString(3, V_DN_SEQ);//V_DN_NO
						cs.setString(4, V_S_BP_CD);//V_DN_SEQ
						cs.setString(5, V_S_SL_CD);//V_DN_REQ_DT
						cs.setString(6, V_V_DN_REQ_DT);//V_DN_REQ_NO
						cs.setString(7, V_ITEM_NM);//V_PRINT_NO
						cs.setString(8, V_ITEM_NM2);//V_BLCN_NO
						cs.setString(9, V_BL_CNNO);//V_ITEM_NM2
						cs.setString(10, V_BRAND);//V_REMARK
						cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						if (i == jsonAr.size() - 1) {
							cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW2(?,?,?)");
							cs.setString(1, V_COMP_ID);//V_COMP_ID
							cs.setString(2, "");//V_SP_ID
							cs.setString(3, V_USR_ID);//V_USR_ID
							cs.executeQuery();
						}
					}
				}

			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_BLCN_NO = jsondata.get("BL_CN_NO") == null ? "" : jsondata.get("BL_CN_NO").toString().toUpperCase();
				String V_ITEM_NM2 = jsondata.get("ITEM_NM2") == null ? "" : jsondata.get("ITEM_NM2").toString().toUpperCase();
				String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString().toUpperCase();
				String V_DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString().toUpperCase();
				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString().toUpperCase();
				String V_S_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString().toUpperCase();
				String V_V_DN_REQ_DT = V_DN_REQ_DT;
				String V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String V_BL_CNNO = jsondata.get("BL_CN_NO") == null ? "" : jsondata.get("BL_CN_NO").toString();
				String V_BRAND = jsondata.get("BRAND") == null ? "" : jsondata.get("BRAND").toString();


				if (V_TYPE.equals("I")) {
					cs = conn.prepareCall("call DISTR_SALES2.USP_TEMP_DN_REQ(?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_TYPE
					cs.setString(2, V_DN_NO);//V_COMP_ID
					cs.setString(3, V_DN_SEQ);//V_DN_NO
					cs.setString(4, V_S_BP_CD);//V_DN_SEQ
					cs.setString(5, V_S_SL_CD);//V_DN_REQ_DT
					cs.setString(6, V_V_DN_REQ_DT);//V_DN_REQ_NO
					cs.setString(7, V_ITEM_NM);//V_PRINT_NO
					cs.setString(8, V_ITEM_NM2);//V_BLCN_NO
					cs.setString(9, V_BL_CNNO);//V_ITEM_NM2
					cs.setString(10, V_BRAND);//V_REMARK
					cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					cs = conn.prepareCall("call DISTR_SALES2.USP_DN_PRINT_NEW2(?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, "");//V_SP_ID
					cs.setString(3, V_USR_ID);//V_USR_ID
					cs.executeQuery();
				}
			}
			//탭2 조회

		} else if (V_TYPE.equals("BANK")) {
			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE");
			String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
			String V_IN_DT_FR = request.getParameter("V_IN_DT_FR") == null ? "" : request.getParameter("V_IN_DT_FR").toUpperCase().substring(0, 10).replaceAll("-", "");
			String V_IN_DT_TO = request.getParameter("V_IN_DT_TO") == null ? "" : request.getParameter("V_IN_DT_TO").toUpperCase().substring(0, 10).replaceAll("-", "");
			String V_S_DN_DT = request.getParameter("V_S_DN_DT") == null ? "" : request.getParameter("V_S_DN_DT").toUpperCase().substring(0, 10);
			String V_PRINT_NO = request.getParameter("V_PRINT_NO") == null ? "" : request.getParameter("V_PRINT_NO").toUpperCase();
			String V_VACCT_NO = request.getParameter("V_VACCT_NO") == null ? "" : request.getParameter("V_VACCT_NO").toUpperCase();

			if (U_TYPE.equals("SH")) {

				cs = conn.prepareCall("call DISTR_SALES2.USP_V_BANK_LIST(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, U_TYPE);//V_TYPE
				cs.setString(2, V_S_BP_CD);//V_S_BP_CD
				cs.setString(3, V_IN_DT_FR);//V_IN_DT_FR
				cs.setString(4, V_IN_DT_TO);//V_IN_DT_TO
				cs.setString(5, V_S_DN_DT);//V_S_DN_DT
				cs.setString(6, V_PRINT_NO);//V_PRINT_NO
				cs.setString(7, V_VACCT_NO);//V_VACCT_NO
				cs.setString(8, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(9);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("PRINT_NO", rs.getString("PRINT_NO"));
					subObject.put("DN_LOC_AMT", rs.getString("DN_LOC_AMT"));
					subObject.put("IN_AMT", rs.getString("IN_AMT"));
					subObject.put("JAN_AMT", rs.getString("JAN_AMT"));

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
			} else if (U_TYPE.equals("SR")) {

				cs = conn.prepareCall("call DISTR_SALES2.USP_V_BANK_LIST(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, U_TYPE);//V_TYPE
				cs.setString(2, V_S_BP_CD);//V_S_BP_CD
				cs.setString(3, V_IN_DT_FR);//V_IN_DT_FR
				cs.setString(4, V_IN_DT_TO);//V_IN_DT_TO
				cs.setString(5, V_S_DN_DT);//V_S_DN_DT
				cs.setString(6, V_PRINT_NO);//V_PRINT_NO
				cs.setString(7, V_VACCT_NO);//V_VACCT_NO
				cs.setString(8, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(9);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("TR_SEQ", rs.getString("TR_SEQ"));
					subObject.put("BP_CD", rs.getString("BP_CD"));
					subObject.put("BP_NM", rs.getString("BP_NM"));
					subObject.put("V_BANK_ACCT", rs.getString("V_BANK_ACCT"));
					subObject.put("TR_DATE", rs.getString("TR_DATE"));
					subObject.put("TR_TIME", rs.getString("TR_TIME"));
					subObject.put("IN_NAME", rs.getString("IN_NAME"));
					subObject.put("TR_AMT", rs.getString("TR_AMT"));
					subObject.put("IN_AMT", rs.getString("IN_AMT"));
					subObject.put("PRINT_NO", rs.getString("PRINT_NO"));
					subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
					subObject.put("REMARK", rs.getString("REMARK"));
					subObject.put("BANK_CD", rs.getString("BANK_CD"));

					jsonArray.add(subObject);
				}
				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();

				/*입금불러오기*/
			} else if (U_TYPE.equals("DEPOSIT")) {
				String V_TR_DT = request.getParameter("V_TR_DT") == null ? "" : request.getParameter("V_TR_DT").substring(0, 10).replaceAll("-", "");
				V_IN_DT_FR = request.getParameter("V_IN_DT_FR") == null ? "" : request.getParameter("V_IN_DT_FR").toUpperCase().substring(0, 10).replaceAll("-", "");
				V_IN_DT_TO = request.getParameter("V_IN_DT_TO") == null ? "" : request.getParameter("V_IN_DT_TO").toUpperCase().substring(0, 10).replaceAll("-", "");

				if ((Integer.parseInt(V_IN_DT_FR) >= 20190618) == true) {
					V_IN_DT_FR = "20190618";
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_B_TB_RVAS_LIST()}");
				e_cs.execute();

				String sql = "";
				sql += "INSERT                                                                                                 ";
				sql += "INTO   TB_RVAS_LIST                                                                                    ";
				sql += "       (                                                                                               ";
				sql += "              TR_DATE, TR_SEQ, BANK_CD, ORG_CD, VACCT_NO, STAT_CD,                                     ";
				sql += "              CUST_CD, CUST_NM, TR_TIME, TR_AMT, IN_BANK_CD, IN_BANK_BRANCH,                          ";
				sql += "              IN_NAME, ENTRY_DATE, ENTRY_IDNO, ERP_PROC_YN, INSRT_DT, INSRT_USR_ID,                   ";
				sql += "              UPDT_DT, UPDT_USR_ID                                                                     ";
				sql += "       )                                                                                               ";
				sql += "SELECT TR_DATE, TO_CHAR(SYSDATE, 'YYYYMMDD')||SUBSTR(TR_SEQ, 9, 6), BANK_CD, ORG_CD, VACCT_NO, STAT_CD,";
				sql += "       CUST_CD, CUST_NM, TR_TIME, TR_AMT, IN_BANK_CD, IN_BANK_BRANCH,                                  ";
				sql += "       IN_NAME, ENTRY_DATE, ENTRY_IDNO, ERP_PROC_YN, INSRT_DT, INSRT_USR_ID,                           ";
				sql += "       UPDT_DT, UPDT_USR_ID                                                                            ";
				sql += "FROM   TB_RVAS_LIST@HSN_LINK                                                                           ";
				sql += "WHERE  TR_DATE >= '" + V_IN_DT_FR + "'                                                                           ";
				sql += "AND    TR_DATE <= '" + V_IN_DT_TO + "'                                                                           ";
				sql += "AND    TR_DATE || SUBSTR(TR_SEQ, 9, 6) NOT IN                                                                       ";
				sql += "       (                                                                                               ";
				sql += "              SELECT TR_DATE || SUBSTR(TR_SEQ, 9, 6)                                                                 ";
				sql += "              FROM   TB_RVAS_LIST                                                                      ";
				sql += "              WHERE  TR_DATE >= '" + V_IN_DT_FR + "'                                                             ";
				sql += "              AND    TR_DATE <= '" + V_IN_DT_TO + "'                                                             ";
				sql += "       )                                                                                               ";

				rs = stmt.executeQuery(sql);
				
				sql = "INSERT INTO B_V_ACCT ( COMP_ID,M_ACCT_CD,DEPT_CD,BP_CD,V_BANK_ACCT,M_BANK_ACCT,INSRT_USR_ID,INSRT_DT,UPDT_USR_ID,UPDT_DT,USE_FLAG ) ";
				sql += "select '" + V_COMP_ID + "' ,M_ACCT_CD,DEPT_CD,BP_CD,V_BANK_ACCT,M_BANK_ACCT,INSRT_USR_ID,INSRT_DT,UPDT_USR_ID,UPDT_DT,USE_FLAG from B_V_ACCT@HSN_LINK where M_ACCT_CD not in (select M_ACCT_CD from B_V_ACCT)";
				
				rs = stmt.executeQuery(sql);

			} else if (U_TYPE.equals("SYNC")) {

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
						V_VACCT_NO = hashMap.get("V_BANK_ACCT") == null ? "" : hashMap.get("V_BANK_ACCT").toString().toUpperCase();
						String V_IN_DT = hashMap.get("TR_DATE") == null ? "" : hashMap.get("TR_DATE").toString().toUpperCase();
						String V_TR_SEQ = hashMap.get("TR_SEQ") == null ? "" : hashMap.get("TR_SEQ").toString().toUpperCase();
						String V_DN_AMT = request.getParameter("V_DN_AMT") == null ? "" : request.getParameter("V_DN_AMT").toUpperCase().replaceAll(",", "");
						String V_JAN_AMT = request.getParameter("V_JAN_AMT") == null ? "0" : request.getParameter("V_JAN_AMT").toUpperCase().replaceAll(",", "");;
						String V_IN_AMT = hashMap.get("REMAIN_AMT") == null ? "0" : hashMap.get("REMAIN_AMT").toString().toUpperCase();

						String V_AMT = "";

						if (Integer.parseInt(V_JAN_AMT) >= Integer.parseInt(V_IN_AMT)) { //미확인금액보다 잔액이 크면.....
							V_AMT = V_IN_AMT;
						} else {
							V_AMT = V_JAN_AMT;
						}

						cs = conn.prepareCall("call DISTR_SALES2.USP_S_DN_IN_CHECK(?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_VACCT_NO);//V_DN_NO
						cs.setString(4, "");//V_DN_SEQ
						cs.setString(5, "");//V_DN_REQ_DT
						cs.setString(6, V_S_BP_CD);//V_DN_REQ_NO
						cs.setString(7, V_IN_DT);//V_PRINT_NO
						cs.setString(8, V_TR_SEQ);//V_BLCN_NO
						cs.setString(9, V_PRINT_NO);//V_ITEM_NM2
						cs.setString(10, V_DN_AMT);//V_REMARK
						cs.setString(11, V_AMT);//V_REMARK
						cs.setString(12, V_USR_ID);//V_USR_ID
						cs.executeQuery();

						String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString().toUpperCase();
						String V_BANK_CD = hashMap.get("BANK_CD") == null ? "" : hashMap.get("BANK_CD").toString().toUpperCase();
						String V_TR_DATE = hashMap.get("TR_DATE") == null ? "" : hashMap.get("TR_DATE").toString().toUpperCase().replaceAll("-", "");

						cs = conn.prepareCall("call DISTR_SALES2.USP_V_BK_LST_REMARK(?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_TR_DATE);//V_COMP_ID
						cs.setString(3, V_TR_SEQ);//V_DN_NO
						cs.setString(4, V_BANK_CD);//V_DN_SEQ
						cs.setString(5, V_VACCT_NO);//V_USR_ID
						cs.setString(6, V_REMARK);//V_USR_ID
						cs.setString(7, V_USR_ID);//V_USR_ID
						cs.executeQuery();

					}
				} else {

					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					V_VACCT_NO = jsondata.get("V_BANK_ACCT") == null ? "" : jsondata.get("V_BANK_ACCT").toString().toUpperCase();
					String V_IN_DT = jsondata.get("TR_DATE") == null ? "" : jsondata.get("TR_DATE").toString().toUpperCase();
					String V_TR_SEQ = jsondata.get("TR_SEQ") == null ? "" : jsondata.get("TR_SEQ").toString().toUpperCase();
					String V_DN_AMT = request.getParameter("V_DN_AMT") == null ? "" : request.getParameter("V_DN_AMT").toUpperCase().replaceAll(",", "");
					String V_JAN_AMT = request.getParameter("V_JAN_AMT") == null ? "0" : request.getParameter("V_JAN_AMT").toUpperCase().replaceAll(",", "");
					String V_IN_AMT = jsondata.get("REMAIN_AMT") == null ? "0" : jsondata.get("REMAIN_AMT").toString().toUpperCase();

					String V_AMT = "";

					if (Integer.parseInt(V_JAN_AMT) >= Integer.parseInt(V_IN_AMT)) { //미확인금액보다 잔액이 크면.....
						V_AMT = V_IN_AMT;
					} else {
						V_AMT = V_JAN_AMT;
					}

					cs = conn.prepareCall("call DISTR_SALES2.USP_S_DN_IN_CHECK(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_VACCT_NO);//V_DN_NO
					cs.setString(4, "");//V_DN_SEQ
					cs.setString(5, "");//V_DN_REQ_DT
					cs.setString(6, V_S_BP_CD);//V_DN_REQ_NO
					cs.setString(7, V_IN_DT);//V_PRINT_NO
					cs.setString(8, V_TR_SEQ);//V_BLCN_NO
					cs.setString(9, V_PRINT_NO);//V_ITEM_NM2
					cs.setString(10, V_DN_AMT);//V_REMARK
					cs.setString(11, V_AMT);//V_REMARK
					cs.setString(12, V_USR_ID);//V_USR_ID
					cs.executeQuery();

					String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString().toUpperCase();
					String V_BANK_CD = jsondata.get("BANK_CD") == null ? "" : jsondata.get("BANK_CD").toString().toUpperCase();
					String V_TR_DATE = jsondata.get("TR_DATE") == null ? "" : jsondata.get("TR_DATE").toString().toUpperCase().replaceAll("-", "");

					cs = conn.prepareCall("call DISTR_SALES2.USP_V_BK_LST_REMARK(?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_TR_DATE);//V_COMP_ID
					cs.setString(3, V_TR_SEQ);//V_DN_NO
					cs.setString(4, V_BANK_CD);//V_DN_SEQ
					cs.setString(5, V_VACCT_NO);//V_USR_ID
					cs.setString(6, V_REMARK);//V_USR_ID
					cs.setString(7, V_USR_ID);//V_USR_ID
					cs.executeQuery();
				}

			}
				 else if (U_TYPE.equals("SYNC2")) { /*비고란 수정*/

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
						V_VACCT_NO = hashMap.get("V_BANK_ACCT") == null ? "" : hashMap.get("V_BANK_ACCT").toString().toUpperCase();
						String V_TR_SEQ = hashMap.get("TR_SEQ") == null ? "" : hashMap.get("TR_SEQ").toString().toUpperCase();
						String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString().toUpperCase();
						String V_BANK_CD = hashMap.get("BANK_CD") == null ? "" : hashMap.get("BANK_CD").toString().toUpperCase();
						String V_TR_DATE = hashMap.get("TR_DATE") == null ? "" : hashMap.get("TR_DATE").toString().toUpperCase().replaceAll("-", "");

						if (V_TYPE.equals("V")) { 
							V_TYPE = "I";
						} 
						
						cs = conn.prepareCall("call DISTR_SALES2.USP_V_BK_LST_REMARK(?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE ㅇ
						cs.setString(2, V_TR_DATE);//V_COMP_ID ㅇ
						cs.setString(3, V_TR_SEQ);//V_DN_NO ㅇ
						cs.setString(4, V_BANK_CD);//V_DN_SEQ ㅇ
						cs.setString(5, V_VACCT_NO);//V_USR_ID
						cs.setString(6, V_REMARK);//V_USR_ID ㅇ
						cs.setString(7, V_USR_ID);//V_USR_ID ㅇ
						cs.executeQuery();

					}
				} else {

					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					V_VACCT_NO = jsondata.get("V_BANK_ACCT") == null ? "" : jsondata.get("V_BANK_ACCT").toString().toUpperCase();
					String V_TR_SEQ = jsondata.get("TR_SEQ") == null ? "" : jsondata.get("TR_SEQ").toString().toUpperCase();
					String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString().toUpperCase();
					String V_BANK_CD = jsondata.get("BANK_CD") == null ? "" : jsondata.get("BANK_CD").toString().toUpperCase();
					String V_TR_DATE = jsondata.get("TR_DATE") == null ? "" : jsondata.get("TR_DATE").toString().toUpperCase().replaceAll("-", "");

					if (V_TYPE.equals("V")) { 
						V_TYPE = "I";
					} 
					
					cs = conn.prepareCall("call DISTR_SALES2.USP_V_BK_LST_REMARK(?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_TR_DATE);//V_COMP_ID
					cs.setString(3, V_TR_SEQ);//V_DN_NO
					cs.setString(4, V_BANK_CD);//V_DN_SEQ
					cs.setString(5, V_VACCT_NO);//V_USR_ID
					cs.setString(6, V_REMARK);//V_USR_ID 
					cs.setString(7, V_USR_ID);//V_USR_ID
					cs.executeQuery();
				}

			}

		} else if (V_TYPE.equals("CALC_POP")) {

			String V_BS_DT = request.getParameter("V_BS_DT") == null ? "" : request.getParameter("V_BS_DT").substring(0, 10);
			String V_BS_BOX_QTY = request.getParameter("V_BS_BOX_QTY") == null ? "" : request.getParameter("V_BS_BOX_QTY");
			String V_BS_QTY = request.getParameter("V_BS_QTY") == null ? "" : request.getParameter("V_BS_QTY");
			String V_BAS_STEP = request.getParameter("V_BAS_STEP") == null ? "" : request.getParameter("V_BAS_STEP");
			String V_BAS_NO = request.getParameter("V_BAS_NO") == null ? "" : request.getParameter("V_BAS_NO");
			String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO");
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");

// 			System.out.println("V_COMP_ID" + V_COMP_ID);
// 			System.out.println("V_TYPE" + V_TYPE);
// 			System.out.println("V_BS_DT" + V_BS_DT);
// 			System.out.println("V_BS_BOX_QTY" + V_BS_BOX_QTY);
// 			System.out.println("V_BS_QTY" + V_BS_QTY);
// 			System.out.println("V_BAS_STEP" + V_BAS_STEP);
// 			System.out.println("V_BAS_NO" + V_BAS_NO);
// 			System.out.println("V_MVMT_NO" + V_MVMT_NO);
// 			System.out.println("V_ITEM_CD" + V_ITEM_CD);

			cs = conn.prepareCall("call USP_Z_A_LOG_DISTR(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);
			cs.setString(2, "I");
			cs.setString(3, V_BS_DT);
			cs.setString(4, V_BS_BOX_QTY);
			cs.setString(5, V_BS_QTY);
			cs.setString(6, V_BAS_NO);
			cs.setString(7, V_BAS_STEP);
			cs.setString(8, V_ITEM_CD);
			cs.setString(9, V_MVMT_NO);
			cs.setString(10, V_USR_ID);
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			cs = conn.prepareCall("call USP_Z_A_LOG_DISTR(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);
			cs.setString(2, "S");
			cs.setString(3, V_BS_DT);
			cs.setString(4, V_BS_BOX_QTY);
			cs.setString(5, V_BS_QTY);
			cs.setString(6, V_BAS_NO);
			cs.setString(7, V_BAS_STEP);
			cs.setString(8, V_ITEM_CD);
			cs.setString(9, V_MVMT_NO);
			cs.setString(10, V_USR_ID);
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(11);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("EX_NO", rs.getString("EX_NO"));
				subObject.put("EX_DT", rs.getString("EX_DT"));
				subObject.put("BAS_STEP", rs.getString("BAS_STEP"));
				subObject.put("BAS_NO", rs.getString("BAS_NO"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("PRC_FLG", rs.getString("PRC_FLG"));
				subObject.put("IV_BOX_QTY", rs.getString("IV_BOX_QTY"));
				subObject.put("IV_QTY", rs.getString("IV_QTY"));
				subObject.put("IV_AMT", rs.getString("IV_AMT"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("LC_OPEN_AMT", rs.getString("LC_OPEN_AMT"));
				subObject.put("LC_AMEND_AMT", rs.getString("LC_AMEND_AMT"));
				subObject.put("ETC_AMT", rs.getString("ETC_AMT"));
				subObject.put("INSUR_AMT", rs.getString("INSUR_AMT"));
				subObject.put("DISTR_CC_AMT", rs.getString("DISTR_CC_AMT"));
				subObject.put("TAX_AMT", rs.getString("TAX_AMT"));
				subObject.put("REC_AMT", rs.getString("REC_AMT"));
				subObject.put("DISTR_AMT", rs.getString("DISTR_AMT"));
				subObject.put("IV_E_AMT", rs.getString("IV_E_AMT"));

				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_COG_AMT", rs.getString("DN_COG_AMT"));
				subObject.put("DN_ETC_COG_AMT", rs.getString("DN_ETC_COG_AMT"));
				subObject.put("DN_CALC_AMT", rs.getString("DN_CALC_AMT"));
				subObject.put("PER_AMT", rs.getString("PER_AMT"));
				subObject.put("OV_AMT", rs.getString("OV_AMT"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("F_DN_PRC", rs.getString("F_DN_PRC"));
				subObject.put("REAL_QTY", rs.getString("REAL_QTY"));
				subObject.put("LAST_DN_AMT", rs.getString("LAST_DN_AMT"));
				subObject.put("LAST_DN_PRC", rs.getString("LAST_DN_PRC"));
				subObject.put("LAST_COG_AMT", rs.getString("LAST_COG_AMT"));
				subObject.put("PROF_AMT", rs.getString("PROF_AMT"));
				subObject.put("ST_AMT", rs.getString("ST_AMT"));
				subObject.put("IO_AMT", rs.getString("IO_AMT"));
				subObject.put("JOB_AMT", rs.getString("JOB_AMT"));
				subObject.put("WT_AMT", rs.getString("WT_AMT"));
				subObject.put("CK_AMT", rs.getString("CK_AMT"));
				subObject.put("AP_AMT", rs.getString("AP_AMT"));
				subObject.put("MV_AMT", rs.getString("MV_AMT"));
				subObject.put("BK_AMT", rs.getString("BK_AMT"));
				subObject.put("MG_RT", rs.getString("MG_RT"));
				subObject.put("MG_AMT", rs.getString("MG_AMT"));
				subObject.put("DN_CALC_AMT", rs.getString("DN_CALC_AMT"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_COG_AMT", rs.getString("DN_COG_AMT"));
				subObject.put("DN_ETC_COG_SUM_AMT", rs.getString("DN_ETC_COG_SUM_AMT"));

				subObject.put("REAL_QTY", rs.getString("REAL_QTY"));
				subObject.put("LAST_DN_AMT", rs.getString("LAST_DN_AMT"));
				subObject.put("LAST_DN_PRC", rs.getString("LAST_DN_PRC"));

				subObject.put("PROF_AMT", rs.getString("PROF_AMT"));
				subObject.put("PROF_RT", rs.getString("PROF_RT"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);


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
		if (cs3 != null) try {
			cs3.close();
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
		}catch (SQLException ex) {}
	}
%>


