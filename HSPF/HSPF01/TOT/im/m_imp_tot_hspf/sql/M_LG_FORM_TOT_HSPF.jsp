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

<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.reflect.InvocationTargetException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Properties"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
				
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_M_LG_FORM_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE 
			cs.setString(2, V_BL_DOC_NO);//V_BL_DOC_NO 
			cs.setString(3, "");//V_LC_DOC_NO 
			cs.setString(4, "");//V_BP_NM 
			cs.setString(5, "");//V_SHPNG_COMPANY 
			cs.setString(6, "");//V_VESSEL_NM
			cs.setString(7, "");//V_VOYAGE_NO 
			cs.setString(8, "");//V_LOADING_PORT 
			cs.setString(9, "");//V_DISCHGE_PORT 
			cs.setString(10, "");//V_PACKAGE_CNT
			cs.setString(11, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
		       
			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("SHPNG_COMPANY", rs.getString("SHPNG_COMPANY"));
				subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
				subObject.put("VOYAGE_NO", rs.getString("VOYAGE_NO"));
				subObject.put("LOADING_PORT", rs.getString("LOADING_PORT"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("PACKAGE_CNT", rs.getString("PACKAGE_CNT"));
				subObject.put("REMARK1", rs.getString("REMARK1"));
				subObject.put("REMARK2", rs.getString("REMARK2"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("I")) {

			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
			String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
			String V_SHPNG_COMPANY = request.getParameter("V_SHPNG_COMPANY") == null ? "" : request.getParameter("V_SHPNG_COMPANY").toUpperCase();
			String V_VESSEL_NM = request.getParameter("V_VESSEL_NM") == null ? "" : request.getParameter("V_VESSEL_NM").toUpperCase();
			String V_VOYAGE_NO = request.getParameter("V_VOYAGE_NO") == null ? "" : request.getParameter("V_VOYAGE_NO").toUpperCase();
			String V_LOADING_PORT = request.getParameter("V_LOADING_PORT") == null ? "" : request.getParameter("V_LOADING_PORT").toUpperCase();
			String V_DISCHGE_PORT = request.getParameter("V_DISCHGE_PORT") == null ? "" : request.getParameter("V_DISCHGE_PORT").toUpperCase();
			String V_PACKAGE_CNT = request.getParameter("V_PACKAGE_CNT") == null ? "" : request.getParameter("V_PACKAGE_CNT").toUpperCase();
			
			cs = conn.prepareCall("call USP_003_M_LG_FORM_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE 
			cs.setString(2, V_BL_DOC_NO);//V_BL_DOC_NO 
			cs.setString(3, V_LC_DOC_NO);//V_LC_DOC_NO 
			cs.setString(4, V_BP_NM);//V_BP_NM 
			cs.setString(5, V_SHPNG_COMPANY);//V_SHPNG_COMPANY 
			cs.setString(6, V_VESSEL_NM);//V_VESSEL_NM
			cs.setString(7, V_VOYAGE_NO);//V_VOYAGE_NO 
			cs.setString(8, V_LOADING_PORT);//V_LOADING_PORT 
			cs.setString(9, V_DISCHGE_PORT);//V_DISCHGE_PORT 
			cs.setString(10, V_PACKAGE_CNT);//V_PACKAGE_CNT
			cs.setString(11, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
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
		if (cs2 != null) try {
			cs2.close();
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


