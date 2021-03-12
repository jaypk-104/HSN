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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");
		String V_DD_DT_FR = request.getParameter("V_DD_DT_FR") == null ? "" : request.getParameter("V_DD_DT_FR").substring(0, 10);
		String V_DD_DT_TO = request.getParameter("V_DD_DT_TO") == null ? "" : request.getParameter("V_DD_DT_TO").substring(0, 10);
		String V_DD_NO = request.getParameter("V_DD_NO") == null ? "" : request.getParameter("V_DD_NO");
		String V_CFM_YN = request.getParameter("V_CFM_YN") == null ? "" : request.getParameter("V_CFM_YN");
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");

		if (V_SL_CD.equals("T")) {
			V_SL_CD = "";
		}

		if (V_TYPE.equals("S") || V_TYPE.equals("CB") || V_TYPE.equals("CAR")) {

			cs = conn.prepareCall("call USP_S_DD_CFM_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_S_BP_NM);//V_S_BP_CD
			cs.setString(4, V_DD_DT_FR);//V_DD_DT
			cs.setString(5, V_DD_DT_TO);//V_DD_DT
			cs.setString(6, V_SL_CD);//V_CUST_ORDER_NO
			cs.setString(7, V_DD_NO);//V_DD_NO
			cs.setString(8, "");//V_DD_SEQ
			cs.setString(9, "");//V_CHG_DD_NO
			cs.setString(10, V_CFM_YN);//V_CFM_YN
			cs.setString(11, "");//V_CAR_NO
			cs.setString(12, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				if (V_TYPE.equals("S")) {
					subObject.put("DD_NO", rs.getString("DD_NO"));
					subObject.put("DD_SEQ", rs.getString("DD_SEQ"));
					subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
					subObject.put("TO_SL_NM", rs.getString("TO_SL_NM"));
					subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("DD_DT", rs.getString("DD_DT"));
					subObject.put("DD_QTY", rs.getString("DD_QTY"));
					subObject.put("DN_QTY", rs.getString("DN_QTY"));
					subObject.put("REMAIN_QTY", rs.getString("REMAIN_QTY"));
					subObject.put("CHNG_DD_NO", rs.getString("CHNG_DD_NO"));
					subObject.put("END_YN", rs.getString("END_YN"));
					subObject.put("CAR_NO", rs.getString("CAR_NO"));
					subObject.put("FROM_DD_NO", rs.getString("FROM_DD_NO"));
				} else if (V_TYPE.equals("CB")) {
					subObject.put("DD_NO", rs.getString("DD_NO"));
				} else if (V_TYPE.equals("CAR")) {
					subObject.put("CAR_NO", rs.getString("CAR_NO"));
					subObject.put("CAR_TYPE", rs.getString("CAR_TYPE"));
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
					HashMap jsondata = (HashMap) jsonAr.get(i);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					String V_CUST_ORDER_NO = jsondata.get("CUST_ORDER_NO") == null ? "" : jsondata.get("CUST_ORDER_NO").toString();
					V_DD_NO = jsondata.get("DD_NO") == null ? "" : jsondata.get("DD_NO").toString();
					String V_DD_SEQ = jsondata.get("DD_SEQ") == null ? "" : jsondata.get("DD_SEQ").toString();
					String V_CHG_DD_NO = jsondata.get("CHNG_DD_NO") == null ? "" : jsondata.get("CHNG_DD_NO").toString();
					V_CFM_YN = jsondata.get("END_YN") == null ? "" : jsondata.get("END_YN").toString();
					String V_CAR_NO = jsondata.get("CAR_NO") == null ? "" : jsondata.get("CAR_NO").toString();

					// 					System.out.println("ININININININI");
					// 					System.out.println("V_TYPE :" + V_TYPE);
					// 					System.out.println("V_DD_DT :" + V_DD_DT);
					// 					System.out.println("V_DD_NO :" + V_DD_NO);
					// 					System.out.println("V_DD_SEQ :" + V_DD_SEQ);
					// 					System.out.println("V_CFM_YN :" + V_CFM_YN);

					//출고등록
					cs = conn.prepareCall("call USP_S_DD_CFM_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_S_BP_NM);//V_S_BP_CD
					cs.setString(4, V_DD_DT_FR);//V_DD_DT
					cs.setString(5, V_DD_DT_TO);//V_DD_DT
					cs.setString(6, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
					cs.setString(7, V_DD_NO);//V_DD_NO
					cs.setString(8, V_DD_SEQ);//V_DD_SEQ
					cs.setString(9, V_CHG_DD_NO);//V_CHG_DD_NO
					cs.setString(10, V_CFM_YN);//END_YN
					cs.setString(11, V_CAR_NO);//V_CAR_NO
					cs.setString(12, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_CUST_ORDER_NO = jsondata.get("CUST_ORDER_NO") == null ? "" : jsondata.get("CUST_ORDER_NO").toString();
				V_DD_NO = jsondata.get("DD_NO") == null ? "" : jsondata.get("DD_NO").toString();
				String V_DD_SEQ = jsondata.get("DD_SEQ") == null ? "" : jsondata.get("DD_SEQ").toString();
				String V_CHG_DD_NO = jsondata.get("CHNG_DD_NO") == null ? "" : jsondata.get("CHNG_DD_NO").toString();
				V_CFM_YN = jsondata.get("END_YN") == null ? "" : jsondata.get("END_YN").toString();
				String V_CAR_NO = jsondata.get("CAR_NO") == null ? "" : jsondata.get("CAR_NO").toString();

				// 				System.out.println("V_TYPE :" + V_TYPE);
				// 				System.out.println("V_DD_DT :" + V_DD_DT);
				// 				System.out.println("V_DD_NO :" + V_DD_NO);
				// 				System.out.println("V_DD_SEQ :" + V_DD_SEQ);
				// 				System.out.println("V_CFM_YN :" + V_CFM_YN);

				//출고등록
				cs = conn.prepareCall("call USP_S_DD_CFM_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_S_BP_NM);//V_S_BP_CD
				cs.setString(4, V_DD_DT_FR);//V_DD_DT
				cs.setString(5, V_DD_DT_TO);//V_DD_DT
				cs.setString(6, V_CUST_ORDER_NO);//V_CUST_ORDER_NO
				cs.setString(7, V_DD_NO);//V_DD_NO
				cs.setString(8, V_DD_SEQ);//V_DD_SEQ
				cs.setString(9, V_CHG_DD_NO);//V_CHG_DD_NO
				cs.setString(10, V_CFM_YN);//END_YN
				cs.setString(11, V_CAR_NO);//V_CAR_NO
				cs.setString(12, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
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



