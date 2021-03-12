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
		String V_DATE = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE").toUpperCase().substring(0, 10);
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_SALE_TYPE = request.getParameter("V_SALE_TYPE") == null ? "" : request.getParameter("V_SALE_TYPE").toUpperCase();
		String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
		String V_REGION = request.getParameter("V_REGION") == null ? "" : request.getParameter("V_REGION").toUpperCase();
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_SL_NM = request.getParameter("V_SL_NM") == null ? "" : request.getParameter("V_SL_NM").toUpperCase();

		if (V_SALE_TYPE.equals("T")) {
			V_SALE_TYPE = "";
		}
		if (V_IV_TYPE.equals("T")) {
			V_IV_TYPE = "";
		}
		if (V_REGION.equals("T")) {
			V_REGION = "";
		}

// 		System.out.println(V_DATE);
		//상단
		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_I_STOCK_BY_ITEM_STEEL(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_DATE);//V_COMP_ID
			cs.setString(2, V_ITEM_CD);//V_DN_DT
			cs.setString(3, V_S_BP_NM);//V_S_BP_NM
			cs.setString(4, V_REGION);//V_S_BP_NM
			cs.setString(5, V_SALE_TYPE);//V_S_BP_NM
			cs.setString(6, V_IV_TYPE);//V_S_BP_NM
			cs.setString(7, V_LC_DOC_NO);//V_S_BP_NM
			cs.setString(8, V_BL_DOC_NO);//V_S_BP_NM
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(10, V_SL_NM);//V_SL_NM
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(9);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("BON_QTY", rs.getString("BON_QTY"));
				subObject.put("BON_WGT_UNIT", rs.getString("BON_WGT_UNIT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("GL_QTY", rs.getString("GL_QTY"));
				subObject.put("S_DAY", rs.getString("S_DAY"));
				subObject.put("N_ST_AMT", rs.getString("N_ST_AMT"));
				subObject.put("O_ST_AMT", rs.getString("O_ST_AMT"));
				subObject.put("L_ST_AMT", rs.getString("L_ST_AMT"));
				subObject.put("ST_AMT", rs.getString("ST_AMT"));
				subObject.put("ST_GL_AMT", rs.getString("ST_GL_AMT"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("TAX_AMT", rs.getString("TAX_AMT"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("NON_AMT", rs.getString("NON_AMT"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("APPROV_DT", rs.getString("APPROV_DT"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("ORIGIN_NM", rs.getString("ORIGIN_NM"));
				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
				subObject.put("GRADE_NM", rs.getString("GRADE_NM"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("F_S_PRC", rs.getString("F_S_PRC"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			//출고요청서 번호 채번

		} else if (V_TYPE.equals("CALC")) {

// 			System.out.println("zz" + V_DATE);

			cs = conn.prepareCall("call DISTR_STOCK.USP_I_STOCK_SALE_CALC(?,?)");
			cs.setString(1, V_DATE);//V_COMP_ID
			cs.setString(2, V_COMP_ID);//V_COMP_ID
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


