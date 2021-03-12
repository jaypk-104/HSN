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
		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").substring(0, 10);
// 		String V_YYYYMM = request.getParameter("V_YYYYMM") == null ? "" : request.getParameter("V_YYYYMM").replace("-", "").substring(0, 6);
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("SH")) {
			cs = conn.prepareCall("call USP_003_M_S_COG_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_MVMT_DT_FR);//V_MVMT_DT_FR
			cs.setString(4, V_MVMT_DT_TO);//V_MVMT_DT_TO 
			cs.setString(5, V_M_BP_CD);//V_M_BP_CD 
			cs.setString(6, V_ITEM_CD);//V_ITEM_CD 
			cs.setString(7, V_ITEM_NM);//V_ITEM_NM 
			cs.setString(8, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(9, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(10, "");//V_MVMT_NO
			cs.setString(11, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BL_QTY", rs.getString("BL_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("CUR_METH", rs.getString("CUR_METH"));
				subObject.put("MVMT_PRC", rs.getString("MVMT_PRC"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("AT_LOC_AMT2", rs.getString("AT_LOC_AMT2"));
				subObject.put("TAX_AMT", rs.getString("TAX_AMT"));
				subObject.put("ETC_AMT", rs.getString("ETC_AMT"));
				subObject.put("DISTR_AMT", rs.getString("DISTR_AMT"));
				subObject.put("MVMT_LOC_AMT", rs.getString("MVMT_LOC_AMT"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("AT_PRC_AMT", rs.getString("AT_PRC_AMT"));
				subObject.put("DISTR_PRC", rs.getString("DISTR_PRC"));
				subObject.put("DISTR_RT", rs.getString("DISTR_RT"));
				subObject.put("DISTR_CC_RT", rs.getString("DISTR_CC_RT"));
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

		} else if (V_TYPE.equals("SD")) {
			String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_003_M_S_COG_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_MVMT_DT_FR
			cs.setString(4, "");//V_MVMT_DT_TO 
			cs.setString(5, "");//V_M_BP_CD 
			cs.setString(6, "");//V_ITEM_CD 
			cs.setString(7, "");//V_ITEM_NM 
			cs.setString(8, "");//V_LC_DOC_NO
			cs.setString(9, "");//V_BL_DOC_NO
			cs.setString(10, V_MVMT_NO);//V_MVMT_NO
			cs.setString(11, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("CHARGE_CD", rs.getString("CHARGE_CD"));
				subObject.put("CHARGE_NM", rs.getString("CHARGE_NM"));
				subObject.put("DISB_AMT", rs.getString("DISB_AMT"));
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


