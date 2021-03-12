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

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


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
		String V_BS_FR_DT = request.getParameter("V_BS_FR_DT") == null ? "" : request.getParameter("V_BS_FR_DT").toUpperCase().substring(0, 10);
		String V_BS_TO_DT = request.getParameter("V_BS_TO_DT") == null ? "" : request.getParameter("V_BS_TO_DT").toUpperCase().substring(0, 10);
		String V_APPROV_NM = request.getParameter("V_APPROV_NM") == null ? "" : request.getParameter("V_APPROV_NM").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_REGION = request.getParameter("V_REGION") == null ? "" : request.getParameter("V_REGION").toUpperCase();
		String V_SALE_TYPE = request.getParameter("V_SALE_TYPE") == null ? "" : request.getParameter("V_SALE_TYPE").toUpperCase();
		String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
		String V_BF_TYPE = request.getParameter("V_BF_TYPE") == null ? "" : request.getParameter("V_BF_TYPE").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_DN_YN = request.getParameter("V_DN_YN") == null ? "" : request.getParameter("V_DN_YN").toUpperCase();

// 		System.out.println("V_DN_YN : " + V_DN_YN);
		
		if(V_REGION.equals("T")) {
			V_REGION = "";
		}
		if(V_SALE_TYPE.equals("T")) {
			V_SALE_TYPE = "";
		}
		if(V_IV_TYPE.equals("T")) {
			V_IV_TYPE = "";
		}
		if(V_BF_TYPE.equals("A")) {
			V_BF_TYPE = "";
		}

		
		cs = conn.prepareCall("call USP_002_I_INVENTORY_RATE_DISTR(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_COMP_ID);//V_COMP_ID
		cs.setString(2, "I");//V_TYPE
		cs.setString(3, V_BS_FR_DT);//V_YYMMDD_FR
		cs.setString(4, V_BS_TO_DT);//V_YYMMDD_TO
		cs.setString(5, V_DN_YN);//V_DN_TYPE
		cs.setString(6, V_SALE_TYPE);//V_SALE_TYPE
		cs.setString(7, V_IV_TYPE);//V_IV_TYPE
		cs.setString(8, V_BL_DOC_NO);//V_BL_DOC_NO
		cs.setString(9, V_S_BP_NM);//V_S_BP_NM
		cs.setString(10, V_USR_ID);//V_USR_ID
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();
		
		
		cs = conn.prepareCall("call USP_002_I_INVENTORY_RATE_DISTR(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_COMP_ID);//V_COMP_ID
		cs.setString(2, V_TYPE);//V_TYPE
		cs.setString(3, V_BS_FR_DT);//V_YYMMDD_FR
		cs.setString(4, V_BS_TO_DT);//V_YYMMDD_TO
		cs.setString(5, V_DN_YN);//V_DN_TYPE
		cs.setString(6, V_SALE_TYPE);//V_SALE_TYPE
		cs.setString(7, V_IV_TYPE);//V_IV_TYPE
		cs.setString(8, V_BL_DOC_NO);//V_BL_DOC_NO
		cs.setString(9, V_S_BP_NM);//V_S_BP_NM
		cs.setString(10, V_USR_ID);//V_USR_ID
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(11);

		while (rs.next()) {
			subObject = new JSONObject();

			
			subObject.put("COMP_ID", rs.getString("COMP_ID"));
			subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
			subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
			subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
			subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
			subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
			subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
			subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
			subObject.put("IN_DT", rs.getString("IN_DT"));
			subObject.put("DN_DT", rs.getString("DN_DT"));
			subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
			subObject.put("GR_AMT", rs.getString("GR_AMT"));
			subObject.put("DN_AMT", rs.getString("DN_AMT"));
			subObject.put("DN_TOT_AMT", rs.getString("DN_TOT_AMT"));
			subObject.put("NON_DN_AMT", rs.getString("NON_DN_AMT"));
			subObject.put("DN_TYPE", rs.getString("DN_TYPE"));
			subObject.put("IND_ST_RT", rs.getString("IND_ST_RT"));
			subObject.put("BL_ST_RT", rs.getString("BL_ST_RT"));
			subObject.put("S_BP_ST_RT", rs.getString("S_BP_ST_RT"));
			subObject.put("APROV_RT", rs.getString("APROV_RT"));
			
			subObject.put("SL_AMT", rs.getString("SL_AMT"));
			subObject.put("INTER_AMT", rs.getString("INTER_AMT"));
			subObject.put("BILL_BP_NM", rs.getString("BILL_BP_NM"));
			subObject.put("BILL_IND_AMT", rs.getString("BILL_IND_AMT"));
			subObject.put("BILL_TOT_AMT", rs.getString("BILL_TOT_AMT"));
			subObject.put("BILL_PROFIT_AMT", rs.getString("BILL_PROFIT_AMT"));

			jsonArray.add(subObject);
		}
		

		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
// 		System.out.println(jsonObject);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

		//하단

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


