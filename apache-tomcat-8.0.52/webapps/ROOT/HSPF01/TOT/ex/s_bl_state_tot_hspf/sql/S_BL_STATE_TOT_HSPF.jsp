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
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_LOADING_DT_FR = request.getParameter("V_LOADING_DT_FR") == null ? "" : request.getParameter("V_LOADING_DT_FR").substring(0, 10);
		String V_LOADING_DT_TO = request.getParameter("V_LOADING_DT_TO") == null ? "" : request.getParameter("V_LOADING_DT_TO").substring(0, 10);
		String V_S_BP_CD = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_CFM_YN = request.getParameter("V_CFM_YN") == null ? "" : request.getParameter("V_CFM_YN").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_S_BL_STATE_TOT_HSPF(?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_LOADING_DT_FR);//V_LOADING_DT_FR
			cs.setString(3, V_LOADING_DT_TO);//V_LOADING_DT_TO
			cs.setString(4, V_S_BP_CD);//V_S_BP_CD
			cs.setString(5, V_CFM_YN);//V_CFM_YN
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("INVOICE_NO", rs.getString("INVOICE_NO"));
				subObject.put("ED_DOC_NO", rs.getString("ED_DOC_NO"));
				subObject.put("IN_PLAN_DT", rs.getString("IN_PLAN_DT"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("DIS_PORT_NM", rs.getString("DIS_PORT_NM"));
				subObject.put("LOADING_PORT", rs.getString("LOADING_PORT"));
				subObject.put("LD_PORT", rs.getString("LD_PORT"));
				subObject.put("INSRT_USR_NM", rs.getString("INSRT_USR_NM"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("INVOICE_DT", rs.getString("INVOICE_DT"));
				subObject.put("SALE_GRP_NM", rs.getString("SALE_GRP_NM"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
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

<%!
// 	void callProcedure(CallableStatement cs, String V_COMP_ID, String V_TYPE) throws Exception {

// 	}

%>


