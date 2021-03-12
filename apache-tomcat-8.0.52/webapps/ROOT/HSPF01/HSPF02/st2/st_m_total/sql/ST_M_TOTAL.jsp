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
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_APPROV_NM = request.getParameter("V_APPROV_NM") == null ? "" : request.getParameter("V_APPROV_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_REGION = request.getParameter("V_REGION") == null ? "" : request.getParameter("V_REGION").toUpperCase();
		String V_SL_TYPE = request.getParameter("V_SL_TYPE") == null ? "" : request.getParameter("V_SL_TYPE").toUpperCase();
		String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").toUpperCase().substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").toUpperCase().substring(0, 10);
		String V_LD_DT_FR = request.getParameter("V_LD_DT_FR") == null || request.getParameter("V_LD_DT_FR").length() == 0 ? "" : request.getParameter("V_LD_DT_FR").toUpperCase().substring(0, 10);
		String V_LD_DT_TO = request.getParameter("V_LD_DT_TO") == null|| request.getParameter("V_LD_DT_TO").length() == 0  ? "" : request.getParameter("V_LD_DT_TO").toUpperCase().substring(0, 10);
		String V_GR_DT_FR = request.getParameter("V_GR_DT_FR") == null || request.getParameter("V_GR_DT_FR").length() == 0 ? "" : request.getParameter("V_GR_DT_FR").toUpperCase().substring(0, 10);
		String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null|| request.getParameter("V_GR_DT_TO").length() == 0  ? "" : request.getParameter("V_GR_DT_TO").toUpperCase().substring(0, 10);
		String V_MV_DT_FR = request.getParameter("V_MV_DT_FR") == null || request.getParameter("V_MV_DT_FR").length() == 0 ? "" : request.getParameter("V_MV_DT_FR").toUpperCase().substring(0, 10);
		String V_MV_DT_TO = request.getParameter("V_MV_DT_TO") == null|| request.getParameter("V_MV_DT_TO").length() == 0  ? "" : request.getParameter("V_MV_DT_TO").toUpperCase().substring(0, 10);

		
// 		System.out.println("V_LC_DOC_NO : " + V_LC_DOC_NO);
		
		if (V_SL_TYPE.equals("T")) {
			V_SL_TYPE = "";
		}
		if (V_IV_TYPE.equals("T")) {
			V_IV_TYPE = "";
		}
		if (V_REGION.equals("T")) {
			V_REGION = "";
		}

		//상단
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call DISTR_TOTAL.USP_M_TOTAL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_APPROV_NO);//V_APPROV_NO
			cs.setString(3, V_APPROV_NM);//V_APPROV_NM
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_M_BP_NM);//V_M_BP_CD
			cs.setString(6, V_S_BP_NM);//V_S_BP_CD
			cs.setString(7, V_REGION);//V_REGION
			cs.setString(8, V_SL_TYPE);//V_SL_TYPE
			cs.setString(9, V_IV_TYPE);//V_IV_TYPE
			cs.setString(10, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(11, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(12, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(13, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(14, V_LD_DT_FR);//V_LD_DT_FR
			cs.setString(15, V_LD_DT_TO);//V_LD_DT_TO
			cs.setString(16, V_GR_DT_FR);//V_GR_DT_FR
			cs.setString(17, V_GR_DT_TO);//V_GR_DT_TO
			cs.setString(18, V_MV_DT_FR);//V_MV_DT_FR
			cs.setString(19, V_MV_DT_TO);//V_MV_DT_TO
			cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(20);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_INFO", rs.getString("APPROV_INFO"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
// 				subObject.put("APPROV_DT", rs.getString("APPROV_DT"));
				subObject.put("APPROV_SEQ", rs.getString("APPROV_SEQ"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("BL_AMT", rs.getString("BL_AMT"));
				subObject.put("BL_LOC_AMT", rs.getString("BL_LOC_AMT"));
				subObject.put("INBOARD_DT", rs.getString("INBOARD_DT"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("FORWARD_XCH", rs.getString("FORWARD_XCH"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
// 				subObject.put("CH_LC_AMT", rs.getString("CH_LC_AMT"));
// 				subObject.put("CH_LC_AMEND_AMT", rs.getString("CH_LC_AMEND_AMT"));
// 				subObject.put("CH_ETC_AMT", rs.getString("CH_ETC_AMT"));
// 				subObject.put("CH_TAX_AMT", rs.getString("CH_TAX_AMT"));
// 				subObject.put("CH_REC_AMT", rs.getString("CH_REC_AMT"));
// 				subObject.put("CH_TOT_AMT", rs.getString("CH_TOT_AMT"));
				subObject.put("CH_LC_YN", rs.getString("CH_LC_YN"));
				subObject.put("CH_BL_YN", rs.getString("CH_BL_YN"));
				subObject.put("CH_CC_YN", rs.getString("CH_CC_YN"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("GR_LOC_AMT", rs.getString("GR_LOC_AMT"));
				subObject.put("ST_BOX_QTY", rs.getString("ST_BOX_QTY"));
				subObject.put("ST_QTY", rs.getString("ST_QTY"));
				subObject.put("ST_AMT", rs.getString("ST_AMT"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("TEMP_GL_BL", rs.getString("TEMP_GL_BL"));
				subObject.put("TEMP_GL_GR", rs.getString("TEMP_GL_GR"));
				

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


