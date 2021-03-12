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
	CallableStatement cs = null;

     ResultSet rs = null;
    try{
    	

	request.setCharacterEncoding("utf-8");
	String data = request.getParameter("data");
   	String jsonData = URLDecoder.decode(data, "UTF-8");

   	if (jsonData.lastIndexOf("},{") > 0) { //배열일경우(여러개가 체크된 경우)
		System.out.println("sqlUpdate if");
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
    		for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);	
				String dummy   = hashMap.get("dummy")  == null ? "" : hashMap.get("dummy").toString();  
				if(dummy.equals("I")){
					String V_TYPE   = request.getParameter("V_TYPE")  == null ? "" : request.getParameter("V_TYPE").toString();  
					String V_PO_NO  = hashMap.get("PO_NO")       == null ? "" : hashMap.get("PO_NO").toString();   
					String V_PO_SEQ  = hashMap.get("PO_SEQ")       == null ? "" : hashMap.get("PO_SEQ").toString();   
					String V_DLV    = hashMap.get("CUST_DLVY_DT")       == null ? "" : hashMap.get("CUST_DLVY_DT").toString();   
					String V_BP_CD   = hashMap.get("BP_CD")       == null ? "" : hashMap.get("BP_CD").toString();   
					String V_MAST_PO_DT = request.getParameter("V_MAST_PO_DT")  == null ? "" : request.getParameter("V_MAST_PO_DT").toString();  
					if(V_MAST_PO_DT != "") {
						V_MAST_PO_DT = V_MAST_PO_DT.substring(0, 10);
					}
					
					String V_ITEM_CD = hashMap.get("ITEM_CD")       == null ? "" : hashMap.get("ITEM_CD").toString();   
					String V_FIR_DLV = hashMap.get("FIR_DLV")       == null ? "" : hashMap.get("FIR_DLV").toString(); 
					if(V_FIR_DLV != "") {
						V_FIR_DLV = V_FIR_DLV.substring(0, 10);
					}
					
					String V_FIR_QTY = hashMap.get("FIR_QTY")       == null ? "" : hashMap.get("FIR_QTY").toString(); 
					if( V_FIR_QTY.equals("null")){
						V_FIR_QTY = "";
					}
					
					String V_SEC_DLV = hashMap.get("SEC_DLV")       == null ? "" : hashMap.get("SEC_DLV").toString(); 
					if(!V_SEC_DLV.equals("")) {
						V_SEC_DLV = V_SEC_DLV.substring(0, 10);
					}
					
					String V_SEC_QTY = hashMap.get("SEC_QTY")       == null ? "" : hashMap.get("SEC_QTY").toString(); 
					if( V_SEC_QTY.equals("null")){
						V_SEC_QTY = "";
					}
					
					String V_THR_DLV = hashMap.get("THR_DLV")       == null ? "" : hashMap.get("THR_DLV").toString(); 
					if(!V_THR_DLV.equals("")) {
						V_THR_DLV = V_THR_DLV.substring(0, 10);
					}
					
					String V_THR_QTY = hashMap.get("THR_QTY")       == null ? "" : hashMap.get("THR_QTY").toString();
					if( V_THR_QTY.equals("null")){
						V_THR_QTY = "";
					}
					
					String V_FOR_DLV = hashMap.get("FOR_DLV")       == null ? "" : hashMap.get("FOR_DLV").toString(); 
					if(!V_FOR_DLV.equals("")) {
						V_FOR_DLV = V_FOR_DLV.substring(0, 10);
					}
					
					String V_FOR_QTY = hashMap.get("FOR_QTY")       == null ? "" : hashMap.get("FOR_QTY").toString();
					if( V_FOR_QTY.equals("null")){
						V_FOR_QTY = "";
					}
					
					String V_FIF_DLV = hashMap.get("FIF_DLV")       == null ? "" : hashMap.get("FIF_DLV").toString(); 
					if(!V_FIF_DLV.equals("")) {
						V_FIF_DLV = V_FIF_DLV.substring(0, 10);
					}
					
					String V_FIF_QTY = hashMap.get("FIF_QTY")       == null ? "" : hashMap.get("FIF_QTY").toString(); 
					if( V_FIF_QTY.equals("null")){
						V_FIF_QTY = "";
					}
					
					String V_USR_ID   = request.getParameter("V_USR_ID")  == null ? "" : request.getParameter("V_USR_ID").toString();
					
 			/* 		System.out.println("V_TYPE : " + V_TYPE);
 					System.out.println("V_PO_NO : " + V_PO_NO);
 					System.out.println("V_PO_SEQ : " + V_PO_SEQ);
 					System.out.println("V_DLV : "+  V_DLV);
 					System.out.println("V_BP_CD : "+ V_BP_CD);
 					System.out.println("V_MAST_PO_DT : "+V_MAST_PO_DT);
 					System.out.println("V_ITEM_CD : "+V_ITEM_CD);
 					System.out.println("V_FIR_DLV : "+V_FIR_DLV);
 					System.out.println("V_FIR_QTY : "+V_FIR_QTY);
 					System.out.println("V_SEC_DLV : "+V_SEC_DLV);
 					System.out.println("V_SEC_QTY : "+V_SEC_QTY);
 					System.out.println("V_THR_DLV : "+V_THR_DLV);
 					System.out.println("V_THR_QTY : "+V_THR_QTY);
 					System.out.println("V_FOR_DLV : "+V_FOR_DLV);
 					System.out.println("V_FOR_QTY : "+V_FOR_QTY);
 					System.out.println("V_FIF_DLV : "+V_FIF_DLV);
 					System.out.println("V_FIF_QTY : "+V_FIF_QTY);
 					System.out.println("V_USR_ID : "+V_USR_ID); */
					
			    	
			    	cs = conn.prepareCall("{call USP_PO_CFM_SURVEY_DTL_GR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				   	cs.setString(1, V_TYPE);
				   	cs.setString(2, V_PO_NO);
				   	cs.setString(3, V_PO_SEQ);
				   	cs.setString(4, V_DLV);  			
				   	cs.setString(5, V_BP_CD);
				   	cs.setString(6, V_MAST_PO_DT);
				   	cs.setString(7, V_ITEM_CD);
				   	cs.setString(8, V_FIR_DLV);
				   	cs.setString(9, V_FIR_QTY);
				   	cs.setString(10, V_SEC_DLV);
				   	cs.setString(11, V_SEC_QTY);
				   	cs.setString(12, V_THR_DLV);
				   	cs.setString(13, V_THR_QTY);
				   	cs.setString(14, V_FOR_DLV);
				   	cs.setString(15, V_FOR_QTY);
				   	cs.setString(16, V_FIF_DLV);
				   	cs.setString(17, V_FIF_QTY);
				   	cs.setString(18, V_USR_ID);
					
					cs.execute();
				}
				
    		}
    	}
   	
   		else{
   			JSONObject jsondata = JSONObject.fromObject(jsonData);
   			System.out.println("하단 sqlUpdate else");
   			
   			String dummy  = jsondata.get("dummy")       == null ? "" : jsondata.get("dummy").toString();
   			System.out.println("dummy : " + dummy);
   			if(dummy.equals("I")){
   				String V_TYPE   = request.getParameter("V_TYPE")  == null ? "" : request.getParameter("V_TYPE").toString();  
				String V_PO_NO  = jsondata.get("PO_NO")       == null ? "" : jsondata.get("PO_NO").toString();   
				String V_PO_SEQ  = jsondata.get("PO_SEQ")       == null ? "" : jsondata.get("PO_SEQ").toString();   
				String V_DLV    = jsondata.get("CUST_DLVY_DT")       == null ? "" : jsondata.get("CUST_DLVY_DT").toString();   
				String V_BP_CD   = jsondata.get("BP_CD")       == null ? "" : jsondata.get("BP_CD").toString();   
				String V_MAST_PO_DT = request.getParameter("V_MAST_PO_DT")  == null ? "" : request.getParameter("V_MAST_PO_DT").toString();  
				if(V_MAST_PO_DT != "") {
					V_MAST_PO_DT = V_MAST_PO_DT.substring(0, 10);
				}
				String V_ITEM_CD = jsondata.get("ITEM_CD")       == null ? "" : jsondata.get("ITEM_CD").toString();   
				String V_FIR_DLV = jsondata.get("FIR_DLV")       == null ? "" : jsondata.get("FIR_DLV").toString(); 
				if(V_FIR_DLV != "") {
					V_FIR_DLV = V_FIR_DLV.substring(0, 10);
				}
				
				String V_FIR_QTY = jsondata.get("FIR_QTY")       == null ? "" : jsondata.get("FIR_QTY").toString(); 
				String V_SEC_DLV = jsondata.get("SEC_DLV")       == null ? "" : jsondata.get("SEC_DLV").toString(); 
	
				if(!V_SEC_DLV.equals("")) {
					V_SEC_DLV = V_SEC_DLV.substring(0, 10);
				}
				String V_SEC_QTY = jsondata.get("SEC_QTY")       == null ? "" : jsondata.get("SEC_QTY").toString(); 
				if( V_SEC_QTY.equals("null")){
					V_SEC_QTY = "";
				}
				String V_THR_DLV = jsondata.get("THR_DLV")       == null ? "" : jsondata.get("THR_DLV").toString(); 
				if(!V_THR_DLV.equals("")) {
					V_THR_DLV = V_THR_DLV.substring(0, 10);
				}
				String V_THR_QTY = jsondata.get("THR_QTY")       == null ? "" : jsondata.get("THR_QTY").toString();
				if( V_THR_QTY.equals("null")){
					V_THR_QTY = "";
				}
				String V_FOR_DLV = jsondata.get("FOR_DLV")       == null ? "" : jsondata.get("FOR_DLV").toString(); 
				if(!V_FOR_DLV.equals("")) {
					V_FOR_DLV = V_FOR_DLV.substring(0, 10);
				}
				String V_FOR_QTY = jsondata.get("FOR_QTY")       == null ? "" : jsondata.get("FOR_QTY").toString();
				if( V_FOR_QTY.equals("null")){
					V_FOR_QTY = "";
				}
				String V_FIF_DLV = jsondata.get("FIF_DLV")       == null ? "" : jsondata.get("FIF_DLV").toString(); 
				if(!V_FIF_DLV.equals("")) {
					V_FIF_DLV = V_FIF_DLV.substring(0, 10);
				}
				String V_FIF_QTY = jsondata.get("FIF_QTY")       == null ? "" : jsondata.get("FIF_QTY").toString(); 
				if( V_FIF_QTY.equals("null")){
					V_FIF_QTY = "";
				}
				String V_USR_ID   = request.getParameter("V_USR_ID")  == null ? "" : request.getParameter("V_USR_ID").toString();
				
			
/* 				System.out.println("V_TYPE : " + V_TYPE);
				System.out.println("V_PO_NO : " + V_PO_NO);
				System.out.println("V_PO_SEQ : " + V_PO_SEQ);
				System.out.println("V_DLV : "+  V_DLV);
				System.out.println("V_BP_CD : "+ V_BP_CD);
				System.out.println("V_MAST_PO_DT : "+V_MAST_PO_DT);
				System.out.println("V_ITEM_CD : "+V_ITEM_CD);
				System.out.println("V_FIR_DLV : "+V_FIR_DLV);
				System.out.println("V_FIR_QTY : "+V_FIR_QTY);
				System.out.println("V_SEC_DLV : "+V_SEC_DLV);
				System.out.println("V_SEC_QTY : "+V_SEC_QTY);
				System.out.println("V_THR_DLV : "+V_THR_DLV);
				System.out.println("V_THR_QTY : "+V_THR_QTY);
				System.out.println("V_FOR_DLV : "+V_FOR_DLV);
				System.out.println("V_FOR_QTY : "+V_FOR_QTY);
				System.out.println("V_FIF_DLV : "+V_FIF_DLV);
				System.out.println("V_FIF_QTY : "+V_FIF_QTY);
				System.out.println("V_USR_ID : "+V_USR_ID);  */
				
		    	
		    	cs = conn.prepareCall("{call USP_PO_CFM_SURVEY_DTL_GR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			   	cs.setString(1, V_TYPE);
			   	cs.setString(2, V_PO_NO);
			   	cs.setString(3, V_PO_SEQ);
			   	cs.setString(4, V_DLV);  			
			   	cs.setString(5, V_BP_CD);
			   	cs.setString(6, V_MAST_PO_DT);
			   	cs.setString(7, V_ITEM_CD);
			   	cs.setString(8, V_FIR_DLV);
			   	cs.setString(9, V_FIR_QTY);
			   	cs.setString(10, V_SEC_DLV);
			   	cs.setString(11, V_SEC_QTY);
			   	cs.setString(12, V_THR_DLV);
			   	cs.setString(13, V_THR_QTY);
			   	cs.setString(14, V_FOR_DLV);
			   	cs.setString(15, V_FOR_QTY);
			   	cs.setString(16, V_FIF_DLV);
			   	cs.setString(17, V_FIF_QTY);
			   	cs.setString(18, V_USR_ID);
				System.out.println("cs : " + cs );
				cs.execute();
   			}
   		}
   	
    }catch(Exception e){
 e.printStackTrace();
 }finally{
 	  if (rs != null) try { rs.close(); } catch(SQLException ex) {}
 	  if (cs != null) try { cs.close(); } catch(SQLException ex) {}
      if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
 }
    
    %>
    
    