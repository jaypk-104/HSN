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
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>

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
		String V_SO_NO = request.getParameter("V_SO_NO") == null ? "" : request.getParameter("V_SO_NO");
		String V_SO_TYPE = request.getParameter("V_SO_TYPE") == null ? "" : request.getParameter("V_SO_TYPE");
		String V_SO_DT = request.getParameter("V_SO_DT") == null ? "" : request.getParameter("V_SO_DT").substring(0, 10);
		String V_PAY_METH = request.getParameter("V_PAY_METH") == null ? "" : request.getParameter("V_PAY_METH");
		String V_DLVY_HOPE_DT = request.getParameter("V_DLVY_HOPE_DT") == null ? "" : request.getParameter("V_DLVY_HOPE_DT").substring(0, 10);
		String V_CUST_ORDER_NO = request.getParameter("V_CUST_ORDER_NO") == null ? "" : request.getParameter("V_CUST_ORDER_NO");
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD");
		String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR");
		String V_XCH_RATE = request.getParameter("V_XCH_RATE") == null ? "" : request.getParameter("V_XCH_RATE");
		String V_SO_DT_FROM = request.getParameter("V_SO_DT_FROM") == null ? "" : request.getParameter("V_SO_DT_FROM").substring(0, 10);
		String V_SO_DT_TO = request.getParameter("V_SO_DT_TO") == null ? "" : request.getParameter("V_SO_DT_TO").substring(0, 10);
		String V_SO_CFM = request.getParameter("V_SO_CFM") == null ? "" : request.getParameter("V_SO_CFM");

// 		System.out.println("V_TYPE :" + V_TYPE);
// 		System.out.println("V_COMP_ID :" + V_COMP_ID);
// 		System.out.println("V_USR_ID :" + V_USR_ID);
// 		System.out.println("V_SO_NO :" + V_SO_NO);
// 		System.out.println("V_SO_TYPE :" + V_SO_TYPE);
// 		System.out.println("V_SO_DT :" + V_SO_DT);
// 		System.out.println("V_PAY_METH :" + V_PAY_METH);
// 		System.out.println("V_DLVY_HOPE_DT :" + V_DLVY_HOPE_DT);
// 		System.out.println("V_CUST_ORDER_NO :" + V_CUST_ORDER_NO);
// 		System.out.println("V_BP_CD :" + V_BP_CD);
// 		System.out.println("V_CUR :" + V_CUR);
// 		System.out.println("V_XCH_RATE :" + V_XCH_RATE);
// 		System.out.println("V_SO_DT_FROM :" + V_SO_DT_FROM);
// 		System.out.println("V_SO_DT_TO :" + V_SO_DT_TO);
// 		System.out.println("V_SO_CFM :" + V_SO_CFM);

		//수주헤더저장
		if (V_TYPE.equals("SI")) {
			cs = conn.prepareCall("call USP_S_SO_H_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_SO_NO); //V_SO_NO
			cs.setString(4, V_SO_TYPE); //V_SO_TYPE
			cs.setString(5, V_SO_DT); //V_SO_DT
			cs.setString(6, V_PAY_METH); //V_PAY_METH
			cs.setString(7, V_DLVY_HOPE_DT); //V_DLVY_HOPE_DT
			cs.setString(8, V_CUST_ORDER_NO); //V_CUST_ORDER_NO
			cs.setString(9, V_BP_CD); //V_BP_CD
			cs.setString(10, V_CUR); //V_CUR
			cs.setString(11, V_XCH_RATE); //V_XCH_RATE
			cs.setString(12, V_SO_DT_FROM); //V_SO_DT_FROM
			cs.setString(13, V_SO_DT_TO); //V_SO_DT_TO
			cs.setString(14, V_SO_CFM); //V_USR_ID
			cs.setString(15, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);
			String SO_NO = "";
			while (rs.next()) {
				SO_NO = rs.getString("SO_NO");
			}
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(SO_NO);
			pw.flush();
			pw.close();
		
		//수주헤더팝업조회
		} else if (V_TYPE.equals("SHP")) {	
			V_BP_CD = request.getParameter("W_S_BP_NM_SO") == null ? "" : request.getParameter("W_S_BP_NM_SO");
			cs = conn.prepareCall("call USP_S_SO_H_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_SO_NO); //V_SO_NO
			cs.setString(4, V_SO_TYPE); //V_SO_TYPE
			cs.setString(5, V_SO_DT); //V_SO_DT
			cs.setString(6, V_PAY_METH); //V_PAY_METH
			cs.setString(7, V_DLVY_HOPE_DT); //V_DLVY_HOPE_DT
			cs.setString(8, V_CUST_ORDER_NO); //V_CUST_ORDER_NO
			cs.setString(9, V_BP_CD); //V_BP_CD
			cs.setString(10, V_CUR); //V_CUR
			cs.setString(11, V_XCH_RATE); //V_XCH_RATE
			cs.setString(12, V_SO_DT_FROM); //V_SO_DT_FROM
			cs.setString(13, V_SO_DT_TO); //V_SO_DT_TO
			cs.setString(14, V_SO_CFM); //V_USR_ID
			cs.setString(15, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SO_NO", rs.getString("SO_NO"));
				subObject.put("SO_DT", rs.getString("SO_DT").substring(0, 10));
				subObject.put("SO_TYPE", rs.getString("SO_TYPE"));
				subObject.put("SO_TYPE_NM", rs.getString("SO_TYPE_NM"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("S_BP_CD", rs.getString("BP_CD"));
				subObject.put("S_BP_NM", rs.getString("BP_NM"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		//수주헤더조회
		} else if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_S_SO_H_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_SO_NO); //V_SO_NO
			cs.setString(4, V_SO_TYPE); //V_SO_TYPE
			cs.setString(5, V_SO_DT); //V_SO_DT
			cs.setString(6, V_PAY_METH); //V_PAY_METH
			cs.setString(7, V_DLVY_HOPE_DT); //V_DLVY_HOPE_DT
			cs.setString(8, V_CUST_ORDER_NO); //V_CUST_ORDER_NO
			cs.setString(9, V_BP_CD); //V_BP_CD
			cs.setString(10, V_CUR); //V_CUR
			cs.setString(11, V_XCH_RATE); //V_XCH_RATE
			cs.setString(12, V_SO_DT_FROM); //V_SO_DT_FROM
			cs.setString(13, V_SO_DT_TO); //V_SO_DT_TO
			cs.setString(14, V_SO_CFM); //V_USR_ID
			cs.setString(15, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SO_NO", rs.getString("SO_NO"));
				subObject.put("SO_DT", rs.getString("SO_DT").substring(0, 10));
				subObject.put("SO_TYPE", rs.getString("SO_TYPE"));
				subObject.put("SO_TYPE_NM", rs.getString("SO_TYPE_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("CUST_ORDER_NO", rs.getString("CUST_ORDER_NO"));
				subObject.put("S_BP_CD", rs.getString("BP_CD"));
				subObject.put("S_BP_NM", rs.getString("BP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		
		// 수주헤더저장, 업데이트, 삭제, 확정/취소
		} else  {
			cs = conn.prepareCall("call USP_S_SO_H_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_SO_NO); //V_SO_NO
			cs.setString(4, V_SO_TYPE); //V_SO_TYPE
			cs.setString(5, V_SO_DT); //V_SO_DT
			cs.setString(6, V_PAY_METH); //V_PAY_METH
			cs.setString(7, V_DLVY_HOPE_DT); //V_DLVY_HOPE_DT
			cs.setString(8, V_CUST_ORDER_NO); //V_CUST_ORDER_NO
			cs.setString(9, V_BP_CD); //V_BP_CD
			cs.setString(10, V_CUR); //V_CUR
			cs.setString(11, V_XCH_RATE); //V_XCH_RATE
			cs.setString(12, V_SO_DT_FROM); //V_SO_DT_FROM
			cs.setString(13, V_SO_DT_TO); //V_SO_DT_TO
			cs.setString(14, V_SO_CFM); //V_USR_ID
			cs.setString(15, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
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



