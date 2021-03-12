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

		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0, 10);
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		String V_SL_CD_LEFT = request.getParameter("V_SL_CD_LEFT").equals("T") ? "" : request.getParameter("V_SL_CD_LEFT");


		if (V_TYPE.equals("S")) {
			V_USR_ID = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
		System.out.println(V_USR_ID);
			
			cs = conn.prepareCall("call USP_S_DN_REQ_HSPF_NEW(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(4, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(5, V_ITEM_CD);//V_ITEM_CD
			cs.setString(6, V_SL_CD_LEFT);//V_S_BP_CD
			cs.setString(7, "");//V_S_BP_NM
			cs.setString(8, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(9);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("REQ_NO", rs.getString("REQ_NO"));
				subObject.put("REQ_SEQ", rs.getString("REQ_SEQ"));
				subObject.put("REQ_DT", rs.getString("REQ_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("BP_ITEM_NM", rs.getString("BP_ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("REQ_DT", rs.getString("REQ_DT"));
				subObject.put("REQ_QTY", rs.getString("REQ_QTY"));
				subObject.put("TO_SL_CD", rs.getString("TO_BP_SL_CD"));
				subObject.put("CANCEL_QTY", rs.getString("CANCEL_QTY"));
				subObject.put("FLG", rs.getString("FLG"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("DD_QTY", rs.getString("DD_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("PO_REMAIN_QTY", rs.getString("PO_REMAIN_QTY"));
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

		} else if (V_TYPE.equals("PO_MAPPING")) {

			cs = conn.prepareCall("call USP_S_DN_REQ_HSPF_NEW(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, "");//V_COMP_ID
			cs.setString(3, "");//V_PO_DT_FR
			cs.setString(4, "");//V_PO_DT_TO
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_S_BP_CD
			cs.setString(7, "");//V_S_BP_NM
			cs.setString(8, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			cs = conn.prepareCall("call USP_M_PROD_TO_S_DR(?,?,?,?)");
			// 			cs.setString(1, V_TYPE);//V_TYPE
			// 			cs.setString(2, V_COMP_ID);//V_COMP_ID
			// 			cs.setString(3, "");//V_DR_DT_FROM
			// 			cs.setString(4, V_USR_ID);//V_DR_DT_TO
			// 			cs.executeQuery();

		}
		// 		else if (V_TYPE.equals("SO_REQ_MAKE")) {

		// 			

		// 		}

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



