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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();;
		String V_YYMMDD = request.getParameter("V_YYMMDD") == null ? "" : request.getParameter("V_YYMMDD").substring(0, 10).replaceAll("-", "");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();;
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();;

		// 		조회
		if (V_TYPE.equals("HS")) {
			cs = conn.prepareCall("call USP_M_PO_PLAN_LOCAL_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_YYMMDD);//V_YYMMDD
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(6);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("BP_ITEM_NM", rs.getString("BP_ITEM_NM"));
				subObject.put("M_USAGE", rs.getString("M_USAGE"));
				subObject.put("D_USAGE", rs.getString("D_USAGE"));
				subObject.put("SAFE_QTY", rs.getString("SAFE_QTY"));
				subObject.put("MIN_PO_QTY", rs.getString("MIN_PO_QTY"));
				subObject.put("AVG_DN_QTY", rs.getString("AVG_DN_QTY"));
				subObject.put("STOCK_QTY", rs.getString("STOCK_QTY"));
				subObject.put("STOCK_DAY", rs.getString("STOCK_DAY"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("NEW_DLV_DT", rs.getString("NEW_DLV_DT"));
				subObject.put("NEW_DLV_QTY", rs.getString("NEW_DLV_QTY"));
				subObject.put("FT_DN_QTY", rs.getString("FT_DN_QTY"));
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

		} else if (V_TYPE.equals("DS")) {

// 			System.out.println("V_TYPE :" + V_TYPE);
// 			System.out.println("V_COMP_ID :" + V_COMP_ID);
// 			System.out.println("V_USR_ID :" + V_USR_ID);
// 			System.out.println("V_YYMMDD :" + V_YYMMDD);
// 			System.out.println("V_ITEM_CD :" + V_ITEM_CD);
// 			System.out.println("V_ITEM_NM :" + V_ITEM_NM);
			
			cs = conn.prepareCall("call USP_M_PO_PLAN_LOCAL_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_YYMMDD);//V_YYMMDD
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("DLVY_AVL_QTY", rs.getString("DLVY_AVL_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
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
		} else if (V_TYPE.equals("DS2")) {

// 			System.out.println("V_TYPE :" + V_TYPE);
// 			System.out.println("V_COMP_ID :" + V_COMP_ID);
// 			System.out.println("V_USR_ID :" + V_USR_ID);
// 			System.out.println("V_YYMMDD :" + V_YYMMDD);
// 			System.out.println("V_ITEM_CD :" + V_ITEM_CD);
// 			System.out.println("V_ITEM_NM :" + V_ITEM_NM);
			
			cs = conn.prepareCall("call USP_M_PO_PLAN_LOCAL_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_YYMMDD);//V_YYMMDD
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DR_NO", rs.getString("DR_NO"));
				subObject.put("DR_SEQ", rs.getString("DR_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DR_DT", rs.getString("DR_DT"));
				subObject.put("DR_QTY", rs.getString("DR_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("BT")) {
			cs = conn.prepareCall("call USP_M_PO_PLAN_LOCAL_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_YYMMDD);//V_YYMMDD
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
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



