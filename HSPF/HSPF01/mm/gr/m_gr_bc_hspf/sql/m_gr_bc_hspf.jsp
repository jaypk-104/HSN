<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	JSONObject anyObject = new JSONObject();
	JSONArray anyArray = new JSONArray();
	JSONObject anySubObject = new JSONObject();

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_GR_DT_FROM = request.getParameter("V_GR_DT_FROM") == null ? "" : request.getParameter("V_GR_DT_FROM").substring(0, 10);
		String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null ? "" : request.getParameter("V_GR_DT_TO").substring(0, 10);
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM");

		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");
		String V_LC_CD = request.getParameter("V_LC_CD") == null ? "" : request.getParameter("V_LC_CD");
		String V_RACK_CD = request.getParameter("V_RACK_CD") == null ? "" : request.getParameter("V_RACK_CD");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
		if (V_SL_CD.equals("T")) {
			V_SL_CD = "";
		}
		if (V_LC_CD.equals("T")) {
			V_LC_CD = "";
		}
		if (V_RACK_CD.equals("T")) {
			V_RACK_CD = "";
		}

		// 바코드입고조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_M_GR_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_GR_DT_FROM);//V_GR_DT_FR
			cs.setString(4, V_GR_DT_TO);//V_GR_DT_TO
			cs.setString(5, "");//V_M_BP_CD
			cs.setString(6, V_M_BP_NM);//V_M_BP_NM
			cs.setString(7, V_SL_CD);//V_SL_CD
			cs.setString(8, V_LC_CD);//V_LC_CD
			cs.setString(9, V_RACK_CD);//V_RACK_CD
			cs.setString(10, "");//V_LOT_BC_NO
			cs.setString(11, V_ITEM_CD);//V_ITEM_CD
			cs.setString(12, V_ITEM_NM);//V_ITEM_NM
			cs.setString(13, V_BL_NO);//V_GR_NO   임시로 V_BL_NO로 사용. 20180628 김장운.
			cs.setString(14, "");//V_GR_SEQ
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);

			cs.executeQuery();

			rs = (ResultSet) cs.getObject(15);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("GR_SEQ", rs.getString("GR_SEQ"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("LC_NM", rs.getString("LC_NM"));
				subObject.put("RACK_NM", rs.getString("RACK_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("GR_AMT", rs.getString("GR_AMT"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("IF_YN", rs.getString("IF_YN"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("GR_USR_NM", rs.getString("GR_USR_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));

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
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
					String GR_SEQ = hashMap.get("GR_SEQ") == null ? "" : hashMap.get("GR_SEQ").toString();
					String LOT_BC_NO = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();

					if (V_TYPE.equals("IF")) {
						anySubObject = new JSONObject();
						anySubObject.put("V_GR_NO", GR_NO);
						anySubObject.put("V_GR_SEQ", GR_SEQ);
						anySubObject.put("V_USR_ID", V_USR_ID);
						anyArray.add(anySubObject);
					} else {
						cs = conn.prepareCall("call USP_M_GR_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_GR_DT_FROM);//V_GR_DT_FR
						cs.setString(4, V_GR_DT_TO);//V_GR_DT_TO
						cs.setString(5, "");//V_M_BP_CD
						cs.setString(6, V_M_BP_NM);//V_M_BP_NM
						cs.setString(7, V_SL_CD);//V_SL_CD
						cs.setString(8, V_LC_CD);//V_LC_CD
						cs.setString(9, V_RACK_CD);//V_RACK_CD
						cs.setString(10, LOT_BC_NO);//V_LOT_BC_NO
						cs.setString(11, "");//V_ITEM_CD
						cs.setString(12, "");//V_ITEM_NM
						cs.setString(13, GR_NO);//V_GR_NO
						cs.setString(14, GR_SEQ);//V_GR_SEQ
						cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}

			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();
				String GR_SEQ = jsondata.get("GR_SEQ") == null ? "" : jsondata.get("GR_SEQ").toString();
				String LOT_BC_NO = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();

				if (V_TYPE.equals("IF")) {
					anySubObject = new JSONObject();
					anySubObject.put("V_GR_NO", GR_NO);
					anySubObject.put("V_GR_SEQ", GR_SEQ);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anyArray.add(anySubObject);
				} else {
					cs = conn.prepareCall("call USP_M_GR_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_GR_DT_FROM);//V_GR_DT_FR
					cs.setString(4, V_GR_DT_TO);//V_GR_DT_TO
					cs.setString(5, "");//V_M_BP_CD
					cs.setString(6, V_M_BP_NM);//V_M_BP_NM
					cs.setString(7, V_SL_CD);//V_SL_CD
					cs.setString(8, V_LC_CD);//V_LC_CD
					cs.setString(9, V_RACK_CD);//V_RACK_CD
					cs.setString(10, LOT_BC_NO);//V_LOT_BC_NO
					cs.setString(11, "");//V_ITEM_CD
					cs.setString(12, "");//V_ITEM_NM
					cs.setString(13, GR_NO);//V_GR_NO
					cs.setString(14, GR_SEQ);//V_GR_SEQ
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
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




