<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@ include file="/HSPF01/common/DB_Connection_ERP_TEMP.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		

		if (V_TYPE.equals("S")) {
			
			String V_MAST_BP_NM = request.getParameter("V_MAST_BP_NM") == null ? "" : request.getParameter("V_MAST_BP_NM").toUpperCase();
			
			
			String sql = "select  B.BP_CD MAST_BP_CD, B.BP_NM MAST_BP_NM, C.BP_CD SELECT_BP_CD, C.BP_NM SELECT_BP_NM from  M_BP_CHARGE_PARTNER  A ";
				   sql += " LEFT OUTER JOIN B_BIZ_PARTNER B ON A.MAST_BP_CD = B.BP_CD ";
				   sql += " LEFT OUTER JOIN B_BIZ_PARTNER C ON A.SELECT_BP_CD = C.BP_CD ";
				   sql += " where B.BP_NM LIKE '%" + V_MAST_BP_NM + "%' ";
				   sql += " order by B.BP_CD, C.BP_CD";
				   
			e_cs = e_conn.prepareCall("{call dbo.getData(?)}");
			e_cs.setString(1, sql); 
			
			rs = e_cs.executeQuery();
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_BP_CD", rs.getString("MAST_BP_CD"));
				subObject.put("MAST_BP_NM", rs.getString("MAST_BP_NM"));
				subObject.put("SELECT_BP_CD", rs.getString("SELECT_BP_CD"));
				subObject.put("SELECT_BP_NM", rs.getString("SELECT_BP_NM"));
				
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
		else if (V_TYPE.equals("SYNC")){
			request.setCharacterEncoding("utf-8");
			
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };
			
			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_MAST_BP_CD  = hashMap.get("MAST_BP_CD") == null ? "" : hashMap.get("MAST_BP_CD").toString();
					String V_SELECT_BP_CD  = hashMap.get("SELECT_BP_CD") == null ? "" : hashMap.get("SELECT_BP_CD").toString();
					
					e_cs = e_conn.prepareCall("{call USP_M_BP_CHARGE_PARTNER_MGM(?,?,?,?)}");
					e_cs.setString(1, V_TYPE); //
					e_cs.setString(2, V_MAST_BP_CD); //
					e_cs.setString(3, V_SELECT_BP_CD); //
					e_cs.setString(4, V_USR_ID); //
					
					e_cs.execute();
					
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_MAST_BP_CD  = jsondata.get("MAST_BP_CD") == null ? "" : jsondata.get("MAST_BP_CD").toString();
				String V_SELECT_BP_CD  = jsondata.get("SELECT_BP_CD") == null ? "" : jsondata.get("SELECT_BP_CD").toString();
				
				e_cs = e_conn.prepareCall("{call USP_M_BP_CHARGE_PARTNER_MGM(?,?,?,?)}");
				e_cs.setString(1, V_TYPE); //
				e_cs.setString(2, V_MAST_BP_CD); //
				e_cs.setString(3, V_SELECT_BP_CD); //
				e_cs.setString(4, V_USR_ID); //
				
				e_cs.execute();
				
			}
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
		
		//MSSQL
		if (e_cs != null) try {
			e_cs.close();
		} catch (SQLException ex) {}
		if (e_rs != null) try {
			e_rs.close();
		} catch (SQLException ex) {}
		if (e_stmt != null) try {
			e_stmt.close();
		} catch (SQLException ex) {}
		if (e_conn != null) try {
			e_conn.close();
		} catch (SQLException ex) {}
	}
%>


