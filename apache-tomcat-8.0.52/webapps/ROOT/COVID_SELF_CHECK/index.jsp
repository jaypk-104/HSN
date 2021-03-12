<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<!-- Auto Generated with Sencha Architect -->
<!-- Modifications to this file will be overwritten. -->
<html>

<head>
	

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<!--     <script src="../ext6.5.3/build/ext-all.js"></script> -->
<!-- 	<script src="../ext6.5.3/build/classic/theme-triton/theme-triton.js"></script> -->
<!-- 	<link rel="stylesheet" href="../ext6.5.3/build/classic/theme-triton/resources/theme-triton-all.css"> -->
<!--     <script type="text/javascript" src="app.js"></script> -->
<!--     <link rel="stylesheet" href="../ext6.5.3/build/packages/font-awesome/resources/font-awesome-all.css"> -->
<!--     <script src="../ext6.5.3/build/classic/locale/locale-ko.js"></script> -->
    
    
    <script src="../extmobile/sencha-touch-all.js"></script>
	<link rel="stylesheet" href="../extmobile/resources/css/sencha-touch.css">
    <script type="text/javascript" src="app.js"></script>
    
    
<%
	String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
	String V_DATE = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE");
	request.setAttribute("V_USR_ID", V_USR_ID);
	request.setAttribute("V_DATE", V_DATE);
%>

    
</head>


<body>
	<input type="hidden" id="V_USR_ID" value="<%=request.getAttribute("V_USR_ID")%>" />
 	<input type="hidden" id="V_DATE" value="<%=request.getAttribute("V_DATE")%>" />
</body>
</html>

