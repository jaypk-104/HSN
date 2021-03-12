<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<!-- <title>Insert title here</title> -->

<script type="text/javascript"
	src="<c:url value='/ext6.5/build/ext-all.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/ext6.5/build/classic/theme-triton/theme-triton.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/ext6.5/build/packages/ux/classic/ux.js'/>"></script>
<link
	href="<c:url value='/'/>ext6.5/build/classic/theme-triton/resources/theme-triton-all.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="<c:url value='/ext6.5/build/classic/locale/locale-ko.js'/>"></script>
<script type="text/javascript" src="app.js"></script>
<style>
.fa-list-ol, .fa-shopping-cart, .fa-archive, .fa-truck, .fa-handshake-o, .fa-search, .fa-calculator, .fa-clipboard, .fa-stack-overflow
	{
	width: 20px
}

.fa-logout .x-btn-icon-left>.x-btn-icon-el-default-toolbar-small,
	.x-btn-icon-right>.x-btn-icon-el-default-toolbar-small {
	font-size: 30px;
	width: 30px;
	color: #3367d6;
}

.fa-info-hspf{
	color: #3367d6;
	background-color: white;
	cursor:pointer;
}
.fa-my-home{
	color: #3367d6;
}

</style>
</head>

<!-- 세션관리 -->
<%
	String user_id = (String) session.getAttribute("user_id");
	String comp_id = (String) session.getAttribute("comp_id");
%>
<script>
	console.log('user_id' + '<%=user_id%> ');
	console.log('comp_id' + '<%=comp_id%> ');
</script>

<%
	//세션이 없으면 login으로 간다.
	if (comp_id==null || user_id ==null ) {
		System.out.println("세션없음");
		response.sendRedirect("/HSPF01/common/login/login.jsp");
	} 
%>
<!-- 세션관리 -->
<body>
	<!-- hi -->

</body>
</html>