<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>Insert title here</title>
</head>
<body>
	<script>  
function checkForm() {   
 if (upload.file1.value == "") {   
  alert("������ ���ε����ּ���.");   
  return false;   
 }  else if(!checkFileType(upload.file1.value)) {   
  alert("�������ϸ� ���ε� ���ּ���.");   
  return false;   
 }   
  document.upload.submit();
}   
function checkFileType(filePath){   
  
 var fileLen = filePath.length;   
 var fileFormat = filePath.substring(fileLen - 4);   
 var fileFormat1 = filePath.substring(fileLen - 5);   
 fileFormatfileFormat = fileFormat.toLowerCase();   
  
 if (fileFormat == ".xls" || fileFormat1 == ".xlsx"){   return true;    
 }   else{     return false;     }   
}   
</script>  
<body>
<form action="/swm/supplier/supdlv/excel/UploadActionExcelEx1.do" name="upload" method="POST" enctype="multipart/form-data">
<td><input type="file" name="file1" size="20" align="absmiddle" /></td>
<td><input type="button" onclick="checkForm();" style="cursor:hand" value="���ε�"></td>
<h3>���ε� ��ư�� ���� �� ��� ��ٷ��ּ���.</h3>
</form>
</body>
</html>