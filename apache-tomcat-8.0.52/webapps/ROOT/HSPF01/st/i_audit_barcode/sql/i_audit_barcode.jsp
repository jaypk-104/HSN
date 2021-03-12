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
		String V_AUDIT_DT = request.getParameter("V_AUDIT_DT") == null ? "" : request.getParameter("V_AUDIT_DT").substring(0, 10);
		String V_BARCODE_YN = request.getParameter("V_BARCODE_YN") == null ? "" : request.getParameter("V_BARCODE_YN");
		
// 		System.out.println( V_BARCODE_YN );
		
		if(V_BARCODE_YN.equals("A")) {
			V_BARCODE_YN = "";
		}
		String V_BARCODE_NO = request.getParameter("V_BARCODE_NO") == null ? "" : request.getParameter("V_BARCODE_NO");

		cs = conn.prepareCall("call USP_I_AUDIT_BARCODE_HSPF(?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_COMP_ID);//V_COMP_ID
		cs.setString(3, V_AUDIT_DT);//V_AUDIT_DT
		cs.setString(4, V_BARCODE_NO);//V_BARCODE_NO
		cs.setString(5, V_BARCODE_YN);//V_BARCODE_YN
		cs.setString(6, V_USR_ID);//VV_SL_CD
		cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();
		
		rs = (ResultSet) cs.getObject(7);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("GR_DT", rs.getString("GR_DT"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
			subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
			subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
			subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
			subObject.put("CHECK_YN", rs.getString("CHECK_YN"));
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

// 		System.out.println(jsonObject);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

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



