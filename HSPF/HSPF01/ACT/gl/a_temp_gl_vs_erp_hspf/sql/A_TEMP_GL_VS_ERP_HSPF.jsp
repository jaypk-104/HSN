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
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toUpperCase();
		String V_TEMP_GL_NO = request.getParameter("V_TEMP_GL_NO") == null ? "" : request.getParameter("V_TEMP_GL_NO");
		String V_DEPT_NM = request.getParameter("V_DEPT_NM") == null ? "" : request.getParameter("V_DEPT_NM");
		String V_ERROR_YN = request.getParameter("V_ERROR_YN") == null ? "" : request.getParameter("V_ERROR_YN");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_TEMP_GL_DT_FR = request.getParameter("V_TEMP_GL_DT_FR") == null ? "" : request.getParameter("V_TEMP_GL_DT_FR").toString().substring(0, 10);
		String V_TEMP_GL_DT_TO = request.getParameter("V_TEMP_GL_DT_TO") == null ? "" : request.getParameter("V_TEMP_GL_DT_TO").toString().substring(0, 10);
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_A_TEMP_GL_VS_ERP_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_TEMP_GL_DT_FR);//V_TEMP_GL_DT_FR			
			cs.setString(3, V_TEMP_GL_DT_TO);//V_TEMP_GL_DT_TO			
			cs.setString(4, V_DEPT_NM);//V_DEPT_NM			
			cs.setString(5, V_TEMP_GL_NO);//V_TEMP_GL_NO			
			cs.setString(6, V_ERROR_YN);//V_ERROR_YN			
			cs.setString(7, V_USR_ID);	//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("ERP_TEMP_GL_NO", rs.getString("ERP_TEMP_GL_NO"));
				subObject.put("GL_NO", rs.getString("GL_NO"));
				subObject.put("TEMP_GL_DT", rs.getString("TEMP_GL_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("REF_NO", rs.getString("REF_NO"));
				subObject.put("INSRT_USER_ID", rs.getString("INSRT_USER_ID"));
				subObject.put("INSRT_DT", rs.getString("INSRT_DT"));
				subObject.put("ERROR_YN", rs.getString("ERROR_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

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


