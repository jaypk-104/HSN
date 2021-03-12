<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%--<%@ include file="/HSPF01/common/DB_SWM.jsp"%> --%>

<%
	String url = "jdbc:tibero:thin:@123.142.124.138:8629:hsnetwork";
	String id = "swm";
	String pwd = "hsnadmin";
	Connection conn = null;
	Statement stmt = null;
	Class.forName("com.tmax.tibero.jdbc.TbDriver");
	conn = DriverManager.getConnection(url, id, pwd);
	stmt = conn.createStatement();
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject subObject = null;
	JSONArray jsonArray = new JSONArray();
	try {
		request.setCharacterEncoding("utf-8");

		String[] findList = { "#", "+", "&", "%", " " };
		String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

		String data = request.getParameter("data");
		data = StringUtils.replaceEach(data, findList, replList);
		String jsonData = URLDecoder.decode(data, "UTF-8");

		String V_TYPE = request.getParameter("V_TYPE"); //C
		String V_USR_ID = request.getParameter("V_USR_ID");

		if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);
				String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
				String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();

				cs = conn.prepareCall("{call USP_M_PREQ_TO_SURVEY(?,?,?,?,?)}");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_PO_NO);
				cs.setString(3, V_PO_SEQ);
				cs.setString(4, V_USR_ID);
				cs.registerOutParameter(5, Types.VARCHAR);

				cs.execute();
			}
		} else {

			JSONObject jsondata = JSONObject.fromObject(jsonData);
			String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
			String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();

			cs = conn.prepareCall("{call USP_M_PREQ_TO_SURVEY(?,?,?,?,?)}");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_PO_NO);
			cs.setString(3, V_PO_SEQ);
			cs.setString(4, V_USR_ID);
			cs.registerOutParameter(5, Types.VARCHAR);

			cs.execute();
		}

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

