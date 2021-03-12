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
		String V_SO_DT_FR = request.getParameter("V_SO_DT_FR") == null ? "" : request.getParameter("V_SO_DT_FR").substring(0, 10);
		String V_SO_DT_TO = request.getParameter("V_SO_DT_TO") == null ? "" : request.getParameter("V_SO_DT_TO").substring(0, 10);
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");

		//수주헤더저장
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_S_SO_QUERY_HSPF(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_SO_DT_FR); //V_SO_DT_FR
			cs.setString(4, V_SO_DT_TO); //V_SO_DT_TO
			cs.setString(5, V_S_BP_NM); //V_S_BP_CD
			cs.setString(6, V_ITEM_CD); //V_ITEM_CD
			cs.setString(7, V_ITEM_NM); //V_ITEM_NM
			cs.setString(8, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(9);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SO_USR_NM", rs.getString("SO_USR_NM"));
				subObject.put("SO_DT", rs.getString("SO_DT").substring(0, 10));
				subObject.put("SO_TYPE", rs.getString("SO_TYPE"));
				subObject.put("SO_TYPE_NM", rs.getString("SO_TYPE_NM"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("SO_NO", rs.getString("SO_NO"));
				subObject.put("SO_SEQ", rs.getString("SO_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("SO_QTY", rs.getString("SO_QTY"));
				subObject.put("SO_PRICE", rs.getString("SO_PRICE"));
				subObject.put("SO_AMT", rs.getString("SO_AMT"));
				subObject.put("SO_LOC_AMT", rs.getString("SO_LOC_AMT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("REMAIN_QTY", rs.getString("REMAIN_QTY"));
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



