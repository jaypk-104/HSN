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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();

		//구매요청조회(좌측)
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_M_PO_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_NO);//V_PO_NO
			cs.setString(4, "");//V_PO_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_PO_QTY
			cs.setString(7, "");//V_PO_PRC
			cs.setString(8, "");//V_PO_AMT
			cs.setString(9, "");//V_PO_LOC_AMT
			cs.setString(10, "");//V_VAT_TYPE
			cs.setString(11, "");//V_PO_VAT_AMT
			cs.setString(12, "");//V_DLVY_HOPE_DT
			cs.setString(13, "");//V_HOPE_SL_CD
			cs.setString(14, "");//V_OVER_TOL
			cs.setString(15, "");//V_UNDER_TOL
			cs.setString(16, "");//V_ERP_TRANS_YN
			cs.setString(17, "");//V_PUR_NO
			cs.setString(18, "");//V_PUR_SEQ
			cs.setString(19, "");//V_M_BP_CD
			cs.setString(20, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(21);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("MIN_PO_QTY", rs.getString("MIN_PO_QTY"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("PO_VAT_AMT", rs.getString("PO_VAT_AMT"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT").substring(0, 10));
				subObject.put("HOPE_SL_CD", rs.getString("HOPE_SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("OVER_TOL", rs.getString("OVER_TOL"));
				subObject.put("UNDER_TOL", rs.getString("UNDER_TOL"));
				subObject.put("PUR_NO", rs.getString("PUR_NO"));
				subObject.put("PUR_SEQ", rs.getString("PUR_SEQ"));
				subObject.put("SUPP_REMARK", rs.getString("SUPP_REMARK"));
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

			//발주아이템불러오기
		} else if (V_TYPE.equals("B")) {

			cs = conn.prepareCall("call USP_M_PO_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_PO_NO
			cs.setString(4, "");//V_PO_SEQ
			cs.setString(5, V_ITEM_CD);//V_ITEM_CD
			cs.setString(6, "");//V_PO_QTY
			cs.setString(7, "");//V_PO_PRC
			cs.setString(8, "");//V_PO_AMT
			cs.setString(9, "");//V_PO_LOC_AMT
			cs.setString(10, "");//V_VAT_TYPE
			cs.setString(11, "");//V_PO_VAT_AMT
			cs.setString(12, "");//V_DLVY_HOPE_DT
			cs.setString(13, "");//V_HOPE_SL_CD
			cs.setString(14, "");//V_OVER_TOL
			cs.setString(15, "");//V_UNDER_TOL
			cs.setString(16, "");//V_ERP_TRANS_YN
			cs.setString(17, "");//V_PUR_NO
			cs.setString(18, "");//V_PUR_SEQ
			cs.setString(19, V_M_BP_CD);//V_M_BP_CD
			cs.setString(20, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(21);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MB_PRC", rs.getString("MB_PRC"));
				subObject.put("LT", rs.getString("LT"));
				subObject.put("HP_SL_CD", rs.getString("HP_SL_CD"));
				subObject.put("HP_SL_NM", rs.getString("HP_SL_NM"));
				subObject.put("MIN_PO_QTY", rs.getString("MIN_PO_QTY"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("DH")) { //발주헤더삭제

			cs = conn.prepareCall("call USP_M_PO_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_NO);//V_PO_NO
			cs.setString(4, "");//V_PO_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_PO_QTY
			cs.setString(7, "");//V_PO_PRC
			cs.setString(8, "");//V_PO_AMT
			cs.setString(9, "");//V_PO_LOC_AMT
			cs.setString(10, "");//V_VAT_TYPE
			cs.setString(11, "");//V_PO_VAT_AMT
			cs.setString(12, "");//V_DLVY_HOPE_DT
			cs.setString(13, "");//V_HOPE_SL_CD
			cs.setString(14, "");//V_OVER_TOL
			cs.setString(15, "");//V_UNDER_TOL
			cs.setString(16, "");//V_ERP_TRANS_YN
			cs.setString(17, "");//V_PUR_NO
			cs.setString(18, "");//V_PUR_SEQ
			cs.setString(19, "");//V_M_BP_CD
			cs.setString(20, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			//System.out.println(jsonData);

			if (!V_TYPE.equals("V")) {
				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
						String V_PO_SEQ = (i + 1) + "";
						if (V_TYPE.equals("D")) {
							V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
							V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
						}
						if (V_TYPE.equals("U")) {
							V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
							V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
						}
						V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						String V_PO_QTY = hashMap.get("PO_QTY") == null ? "" : hashMap.get("PO_QTY").toString();
						V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD");
						if (V_TYPE.equals("B")) {
							V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
						}
						String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
						String V_OVER_TOL = hashMap.get("OVER_TOL") == null ? "" : hashMap.get("OVER_TOL").toString();
						if (V_OVER_TOL.equals("null")) {
							V_OVER_TOL = "";
						}
						String V_UNDER_TOL = hashMap.get("UNDER_TOL") == null ? "" : hashMap.get("UNDER_TOL").toString();
						if (V_UNDER_TOL.equals("null")) {
							V_UNDER_TOL = "";
						}
						String V_PUR_NO = hashMap.get("PUR_NO") == null ? "" : hashMap.get("PUR_NO").toString();
						String V_PUR_SEQ = hashMap.get("PUR_SEQ") == null ? "" : hashMap.get("PUR_SEQ").toString();
						String V_PO_PRC = hashMap.get("PO_PRC") == null ? "" : hashMap.get("PO_PRC").toString();
						String V_PO_AMT = hashMap.get("PO_AMT") == null ? "" : hashMap.get("PO_AMT").toString();
						String V_PO_LOC_AMT = hashMap.get("PO_LOC_AMT") == null ? "" : hashMap.get("PO_LOC_AMT").toString();
						String V_PO_VAT_AMT = hashMap.get("PO_VAT_AMT") == null ? "" : hashMap.get("PO_VAT_AMT").toString();
						String V_DLVY_HOPE_DT = hashMap.get("DLVY_HOPE_DT") == null ? "" : hashMap.get("DLVY_HOPE_DT").toString();

						if (V_DLVY_HOPE_DT.equals("null")) {
							V_DLVY_HOPE_DT = "";
							// 						System.out.println("텍스트 null");
						} else if (V_DLVY_HOPE_DT == null) {
							// 						System.out.println("진짜null");
						} else if (V_DLVY_HOPE_DT.equals("")) {
							// 						System.out.println("공백");
						} else {
							// 						System.out.println("엘사?");
							V_DLVY_HOPE_DT = V_DLVY_HOPE_DT.substring(0, 10);
						}

						String V_HOPE_SL_CD = hashMap.get("HOPE_SL_CD") == null ? "" : hashMap.get("HOPE_SL_CD").toString();
						if (V_HOPE_SL_CD.equals("null")) {
							V_HOPE_SL_CD = "";
						}

						String V_SUPP_REMARK = hashMap.get("SUPP_REMARK") == null ? "" : hashMap.get("SUPP_REMARK").toString();

						cs = conn.prepareCall("call USP_M_PO_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_PO_NO);//V_PO_NO
						cs.setString(4, V_PO_SEQ);//V_PO_SEQ
						cs.setString(5, V_ITEM_CD);//V_ITEM_CD
						cs.setString(6, V_PO_QTY);//V_PO_QTY
						cs.setString(7, V_PO_PRC);//V_PO_PRC
						cs.setString(8, V_PO_AMT);//V_PO_AMT
						cs.setString(9, V_PO_LOC_AMT);//V_PO_LOC_AMT
						cs.setString(10, V_VAT_TYPE);//V_VAT_TYPE
						cs.setString(11, V_PO_VAT_AMT);//V_PO_VAT_AMT
						cs.setString(12, V_DLVY_HOPE_DT);//V_DLVY_HOPE_DT
						cs.setString(13, V_HOPE_SL_CD);//V_HOPE_SL_CD
						cs.setString(14, V_OVER_TOL);//V_OVER_TOL
						cs.setString(15, V_UNDER_TOL);//V_UNDER_TOL
						cs.setString(16, V_SUPP_REMARK);//V_SUPP_REMARK
						cs.setString(17, V_PUR_NO);//V_PUR_NO
						cs.setString(18, V_PUR_SEQ);//V_PUR_SEQ
						cs.setString(19, V_M_BP_CD);//V_M_BP_CD
						cs.setString(20, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						if (V_TYPE.equals("B")) {
							rs = (ResultSet) cs.getObject(21);

							while (rs.next()) {
								subObject = new JSONObject();
								subObject.put("MB_PRC", rs.getString("MB_PRC"));
								subObject.put("LT", rs.getString("LT"));
								subObject.put("HP_SL_CD", rs.getString("HP_SL_CD"));
								subObject.put("HP_SL_NM", rs.getString("HP_SL_NM"));
								jsonArray.add(subObject);
							}
						}
					}
				} else {
					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
					String V_PO_SEQ = "1";
					if (V_TYPE.equals("D")) {
						V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
						V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					}
					if (V_TYPE.equals("U")) {
						V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
						V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					}

					V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					String V_PO_QTY = jsondata.get("PO_QTY") == null ? "" : jsondata.get("PO_QTY").toString();
					String V_PO_PRC = jsondata.get("PO_PRC") == null ? "" : jsondata.get("PO_PRC").toString();
					String V_PO_AMT = jsondata.get("PO_AMT") == null ? "" : jsondata.get("PO_AMT").toString();
					String V_PO_LOC_AMT = jsondata.get("PO_LOC_AMT") == null ? "" : jsondata.get("PO_LOC_AMT").toString();
					String V_PO_VAT_AMT = jsondata.get("PO_VAT_AMT") == null ? "" : jsondata.get("PO_VAT_AMT").toString();
					V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD");
					if (V_TYPE.equals("B")) {
						V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
					}
					String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
					String V_OVER_TOL = jsondata.get("OVER_TOL") == null ? "" : jsondata.get("OVER_TOL").toString();
					if (V_OVER_TOL.equals("null")) {
						V_OVER_TOL = "";
					}
					String V_UNDER_TOL = jsondata.get("UNDER_TOL") == null ? "" : jsondata.get("UNDER_TOL").toString();
					if (V_UNDER_TOL == null) {
						V_UNDER_TOL = "";
					}
					String V_PUR_NO = jsondata.get("PUR_NO") == null ? "" : jsondata.get("PUR_NO").toString();
					String V_PUR_SEQ = jsondata.get("PUR_SEQ") == null ? "" : jsondata.get("PUR_SEQ").toString();

					String V_DLVY_HOPE_DT = jsondata.get("DLVY_HOPE_DT") == null ? "" : jsondata.get("DLVY_HOPE_DT").toString();
					if (V_DLVY_HOPE_DT.equals("null")) {
						V_DLVY_HOPE_DT = "";
						// 					System.out.println("텍스트 null");
					} else if (V_DLVY_HOPE_DT == null) {
						// 					System.out.println("진짜null");
					} else if (V_DLVY_HOPE_DT.equals("")) {
						// 					System.out.println("공백");
					} else {
						// 					System.out.println("엘사?");
						V_DLVY_HOPE_DT = V_DLVY_HOPE_DT.substring(0, 10);
					}

					String V_HOPE_SL_CD = jsondata.get("HOPE_SL_CD") == null ? "" : jsondata.get("HOPE_SL_CD").toString();
					if (V_HOPE_SL_CD.equals("null")) {
						V_HOPE_SL_CD = "";
					}

					String V_SUPP_REMARK = jsondata.get("SUPP_REMARK") == null ? "" : jsondata.get("SUPP_REMARK").toString();
					cs = conn.prepareCall("call USP_M_PO_HSPF_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_PO_NO);//V_PO_NO
					cs.setString(4, V_PO_SEQ);//V_PO_SEQ
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, V_PO_QTY);//V_PO_QTY
					cs.setString(7, V_PO_PRC);//V_PO_PRC
					cs.setString(8, V_PO_AMT);//V_PO_AMT
					cs.setString(9, V_PO_LOC_AMT);//V_PO_LOC_AMT
					cs.setString(10, V_VAT_TYPE);//V_VAT_TYPE
					cs.setString(11, V_PO_VAT_AMT);//V_PO_VAT_AMT
					cs.setString(12, V_DLVY_HOPE_DT);//V_DLVY_HOPE_DT
					cs.setString(13, V_HOPE_SL_CD);//V_HOPE_SL_CD
					cs.setString(14, V_OVER_TOL);//V_OVER_TOL
					cs.setString(15, V_UNDER_TOL);//V_UNDER_TOL
					cs.setString(16, V_SUPP_REMARK);//V_SUPP_REMARK
					cs.setString(17, V_PUR_NO);//V_PUR_NO
					cs.setString(18, V_PUR_SEQ);//V_PUR_SEQ
					cs.setString(19, V_M_BP_CD);//V_M_BP_CD
					cs.setString(20, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(21, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					if (V_TYPE.equals("B")) {
						rs = (ResultSet) cs.getObject(21);
						while (rs.next()) {
							subObject = new JSONObject();
							subObject.put("MB_PRC", rs.getString("MB_PRC"));
							subObject.put("LT", rs.getString("LT"));
							subObject.put("HP_SL_CD", rs.getString("HP_SL_CD"));
							subObject.put("HP_SL_NM", rs.getString("HP_SL_NM"));
							subObject.put("MIN_PO_QTY", rs.getString("MIN_PO_QTY"));
							jsonArray.add(subObject);
						}
					}
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
		}

	} catch (Exception e) {
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


