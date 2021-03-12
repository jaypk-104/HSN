<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.io.InputStreamReader"%>
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
<%@page import="org.apache.commons.codec.binary.Base64"%>




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
		
		
		String sql = "select FTX_AAI_H ETA, FTX_AAI_D CARRIER_CD, FTX_AAI_G BL_DOC_NO from REQINF_HD where FTX_AAI_G not in (select BL_DOC_NO from CONTAINER_TIME) and FTX_AAI_G IN ('MAEU968073375', 'HASLAB0229004200')"; // 'ANRPUS40291')";
		
		rs = e_stmt.executeQuery(sql);
		while (rs.next()) {
			System.out.println(rs.getString("BL_DOC_NO"));
			String apiURL = "http://api.plism.com/cxfServlet/etrans/HSNTEWORK/WVVOaVYzaDZiR2xsZW1aNE4zcHJkSFV6ZVhOVVltOXZkSE5UVVVacFQyRkxlRzVGVGxsTFdIRmhjdz09/INB0007/";
					apiURL += "carrierCode=" + rs.getString("CARRIER_CD") + "/blNo=" + rs.getString("BL_DOC_NO") + "/eta=" + rs.getString("ETA") + "/pod=KRPUS/format=json";
			
			URL url = new URL(apiURL);
			URLConnection urlConnection = url.openConnection();
			
			String auth = "HSNTEWORK:ghktmd10$*";
			if (auth != null) {
                byte[] authEncBytes = Base64.encodeBase64(auth.getBytes());
                String authStringEnc = new String(authEncBytes);
                urlConnection.setRequestProperty("Authorization", "Basic " + authStringEnc);
            }
			
			
			InputStreamReader isr =  new InputStreamReader(urlConnection.getInputStream(), "UTF-8");
			JSONArray obj1 = (JSONArray)JSONValue.parse(isr);
			
			
			System.out.println(obj1);
			System.out.println(obj1.size());
			
			for(int i=0 ; i<obj1.size() ; i++){
                JSONObject tempObj = (JSONObject) obj1.get(i);
//                 System.out.println("반출기한"+tempObj.get("out_due_date"));
//                 System.out.println("반납기한"+tempObj.get("ret_due_date"));
//                 System.out.println("----------------------------");
                
                e_cs = e_conn.prepareCall("{call USP_CONTAINER_TIME_MGM(?,?,?,?)}");
    			e_cs.setString(1, "I"); //
    			e_cs.setString(2, rs.getString("BL_DOC_NO")); //
    			e_cs.setString(3, tempObj.get("ret_due_date").toString()); //
    			e_cs.setString(4, tempObj.get("out_due_date").toString()); //
    			
    			e_cs.execute();
                
                
            }

			
			/*
			
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


