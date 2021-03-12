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
		String V_DLV_REQ_DT_FR = request.getParameter("V_DLV_REQ_DT_FR") == null ? "" : request.getParameter("V_DLV_REQ_DT_FR").substring(0,10);
		String V_DLV_REQ_DT_TO = request.getParameter("V_DLV_REQ_DT_TO") == null ? "" : request.getParameter("V_DLV_REQ_DT_TO").substring(0,10);
		String V_TO_SL_CD = request.getParameter("V_TO_SL_CD") == null ? "" : request.getParameter("V_TO_SL_CD");
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0,10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0,10);
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		if(V_TO_SL_CD.equals("T")){
			V_TO_SL_CD = "";
		}


		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_SCM_QUERY_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "");//V_M_BP_CD
			cs.setString(3, V_DLV_REQ_DT_FR);//V_DLV_REQ_DT_FR
			cs.setString(4, V_DLV_REQ_DT_TO);//V_DLV_REQ_DT_TO
			cs.setString(5, V_TO_SL_CD);//V_TO_SL_CD
			cs.setString(6, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(7, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(8, V_ITEM_CD);//V_ITEM_CD
			cs.setString(9, "");//V_ITEM_NM
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("DLVY_AVL_QTY", rs.getString("DLVY_AVL_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("HOPE_SL_CD", rs.getString("HOPE_SL_CD"));
				subObject.put("HOPE_SL_NM", rs.getString("HOPE_SL_NM"));
				subObject.put("PRINT_FLG", rs.getString("PRINT_FLG"));
				
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




