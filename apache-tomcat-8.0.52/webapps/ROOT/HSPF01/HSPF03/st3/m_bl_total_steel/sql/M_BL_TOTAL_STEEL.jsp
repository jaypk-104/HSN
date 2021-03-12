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
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();

		//상단
		if (V_TYPE.equals("HH")) {
			cs = conn.prepareCall("call USP_001_M_BL_TOTAL_STEEL(?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(4);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("APPROV_DT", rs.getString("APPROV_DT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TEMRS_NM"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("FORWARD_XCH", rs.getString("FORWARD_XCH"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("D1")) {

			cs = conn.prepareCall("call USP_001_M_BL_TOTAL_STEEL(?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(4);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_NM", rs.getString("COL_NM"));
				subObject.put("COL_AVL_AMT", rs.getString("COL_AVL_AMT"));
				subObject.put("COL_AMT", rs.getString("COL_AMT"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("D2")) {
			
			cs = conn.prepareCall("call USP_001_M_BL_TOTAL_STEEL(?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(4);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_TYPE", rs.getString("M_TYPE"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BL_BOX_QTY", rs.getString("BL_BOX_QTY"));
				subObject.put("BL_QTY", rs.getString("BL_QTY"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("GR_BOX_QTY", rs.getString("GR_BOX_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("GR_AMT", rs.getString("GR_AMT"));
				subObject.put("DISTB_AMT", rs.getString("DISTB_AMT"));
				subObject.put("M_LOC_AMT", rs.getString("M_LOC_AMT"));
				subObject.put("M_PRC_AMT", rs.getString("M_PRC_AMT"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("D3")) {
			
			cs = conn.prepareCall("call USP_001_M_BL_TOTAL_STEEL(?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(4);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_REAL_QTY", rs.getString("DN_REAL_QTY"));
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("COG_AMT", rs.getString("COG_AMT"));
				subObject.put("PROFIT_AMT", rs.getString("PROFIT_AMT"));
				subObject.put("PROFIT_RATE", rs.getString("PROFIT_RATE"));
				subObject.put("PRC_1", rs.getString("PRC_1"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SP")) {
			String V_LOADING_DT_FR = request.getParameter("W_LOADING_DT_FR") == null ? "" : request.getParameter("W_LOADING_DT_FR").substring(0, 10);
			String V_LOADING_DT_TO = request.getParameter("W_LOADING_DT_TO") == null ? "" : request.getParameter("W_LOADING_DT_TO").substring(0, 10);
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
			String V_LC_DOC_NO = request.getParameter("W_LC_DOC_NO") == null ? "" : request.getParameter("W_LC_DOC_NO").toUpperCase();
			String V_PO_NO = request.getParameter("W_PO_NO") == null ? "" : request.getParameter("W_PO_NO").toUpperCase();
			V_BL_DOC_NO = request.getParameter("W_BL_DOC_NO") == null ? "" : request.getParameter("W_BL_DOC_NO").toUpperCase();

			cs = conn.prepareCall("call USP_001_M_BL_TOTAL_REF_STEEL(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_LOADING_DT_FR);//V_LOADING_DT_FR
			cs.setString(2, V_LOADING_DT_TO);//V_LOADING_DT_TO
			cs.setString(3, V_M_BP_NM);//V_M_BP_NM
			cs.setString(4, V_S_BP_NM);//V_S_BP_NM
			cs.setString(5, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(6, V_PO_NO);//V_PO_NO
			cs.setString(7, V_LC_DOC_NO);//V_CONT_NO
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("SO_BP_NM", rs.getString("SO_BP_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				
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


