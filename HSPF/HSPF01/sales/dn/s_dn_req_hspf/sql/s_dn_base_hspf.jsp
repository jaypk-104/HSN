<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
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
		String V_TITLE = request.getParameter("V_TITLE") == null ? "" : request.getParameter("V_TITLE");
		String V_TO_NM = request.getParameter("V_TO_NM") == null ? "" : request.getParameter("V_TO_NM");
		String V_TO_USR_NM = request.getParameter("V_TO_USR_NM") == null ? "" : request.getParameter("V_TO_USR_NM");
		String V_FROM_NM = request.getParameter("V_FROM_NM") == null ? "" : request.getParameter("V_FROM_NM");
		String V_FROM_USR_NM = request.getParameter("V_FROM_USR_NM") == null ? "" : request.getParameter("V_FROM_USR_NM");
		String V_FROM_USR_TEL = request.getParameter("V_FROM_USR_TEL") == null ? "" : request.getParameter("V_FROM_USR_TEL");
		String V_TO_USR_TEL = request.getParameter("V_TO_USR_TEL") == null ? "" : request.getParameter("V_TO_USR_TEL");
		String V_ARRV_COMP_NM = request.getParameter("V_ARRV_COMP_NM") == null ? "" : request.getParameter("V_ARRV_COMP_NM");
		String V_ARRV_COMP_ADDR = request.getParameter("V_ARRV_COMP_ADDR") == null ? "" : request.getParameter("V_ARRV_COMP_ADDR");
		String V_DLV_IND_NM = request.getParameter("V_DLV_IND_NM") == null ? "" : request.getParameter("V_DLV_IND_NM");
		String V_REQ_TEXT = request.getParameter("V_REQ_TEXT") == null ? "" : request.getParameter("V_REQ_TEXT");
		String V_VEH_INFO_REQUESTOR = request.getParameter("V_VEH_INFO_REQUESTOR") == null ? "" : request.getParameter("V_VEH_INFO_REQUESTOR");
		String V_VEH_INFO_REQUESTOR_TEL = request.getParameter("V_VEH_INFO_REQUESTOR_TEL") == null ? "" : request.getParameter("V_VEH_INFO_REQUESTOR_TEL");

// 		System.out.println("V_TYPE" + V_TYPE);
		
		//출고지시정보(Favor) 신규등록

		cs = conn.prepareCall("call USP_S_DN_BASE2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_COMP_ID);//V_COMP_ID
		cs.setString(3, V_TITLE);//V_TITLE
		cs.setString(4, V_USR_ID);//V_MGM_USR_ID = V_USR_ID
		cs.setString(5, V_TO_NM);//V_TO_NM
		cs.setString(6, V_TO_USR_NM);//V_TO_USR_NM
		cs.setString(7, V_FROM_NM);//V_FROM_NM
		cs.setString(8, V_FROM_USR_NM);//V_FROM_USR_NM
		cs.setString(9, V_FROM_USR_TEL);//V_FROM_USR_TEL
		cs.setString(10, V_ARRV_COMP_NM);//V_ARRV_COMP_NM
		cs.setString(11, V_ARRV_COMP_ADDR);//V_ARRV_COMP_ADDR
		cs.setString(12, V_DLV_IND_NM);//V_DLV_IND_NM
		cs.setString(13, V_REQ_TEXT);//V_REQ_TEXT
		cs.setString(14, V_USR_ID);//V_USR_ID
		cs.setString(15, V_TO_USR_TEL);//V_USR_ID
		cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
		cs.setString(17, V_VEH_INFO_REQUESTOR);//
		cs.setString(18, V_VEH_INFO_REQUESTOR_TEL);//
		cs.executeQuery();

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



