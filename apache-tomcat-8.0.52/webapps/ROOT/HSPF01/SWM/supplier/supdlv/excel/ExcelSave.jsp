	<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
   
    <%
		
	CallableStatement cs = null;
     ResultSet rs = null;
    try{
// 	 System.out.println("엑셀저장SQL");

     String V_ASN_NO = request.getParameter("V_ASN_NO");
     String V_ASN_SEQ = request.getParameter("V_ASN_SEQ");
     String V_LOT_NO = request.getParameter("V_LOT_NO");
     String V_MAKE_DT = request.getParameter("V_MAKE_DT");
     String V_VALID_DT = request.getParameter("V_VALID_DT");
     String V_USR_ID = request.getParameter("V_USR_ID");
     String V_BOX_QTY = request.getParameter("V_BOX_QTY");
     
// 	 System.out.println("V_MAKE_DT : " + V_MAKE_DT);
// 	 System.out.println("V_VALID_DT : " + V_VALID_DT);
	 
	 if(V_MAKE_DT.contains("-")) {
		 V_MAKE_DT = (V_MAKE_DT==null || V_MAKE_DT.equals(""))?"":V_MAKE_DT.substring(0, 10); 
	 }
	 
	 if(V_VALID_DT.contains("-")) {
	     V_VALID_DT = (V_VALID_DT==null || V_VALID_DT.equals(""))?"":V_VALID_DT.substring(0, 10); 
	 }
    	
// 	 System.out.println(V_ASN_NO);
// 	 System.out.println(V_ASN_SEQ);
// 	 System.out.println(V_LOT_NO);
// 	 System.out.println(V_USR_ID);
// 	 System.out.println(V_BOX_QTY);
	 
	cs = conn.prepareCall("{call USP_SUPP_ASN_LOTNO_INSRT(?,?,?,?,?,?,?)}");
   	cs.setString(1, V_ASN_NO);
   	cs.setString(2, V_ASN_SEQ);
   	cs.setString(3, V_LOT_NO);
   	cs.setString(4, V_MAKE_DT);
   	cs.setString(5, V_VALID_DT);
   	cs.setString(6, V_USR_ID);
   	cs.setString(7, V_BOX_QTY); //과부족허용률위한 BOX QTY

   	
   	cs.executeUpdate();

	    }catch(Exception e){
	 e.printStackTrace();
	 }finally{
 	  if (rs != null) try { rs.close(); } catch(SQLException ex) {}
 	  if (cs != null) try { cs.close(); } catch(SQLException ex) {}
      if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
 }
	    
	    %>
	    
	    
	    
	    
	    
	    
	    
	 
	 