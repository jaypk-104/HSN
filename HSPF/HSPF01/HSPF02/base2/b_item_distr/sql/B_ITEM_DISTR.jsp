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
	ResultSet rs1 = null;
	CallableStatement cs = null;
	CallableStatement cs1 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_SM_NM = request.getParameter("V_SM_NM") == null ? "" : request.getParameter("V_SM_NM").toUpperCase();

		// 		System.out.println("V_TYPE" + V_TYPE);
		if (V_TYPE.equals("T1")) {

			cs = conn.prepareCall("call DISTR_B_ITEM.USP_B_ITEM_DISTR(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_ITEM_CD);//V_ITEM_CD
			cs.setString(4, V_SM_NM);//V_SM_NM
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BF_TYPE", rs.getString("BF_TYPE"));
				subObject.put("BF_NM", rs.getString("BF_NM"));
				subObject.put("PART_CODE", rs.getString("PART_CODE"));
				subObject.put("LG_TYPE", rs.getString("LG_TYPE"));
				subObject.put("LG_NM", rs.getString("LG_NM"));
				subObject.put("SM_TYPE", rs.getString("SM_TYPE"));
				subObject.put("SM_NM", rs.getString("SM_NM"));
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
		} else if (V_TYPE.equals("T2")) {
			
			cs = conn.prepareCall("call DISTR_B_ITEM.USP_B_ITEM_DISTR(?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_ITEM_CD);//V_ITEM_CD
			cs.setString(4, V_SM_NM);//V_SM_NM
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("BF_TYPE", rs.getString("BF_TYPE"));
				subObject.put("BF_TYPE_NM", rs.getString("BF_TYPE_NM"));
				subObject.put("ST_TYPE", rs.getString("ST_TYPE"));
				subObject.put("ST_TYPE_NM", rs.getString("ST_TYPE_NM"));
				subObject.put("LG_TYPE", rs.getString("LG_TYPE"));
				subObject.put("LG_TYPE_NM", rs.getString("LG_TYPE_NM"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("ORIGIN_NM", rs.getString("ORIGIN_NM"));
				subObject.put("SM_TYPE", rs.getString("SM_TYPE"));
				subObject.put("SM_TYPE_NM", rs.getString("SM_TYPE_NM"));
				subObject.put("GRADE", rs.getString("GRADE"));
				subObject.put("GRADE_NM", rs.getString("GRADE_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("USR_NM", rs.getString("USR_NM"));
				subObject.put("UPDT_DT", rs.getString("UPDT_DT"));
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
		String res = e.toString();
		pw.print(res);
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
		if (cs1 != null) try {
			cs1.close();
		} catch (SQLException ex) {}
		if (rs1 != null) try {
			rs1.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>


