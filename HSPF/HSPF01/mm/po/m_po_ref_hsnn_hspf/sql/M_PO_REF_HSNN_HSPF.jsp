<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		String V_TYPE = request.getParameter("V_TYPE").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");

		System.out.println("V_TYPE" + V_TYPE);

		if (V_TYPE.equals("S")) {
			String u_na_dt_to = request.getParameter("u_na_dt_to").substring(0, 10);
			String u_na_dt_from = request.getParameter("u_na_dt_from").substring(0, 10);
			String u_dt_to = request.getParameter("u_dt_to").substring(0, 10);
			String u_dt_from = request.getParameter("u_dt_from").substring(0, 10);
			String u_po_no = request.getParameter("u_po_no");
			String poradio = request.getParameter("poradio");

			String V_chk_AA = request.getParameter("V_chk_AA");
			String V_chk_AU = request.getParameter("V_chk_AU");
			String V_chk_AM = request.getParameter("V_chk_AM");
			String V_chk_TN = request.getParameter("V_chk_TN");

			String V_PLANT_CD = "";

			cs = conn.prepareCall("call USP_M_PO_REF_HSNN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "S");
			cs.setString(2, u_po_no);
			cs.setString(3, "");
			cs.setString(4, u_na_dt_from);
			cs.setString(5, u_na_dt_to);
			cs.setString(6, u_dt_from);
			cs.setString(7, u_dt_to);
			cs.setString(8, poradio);
			cs.setString(9, V_chk_AA);
			cs.setString(10, V_chk_AU);
			cs.setString(11, V_chk_AM);
			cs.setString(12, V_chk_TN);
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(14, V_USR_ID);
			cs.setString(15, "");
			cs.setString(16, "");

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(13);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_CFM", rs.getString("PO_CFM"));
				subObject.put("PO_YN", rs.getString("PO_YN"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", Integer.parseInt(rs.getString("PO_SEQ")));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("PLANT_CD", rs.getString("PLANT_CD"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("SL_QTY", rs.getFloat("SL_QTY"));
				subObject.put("SL_PRC", rs.getFloat("SL_PRC"));
				subObject.put("SL_AMT", rs.getFloat("SL_AMT"));
				subObject.put("BASE_SL_PRC", rs.getFloat("BASE_SL_PRC"));
				subObject.put("DLV_DT", rs.getString("DLV_DT").substring(0, 10));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("M_PRC", rs.getFloat("M_PRC"));
				subObject.put("PLANT_NM", rs.getString("PLANT_NM"));

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
				int roop_flag = 0;
				String NEW_PO_NO = "";

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();

					if (V_TYPE.equals("I")) {

						if (roop_flag == 0) {
							cs = conn.prepareCall("call USP_M_PO_REF_HSNN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, "IH");
							cs.setString(2, V_PO_NO);
							cs.setString(3, V_PO_SEQ);
							cs.setString(4, "");
							cs.setString(5, "");
							cs.setString(6, "");
							cs.setString(7, "");
							cs.setString(8, "");
							cs.setString(9, "");
							cs.setString(10, "");
							cs.setString(11, "");
							cs.setString(12, "");
							cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
							cs.setString(14, V_USR_ID);
							cs.setString(15, V_M_BP_CD);
							cs.setString(16, "");
							cs.execute();
							roop_flag++;

							rs = (ResultSet) cs.getObject(13);

							if (rs.next()) {
								NEW_PO_NO = rs.getString("NEW_PO_NO");
							}
						}

						cs = conn.prepareCall("call USP_M_PO_REF_HSNN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, "ID");
						cs.setString(2, V_PO_NO);
						cs.setString(3, V_PO_SEQ);
						cs.setString(4, "");
						cs.setString(5, "");
						cs.setString(6, "");
						cs.setString(7, "");
						cs.setString(8, "");
						cs.setString(9, "");
						cs.setString(10, "");
						cs.setString(11, "");
						cs.setString(12, "");
						cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(14, V_USR_ID);
						cs.setString(15, V_M_BP_CD);
						cs.setString(16, NEW_PO_NO);
						cs.execute();
					}

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();

				System.out.println("V_TYPE" + V_TYPE);
				System.out.println("V_PO_NO" + V_PO_NO);
				System.out.println("V_PO_SEQ" + V_PO_SEQ);
				System.out.println("V_M_BP_CD" + V_M_BP_CD);

				String NEW_PO_NO = "";

				if (V_TYPE.equals("I")) {
					cs = conn.prepareCall("call USP_M_PO_REF_HSNN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "IH");
					cs.setString(2, V_PO_NO);
					cs.setString(3, V_PO_SEQ);
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, "");
					cs.setString(7, "");
					cs.setString(8, "");
					cs.setString(9, "");
					cs.setString(10, "");
					cs.setString(11, "");
					cs.setString(12, "");
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(14, V_USR_ID);
					cs.setString(15, V_M_BP_CD);
					cs.setString(16, "");
					cs.execute();

					rs = (ResultSet) cs.getObject(13);

					if (rs.next()) {
						NEW_PO_NO = rs.getString("NEW_PO_NO");
					}

					cs = conn.prepareCall("call USP_M_PO_REF_HSNN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "ID");
					cs.setString(2, V_PO_NO);
					cs.setString(3, V_PO_SEQ);
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, "");
					cs.setString(7, "");
					cs.setString(8, "");
					cs.setString(9, "");
					cs.setString(10, "");
					cs.setString(11, "");
					cs.setString(12, "");
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(14, V_USR_ID);
					cs.setString(15, V_M_BP_CD);
					cs.setString(16, NEW_PO_NO);
					cs.execute();
				}
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
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

