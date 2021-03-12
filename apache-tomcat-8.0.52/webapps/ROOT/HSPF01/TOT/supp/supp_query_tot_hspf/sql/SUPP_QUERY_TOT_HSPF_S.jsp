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
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD");
		
		String V_DLV_REQ_DT_FR = request.getParameter("V_DLV_REQ_DT_FR") == null ? "" : request.getParameter("V_DLV_REQ_DT_FR").substring(0,10);
		String V_DLV_REQ_DT_TO = request.getParameter("V_DLV_REQ_DT_TO") == null ? "" : request.getParameter("V_DLV_REQ_DT_TO").substring(0,10);
		String V_DLV_DT_CHECK = request.getParameter("V_DLV_DT_CHECK") == null ? "" : request.getParameter("V_DLV_DT_CHECK");
		
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO");
		String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO");
		
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0,10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0,10);
		String V_PO_DT_CHECK = request.getParameter("V_PO_DT_CHECK") == null ? "" : request.getParameter("V_PO_DT_CHECK");
		
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");

// 		System.out.println("V_DLV_DT_CHECK : " + V_DLV_DT_CHECK);
// 		System.out.println("V_PO_DT_CHECK : " + V_PO_DT_CHECK);
		
		
		if(V_DLV_DT_CHECK.equals("false")){
			V_DLV_REQ_DT_FR = "2020-01-01";
			V_DLV_REQ_DT_TO = "3020-01-01";
		}
		if(V_PO_DT_CHECK.equals("false")){
			V_PO_DT_FR = "2020-01-01";
			V_PO_DT_TO = "3020-01-01";
		}
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_SUPP_QUERY_TOT_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_BP_CD);//V_BP_CD
			cs.setString(3, V_DLV_REQ_DT_FR);//V_DLV_REQ_DT_FR
			cs.setString(4, V_DLV_REQ_DT_TO);//V_DLV_REQ_DT_TO
			cs.setString(5, V_PO_NO);//V_PO_NO
			cs.setString(6, V_ASN_NO);//V_ASN_NO
			cs.setString(7, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(8, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(9, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
				subObject.put("PRINT_FLG", rs.getString("PRINT_FLG"));
				subObject.put("BARCODE_DT", rs.getString("BARCODE_DT"));
				subObject.put("FILE_YN", rs.getString("FILE_YN"));
				subObject.put("FILE_CONFIRM", rs.getString("FILE_CONFIRM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				
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




