<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
 <%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		/*
		//	 String sql = "SELECT DISTINCT A.INV_MGM_NO, B.INV_NO, B.VESSEL_NM, B.LOAD_DT ";
		//			sql += "FROM S_INVOICE_HSNA_DTL A, S_INVOICE_HSNA_HDR B ";
		//			sql += "WHERE A.INV_MGM_NO = B.INV_MGM_NO ";  
		//			sql += " AND A.INV_MGM_NO NOT IN (SELECT INV_MGM_NO FROM S_BL_HSNA_DTL) ";
		//			sql += " AND B.CFM_YN = 'Y'"; //인보이스 확정된것만 조회
		//			sql += " AND B.INV_NO LIKE '%"+u_inv_no+"%'";
		//너무 느려서 쿼리변경2018-01-04 HDH
		String sql = "  SELECT DISTINCT A.INV_MGM_NO, B.INV_NO, B.VESSEL_NM, B.LOAD_DT ";
		       sql += " FROM S_INVOICE_HSNA_DTL A LEFT JOIN S_INVOICE_HSNA_HDR B ON A.INV_MGM_NO = B.INV_MGM_NO ";
		       sql += "                           LEFT JOIN S_BL_HSNA_DTL C ON A.INV_MGM_NO = C.INV_MGM_NO AND A.INV_SEQ = C.INV_MGM_SEQ ";
		       sql += " WHERE B.CFM_YN = 'Y' ";
		       sql += "  AND B.LOAD_DT >= TO_CHAR(ADD_MONTHS(SYSDATE,-3),'YYYY-MM-DD') ";
		       sql += "  AND B.INV_NO LIKE '%"+u_inv_no+"%' ";
		       sql += "  AND C.BL_MGM_NO IS NULL ";		
		rs = stmt.executeQuery(sql);
		 */
		 
		 String u_inv_no = request.getParameter("u_inv_no");
		
		cs = conn.prepareCall("call USP_S_BL_SELECT(?,?,?,?,?,?)");
		cs.setString(1, "S_REG_LIST");
		cs.setString(2, "");
		cs.setString(3, u_inv_no);
		cs.setString(4, "");
		cs.setString(5, "");
		cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);

		cs.executeQuery();
		rs = (ResultSet) cs.getObject(6);
		

		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("INV_MGM_NO", rs.getString("INV_MGM_NO"));
			subObject.put("INV_NO", rs.getString("INV_NO"));
			subObject.put("VESSEL_NM", rs.getString("VESSEL_NM"));
			subObject.put("LOAD_DT", rs.getString("LOAD_DT") == null || rs.getString("LOAD_DT").equals("") ? "" : rs.getString("LOAD_DT").substring(0, 10));
			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		// 	  System.out.println(jsonObject);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>
