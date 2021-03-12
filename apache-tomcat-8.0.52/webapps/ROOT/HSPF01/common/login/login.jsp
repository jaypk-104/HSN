<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<script type="text/javascript"	src="<c:url value='/ext6.5/build/ext-all.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/ext6.5/build/classic/theme-triton/theme-triton.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/ext6.5/build/packages/ux/classic/ux.js'/>"></script>
<link
	href="<c:url value='/ext6.5/build/classic/theme-triton/resources/theme-triton-all.css'/>"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="<c:url value='/ext6.5/build/classic/locale/locale-ko.js'/>"></script>
	
<script type="text/javascript" src="<c:url value="/ext6.5/jsbn.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext6.5/rsa.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext6.5/prng4.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext6.5/rng.js"/>"></script>


<%@page import="java.security.KeyFactory"%>
<%@page import="java.security.KeyPair"%>

<%@page import="java.security.KeyPairGenerator"%>
<%@page import="java.security.PrivateKey"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.spec.RSAPublicKeySpec"%>

<%
	String user_id = (String) session.getAttribute("user_id");
	String comp_id = (String) session.getAttribute("comp_id");

	//세션이 있으면 frame으로 간다.
	if(comp_id != null && user_id != null) {
		response.sendRedirect("/HSPF01/common/frame/frame.jsp?userid=" + user_id + "&comp_id=" + comp_id);
	}
	
	//RSA 암호화 부분 추가 20200529김장운
	KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
	generator.initialize(2048);

	KeyPair keyPair = generator.genKeyPair();
	KeyFactory keyFactory = KeyFactory.getInstance("RSA");

	PublicKey publicKey = keyPair.getPublic();
	PrivateKey privateKey = keyPair.getPrivate();

	// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
	session.setAttribute("_HSPF_RSA_WEB_Key_", privateKey);
	
// 	System.out.println("미트숍 확인로그 (RSA 키 생성) : " + privateKey);

	// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
	RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);


	String publicKeyModulus = publicSpec.getModulus().toString(16);
	String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
	request.setAttribute("publicKeyModulus", publicKeyModulus);
	request.setAttribute("publicKeyExponent", publicKeyExponent);
%>

<script type="text/javascript" src="app.js"></script>
<style>

.fa-info-hspf, .fa-unlock-hspf {
	color: white;
	background-color: rgba(31,31,31,0);
	margin: 2px 10px 0 20px;
	font-size: 28px !important;
}
.login-container:hover {
	background-color: #11469c  ;
}
.fa-my-home{
	color: #3367d6;
}
.x-form-cb-label-default.x-form-cb-label-after {
	color: white  ;
}

</style>

</head>

<body>
	<input type="hidden" id="rsaPublicKeyModulus" value="<%=request.getAttribute("publicKeyModulus")%>" />
 	<input type="hidden" id="rsaPublicKeyExponent" value="<%=request.getAttribute("publicKeyExponent")%>" />
</body>
</html>