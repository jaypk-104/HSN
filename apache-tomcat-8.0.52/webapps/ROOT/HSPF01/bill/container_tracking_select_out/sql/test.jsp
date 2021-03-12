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
<%@ include file="/HSPF01/common/DB_Connection_ERP_KLNET.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%@page import="java.net.URL"%>
<%@page import="java.net.URLConnection"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="org.apache.cxf.helpers.IOUtils"%>
<%@page import="org.apache.cxf.io.CachedOutputStream"%>

<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>

<%@page import="org.json.simple.parser.JSONParser"%>


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
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		
		
		String sql = "select FTX_AAI_H ETA, FTX_AAI_D CARRIER_CD, FTX_AAI_G BL_DOC_NO from REQINF_HD where FTX_AAI_G not in (select BL_DOC_NO from CONTAINER_TIME) and FTX_AAI_G IN ('MAEU968073375', 'ANRPUS40291')";
		
		rs = e_stmt.executeQuery(sql);
		while (rs.next()) {
			System.out.println(rs.getString("BL_DOC_NO"));
			String apiURL = "http://api.plism.com/cxfServlet/etrans/HSNTEWORK/WVVOaVYzaDZiR2xsZW1aNE4zcHJkSFV6ZVhOVVltOXZkSE5UVVVacFQyRkxlRzVGVGxsTFdIRmhjdz09/INB0007/";
					apiURL += "carrierCode=" + rs.getString("CARRIER_CD") + "/blNo=" + rs.getString("BL_DOC_NO") + "/eta=" + rs.getString("ETA") + "/pod=KRPUS/format=json";
			/*	
			URL url = new URL(apiURL);
			URLConnection urlConnection = url.openConnection();
			InputStreamReader isr =  new InputStreamReader(urlConnection.getInputStream(), "UTF-8");
			System.out.println(isr);
			*/
				
					/*
			String auth = "HSNTEWORK:ghktmd10$*";
			if (auth != null) {
                byte[] authEncBytes = Base64.encodeBase64(auth.getBytes());
                String authStringEnc = new String(authEncBytes);
                urlConnection.setRequestProperty("Authorization", "Basic " + authStringEnc);
            }
			*/
			
			
			
			
			URL url = new URL(apiURL);
			InputStream in = url.openStream(); 
	        CachedOutputStream bos = new CachedOutputStream();
	        IOUtils.copy(in, bos);
	        in.close();
	        bos.close();
	        
	        String data = bos.getOut().toString();        
	        out.println(data);
	        System.out.println(data);
	        
	        JSONObject json = new JSONObject();
	        json.put("data", data);
	        
			
		}
		/*
		String apiURL = "http://api.plism.com/cxfServlet/etrans/HSNTEWORK/WVVOaVYzaDZiR2xsZW1aNE4zcHJkSFV6ZVhOVVltOXZkSE5UVVVacFQyRkxlRzVGVGxsTFdIRmhjdz09/INB0007/carrierCode=YML/blNo=YMLUN851087636/eta=20190414/pod=KRPUS/format=json";
		URL url = new URL(apiURL);
		InputStream in = url.openStream(); 
        CachedOutputStream bos = new CachedOutputStream();
        IOUtils.copy(in, bos);
        in.close();
        bos.close();
        
        String data = bos.getOut().toString();        
        out.println(data);
        System.out.println(data);
        
        JSONObject json = new JSONObject();
        json.put("data", data);
        */
        
        

        
        
		if (V_TYPE.equals("S")) {
			String V_CONTAINER_NO = request.getParameter("V_CONTAINER_NO") == null ? "" : request.getParameter("V_CONTAINER_NO");
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO");
			
			e_cs = e_conn.prepareCall("{call USP_CONTAINER_TRACKING_SELECT(?,?,?)}");
			e_cs.setString(1, V_TYPE); //
			e_cs.setString(2, V_CONTAINER_NO); //
			e_cs.setString(3, V_BL_DOC_NO); //
			
			rs = e_cs.executeQuery();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("DOCK_YN", rs.getString("DOCK_YN"));
				subObject.put("BEEF_GR_YN", rs.getString("BEEF_GR_YN"));
				subObject.put("ERP_CC_YN", rs.getString("ERP_CC_YN"));
				subObject.put("ERP_GR_YN", rs.getString("ERP_GR_YN"));
				subObject.put("RETURN_DT", rs.getString("RETURN_DT"));
				subObject.put("CARRYOUT_DT", rs.getString("CARRYOUT_DT"));
				subObject.put("ACTUAL_RETURN_DT", rs.getString("ACTUAL_RETURN_DT"));
				subObject.put("ACTUAL_CARRYOUT_DT", rs.getString("ACTUAL_CARRYOUT_DT"));
				
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
// 		jsonObject.put("success", false);
// 		jsonObject.put("resultList", e.printStackTrace());

// 		response.setContentType("text/plain; charset=UTF-8");
// 		PrintWriter pw = response.getWriter();
// 		pw.print(jsonObject);
// 		pw.flush();
// 		pw.close();
		
		
	} finally {
		
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


