<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<style>
.can-change .x-change-cell {

    background-color: #D8F6CE;
    color: green;
    font-weight: 500;
}

.qty-style1 .x-change-cell1 {
    color: #bf2867;
    font-weight: bold;
}
.qty-style2 .x-change-cell1, .qty-style2 .x-change-cell2 {
    color: #bf2867;
    font-weight: bold;
}

.bg-green {
    background-color: #D8F6CE;
}
.bg-gray {
    background-color: #e0e0e0;
}

.blue-btn .x-btn-inner {
    color: #3367d6 !important;
    font-weight: 600;
    font-size: 13px;
}

div#checkcolumn-1064-titleEl.x-column-header-inner.x-leaf-column-header.x-column-header-inner-empty {
	background-color:#ffefbb;
}

</style>
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
	
// 	response.setContentType("text/plain; charset=UTF-8");
// 	PrintWriter pw = response.getWriter();
// 	pw.print(request.getParameter("PO_NO"));
// 	pw.flush();
// 	pw.close();
%>