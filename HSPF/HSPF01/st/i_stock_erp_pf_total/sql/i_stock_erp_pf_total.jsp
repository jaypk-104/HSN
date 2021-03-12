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
<%@ include file="/HSPF01/common/DB_Connection_ERP_TEMP.jsp"%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Locale"%>

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
		String V_BASE_DT = request.getParameter("V_BASE_DT") == null ? "" : request.getParameter("V_BASE_DT").substring(0, 10).replaceAll("-", "");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD");

// 		System.out.println("V_BASE_DT" + V_BASE_DT);
// 		System.out.println("V_SL_CD" + V_SL_CD);
		if(V_SL_CD.equals("T")){
			V_SL_CD = "";
		}
		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_I_STOCK_ERP_PF_TOTAL(?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BASE_DT);//V_BASE_DT
			cs.setString(4, V_SL_CD);//V_SL_CD
			cs.setString(5, V_ITEM_CD);//V_ITEM_CD
			cs.setString(6, V_ITEM_NM);//V_ITEM_NM
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {

				subObject = new JSONObject();
				subObject.put("ITEM_GROUP_TYPE", rs.getString("ITEM_GROUP_TYPE"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("GUBUN", rs.getString("GUBUN"));
				subObject.put("GUBUN_NM", rs.getString("GUBUN_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("STOCK_QTY", rs.getFloat("STOCK_QTY"));
				subObject.put("STOCK_AMT", rs.getFloat("STOCK_AMT"));
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
		else if (V_TYPE.equals("EXECUTE")) {

			Calendar calendar = new GregorianCalendar(Locale.KOREA);
			int nYear = calendar.get(Calendar.YEAR);

			String firstDate = nYear + "-01-01";
			String lastDate = nYear + "-12-31";
			
// 			System.out.println(firstDate);

// 			System.out.println("V_BAS_DT" + V_BAS_DT); 
			//EXEC USP_M4111MA10_INPUT_SUM_ERP '20180101','20181121','','','','',''
			e_cs = e_conn.prepareCall("{call USP_M4111MA10_INPUT_SUM_ERP(?,?,?,?,?,?,?)}");
			e_cs.setString(1, "2018-01-01");
			e_cs.setString(2, V_BASE_DT);
			e_cs.setString(3, "");
			e_cs.setString(4, "");
			e_cs.setString(5, "");
			e_cs.setString(6, "");
			e_cs.setString(7, "");
			e_cs.execute();
			
			
			cs = conn.prepareCall("call USP_STOCK_SUMMARY_HSPF(?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_BASE_DT);//V_YYYYMMDD
			cs.setString(3, V_USR_ID);//V_USR_ID
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

		//MSSQL
		if (e_cs != null) try {
			e_cs.close();
		} catch (SQLException ex) {}
		if (e_rs != null) try {
			e_rs.close();
		} catch (SQLException ex) {}
		if (e_stmt != null) try {
			e_stmt.close();
		} catch (SQLException ex) {}
		if (e_conn != null) try {
			e_conn.close();
		} catch (SQLException ex) {}
	}
%>



