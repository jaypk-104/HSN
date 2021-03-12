<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	String strCompId = (String) session.getAttribute("comp_id");
	String strId = (String) session.getAttribute("user_id");

	if (strId == "" || strId == null || strId == "null") {
		response.sendRedirect("../../../index.jsp");
	}

	else {
		ResultSet rs = null;
		try {
			request.setCharacterEncoding("utf-8");
			JSONObject jsonObject = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			JSONObject subObject = null;

			// 		jsonArray = dbcon.globalVariation(strId, strCompId);
			String strSql = "SELECT A.COMP_ID,D.COMP_NM,       A.USR_ID, A.ROLE_CD, ";
			strSql += " A.USR_NM,  A.DEPT_CD,  B.DEPT_NM, ";
			strSql += " C.DTL_NM POSIT_NM ,A.BP_CD, E.BP_NM, A.TEL_NO, A.HAND_TEL, A.FAX_NO, A.ADDRESS, A.EMAIL, A.EMAIL_YN, A.EMP_NO ";
			strSql += " FROM   Z_USR_INFO_HSPF A ";
			strSql += " LEFT OUTER JOIN B_DEPT_HSPF B ";
			strSql += " ON     A.DEPT_CD = B.DEPT_CD ";
			strSql += " AND    A.COMP_ID =B.COMP_ID ";
			strSql += " LEFT OUTER JOIN B_DTL_INFO C ";
			strSql += " ON     A.POSIT_CD=C.DTL_CD ";
			strSql += "AND    A.COMP_ID =C.COMP_ID ";
			strSql += " LEFT OUTER JOIN B_COMP_HSPF D ";
			strSql += " ON     A.COMP_ID=D.COMP_ID";
			strSql += " LEFT OUTER JOIN B_BIZ_HSPF E ";
			strSql += " ON     A.BP_CD=E.BP_CD";
			strSql += " WHERE UPPER(A.USR_ID)='" + strId.toUpperCase() + "'";
			strSql += "AND UPPER(A.COMP_ID)='" + strCompId.toUpperCase() + "'";

			rs = stmt.executeQuery(strSql);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("comp_id", rs.getString("COMP_ID"));
				subObject.put("comp_nm", rs.getString("COMP_NM"));
				subObject.put("usr_id", rs.getString("USR_ID"));
				subObject.put("usr_nm", rs.getString("USR_NM"));
				subObject.put("dept_cd", rs.getString("DEPT_CD"));
				subObject.put("dept_nm", rs.getString("DEPT_NM"));
				subObject.put("posit_nm", rs.getString("POSIT_NM"));
				subObject.put("bp_cd", rs.getString("BP_CD"));
				subObject.put("bp_nm", rs.getString("BP_NM"));
				subObject.put("tel_no", rs.getString("TEL_NO"));
				subObject.put("hand_tel", rs.getString("HAND_TEL"));
				subObject.put("fax_no", rs.getString("FAX_NO"));
				subObject.put("address", rs.getString("ADDRESS"));
				subObject.put("email", rs.getString("EMAIL"));
				subObject.put("email_yn", rs.getString("EMAIL_YN"));
				subObject.put("role_cd", rs.getString("ROLE_CD"));
				subObject.put("emp_no", rs.getString("EMP_NO"));
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

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
	}
%>