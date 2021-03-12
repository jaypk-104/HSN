<%@page import="java.io.File"%>
 <%@page import="java.util.Enumeration"%>
 <%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
 <%@page import="com.oreilly.servlet.MultipartRequest"%>
 <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 <title>Insert title here</title>
 </head>
 <body>
 <center>
 <h2> 파일 다운로드 </h2>
 <form action = "/swm/supplier/supdlv/excel/FileDownloadProc.do" method = "post">
 
 <table border = "0" cellpadding="8" cellspacing="5">

 <tr align = "center">
  <th> 파일명 : </th>
  <td> <input type = "text" name = "fileName"> </td>
 </tr>
 
 <tr align = "center">
  <td colspan = "2"> <input type = "submit" value = "다운로드"> </td>
 </tr>
 </table>
 </form>

 </center>
 </body>
 </html>

출처: http://kitchu.tistory.com/48 [Dream Archive]