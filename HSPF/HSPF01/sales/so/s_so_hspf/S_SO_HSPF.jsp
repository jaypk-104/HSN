<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<script type="text/javascript" src="<c:url value='/ext6.5/build/ext-all.js'/>"></script>
<script type="text/javascript" src="<c:url value='/ext6.5/build/classic/theme-triton/theme-triton.js'/>"></script>
<link href="<c:url value='/'/>ext6.5/build/classic/theme-triton/resources/theme-triton-all.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/ext6.5/build/packages/ux/classic/ux.js'/>"></script>
<script type="text/javascript" src="<c:url value='/ext6.5/build/packages/exporter/build/classic/exporter.js'/>"></script>
<script type="text/javascript" src="<c:url value='/ext6.5/build/classic/locale/locale-ko.js'/>"></script>
<script type="text/javascript" src="app.js"></script>
<link href="<c:url value='/'/>ext6.5/build/packages/font-awesome/resources/font-awesome-all.css" rel="stylesheet" type="text/css">
<link href="<c:url value='/'/>HSPF01/common/css/HSPF01_style.css" rel="stylesheet" type="text/css">
<style>
.bg-green {
    background-color: #D8F6CE;
}
</style>
<%-- @include file = "/HSPF01/common/popup/Popup.jsp"--%>
</head>
<body>
</body>
</html>

<%
	String user_id = (String)session.getAttribute("user_id");
	String comp_id = (String)session.getAttribute("comp_id");
	
	if(user_id==null || user_id.equals("") || comp_id==null || comp_id.equals("")) {          
		out.println("<Script language='JavaScript'>window.parent.location.href='../../../../index.jsp';window.close();</Script>");
	}
%>