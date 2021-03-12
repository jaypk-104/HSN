<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	//DbConn dbcon = new DbConn();
	request.setCharacterEncoding("utf-8");
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	CallableStatement cs = null;
	ResultSet rs = null;
	try{
		String V_TYPE = request.getParameter("V_TYPE") == null ? "^" : request.getParameter("V_TYPE");
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "^" : request.getParameter("V_BP_CD");
		String V_BP_NM = request.getParameter("V_BP_NM").equals("T") ? "" : request.getParameter("V_BP_NM");
		
		
		cs = conn.prepareCall("{call USP_B_BIZ_HSPF(?,?,?,?,?,?,?,?,?,?)}");
		cs.setString(1, V_TYPE);
		cs.setString(2, "");
		cs.setString(3, V_BP_CD);
		cs.setString(4, V_BP_NM);
		cs.setString(5, "");
		cs.setString(6, "");
		cs.setString(7, "");
		cs.setString(8, "");
		cs.setString(9, "");
		cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();
		
		rs = (ResultSet) cs.getObject(10);
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("BP_CD", rs.getString("BP_CD"));
			subObject.put("BP_NM", rs.getString("BP_NM"));
			subObject.put("BP_REGNO", rs.getString("BP_REGNO"));
			subObject.put("REG_NM", rs.getString("REG_NM"));
			subObject.put("IND_TYPE", rs.getString("IND_TYPE"));
			subObject.put("IND_CLASS", rs.getString("IND_CLASS"));
			subObject.put("ADDRESS", rs.getString("ADDRESS"));
			subObject.put("TEL_NO", rs.getString("TEL_NO"));
			subObject.put("FAX_NO", rs.getString("FAX_NO"));
			subObject.put("EMAIL", rs.getString("EMAIL"));
			subObject.put("BIZ_TYPE", rs.getString("BIZ_TYPE"));
			subObject.put("BIZ_TYPE_NM", rs.getString("BIZ_TYPE_NM"));
			
			jsonArray.add(subObject);
		}

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		
		/*
		String strSp = "USP_B_BIZ_HSPF";
		String strRetField = "BP_CD|BP_NM|BP_REGNO|REG_NM|IND_TYPE|IND_CLASS|ADDRESS|TEL_NO|FAX_NO|EMAIL|BIZ_TYPE|BIZ_TYPE_NM";
		String strParam = V_TYPE + "|" + V_BP_CD + "|" + V_BP_NM + "|^|^|^|^|^|^|"; //파라미터 정의 : 필드 갯수와 순서를 맞춘다 문자가 공백일때 _ 사용
		int strOutNum = 10; //커서 RETURN 번호

//	 	String debug_yn = "Y"; //DEBUG Y/N
		String debug_yn = "N"; //DEBUG Y/N
		jsonArray = dbcon.spSelect(strSp, strParam, strRetField, strOutNum, debug_yn);

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		
//	 	System.out.println(jsonObject);
	*/

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
	
%>

