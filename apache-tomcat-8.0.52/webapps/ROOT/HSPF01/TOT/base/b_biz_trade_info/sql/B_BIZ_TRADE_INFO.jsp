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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_B_BIZ_TRADE_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BP_CD);//V_BP_CD
			cs.setString(4, "");//V_BP_SEQ
			cs.setString(5, "");//V_BUYER_ADDR
			cs.setString(6, "");//V_CONSIGNEE 
			cs.setString(7, "");//V_NOTIFY
			cs.setString(8, "");//V_SHIP_MARK
			cs.setString(9, "");//V_REMARK
			cs.setString(10, "");//V_SELLER
			cs.setString(11, "");//V_BANK_CD
			cs.setString(12, "");//V_BANK_ADDR
			cs.setString(13, "");//V_SWIFT_CODE
			cs.setString(14, "");//V_ABA_NO
			cs.setString(15, "");//V_SHIPMENT
			cs.setString(16, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(18, "");//V_DISCHGE_PORT
			cs.setString(19, "");//V_LOADING_PORT
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(17);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BP_SEQ", rs.getString("BP_SEQ"));
				subObject.put("BUYER_ADDR", rs.getString("BUYER_ADDR"));
				subObject.put("CONSIGNEE", rs.getString("CONSIGNEE"));
				subObject.put("NOTIFY", rs.getString("NOTIFY"));
				subObject.put("SHIP_MARK", rs.getString("SHIP_MARK"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("SELLER", rs.getString("SELLER"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_ADDR", rs.getString("BANK_ADDR"));
				subObject.put("SWIFT_CODE", rs.getString("SWIFT_CODE"));
				subObject.put("ABA_NO", rs.getString("ABA_NO"));
				subObject.put("SHIPMENT", rs.getString("SHIPMENT"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("LOADING_PORT", rs.getString("LOADING_PORT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("I")) {

			String V_BP_SEQ = request.getParameter("V_BP_SEQ") == null ? "" : request.getParameter("V_BP_SEQ").toUpperCase();
			String V_BUYER_ADDR = request.getParameter("V_BUYER_ADDR") == null ? "" : request.getParameter("V_BUYER_ADDR").toUpperCase();
			String V_CONSIGNEE = request.getParameter("V_CONSIGNEE") == null ? "" : request.getParameter("V_CONSIGNEE").toUpperCase();
			String V_NOTIFY = request.getParameter("V_NOTIFY") == null ? "" : request.getParameter("V_NOTIFY").toUpperCase();
			String V_SHIP_MARK = request.getParameter("V_SHIP_MARK") == null ? "" : request.getParameter("V_SHIP_MARK").toUpperCase();
			String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toUpperCase();
			String V_SELLER = request.getParameter("V_SELLER") == null ? "" : request.getParameter("V_SELLER").toUpperCase();
			String V_BANK_CD = request.getParameter("V_BANK_CD") == null ? "" : request.getParameter("V_BANK_CD").toUpperCase();
			String V_BANK_ADDR = request.getParameter("V_BANK_ADDR") == null ? "" : request.getParameter("V_BANK_ADDR").toUpperCase();
			String V_SWIFT_CODE = request.getParameter("V_SWIFT_CODE") == null ? "" : request.getParameter("V_SWIFT_CODE").toUpperCase();
			String V_ABA_NO = request.getParameter("V_ABA_NO") == null ? "" : request.getParameter("V_ABA_NO").toUpperCase();
			String V_SHIPMENT = request.getParameter("V_SHIPMENT") == null ? "" : request.getParameter("V_SHIPMENT").toUpperCase();
			String V_DISCHGE_PORT = request.getParameter("V_DISCHGE_PORT") == null ? "" : request.getParameter("V_DISCHGE_PORT").toUpperCase();
			String V_LOADING_PORT = request.getParameter("V_LOADING_PORT") == null ? "" : request.getParameter("V_LOADING_PORT").toUpperCase();

			cs = conn.prepareCall("call USP_003_B_BIZ_TRADE_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BP_CD);//V_BP_CD
			cs.setString(4, V_BP_SEQ);//V_BP_SEQ
			cs.setString(5, V_BUYER_ADDR);//V_BUYER_ADDR
			cs.setString(6, V_CONSIGNEE);//V_CONSIGNEE 
			cs.setString(7, V_NOTIFY);//V_NOTIFY
			cs.setString(8, V_SHIP_MARK);//V_SHIP_MARK
			cs.setString(9, V_REMARK);//V_REMARK
			cs.setString(10, V_SELLER);//V_SELLER
			cs.setString(11, V_BANK_CD);//V_BANK_CD
			cs.setString(12, V_BANK_ADDR);//V_BANK_ADDR
			cs.setString(13, V_SWIFT_CODE);//V_SWIFT_CODE
			cs.setString(14, V_ABA_NO);//V_ABA_NO
			cs.setString(15, V_SHIPMENT);//V_SHIPMENT
			cs.setString(16, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(18, V_DISCHGE_PORT);//V_DISCHGE_PORT
			cs.setString(19, V_LOADING_PORT);//V_LOADING_PORT
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(17);

			String res = "";
			if (rs.next()) {
				res = rs.getString("RES");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(res);
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


