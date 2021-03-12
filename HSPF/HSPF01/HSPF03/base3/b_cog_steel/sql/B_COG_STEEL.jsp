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

		System.out.println("V_TYPE" + V_TYPE);
		
		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_001_E_APPROV_B_COG_STEEL(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_TYPE
			cs.setString(2, V_TYPE);//V_COMP_ID
			cs.setString(3, "");//V_RISK_NO
			cs.setString(4, "");//V_RISK_DOC_NO
			cs.setString(5, "");//V_DEPT_CD
			cs.setString(6, "");//V_QTY
			cs.setString(7, "");//V_RISK_DT
			cs.setString(8, "");//V_RISK_NM
			cs.setString(9, "");//V_SALE_TYPE
			cs.setString(10, "");//V_IV_TYPE
			cs.setString(11, "");//V_MON_APR_AMT
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("TYPE_CD", rs.getString("TYPE_CD"));
				subObject.put("DTL_NM", rs.getString("DTL_NM"));
				subObject.put("COGS_CD", rs.getString("COGS_CD"));
				subObject.put("COGS_NM", rs.getString("COGS_NM"));
				subObject.put("BS_CUR", rs.getString("BS_CUR"));
				subObject.put("CALC_TYPE", rs.getString("CALC_TYPE"));
				subObject.put("DOC_PRC", rs.getString("DOC_PRC"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
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


