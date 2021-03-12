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
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
   
<%
    ResultSet rs = null;
 	CallableStatement cs = null;
    try{    		
		request.setCharacterEncoding("utf-8");
		String data = request.getParameter("data");
		String jsonData = URLDecoder.decode(data, "UTF-8");
		
		if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);		
		
				String V_TYPE          = hashMap.get("V_TYPE")       == null ? "" : hashMap.get("V_TYPE").toString();   
				String V_INSROW          = hashMap.get("INSROW")       == null ? "" : hashMap.get("INSROW").toString();   
				String V_BL_MGM_NO     = hashMap.get("BL_MGM_NO")       == null ? "" : hashMap.get("BL_MGM_NO").toString();      
				String V_BL_DOC_NO     = hashMap.get("BL_DOC_NO")       == null ? "" : hashMap.get("BL_DOC_NO").toString();     
				String V_CC_DOC_NO     = hashMap.get("CC_DOC_NO")       == null ? "" : hashMap.get("CC_DOC_NO").toString();     
				String V_BL_LOADING_DT = hashMap.get("BL_LOADING_DT")   == null ? "" : hashMap.get("BL_LOADING_DT").toString().substring(0,10); 
				String V_XCH_RT        = hashMap.get("XCH_RT")          == null ? "" : hashMap.get("XCH_RT").toString();        
				String V_CFM_YN        = hashMap.get("CFM_YN")          == null ? "" : hashMap.get("CFM_YN").toString();        
				String V_USR           = request.getParameter("V_USR")  == null ? "" : request.getParameter("V_USR").toString();           
				
				V_BL_LOADING_DT = (V_BL_LOADING_DT==null||V_BL_LOADING_DT.equals("")?"":V_BL_LOADING_DT.substring(0, 10));
					
				if(V_CFM_YN == null || V_CFM_YN.equals("")) {
					V_CFM_YN = "N";
				}
				
				if(V_TYPE.equals("I") && !V_BL_MGM_NO.equals("")) {
					V_TYPE = "U";
				}
				System.out.println("V_INSROW:" + V_INSROW);
				if(V_INSROW.equals("Y")){
					V_TYPE = "I";
				}
				
				if(!V_TYPE.equals(""))
				{
					cs = conn.prepareCall("{call USP_S_BL_HDR_INSERT(?,?,?,?,?,?,?,?)}");
				   	cs.setString(1, V_TYPE);
				   	cs.setString(2, V_BL_MGM_NO);
				   	cs.setString(3, V_BL_DOC_NO);
				   	cs.setString(4, V_BL_LOADING_DT);
				   	cs.setString(5, V_XCH_RT);
				   	cs.setString(6, V_CFM_YN);
				   	cs.setString(7, V_USR);
				   	cs.setString(8, V_CC_DOC_NO);
				   	
				   	cs.execute();
				}
			}
		} else {
			JSONObject jsondata = JSONObject.fromObject(jsonData);
			
			String V_TYPE          = jsondata.get("V_TYPE")         == null ? "" : jsondata.get("V_TYPE").toString();    
			String V_INSROW        = jsondata.get("INSROW")         == null ? "" : jsondata.get("INSROW").toString();   
			String V_BL_MGM_NO     = jsondata.get("BL_MGM_NO")      == null ? "" : jsondata.get("BL_MGM_NO").toString();      
			String V_BL_DOC_NO     = jsondata.get("BL_DOC_NO")      == null ? "" : jsondata.get("BL_DOC_NO").toString();     
			String V_CC_DOC_NO     = jsondata.get("CC_DOC_NO")      == null ? "" : jsondata.get("CC_DOC_NO").toString();     
			String V_BL_LOADING_DT = jsondata.get("BL_LOADING_DT")  == null ? "" : jsondata.get("BL_LOADING_DT").toString().substring(0,10); 
			String V_XCH_RT        = jsondata.get("XCH_RT")         == null ? "" : jsondata.get("XCH_RT").toString();        
			String V_CFM_YN        = jsondata.get("CFM_YN")         == null ? "" : jsondata.get("CFM_YN").toString();        
			String V_USR           = request.getParameter("V_USR")  == null ? "" : request.getParameter("V_USR").toString();          
			
			V_BL_LOADING_DT = (V_BL_LOADING_DT==null||V_BL_LOADING_DT.equals("")?"":V_BL_LOADING_DT.substring(0, 10));
				
			System.out.println("V_BL_LOADING_DT : " + V_BL_LOADING_DT);
			System.out.println("V_XCH_RT : " + V_XCH_RT);
			
			if(V_CFM_YN == null || V_CFM_YN.equals("")) {
				V_CFM_YN = "N";
			}
				
			if(V_TYPE.equals("I") && !V_BL_MGM_NO.equals("")) {
				V_TYPE = "U";
			}
			
			if(V_INSROW.equals("Y")){
				V_TYPE = "I";
			}
			
			if(!V_TYPE.equals("")){
				cs = conn.prepareCall("{call USP_S_BL_HDR_INSERT(?,?,?,?,?,?,?,?)}");
			   	cs.setString(1, V_TYPE);
			   	cs.setString(2, V_BL_MGM_NO);
			   	cs.setString(3, V_BL_DOC_NO);
			   	cs.setString(4, V_BL_LOADING_DT);
			   	cs.setString(5, V_XCH_RT);
			   	cs.setString(6, V_CFM_YN);
			   	cs.setString(7, V_USR);
			   	cs.setString(8, V_CC_DOC_NO);
			   	
			   	cs.execute();
			}
		}
				
		
	/*  String V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
		String V_INV_MGM_NO = request.getParameter("V_INV_MGM_NO") == null ? "" : request.getParameter("V_INV_MGM_NO");
		String V_CONT_MGM_NO = hashMap.get("CONT_MGM_NO") == null ? "" : hashMap.get("CONT_MGM_NO").toString();
		if (V_TYPE.equals("D")) {
			V_INV_MGM_NO = hashMap.get("INV_MGM_NO") == null ? "" : hashMap.get("INV_MGM_NO").toString();
			V_CONT_MGM_NO = hashMap.get("CONT_NO") == null ? "" : hashMap.get("CONT_NO").toString();
		}
		String V_PAL_BC_NO = hashMap.get("PAL_BC_NO") == null ? "" : hashMap.get("PAL_BC_NO").toString();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		
		
		
		
		
	 JSONObject jsonObject = new JSONObject();
	 JSONArray jsonArray = new JSONArray();
	 JSONObject subObject =  null;
	
	//MyViewport
	 String V_TYPE = request.getParameter("V_TYPE"); 
	 String V_BL_MGM_NO = request.getParameter("V_BL_MGM_NO");
	 String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO");
	 String V_CC_DOC_NO = request.getParameter("V_CC_DOC_NO");
	 String V_BL_LOADING_DT = request.getParameter("V_BL_LOADING_DT");
	 String V_XCH_RT = request.getParameter("V_XCH_RT");
	 String V_CFM_YN = request.getParameter("V_CFM_YN");
	 String V_USR = request.getParameter("V_USR");
	 
	
	 V_BL_LOADING_DT = (V_BL_LOADING_DT==null||V_BL_LOADING_DT.equals("")?"":V_BL_LOADING_DT.substring(0, 10));

	 if(V_CFM_YN == null || V_CFM_YN.equals("")) {
	 	V_CFM_YN = "N";
	 } */ 
	 
	 
	}catch(Exception e){
		e.printStackTrace();
	}finally{
 		if (rs != null)   try { rs.close(); }   catch(SQLException ex) {}
 	  	if (cs != null)   try { cs.close(); }   catch(SQLException ex) {}
      	if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      	if (conn != null) try { conn.close(); } catch(SQLException ex) {}
 	}
%>
