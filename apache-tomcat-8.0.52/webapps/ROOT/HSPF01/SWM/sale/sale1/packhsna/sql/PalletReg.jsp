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

		//MyViewport

		String u_cont_no = request.getParameter("u_cont_no");
		if (u_cont_no == null) {
			u_cont_no = "";
		}
		/*
		// 	System.out.println("u_cont_no" + u_cont_no);

		// 		String sql = " SELECT A.CONT_MGM_NO,A.PAL_BC_NO,C.ITEM_CD,C.ITEM_NM,A.CONT_NO ";
		// 		sql += "FROM (SELECT B.CONT_NO, A.CONT_MGM_NO, A.PAL_BC_NO, MAX(A.ITEM_CD) ITEM_CD ";
		// 		sql += "FROM S_CONTAINER_DTL A, S_CONTAINER_MST B ";
		// 		sql += "WHERE A.CONT_MGM_NO = B.CONT_MGM_NO ";
		// 		sql += " GROUP BY B.CONT_NO, A.CONT_MGM_NO, A.PAL_BC_NO) A, S_CONTAINER_MST B,B_ITEM_SWM C ";
		// 		sql += " WHERE A.CONT_MGM_NO=B.CONT_MGM_NO AND A.ITEM_CD=C.ITEM_CD  ";
		// 		sql += " AND A.PAL_BC_NO NOT IN (SELECT PAL_BC_NO FROM S_INVOICE_HSNA_DTL) ";
		// 		sql += " AND B.CFM_YN = 'Y' "; //확정된 컨테이너만 조회. 
		// 		sql += " AND UPPER(A.CONT_NO) LIKE '%'||UPPER('" + u_cont_no + "')||'%' ";
		String sql = "";
		sql = "SELECT  A.CONT_MGM_NO, A.PAL_BC_NO, C.ITEM_CD, C.ITEM_NM, A.CONT_NO          ";
		sql += "FROM   (SELECT B.CONT_NO, A.CONT_MGM_NO, A.PAL_BC_NO, MAX(A.ITEM_CD) ITEM_CD";
		sql += "        FROM    S_CONTAINER_DTL A                                            ";
		sql += "                INNER JOIN S_CONTAINER_MST B                                 ";
		sql += "                ON      A.CONT_MGM_NO = B.CONT_MGM_NO                        ";
		sql += "                LEFT OUTER JOIN S_INVOICE_HSNA_DTL CX                        ";
		sql += "                ON      A.BOX_BC_NO = CX.BOX_BC_NO                           ";
		sql += "        WHERE   CX.INV_MGM_NO IS NULL                                        ";
		sql += "        GROUP BY B.CONT_NO, A.CONT_MGM_NO, A.PAL_BC_NO                       ";
		sql += "        )                                                                    ";
		sql += "        A, S_CONTAINER_MST B, B_ITEM_SWM C                                   ";
		sql += "WHERE   A.CONT_MGM_NO       = B.CONT_MGM_NO                                  ";
		sql += "AND     A.ITEM_CD           = C.ITEM_CD                                      ";
		sql += "AND     B.CFM_YN            = 'Y'                                            ";
		sql += "AND     UPPER(A.CONT_NO) LIKE '%"+ u_cont_no +"%'                                           ";

// 		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		*/
		
		cs = conn.prepareCall("call USP_S_INV_SELECT(?,?,?,?,?,?)");
		cs.setString(1, "S_REG_LIST");
		cs.setString(2, "");
		cs.setString(3, "");
		cs.setString(4, "");
		cs.setString(5, u_cont_no);
		cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);

		cs.executeQuery();
		rs = (ResultSet) cs.getObject(6);
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
			subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("CONT_NO", rs.getString("CONT_NO"));
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
