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
				
				String V_TYPE       = hashMap.get("V_TYPE")          == null ? "" : hashMap.get("V_TYPE").toString(); 
				String V_INSROW     = hashMap.get("INSROW")          == null ? "" : hashMap.get("INSROW").toString();
				String V_INV_MGM_NO = hashMap.get("INV_MGM_NO")      == null ? "" : hashMap.get("INV_MGM_NO").toString();      
				String V_INV_NO     = hashMap.get("INV_NO")          == null ? "" : hashMap.get("INV_NO").toString();     
				String V_VESSEL     = hashMap.get("VESSEL_NM")       == null ? "" : hashMap.get("VESSEL_NM").toString();     
				String V_LOAD_DT    = hashMap.get("LOAD_DT")         == null ? "" : hashMap.get("LOAD_DT").toString().substring(0,10); 
				String V_CFM_YN     = hashMap.get("CFM_YN")          == null ? "" : hashMap.get("CFM_YN").toString();        
				String V_USR        = request.getParameter("V_USR")  == null ? "" : request.getParameter("V_USR").toString();  
			
			 	V_LOAD_DT = (V_LOAD_DT==null||V_LOAD_DT.equals("")?"":V_LOAD_DT.substring(0, 10));
			 	
			 	if(V_CFM_YN == null || V_CFM_YN.equals("")) {
		 			V_CFM_YN = "N";
			 	}	
			 	if(V_TYPE.equals("I") && !V_INV_MGM_NO.equals("")) {
					V_TYPE = "U";
				}
// 			 	System.out.println("V_INSROW:" + V_INSROW + "/V_TYPE:" + V_TYPE);
			 	if(V_INSROW.equals("Y")){
					V_TYPE = "I";
				}
				
			
			 	
				cs = conn.prepareCall("{call USP_S_INV_HDR_INSERT(?,?,?,?,?,?,?,?)}");
			   	cs.setString(1, V_TYPE);
			   	cs.setString(2, V_INV_MGM_NO);
			   	cs.setString(3, V_INV_NO);
			   	cs.setString(4, V_VESSEL);
			   	cs.setString(5, V_LOAD_DT);
			   	cs.setString(6, V_CFM_YN);
			   	cs.setString(7, V_USR);
			   	cs.registerOutParameter(8, Types.VARCHAR); 
			   	
			   	cs.execute();
			   	
// 			   	if(cs.getString(8).equals("ISBL")) {
// 						PrintWriter pw = response.getWriter();
// 						pw.print(cs.getString(8));
// 						pw.flush();
// 						pw.close();
// 			   	} 
				
			}
		} else {
			JSONObject jsondata = JSONObject.fromObject(jsonData);
		 
			
			String V_TYPE       = jsondata.get("V_TYPE")         == null ? "" : jsondata.get("V_TYPE").toString();     
			String V_INSROW     = jsondata.get("INSROW")         == null ? "" : jsondata.get("INSROW").toString();
			String V_INV_MGM_NO = jsondata.get("INV_MGM_NO")     == null ? "" : jsondata.get("INV_MGM_NO").toString();      
			String V_INV_NO     = jsondata.get("INV_NO")         == null ? "" : jsondata.get("INV_NO").toString();     
			String V_VESSEL     = jsondata.get("VESSEL_NM")      == null ? "" : jsondata.get("VESSEL_NM").toString();     
			String V_LOAD_DT    = jsondata.get("LOAD_DT")        == null ? "" : jsondata.get("LOAD_DT").toString().substring(0,10); 
			String V_CFM_YN     = jsondata.get("CFM_YN")         == null ? "" : jsondata.get("CFM_YN").toString();        
			String V_USR        = request.getParameter("V_USR")  == null ? "" : request.getParameter("V_USR").toString();  
		
			
		 	V_LOAD_DT = (V_LOAD_DT==null||V_LOAD_DT.equals("")?"":V_LOAD_DT.substring(0, 10));
		 	
		 	if(V_CFM_YN == null || V_CFM_YN.equals("")) {
	 			V_CFM_YN = "N";
		 	}				
			if(V_TYPE.equals("I") && !V_INV_MGM_NO.equals("")) {
					V_TYPE = "U";
				}
		 	if(V_INSROW.equals("Y")){
					V_TYPE = "I";
				}
// 		 	System.out.println("V_INSROW:" + V_INSROW + "/V_TYPE:" + V_TYPE);
			cs = conn.prepareCall("{call USP_S_INV_HDR_INSERT(?,?,?,?,?,?,?,?)}");
		   	cs.setString(1, V_TYPE);
		   	cs.setString(2, V_INV_MGM_NO);
		   	cs.setString(3, V_INV_NO);
		   	cs.setString(4, V_VESSEL);
		   	cs.setString(5, V_LOAD_DT);
		   	cs.setString(6, V_CFM_YN);
		   	cs.setString(7, V_USR);
		   	cs.registerOutParameter(8, Types.VARCHAR); 
		   	
		   	cs.execute();
		   	
		   	
// 		   	if(cs.getString(8).equals("ISBL")) {
//  					PrintWriter pw = response.getWriter();
//  					pw.print(cs.getString(8));
//  					pw.flush();
//  					pw.close();
//  		   	}
		} 
	}catch(Exception e){
		e.printStackTrace();
	}finally{
 		if (rs != null)   try { rs.close(); }   catch(SQLException ex) {}
 	  	if (cs != null)   try { cs.close(); }   catch(SQLException ex) {}
      	if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      	if (conn != null) try { conn.close(); } catch(SQLException ex) {}
 	}
 %>
