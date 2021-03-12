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
	
	//MyViewport
	 String V_TYPE = request.getParameter("V_TYPE");

	 String V_INV_MGM_NO = request.getParameter("V_INV_MGM_NO");
	 String V_INV_NO = request.getParameter("V_INV_NO");
	 String V_VESSEL = request.getParameter("V_VESSEL");
	 String V_LOAD_DT = request.getParameter("V_LOAD_DT");
	 String V_CFM_YN = request.getParameter("V_CFM_YN");
	 String V_USR = request.getParameter("V_USR");
	 
	
	 V_LOAD_DT = (V_LOAD_DT==null||V_LOAD_DT.equals("")?"":V_LOAD_DT.substring(0, 10));
	 if(V_CFM_YN == null || V_CFM_YN.equals("")) {
	 	V_CFM_YN = "N";
	 }
// 	 System.out.println("V_TYPE " + V_TYPE);
// 	 System.out.println("V_INV_MGM_NO " + V_INV_MGM_NO);
// 	 System.out.println("V_INV_NO " + V_INV_NO);
// 	 System.out.println("V_VESSEL " + V_VESSEL);
// 	 System.out.println("V_LOAD_DT " + V_LOAD_DT);
// 	 System.out.println("V_CFM_YN " + V_CFM_YN);
// 	 System.out.println("V_USR " + V_USR);
	
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
   	
   	if(cs.getString(8).equals("ISBL")) {
			PrintWriter pw = response.getWriter();
			pw.print(cs.getString(8));
			pw.flush();
			pw.close();
   	} else {
   	}
	 
	 }catch(Exception e){
	 e.printStackTrace();
	 }finally{
 	  if (cs != null) try { cs.close(); } catch(SQLException ex) {}
 	  if (rs != null) try { rs.close(); } catch(SQLException ex) {}
      if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
 }
	    %>
