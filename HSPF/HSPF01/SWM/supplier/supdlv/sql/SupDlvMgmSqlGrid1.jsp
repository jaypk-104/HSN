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
	String V_ERR_NO = "";
	try {
		// 	 System.out.println("그리드1의 셀 클릭시 변하는 그리드2 SQL");
// 		String MAST_PO_NO = request.getParameter("MAST_PO_NO");
// 		String MAST_PO_SEQ = request.getParameter("MAST_PO_SEQ");

// 		String PO_NO_SEQ = MAST_PO_NO + MAST_PO_SEQ;
		String V_PO_NO_SEQ = request.getParameter("V_PO_NO_SEQ");
		V_PO_NO_SEQ = V_PO_NO_SEQ.replace("undefined", "");
		V_PO_NO_SEQ = V_PO_NO_SEQ.substring(0, V_PO_NO_SEQ.length() - 3);
		V_ERR_NO = V_PO_NO_SEQ;
// 			 System.out.println(V_PO_NO_SEQ);

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		
// 		System.out.println("V_PO_NO_SEQ : " + V_PO_NO_SEQ);
		
		String SQL = "";
		SQL =       "SELECT DISTINCT A.ASN_NO                                                                                                ";
		SQL = SQL + "                            ,A.PO_NO     MAST_PO_NO                                                                     ";
		SQL = SQL + "                            ,A.PO_SEQ     MAST_PO_SEQ                                                                   ";
		SQL = SQL + "                            ,1 MAST_PO_SEQ_NO                                                                           ";
		SQL = SQL + "                            ,A.ITEM_CD                                                                                  ";
		SQL = SQL + "                            ,B.ITEM_NM                                                                                  ";
		SQL = SQL + "                            ,B.SPEC                                                                                     ";
		SQL = SQL + "                            ,B.UNIT     STOCK_UNIT                                                                      ";
		SQL = SQL + "                            ,ASN_STS                                                                                    ";
		SQL = SQL + "                            ,A.CFM_YN                                                                                   ";
		SQL = SQL + "                            ,C.DTL_NM ASN_STS_NM                                                                        ";
		SQL = SQL + "                            , D.DLVY_HOPE_DT     DLVY_DT                                                                ";
		SQL = SQL + "                            ,D.PO_QTY                                                                                   ";
		SQL = SQL + "                            ,A.DLVY_AVL_DT     DLV_AVL_DT                                                               ";
		SQL = SQL + "                            ,CASE WHEN NVL(SUM(E.BOX_QTY),0) > 0 THEN SUM(E.BOX_QTY) ELSE A.DLVY_AVL_QTY END DLV_AVL_QTY";
		SQL = SQL + "                            ,CASE WHEN F.FILE_CNT >= 1 THEN 'Y' ELSE 'N' END FILE_YN ";
		SQL = SQL + "            FROM SCM_BARCD_MST_SWM A                                                                                    ";
		SQL = SQL + "            LEFT OUTER JOIN SCM_BARCD_DTL_SWM E ON A.ASN_NO = E.ASN_NO AND A.PO_NO = E.PO_NO AND A.PO_SEQ = E.PO_SEQ    ";
		SQL = SQL + "            INNER JOIN B_ITEM_HSPF B ON A.ITEM_CD = B.ITEM_CD                                                            ";
		SQL = SQL + "            INNER JOIN B_DTL_INFO C oN C.MAST_CD = 'HSNA2' AND A.ASN_STS = C.DTL_CD                                     ";
		SQL = SQL + "            INNER JOIN M_PO_DTL_SWM D ON A.PO_NO=D.PO_NO AND A.PO_SEQ=D.PO_SEQ                                          ";
		SQL = SQL + "            LEFT OUTER JOIN (SELECT ASN_NO, COUNT(*) FILE_CNT FROM SCM_ASN_FILE_HSPF GROUP BY ASN_NO) F ON A.ASN_NO = F.ASN_NO                                          ";
		SQL = SQL + "            WHERE A.PO_NO || TO_CHAR(A.PO_SEQ) IN ('" + V_PO_NO_SEQ +  "' )                                               ";
		SQL = SQL + "            GROUP BY A.ASN_NO,A.PO_NO,A.PO_SEQ,A.ITEM_CD,B.ITEM_NM,                                                     ";
		SQL = SQL + "            B.SPEC,B.UNIT, A.ASN_STS,A.CFM_YN,C.DTL_NM,D.DLVY_HOPE_DT,D.PO_QTY, A.DLVY_AVL_DT,A.DLVY_AVL_QTY            ";
		SQL = SQL + "            ,CASE WHEN F.FILE_CNT >= 1 THEN 'Y' ELSE 'N' END             ";

		rs = stmt.executeQuery(SQL);
		
		/*
		String sql = "SELECT DISTINCT A.ASN_NO,A.MAST_PO_NO,A.MAST_PO_SEQ, A.MAST_PO_SEQ_NO,A.ITEM_CD,B.ITEM_NM,B.SPEC,B.STOCK_UNIT, "; //A.MAST_PO_SEQ_NO
		sql += "A.ASN_STS,A.CFM_YN,C.DTL_NM ASN_STS_NM, D.DLVY_DT,D.PO_QTY,A.DLV_AVL_DT, ";
		sql += "CASE WHEN NVL(SUM(E.BOX_QTY),0) > 0 THEN SUM(E.BOX_QTY) ELSE A.DLV_AVL_QTY END DLV_AVL_QTY ";
		sql += "FROM SUPP_BARCD_MST A LEFT OUTER JOIN SUPP_BARCD_DTL E ON A.ASN_NO = E.ASN_NO AND A.MAST_PO_NO = E.MAST_PO_NO AND A.MAST_PO_SEQ = E.MAST_PO_SEQ, ";
		sql += " B_ITEM_SWM B ,B_DTL_INFO c,M_PO_SURVEY_DTL D ";
		sql += "WHERE A.ITEM_CD=B.ITEM_CD and a.ASN_STS=c.dtl_cd and c.mast_cd='HSNA2' ";
		sql += "AND A.MAST_PO_NO=D.MAST_PO_NO AND A.MAST_PO_SEQ=D.MAST_PO_SEQ  "; //AND GR_QTY=0
		sql += "AND A.MAST_PO_NO|| TO_CHAR(A.MAST_PO_SEQ) IN ('" + V_PO_NO_SEQ + ")";
		sql += " GROUP BY A.ASN_NO,A.MAST_PO_NO,A.MAST_PO_SEQ,A.MAST_PO_SEQ_NO,A.ITEM_CD,B.ITEM_NM,";
		sql += " B.SPEC,B.STOCK_UNIT, A.ASN_STS,A.CFM_YN,C.DTL_NM,D.DLVY_DT,D.PO_QTY, A.DLV_AVL_DT,A.DLV_AVL_QTY, E.BOX_QTY";

			System.out.println(sql);
		rs = stmt.executeQuery(sql);
		
		*/
		
		/*
		cs = conn.prepareCall("call USP_SUPP_SELECT(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "S_DTL");
		cs.setString(2, "");
		cs.setString(3, V_PO_NO_SEQ);
		cs.setString(4, "");
		cs.setString(5, "");
		cs.setString(6, "");
		cs.setString(7, "");
		cs.setString(8, "");
		cs.setString(9, "");
		cs.setString(10, "");
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(11);
		*/
// 		System.out.println(SQL);
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("ASN_NO", rs.getString("ASN_NO"));
			subObject.put("MAST_PO_NO", rs.getString("MAST_PO_NO"));
			subObject.put("MAST_PO_SEQ", rs.getString("MAST_PO_SEQ"));
			subObject.put("MAST_PO_SEQ_NO", rs.getString("MAST_PO_SEQ_NO"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("STOCK_UNIT", rs.getString("STOCK_UNIT"));
			subObject.put("ASN_STS", rs.getString("ASN_STS"));
			subObject.put("CFM_YN", rs.getString("CFM_YN"));
			subObject.put("ASN_STS_NM", rs.getString("ASN_STS_NM"));
			subObject.put("DLVY_DT", rs.getString("DLVY_DT").substring(0, 10));
			subObject.put("PO_QTY", rs.getString("PO_QTY"));
			subObject.put("DLV_AVL_QTY", rs.getString("DLV_AVL_QTY"));
			subObject.put("DLV_AVL_DT", rs.getString("DLV_AVL_DT").substring(0, 10));
			subObject.put("FILE_YN", rs.getString("FILE_YN"));
			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	} catch (Exception e) {
		System.out.println("V_ERR_NO : " + V_ERR_NO);
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








