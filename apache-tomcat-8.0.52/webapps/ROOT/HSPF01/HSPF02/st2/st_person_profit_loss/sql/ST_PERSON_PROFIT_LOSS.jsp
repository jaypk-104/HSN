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
<%@ page import="java.util.Properties"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.internet.MimeBodyPart"%>
<%@ page import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.mail.BodyPart"%>
<%@ page import="javax.mail.Multipart"%>
<%@ page import="java.text.SimpleDateFormat"%>


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

		if (V_TYPE.equals("S")) {
			String V_YYMM = request.getParameter("V_YYMM") == null ? "" : request.getParameter("V_YYMM").toString();
			
			cs = conn.prepareCall("call USP_S_MONTH_COGS_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYMM);//V_YYMM
			cs.setString(4, "");//V_S_BP_CD
			cs.setString(5, "");//V_USR_ID
			cs.setString(6, "");//V_EMP_NO
			cs.setString(7, "");//V_EMP_NAME
			cs.setString(8, "");//V_S_BP_NM
			cs.setString(9, "");//V_LC_DOC_NO
			cs.setString(10, "");//V_BL_DOC_NO
			cs.setString(11, "");//V_S_KO_BILL_QTY
			cs.setString(12, "");//V_S_KO_BILL_AMT
			cs.setString(13, "");//V_S_KO_COGS_QTY
			cs.setString(14, "");//V_S_KO_COGS_AMT
			cs.setString(15, "");//V_S_KO_PROFIT
			cs.setString(16, "");//V_S_KO_PROFIT_RT
			cs.setString(17, "");//V_REMARK
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("EMP_NO", rs.getString("EMP_NO"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("EMP_NAME", rs.getString("EMP_NAME"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("S_KO_BILL_QTY", rs.getString("S_KO_BILL_QTY"));
				subObject.put("S_KO_BILL_AMT", rs.getString("S_KO_BILL_AMT"));
				subObject.put("S_KO_COGS_QTY", rs.getString("S_KO_COGS_QTY"));
				subObject.put("S_KO_COGS_AMT", rs.getString("S_KO_COGS_AMT"));
				subObject.put("S_KO_PROFIT", rs.getString("S_KO_PROFIT"));
				subObject.put("S_KO_PROFIT_RT", rs.getString("S_KO_PROFIT_RT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				

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
		else if (V_TYPE.equals("N")) {
			//계산버튼 클릭.
			String V_YYMM = request.getParameter("V_YYMM") == null ? "" : request.getParameter("V_YYMM").toString();
			
			cs = conn.prepareCall("call USP_S_MONTH_COGS_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYMM);//V_YYMM
			cs.setString(4, "");//V_S_BP_CD
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.setString(6, "");//V_EMP_NO
			cs.setString(7, "");//V_EMP_NAME
			cs.setString(8, "");//V_S_BP_NM
			cs.setString(9, "");//V_LC_DOC_NO
			cs.setString(10, "");//V_BL_DOC_NO
			cs.setString(11, "");//V_S_KO_BILL_QTY
			cs.setString(12, "");//V_S_KO_BILL_AMT
			cs.setString(13, "");//V_S_KO_COGS_QTY
			cs.setString(14, "");//V_S_KO_COGS_AMT
			cs.setString(15, "");//V_S_KO_PROFIT
			cs.setString(16, "");//V_S_KO_PROFIT_RT
			cs.setString(17, "");//V_REMARK
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
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


