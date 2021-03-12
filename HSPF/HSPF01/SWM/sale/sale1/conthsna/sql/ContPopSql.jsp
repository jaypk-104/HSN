<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
   
    <%
     ResultSet rs = null;
    try{
	 JSONObject jsonObject = new JSONObject();
	 JSONArray jsonArray = new JSONArray();
	 JSONObject subObject =  null;
	
	//MyViewport
	 String u_cont_dt_from = request.getParameter("u_cont_dt_from");
	 u_cont_dt_from = u_cont_dt_from==null?"":u_cont_dt_from.substring(0, 10);
	 
	 String u_cont_dt_to = request.getParameter("u_cont_dt_to");
	 u_cont_dt_to = u_cont_dt_to==null?"":u_cont_dt_to.substring(0, 10);
	 
	 String u_cfm = request.getParameter("u_cfm");

	 
	 String sql = "SELECT A.CONT_MGM_NO,A.CONT_NO,A.CONT_DT,COUNT(PAL_BC_NO) PAL_BC_CNT FROM S_CONTAINER_MST A, ";
	        sql += "(SELECT CONT_MGM_NO,PAL_BC_NO FROM S_CONTAINER_DTL GROUP BY CONT_MGM_NO,PAL_BC_NO) B ";						
			sql += " WHERE A.CONT_MGM_NO=B.CONT_MGM_NO ";
			sql += " AND CONT_DT>='"+u_cont_dt_from+"' AND CONT_DT<='"+u_cont_dt_to+"' ";						
			sql += " AND CFM_YN='"+u_cfm+"' ";					
			sql += " GROUP BY A.CONT_MGM_NO,A.CONT_NO,A.CONT_DT; ";

	
	  rs = stmt.executeQuery(sql);
	  while(rs.next()){
	  subObject = new JSONObject();
	
	  subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
	  subObject.put("CONT_NO", rs.getString("CONT_NO"));
	  subObject.put("CONT_DT", rs.getString("CONT_DT").substring(0, 10));
	  subObject.put("PAL_BC_CNT", rs.getString("PAL_BC_CNT"));
	  jsonArray.add(subObject);
	  
	  }
	  jsonObject.put("success", true);
	  jsonObject.put("resultList", jsonArray);
// 	  System.out.println(jsonObject);
	  
	  response.setContentType("text/plain; charset=UTF-8");
	  PrintWriter pw = response.getWriter();
	  pw.print(jsonObject);
	  pw.flush();
	  pw.close();
	    }catch(Exception e){
	 e.printStackTrace();
	 }finally{
 	if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
 }
	    %>
