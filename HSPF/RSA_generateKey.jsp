<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
	
<script type="text/javascript" src="<c:url value="/ext6.5/jsbn.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext6.5/rsa.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext6.5/prng4.js"/>"></script>
<script type="text/javascript" src="<c:url value="/ext6.5/rng.js"/>"></script>


<%@page import="java.io.PrintWriter"%>


<%@page import="java.security.KeyFactory"%>
<%@page import="java.security.KeyPair"%>

<%@page import="java.security.KeyPairGenerator"%>
<%@page import="java.security.PrivateKey"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.spec.RSAPublicKeySpec"%>

<%


	//RSA 암호화 키 생성
	KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
	generator.initialize(2048);

	KeyPair keyPair = generator.genKeyPair();
	KeyFactory keyFactory = KeyFactory.getInstance("RSA");

	PublicKey publicKey = keyPair.getPublic();
	PrivateKey privateKey = keyPair.getPrivate();

	// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
	session.setAttribute("_RSA_WEB_Key_", privateKey);

	// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
	RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);


	String publicKeyModulus = publicSpec.getModulus().toString(16);
	String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
	
	session.setAttribute("publicKeyModulus", publicKeyModulus);
	session.setAttribute("publicKeyExponent", publicKeyExponent);
	
	response.setContentType("text/plain; charset=UTF-8");
	PrintWriter pw = response.getWriter();
	pw.print(publicKeyModulus + ',' + publicKeyExponent);
	pw.flush();
	pw.close();
	
%>

</head>

<body>

</body>
</html>