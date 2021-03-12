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

		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toString();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toString();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toString();
		String V_BASE_DATE = request.getParameter("V_BASE_DATE") == null ? "" : request.getParameter("V_BASE_DATE").toString().substring(0,10);
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toString();
		String V_LOT_NO = request.getParameter("V_LOT_NO") == null ? "" : request.getParameter("V_LOT_NO");
		String V_RACK_NO = request.getParameter("V_RACK_NO") == null ? "" : request.getParameter("V_RACK_NO");
		String V_PAL_BC_NO = request.getParameter("V_PAL_BC_NO") == null ? "" : request.getParameter("V_PAL_BC_NO");
		String V_BOX_BC_NO = request.getParameter("V_BOX_BC_NO") == null ? "" : request.getParameter("V_BOX_BC_NO");
		String V_LOT_BC_NO = request.getParameter("V_LOT_BC_NO") == null ? "" : request.getParameter("V_LOT_BC_NO");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		if(V_SL_CD.equals("T")){
			V_SL_CD = "";
		}
		if( V_TYPE.equals("S")){
			cs = conn.prepareCall("call USP_I_RACK_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_BASE_DATE);//V_BS_DATE
			cs.setString(3, V_COMP_ID);//V_COMP_ID
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, "");//V_ITEM_NM
			cs.setString(6, V_SL_CD);//V_SL_CD
			cs.setString(7, V_RACK_NO);//V_RACK_NO
			cs.setString(8, V_PAL_BC_NO);//V_PAL_BC_NO
			cs.setString(9, V_BOX_BC_NO);//V_BOX_BC_NO
			cs.setString(10, V_LOT_BC_NO);//V_LOT_BC_NO
			cs.setString(11, V_LOT_NO);//V_LOT_NO
			cs.setString(12, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("GR_SL_CD", rs.getString("GR_SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("GR_LC_CD", rs.getString("GR_LC_CD"));
				subObject.put("LC_NM", rs.getString("LC_NM"));
				subObject.put("GR_RACK_CD", rs.getString("GR_RACK_CD"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("GR_AMT", rs.getString("GR_AMT"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("STK_QTY", rs.getString("STK_QTY"));
				subObject.put("STK_AMT", rs.getString("STK_AMT"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
		}
		else if( V_TYPE.equals("T")){
			cs = conn.prepareCall("call USP_I_RACK_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_BASE_DATE);//V_BS_DATE
			cs.setString(3, V_COMP_ID);//V_COMP_ID
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, "");//V_ITEM_NM
			cs.setString(6, V_SL_CD);//V_SL_CD
			cs.setString(7, V_RACK_NO);//V_RACK_NO
			cs.setString(8, V_PAL_BC_NO);//V_PAL_BC_NO
			cs.setString(9, V_BOX_BC_NO);//V_BOX_BC_NO
			cs.setString(10, V_LOT_BC_NO);//V_LOT_BC_NO
			cs.setString(11, V_LOT_NO);//V_LOT_NO
			cs.setString(12, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
		}
		

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
