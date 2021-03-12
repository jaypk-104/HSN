<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<link rel="shortcut icon" href="/HSPF01/common/img/hsnetw.ico" type="image/x-icon" />

<!-- <script type="text/javaScript">document.location.href="<c:url value='/HSPF01/common/login/login.jsp'/>"</script>  -->
<title>HWASEUNG PLATFORM</title>
</head>
<%
	String user_id = (String) session.getAttribute("user_id");
	String comp_id = (String) session.getAttribute("comp_id");

	//세션이 없으면 로그인으로 간다.
	if (comp_id == null || user_id == null) {
%>
<frameset rows="*" cols="*" framespacing="0" frameborder="no" border="0">
	<frame src="/HSPF01/common/login/login.jsp" name="index"
		scrolling="yes" noresize>
</frameset>
<noframes>
	<body></body>
</noframes>

<%
	// 세션이 있으면 새로고침.
	} else if (comp_id != null && user_id != null) {
%>
<frameset rows="*" cols="*" framespacing="0" frameborder="no" border="0">
	<frame src="/HSPF01/common/frame/frame.jsp?userid="
		+ <%=user_id%> + "&comp_id=" + <%=comp_id%>" name="index"
		scrolling="yes" noresize>
</frameset>
<noframes>
	<body></body>
</noframes>
<%
	}
%>
</html>


