<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	/*로그아웃, 세션제거*/
// 	String user_id = (String)session.getAttribute("user_id");
// 	String comp_id = (String)session.getAttribute("comp_id");
	
	session.invalidate(); 
	response.sendRedirect("../../index.jsp"); 
%>