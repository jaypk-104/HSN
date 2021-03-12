<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
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
		
		if (V_TYPE.equals("S")) {
			String V_DT_FR = request.getParameter("V_DT_FR") == null ? "" : request.getParameter("V_DT_FR").toUpperCase();
			String V_DT_TO = request.getParameter("V_DT_TO") == null ? "" : request.getParameter("V_DT_TO").toUpperCase();
			String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();

			if(V_DT_FR.length() > 10){
				V_DT_FR = V_DT_FR.substring(0,10);
			}
			if(V_DT_TO.length() > 10){
				V_DT_TO = V_DT_TO.substring(0,10);
			}
			
			cs = conn.prepareCall("call USP_002_M_B_CON_SELECT_DISTR(?,?,?,?,?,?,?,?)");

			cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(2, V_COMP_ID);//
			cs.setString(3, V_TYPE);//
			cs.setString(4, V_DT_FR);//
			cs.setString(5, V_DT_TO);//
			cs.setString(6, V_BP_NM);//
			cs.setString(7, V_BL_DOC_NO);//
			cs.setString(8, "");//
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(1);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("CONTRACT_DT", rs.getString("CONTRACT_DT"));
				subObject.put("SALE_DEADLINE_DT", rs.getString("SALE_DEADLINE_DT"));
				subObject.put("EX_CON_PRC", rs.getString("EX_CON_PRC"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("S_CON_PRC", rs.getString("S_CON_PRC"));
				subObject.put("S_CON_AMT", rs.getString("S_CON_AMT"));
				subObject.put("BF_IN_AMT", rs.getString("BF_IN_AMT"));
				subObject.put("FILE_YN", rs.getString("FILE_YN"));
				subObject.put("FILE_NM", rs.getString("FILE_NM"));
				subObject.put("FILE_NM_PC", rs.getString("FILE_NM_PC"));
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("REMAIN_BOX_QTY", rs.getString("REMAIN_BOX_QTY"));
				subObject.put("DN_DT", rs.getString("DN_DT"));

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
		// 		System.out.println(cs);
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


