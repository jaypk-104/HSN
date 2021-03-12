<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<%--     <%@ include file="/WEB-INF/jsp/common/DbCon.jsp" %>  --%>
   
    <%
    String url = "jdbc:tibero:thin:@123.142.124.138:8629:hsnetwork";
	String id = "swm";
	String pwd = "hsnadmin";                             
	Connection conn = null;
	Statement stmt = null;
	Class.forName("com.tmax.tibero.jdbc.TbDriver");
	conn=DriverManager.getConnection(url,id,pwd);
		stmt = conn.createStatement();
    	ResultSet rs = null;
    	CallableStatement cs = null;
    	
    try{
    	
	String V_TYPE = request.getParameter("V_TYPE");
	String V_PO_NO = request.getParameter("V_PO_NO");
	String V_USR_ID = request.getParameter("V_USR_ID");
	
// 	System.out.println("V_TYPE" + V_TYPE); //'C'
// 	System.out.println("V_PO_NO" + V_PO_NO); //''
// 	System.out.println("V_USR_ID" + V_USR_ID); //접속아이디
	
   	cs = conn.prepareCall("{call USP_IF_HSNA(?,?,?,?)}");

   	cs.setString(1, V_TYPE);
   	cs.setString(2, V_PO_NO);
   	cs.setString(3, V_USR_ID);
   	cs.registerOutParameter(4, Types.VARCHAR);
	
	cs.execute();
	
	
	
    }catch(Exception e){
	e.printStackTrace();
	 }finally{
 	  if (rs != null) try { rs.close(); } catch(SQLException ex) {}
 	  if (cs != null) try { cs.close(); } catch(SQLException ex) {}
      if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
 }
    
    %>
    
    