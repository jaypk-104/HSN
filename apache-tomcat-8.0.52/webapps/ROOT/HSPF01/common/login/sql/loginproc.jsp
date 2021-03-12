<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="javax.crypto.EncryptedPrivateKeyInfo"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>

<%@page import="java.security.KeyPairGenerator"%>
<%@page import="java.security.PrivateKey"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.spec.RSAPublicKeySpec"%>
<%@page import="javax.crypto.Cipher"%>

<%!
private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
	//  System.out.println("will decrypt : " + securedValue);
	  Cipher cipher = Cipher.getInstance("RSA");
	  byte[] encryptedBytes = hexToByteArray(securedValue);
	  cipher.init(Cipher.DECRYPT_MODE, privateKey);
	  byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
	  String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
	  return decryptedValue;
	  }
		
		public static byte[] hexToByteArray(String hex) {
	      if (hex == null || hex.length() % 2 != 0) {
	          return new byte[]{};
	      }

	      byte[] bytes = new byte[hex.length() / 2];
	      for (int i = 0; i < hex.length(); i += 2) {
	          byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
	          bytes[(int) Math.floor(i / 2)] = value;
	      }
	      return bytes;
	  }
%>

<%
	request.setCharacterEncoding("utf-8");
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	ResultSet rs = null;

	String strCompId = request.getParameter("comp_id");
	String strId = request.getParameter("user_id");
	String strRole = request.getParameter("role_cd");
	
	
	//RSA 복호화 부분 추가 20200529김장운
// 	HttpSession session = request.getSession();
    PrivateKey privateKey = (PrivateKey) session.getAttribute("_HSPF_RSA_WEB_Key_");
    
//     System.out.println("------미트숍 도메인 로그인 에러 확인을 위한 로그------");
//    	System.out.println("privateKey : " + privateKey);
//    	System.out.println("id : " + strId);
//    	System.out.println("password : " + request.getParameter("password"));
//     System.out.println("------미트숍 도메인 로그인 에러 확인을 위한 로그------");

     
    String password = "";
    password = decryptRsa(privateKey, request.getParameter("password"));
    
	String strpassword = password.toUpperCase();
	String strpassword_Enc = password;
	String retval = "0";
	
	try {
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(strpassword.getBytes());
		byte byteData[] = md.digest();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < byteData.length; i++) {
			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		}
		StringBuffer hexString = new StringBuffer();
		for (int i = 0; i < byteData.length; i++) {
			String hex = Integer.toHexString(0xff & byteData[i]);
			if (hex.length() == 1) {
				hexString.append('0');
			}
			hexString.append(hex);
		}
		strpassword_Enc = hexString.toString();
		
		final Pattern SpecialChars = Pattern.compile("['`\"\\-#()@;=*/+!$%~]");
		strId = SpecialChars.matcher(strId).replaceAll("Z"); // 특수문자를 Z로 대체하여 비정상적인 입력은 걸러낼수있게. 20180629 김장운.

		String strSql = "";
		strSql += " SELECT COUNT(*) CNT ";
		strSql += " FROM   Z_USR_INFO_HSPF A ";
		strSql += " WHERE  UPPER(A.USR_ID) ='" + strId.toUpperCase() + "' ";
		strSql += " AND    A.PASSWORD      ='" + strpassword_Enc + "' ";
		strSql += " AND    UPPER(A.COMP_ID)='" + strCompId.toUpperCase() + "'";
		strSql += " AND    USE_YN = 'Y'";

		rs = stmt.executeQuery(strSql);

		while (rs.next()) {
			retval = rs.getString("CNT");
		}
		
		if(retval.equals("1")){
			/*세션생성*/
			session.setAttribute("comp_id", strCompId);
			session.setAttribute("user_id", strId);
		}

		subObject = new JSONObject();

		subObject.put("cnt", retval);
		jsonArray.add(subObject);
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();

	} catch (Exception e) {
		e.printStackTrace();
		throw new RuntimeException();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>

