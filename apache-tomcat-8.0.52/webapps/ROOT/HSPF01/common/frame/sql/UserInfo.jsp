<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="javax.crypto.EncryptedPrivateKeyInfo"%>
<%@page import="java.security.MessageDigest"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	ResultSet rs = null;
	try {
		request.setCharacterEncoding("utf-8");
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String w_usr_nm = request.getParameter("w_usr_nm") == null ? "" : request.getParameter("w_usr_nm").toUpperCase();
		String w_oldPassword = request.getParameter("w_oldPassword") == null ? "" : request.getParameter("w_oldPassword").toUpperCase();
		String w_newPassword = request.getParameter("w_newPassword") == null ? "" : request.getParameter("w_newPassword").toUpperCase();
		String w_usr_dept = request.getParameter("w_usr_dept") == null ? "" : request.getParameter("w_usr_dept").toUpperCase();
		String w_usr_posit = request.getParameter("w_usr_posit") == null ? "" : request.getParameter("w_usr_posit").toUpperCase();
		String w_usr_tel_no = request.getParameter("w_usr_tel_no") == null ? "" : request.getParameter("w_usr_tel_no").replaceAll("-", "").replaceAll("\\.", "");
		String w_usr_handtel = request.getParameter("w_usr_handtel") == null ? "" : request.getParameter("w_usr_handtel").replaceAll("-", "").replaceAll("\\.", "");;
		String w_usr_fax = request.getParameter("w_usr_fax") == null ? "" : request.getParameter("w_usr_fax").replaceAll("-", "").replaceAll("\\.", "");
		String w_usr_email = request.getParameter("w_usr_email") == null ? "" : request.getParameter("w_usr_email");
		String w_usr_email_yn = request.getParameter("w_usr_email_yn") == null ? "" : request.getParameter("w_usr_email_yn");
		if(w_usr_email_yn.equals("true")) {
			w_usr_email_yn = "Y";
		} else {
			w_usr_email_yn = "N";
		}
		String w_usr_address = request.getParameter("w_usr_address") == null ? "" : request.getParameter("w_usr_address").toUpperCase();

		// 		System.out.println(V_BP_CD);
		// 		System.out.println(V_USR_ID);

		String sql = "";
		if (V_TYPE.equals("P_CHECK")) { //비밀번호 체크
			sql = "SELECT PASSWORD ";
			sql += " FROM Z_USR_INFO_HSPF";
			sql += " WHERE BP_CD = ? AND USR_ID =? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, V_BP_CD);
			pstmt.setString(2, V_USR_ID);
			rs = pstmt.executeQuery();

			String system_password = "";
			while (rs.next()) {
				system_password = rs.getString("PASSWORD");
			}

			/*현재비밀번호 전환*/
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(w_oldPassword.getBytes());
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
			String old_password_enc = hexString.toString();

			// 			System.out.println(old_password_enc);
			// 			System.out.println(system_password);

			String password_result = "";
			if (system_password.equals(old_password_enc)) {
				password_result = "SUCCESS";
			} else {
				password_result = "FAIL";
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(password_result);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("P_CHANGE")) {
			/*변경할 비밀번호 전환*/
			// 			System.out.println("w_newPassword" + w_newPassword);

			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(w_newPassword.getBytes());
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
			String new_password_enc = hexString.toString();
			// 			System.out.println(new_password_enc);
			// 			System.out.println("w_usr_nm" + w_usr_nm);

			sql += "UPDATE Z_USR_INFO_HSPF                                                        ";
			sql += "SET USR_NM = ?, ADDRESS = ?, TEL_NO = ?, FAX_NO = ?, HAND_TEL = ?, EMAIL = ?, EMAIL_YN = ?, ";
			sql += " PASSWORD = ?, UPDT_DT = SYSDATE ";
			sql += "WHERE BP_CD = ?                                                             ";
			sql += "AND USR_ID = ?  ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, w_usr_nm);
			pstmt.setString(2, w_usr_address);
			pstmt.setString(3, w_usr_tel_no);
			pstmt.setString(4, w_usr_fax);
			pstmt.setString(5, w_usr_handtel);
			pstmt.setString(6, w_usr_email);
			pstmt.setString(7, w_usr_email_yn);
			pstmt.setString(8, new_password_enc);
			pstmt.setString(9, V_BP_CD);
			pstmt.setString(10, V_USR_ID);
			pstmt.execute(sql);

		} else {
			sql += "UPDATE Z_USR_INFO_HSPF                                                        ";
			sql += "SET USR_NM = ?, ADDRESS = ?, TEL_NO = ?, FAX_NO = ?, HAND_TEL = ?, EMAIL = ?, EMAIL_YN = ? ";
			sql += "WHERE BP_CD = ?                                                             ";
			sql += "AND USR_ID = ?                                                                ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, w_usr_nm);
			pstmt.setString(2, w_usr_address);
			pstmt.setString(3, w_usr_tel_no);
			pstmt.setString(4, w_usr_fax);
			pstmt.setString(5, w_usr_handtel);
			pstmt.setString(6, w_usr_email);
			pstmt.setString(7, w_usr_email_yn);
			pstmt.setString(8, V_BP_CD);
			pstmt.setString(9, V_USR_ID);
			rs = pstmt.executeQuery();
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (pstmt != null) try {
			pstmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>