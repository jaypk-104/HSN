<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

		// 		System.out.println("V_TYPE :" + V_TYPE);
		// 		System.out.println("V_COMP_ID :" + V_COMP_ID);
		// 		System.out.println("V_USR_ID :" + V_USR_ID);

		if (V_TYPE.equals("SD")) { //수주상세조회

			String SO_NO = request.getParameter("V_SO_NO") == null ? "" : request.getParameter("V_SO_NO");
			cs = conn.prepareCall("call USP_S_SO_D_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, SO_NO);
			cs.setString(4, ""); //SO_SEQ
			cs.setString(5, ""); //ITEM_CD
			cs.setString(6, ""); //QTY
			cs.setString(7, ""); //PRICE
			cs.setString(8, ""); //AMT
			cs.setString(9, ""); //LOC_AMT
			cs.setString(10, ""); //VAT_TYPE
			cs.setString(11, ""); //VAT_AMT
			cs.setString(12, ""); //DLVY_HOPE_DT
			cs.setString(13, V_USR_ID);
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SO_NO", rs.getString("SO_NO"));
				subObject.put("SO_SEQ", rs.getString("SO_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("QTY", rs.getString("SO_QTY"));
				subObject.put("PRICE", rs.getString("SO_PRICE"));
				subObject.put("AMT", rs.getString("SO_AMT"));
				subObject.put("LOC_AMT", rs.getString("SO_LOC_AMT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("REMAIN_QTY", rs.getString("REMAIN_QTY"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("U")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			String V_SO_NO = request.getParameter("V_SO_NO") == null ? "" : request.getParameter("V_SO_NO");
			String V_SO_TYPE = request.getParameter("V_SO_TYPE") == null ? "" : request.getParameter("V_SO_TYPE");
			String V_SO_DT = request.getParameter("V_SO_DT") == null ? "" : request.getParameter("V_SO_DT").substring(0, 10);
			String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH");
			String V_DLVY_HOPE_DT = request.getParameter("V_DLVY_HOPE_DT") == null ? "" : request.getParameter("V_DLVY_HOPE_DT").substring(0, 10);
			String V_CUST_ORDER_NO = request.getParameter("V_CUST_ORDER_NO") == null ? "" : request.getParameter("V_CUST_ORDER_NO");
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD");
			String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR");
			String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE");
			String V_SO_DT_FROM = request.getParameter("V_SO_DT_FROM") == null ? "" : request.getParameter("V_SO_DT_FROM").substring(0, 10);
			String V_SO_DT_TO = request.getParameter("V_SO_DT_TO") == null ? "" : request.getParameter("V_SO_DT_TO").substring(0, 10);
			String V_SO_CFM = request.getParameter("V_SO_CFM") == null ? "" : request.getParameter("V_SO_CFM");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				String SO_NO = "";

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					if(V_TYPE.equals("IU") || V_TYPE.equals("ID")) {
						SO_NO = hashMap.get("SO_NO") == null ? "" : hashMap.get("SO_NO").toString();
					}
					String SO_SEQ = hashMap.get("SO_SEQ") == null ? "" : hashMap.get("SO_SEQ").toString();
					String ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					String PRICE = hashMap.get("PRICE") == null ? "" : hashMap.get("PRICE").toString();
					String AMT = hashMap.get("AMT") == null ? "" : hashMap.get("AMT").toString();
					String LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
					String VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String DLVY_HOPE_DT = hashMap.get("DLVY_HOPE_DT") == null ? "" : hashMap.get("DLVY_HOPE_DT").toString().substring(0, 10);

					if (V_TYPE.equals("IC")) {
						V_TYPE = "SI";
					} else if (V_TYPE.equals("IU")) {
						V_TYPE = "SU";
					}
					
					if (i == 0) {
						//헤더저장
						cs = conn.prepareCall("call USP_S_SO_H_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);
						cs.setString(2, V_COMP_ID);
						cs.setString(3, V_SO_NO); //V_SO_NO
						cs.setString(4, V_SO_TYPE); //V_SO_TYPE
						cs.setString(5, V_SO_DT); //V_SO_DT
						cs.setString(6, V_PAY_METH); //V_PAY_METH
						cs.setString(7, V_DLVY_HOPE_DT); //V_DLVY_HOPE_DT
						cs.setString(8, V_CUST_ORDER_NO); //V_CUST_ORDER_NO
						cs.setString(9, V_BP_CD); //V_BP_CD
						cs.setString(10, V_CUR); //V_CUR
						cs.setString(11, V_XCH_RATE); //V_XCH_RATE
						cs.setString(12, V_SO_DT_FROM); //V_SO_DT_FROM
						cs.setString(13, V_SO_DT_TO); //V_SO_DT_TO
						cs.setString(14, V_SO_CFM); //V_USR_ID
						cs.setString(15, V_USR_ID); //V_USR_ID
						cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						//수주등록만 수행
						if (V_TYPE.equals("SI")) {
							rs = (ResultSet) cs.getObject(16);
							while (rs.next()) {
								SO_NO = rs.getString("SO_NO");
							}
						}

					}

					if (V_TYPE.equals("SI")) {
						V_TYPE = "IC";
					} else if (V_TYPE.equals("SU")) {

						SO_NO = hashMap.get("SO_NO") == null ? "" : hashMap.get("SO_NO").toString();
						if (SO_SEQ.equals("")) {
							V_TYPE = "IC";
						} else {
							V_TYPE = "IU";
						}
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(SO_NO);
					pw.flush();
					pw.close();

					cs = conn.prepareCall("call USP_S_SO_D_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_COMP_ID);
					cs.setString(3, SO_NO);
					cs.setString(4, SO_SEQ);
					cs.setString(5, ITEM_CD);
					cs.setString(6, QTY);
					cs.setString(7, PRICE);
					cs.setString(8, AMT);
					cs.setString(9, LOC_AMT);
					cs.setString(10, VAT_TYPE);
					cs.setString(11, VAT_AMT);
					cs.setString(12, DLVY_HOPE_DT);
					cs.setString(13, V_USR_ID);
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String SO_NO = jsondata.get("SO_NO") == null ? "" : jsondata.get("SO_NO").toString();
				String SO_SEQ = jsondata.get("SO_SEQ") == null ? "" : jsondata.get("SO_SEQ").toString();
				String ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
				String PRICE = jsondata.get("PRICE") == null ? "" : jsondata.get("PRICE").toString();
				String AMT = jsondata.get("AMT") == null ? "" : jsondata.get("AMT").toString();
				String LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
				String VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String DLVY_HOPE_DT = jsondata.get("DLVY_HOPE_DT") == null ? "" : jsondata.get("DLVY_HOPE_DT").toString().substring(0, 10);

				if (V_TYPE.equals("IC")) {
					V_TYPE = "SI";
				} else if (V_TYPE.equals("IU")) {
					V_TYPE = "SU";
				}

				//헤더저장
				cs = conn.prepareCall("call USP_S_SO_H_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_SO_NO); //V_SO_NO
				cs.setString(4, V_SO_TYPE); //V_SO_TYPE
				cs.setString(5, V_SO_DT); //V_SO_DT
				cs.setString(6, V_PAY_METH); //V_PAY_METH
				cs.setString(7, V_DLVY_HOPE_DT); //V_DLVY_HOPE_DT
				cs.setString(8, V_CUST_ORDER_NO); //V_CUST_ORDER_NO
				cs.setString(9, V_BP_CD); //V_BP_CD
				cs.setString(10, V_CUR); //V_CUR
				cs.setString(11, V_XCH_RATE); //V_XCH_RATE
				cs.setString(12, V_SO_DT_FROM); //V_SO_DT_FROM
				cs.setString(13, V_SO_DT_TO); //V_SO_DT_TO
				cs.setString(14, V_SO_CFM); //V_USR_ID
				cs.setString(15, V_USR_ID); //V_USR_ID
				cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				//수주등록만 수행
				if (V_TYPE.equals("SI")) {
					rs = (ResultSet) cs.getObject(16);
					while (rs.next()) {
						SO_NO = rs.getString("SO_NO");
					}
				}

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(SO_NO);
				pw.flush();
				pw.close();

				if (V_TYPE.equals("SI")) {
					V_TYPE = "IC";
				} else if (V_TYPE.equals("SU")) {
					SO_NO = jsondata.get("SO_NO") == null ? "" : jsondata.get("SO_NO").toString();
					if (SO_SEQ.equals("")) {
						V_TYPE = "IC";
					} else {
						V_TYPE = "IU";
					}
				}
				cs = conn.prepareCall("call USP_S_SO_D_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_COMP_ID);
				cs.setString(3, SO_NO);
				cs.setString(4, SO_SEQ);
				cs.setString(5, ITEM_CD);
				cs.setString(6, QTY);
				cs.setString(7, PRICE);
				cs.setString(8, AMT);
				cs.setString(9, LOC_AMT);
				cs.setString(10, VAT_TYPE);
				cs.setString(11, VAT_AMT);
				cs.setString(12, DLVY_HOPE_DT);
				cs.setString(13, V_USR_ID);
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
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


