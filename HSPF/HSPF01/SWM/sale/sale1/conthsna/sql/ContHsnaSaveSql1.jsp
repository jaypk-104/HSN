<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
   
    <%
		
     ResultSet rs = null;
	CallableStatement cs = null;
    try{
    		 JSONObject jsonObject = new JSONObject();
			 JSONArray jsonArray = new JSONArray();
			 JSONObject subObject =  null;
	//컨테이너 변경		 = 삭제해도됨
			 String V_u_CONT_NO = request.getParameter("V_u_CONT_NO");
			 String V_CONT_NO = request.getParameter("V_CONT_NO");
			 String V_U_CONT_SEAL_NO = request.getParameter("V_U_CONT_SEAL_NO");
			 String V_U_CONT_SIZE = request.getParameter("V_U_CONT_SIZE");
			 String V_USER_ID = request.getParameter("V_USER_ID");
			 
			 String sql = "UPDATE S_CONTAINER_MST SET CONT_NO = '"+V_u_CONT_NO+"' ";
			 sql += ", CONT_SEAL_NO = '" + V_U_CONT_SEAL_NO+ "' ";
			 sql += ", CONT_SIZE = '" + V_U_CONT_SIZE + "' ";
			 sql += "WHERE CONT_NO = '"+V_CONT_NO+"' ";
			      
			        
			 rs = stmt.executeQuery(sql);

    }catch(Exception e){
	 e.printStackTrace();
	 }finally{
 	  if (rs != null) try { rs.close(); } catch(SQLException ex) {}
 	  if (cs != null) try { cs.close(); } catch(SQLException ex) {}
      if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
 }
	    
	    %>
	    
	    
	    
	    
	    
	    
	    
	 
	 