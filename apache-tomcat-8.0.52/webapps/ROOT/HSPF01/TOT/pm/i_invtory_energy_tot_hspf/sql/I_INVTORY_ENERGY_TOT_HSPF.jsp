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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_DATE = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE").replace("-", "").substring(0, 6);
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_I_TOTAL_INVENTORY_HSPF(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DATE);//V_DATE
			cs.setString(4, V_LC_DOC_NO);//V_LC_DOC_NO 
			cs.setString(5, V_BL_DOC_NO);//V_BL_DOC_NO 
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD
			cs.setString(7, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(9, "Y");//V_ENERGY_YN
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("BS_KO_QTY", rs.getString("BS_KO_QTY"));
				subObject.put("BS_KO_AMT", rs.getString("BS_KO_AMT"));
				subObject.put("BS_LOC_QTY", rs.getString("BS_LOC_QTY"));
				subObject.put("BS_LOC_AMT", rs.getString("BS_LOC_AMT"));
				subObject.put("BS_IMP_QTY", rs.getString("BS_IMP_QTY"));
				subObject.put("BS_IMP_AMT", rs.getString("BS_IMP_AMT"));
				subObject.put("BS_MID_QTY", rs.getString("BS_MID_QTY"));
				subObject.put("BS_MID_AMT", rs.getString("BS_MID_AMT"));
				subObject.put("BS_TOT_QTY", rs.getString("BS_TOT_QTY"));
				subObject.put("BS_TOT_AMT", rs.getString("BS_TOT_AMT"));
				subObject.put("GR_KO_QTY", rs.getString("GR_KO_QTY"));
				subObject.put("GR_KO_AMT", rs.getString("GR_KO_AMT"));
				subObject.put("GR_LOC_QTY", rs.getString("GR_LOC_QTY"));
				subObject.put("GR_LOC_AMT", rs.getString("GR_LOC_AMT"));
				subObject.put("GR_IMP_QTY", rs.getString("GR_IMP_QTY"));
				subObject.put("GR_IMP_AMT", rs.getString("GR_IMP_AMT"));
				subObject.put("GR_MID_QTY", rs.getString("GR_MID_QTY"));
				subObject.put("GR_MID_AMT", rs.getString("GR_MID_AMT"));
				subObject.put("GR_TOT_QTY", rs.getString("GR_TOT_QTY"));
				subObject.put("GR_TOT_AMT", rs.getString("GR_TOT_AMT"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
// 				subObject.put("J_DN_KO_QTY", rs.getString("J_DN_KO_QTY"));
// 				subObject.put("J_DN_KO_AMT", rs.getString("J_DN_KO_AMT"));
// 				subObject.put("J_DN_LOC_QTY", rs.getString("J_DN_LOC_QTY"));
// 				subObject.put("J_DN_LOC_AMT", rs.getString("J_DN_LOC_AMT"));
// 				subObject.put("J_DN_EXP_QTY", rs.getString("J_DN_EXP_QTY"));
// 				subObject.put("J_DN_EXP_AMT", rs.getString("J_DN_EXP_AMT"));
// 				subObject.put("J_DN_MID_QTY", rs.getString("J_DN_MID_QTY"));
// 				subObject.put("J_DN_MID_AMT", rs.getString("J_DN_MID_AMT"));
// 				subObject.put("J_DN_TOT_QTY", rs.getString("J_DN_TOT_QTY"));
// 				subObject.put("J_DN_TOT_AMT", rs.getString("J_DN_TOT_AMT"));
				subObject.put("G_DN_KO_QTY", rs.getString("G_DN_KO_QTY"));
				subObject.put("G_DN_KO_AMT", rs.getString("G_DN_KO_AMT"));
				subObject.put("G_DN_LOC_QTY", rs.getString("G_DN_LOC_QTY"));
				subObject.put("G_DN_LOC_AMT", rs.getString("G_DN_LOC_AMT"));
				subObject.put("G_DN_EXP_QTY", rs.getString("G_DN_EXP_QTY"));
				subObject.put("G_DN_EXP_AMT", rs.getString("G_DN_EXP_AMT"));
				subObject.put("G_DN_MID_QTY", rs.getString("G_DN_MID_QTY"));
				subObject.put("G_DN_MID_AMT", rs.getString("G_DN_MID_AMT"));
				subObject.put("G_DN_TOT_QTY", rs.getString("G_DN_TOT_QTY"));
				subObject.put("G_DN_TOT_AMT", rs.getString("G_DN_TOT_AMT"));
// 				subObject.put("J_DN_EX_KO_QTY", rs.getString("J_DN_EX_KO_QTY"));
// 				subObject.put("J_DN_EX_KO_AMT", rs.getString("J_DN_EX_KO_AMT"));
// 				subObject.put("J_DN_EX_LOC_QTY", rs.getString("J_DN_EX_LOC_QTY"));
// 				subObject.put("J_DN_EX_LOC_AMT", rs.getString("J_DN_EX_LOC_AMT"));
// 				subObject.put("J_DN_EX_IMP_QTY", rs.getString("J_DN_EX_IMP_QTY"));
// 				subObject.put("J_DN_EX_IMP_AMT", rs.getString("J_DN_EX_IMP_AMT"));
// 				subObject.put("J_DN_EX_MID_QTY", rs.getString("J_DN_EX_MID_QTY"));
// 				subObject.put("J_DN_EX_MID_AMT", rs.getString("J_DN_EX_MID_AMT"));
// 				subObject.put("J_DN_EX_TOT_QTY", rs.getString("J_DN_EX_TOT_QTY"));
// 				subObject.put("J_DN_EX_TOT_AMT", rs.getString("J_DN_EX_TOT_AMT"));
				subObject.put("G_DN_EX_KO_QTY", rs.getString("G_DN_EX_KO_QTY"));
				subObject.put("G_DN_EX_KO_AMT", rs.getString("G_DN_EX_KO_AMT"));
				subObject.put("G_DN_EX_LOC_QTY", rs.getString("G_DN_EX_LOC_QTY"));
				subObject.put("G_DN_EX_LOC_AMT", rs.getString("G_DN_EX_LOC_AMT"));
				subObject.put("G_DN_EX_IMP_QTY", rs.getString("G_DN_EX_IMP_QTY"));
				subObject.put("G_DN_EX_IMP_AMT", rs.getString("G_DN_EX_IMP_AMT"));
				subObject.put("G_DN_EX_MID_QTY", rs.getString("G_DN_EX_MID_QTY"));
				subObject.put("G_DN_EX_MID_AMT", rs.getString("G_DN_EX_MID_AMT"));
				subObject.put("G_DN_EX_TOT_QTY", rs.getString("G_DN_EX_TOT_QTY"));
				subObject.put("G_DN_EX_TOT_AMT", rs.getString("G_DN_EX_TOT_AMT"));
				subObject.put("ST_KO_QTY", rs.getString("ST_KO_QTY"));
				subObject.put("ST_KO_AMT", rs.getString("ST_KO_AMT"));
				subObject.put("ST_LOC_QTY", rs.getString("ST_LOC_QTY"));
				subObject.put("ST_LOC_AMT", rs.getString("ST_LOC_AMT"));
				subObject.put("ST_IMP_QTY", rs.getString("ST_IMP_QTY"));
				subObject.put("ST_IMP_AMT", rs.getString("ST_IMP_AMT"));
				subObject.put("ST_MID_QTY", rs.getString("ST_MID_QTY"));
				subObject.put("ST_MID_AMT", rs.getString("ST_MID_AMT"));
				subObject.put("ST_TOT_QTY", rs.getString("ST_TOT_QTY"));
				subObject.put("ST_TOT_AMT", rs.getString("ST_TOT_AMT"));																
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("C")) {
			cs = conn.prepareCall("call USP_003_I_TOTAL_INVENTORY_HSPF(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DATE);//V_DATE
			cs.setString(4, V_LC_DOC_NO);//V_LC_DOC_NO 
			cs.setString(5, V_BL_DOC_NO);//V_BL_DOC_NO 
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD
			cs.setString(7, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(9, "");//V_ENERGY_YN
			cs.executeQuery();
			
		} else if (V_TYPE.equals("CHK_GL")) {
			
			cs = conn.prepareCall("call USP_003_I_TOTAL_INVENTORY_HSPF(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DATE);//V_DATE
			cs.setString(4, V_LC_DOC_NO);//V_LC_DOC_NO 
			cs.setString(5, V_BL_DOC_NO);//V_BL_DOC_NO 
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD
			cs.setString(7, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(9, "");//V_ENERGY_YN
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(8);
			
			String V_CHK_GL = "";
			if (rs.next()) {
				V_CHK_GL = rs.getString("V_CHK_GL");
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(V_CHK_GL);
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


