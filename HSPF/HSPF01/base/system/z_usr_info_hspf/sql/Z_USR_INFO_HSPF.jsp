<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.crypto.EncryptedPrivateKeyInfo"%>
<%@page import="java.security.MessageDigest"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_USER_ID = request.getParameter("V_USER_ID") == null ? "" : request.getParameter("V_USER_ID").toUpperCase();
		String V_USER_NM = request.getParameter("V_USER_NM") == null ? "" : request.getParameter("V_USER_NM").toUpperCase();
		String V_ROLE_CD = request.getParameter("V_ROLE_CD") == null ? "" : request.getParameter("V_ROLE_CD").toUpperCase();
		if (V_ROLE_CD.equals("T")) {
			V_ROLE_CD = "";
		}

		//조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_Z_USR_INFO_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_USER_ID);//V_USER_ID(: 조회)
			cs.setString(4, V_USER_NM);//V_USR_NM
			cs.setString(5, "");//V_PASSWORD
			cs.setString(6, "");//V_BP_CD
			cs.setString(7, "");//V_DEPT_CD
			cs.setString(8, "");//V_POSIT_CD
			cs.setString(9, "");//V_ADDRESS
			cs.setString(10, "");//V_TEL_NO
			cs.setString(11, "");//V_FAX_NO
			cs.setString(12, "");//V_HAND_TEL
			cs.setString(13, "");//V_EMAIL
			cs.setString(14, V_ROLE_CD);//V_ROLE_CD
			cs.setString(15, "");//V_USE_YN
			cs.setString(16, "");//V_QUERY_ALL_YN
			cs.setString(17, "");//V_PRINT_YN
			cs.setString(18, "");//V_UPDT_USR_ID
			cs.setString(19, "");//V_INSRT_YN
			cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(21, "");//V_EMP_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(20);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("USR_ID", rs.getString("USR_ID"));
				subObject.put("PASSWORD", rs.getString("PASSWORD"));
				subObject.put("USR_NM", rs.getString("USR_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("POSIT_CD", rs.getString("POSIT_CD"));
				subObject.put("POSIT_NM", rs.getString("POSIT_NM"));
				subObject.put("ADDRESS", rs.getString("ADDRESS"));
				subObject.put("TEL_NO", rs.getString("TEL_NO"));
				subObject.put("FAX_NO", rs.getString("FAX_NO"));
				subObject.put("HAND_TEL", rs.getString("HAND_TEL"));
				subObject.put("EMAIL", rs.getString("EMAIL"));
				subObject.put("ROLE_CD", rs.getString("ROLE_CD"));
				subObject.put("ROLE_NM", rs.getString("ROLE_NM"));
				subObject.put("USE_YN", rs.getString("USE_YN"));
				subObject.put("QUERY_ALL_YN", rs.getString("QUERY_ALL_YN"));
				subObject.put("PRINT_YN", rs.getString("PRINT_YN"));
				subObject.put("INSRT_YN", rs.getString("INSRT_YN"));
				subObject.put("EMP_NO", rs.getString("EMP_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//아이템수정
		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString().toUpperCase();
					V_USR_ID = hashMap.get("USR_ID") == null ? "" : hashMap.get("USR_ID").toString().toUpperCase();
					String V_USR_NM = hashMap.get("USR_NM") == null ? "" : hashMap.get("USR_NM").toString().toUpperCase();
					String V_PASSWORD = "NO-UPDATE";
					/*암호초기화*/
					if (V_TYPE.equals("P")) {
						MessageDigest md = MessageDigest.getInstance("SHA-256");
						md.update((V_USR_ID + "1234").getBytes());
						byte byteData[] = md.digest();
						StringBuffer sb = new StringBuffer();
						for (int j = 0; j < byteData.length; j++) {
							sb.append(Integer.toString((byteData[j] & 0xff) + 0x100, 16).substring(1));
						}
						StringBuffer hexString = new StringBuffer();
						for (int j = 0; j < byteData.length; j++) {
							String hex = Integer.toHexString(0xff & byteData[j]);
							if (hex.length() == 1) {
								hexString.append('0');
							}
							hexString.append(hex);
						}
						V_PASSWORD = hexString.toString();
					}
					String V_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString().toUpperCase();
					V_ROLE_CD = hashMap.get("ROLE_CD") == null ? "" : hashMap.get("ROLE_CD").toString().toUpperCase();
					String V_DEPT_CD = hashMap.get("DEPT_CD") == null ? "" : hashMap.get("DEPT_CD").toString().toUpperCase();
					String V_POSIT_CD = hashMap.get("POSIT_CD") == null ? "" : hashMap.get("POSIT_CD").toString().toUpperCase();
					String V_ADDRESS = hashMap.get("ADDRESS") == null ? "" : hashMap.get("ADDRESS").toString().toUpperCase();
					String V_TEL_NO = hashMap.get("TEL_NO") == null ? "" : hashMap.get("TEL_NO").toString().toUpperCase();
					String V_FAX_NO = hashMap.get("FAX_NO") == null ? "" : hashMap.get("FAX_NO").toString().toUpperCase();
					String V_HAND_TEL = hashMap.get("HAND_TEL") == null ? "" : hashMap.get("HAND_TEL").toString().toUpperCase();
					String V_EMAIL = hashMap.get("EMAIL") == null ? "" : hashMap.get("EMAIL").toString();
					String V_USE_YN = hashMap.get("USE_YN") == null ? "" : hashMap.get("USE_YN").toString().toUpperCase();
					String V_QUERY_ALL_YN = hashMap.get("QUERY_ALL_YN") == null ? "" : hashMap.get("QUERY_ALL_YN").toString().toUpperCase();
					String V_PRINT_YN = hashMap.get("PRINT_YN") == null ? "" : hashMap.get("PRINT_YN").toString().toUpperCase();
					String V_UPDT_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
					String V_INSRT_YN = hashMap.get("INSRT_YN") == null ? "" : hashMap.get("INSRT_YN").toString().toUpperCase();
					String V_EMP_NO = hashMap.get("EMP_NO") == null ? "" : hashMap.get("EMP_NO").toString().toUpperCase();

					cs = conn.prepareCall("call USP_Z_USR_INFO_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_USR_ID);//V_USR_ID(: SYNC)
					cs.setString(4, V_USR_NM);//V_USR_NM
					cs.setString(5, V_PASSWORD);//V_PASSWORD
					cs.setString(6, V_BP_CD);//V_BP_CD
					cs.setString(7, V_DEPT_CD);//V_DEPT_CD
					cs.setString(8, V_POSIT_CD);//V_POSIT_CD
					cs.setString(9, V_ADDRESS);//V_ADDRESS
					cs.setString(10, V_TEL_NO);//V_TEL_NO
					cs.setString(11, V_FAX_NO);//V_FAX_NO
					cs.setString(12, V_HAND_TEL);//V_HAND_TEL
					cs.setString(13, V_EMAIL);//V_EMAIL
					cs.setString(14, V_ROLE_CD);//V_ROLE_CD
					cs.setString(15, V_USE_YN);//V_USE_YN
					cs.setString(16, V_QUERY_ALL_YN);//V_QUERY_ALL_YN
					cs.setString(17, V_PRINT_YN);//V_PRINT_YN
					cs.setString(18, V_UPDT_USR_ID);//V_UPDT_USR_ID
					cs.setString(19, V_INSRT_YN);//V_INSRT_YN
					cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(21, V_EMP_NO);//V_EMP_NO
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString().toUpperCase();
				V_USR_ID = jsondata.get("USR_ID") == null ? "" : jsondata.get("USR_ID").toString().toUpperCase();
				String V_USR_NM = jsondata.get("USR_NM") == null ? "" : jsondata.get("USR_NM").toString().toUpperCase();
				String V_PASSWORD = "NO-UPDATE";
				/*암호초기화*/
				if (V_TYPE.equals("P")) {
					MessageDigest md = MessageDigest.getInstance("SHA-256");
					md.update((V_USR_ID + "1234").getBytes());
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
					V_PASSWORD = hexString.toString();
				}
				String V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString().toUpperCase();
				V_ROLE_CD = jsondata.get("ROLE_CD") == null ? "" : jsondata.get("ROLE_CD").toString().toUpperCase();
				String V_DEPT_CD = jsondata.get("DEPT_CD") == null ? "" : jsondata.get("DEPT_CD").toString().toUpperCase();
				String V_POSIT_CD = jsondata.get("POSIT_CD") == null ? "" : jsondata.get("POSIT_CD").toString().toUpperCase();
				String V_ADDRESS = jsondata.get("ADDRESS") == null ? "" : jsondata.get("ADDRESS").toString().toUpperCase();
				String V_TEL_NO = jsondata.get("TEL_NO") == null ? "" : jsondata.get("TEL_NO").toString().toUpperCase();
				String V_FAX_NO = jsondata.get("FAX_NO") == null ? "" : jsondata.get("FAX_NO").toString().toUpperCase();
				String V_HAND_TEL = jsondata.get("HAND_TEL") == null ? "" : jsondata.get("HAND_TEL").toString().toUpperCase();
				String V_EMAIL = jsondata.get("EMAIL") == null ? "" : jsondata.get("EMAIL").toString();
				V_ROLE_CD = jsondata.get("ROLE_CD") == null ? "" : jsondata.get("ROLE_CD").toString().toUpperCase();
				String V_USE_YN = jsondata.get("USE_YN") == null ? "" : jsondata.get("USE_YN").toString().toUpperCase();
				String V_QUERY_ALL_YN = jsondata.get("QUERY_ALL_YN") == null ? "" : jsondata.get("QUERY_ALL_YN").toString().toUpperCase();
				String V_PRINT_YN = jsondata.get("PRINT_YN") == null ? "" : jsondata.get("PRINT_YN").toString().toUpperCase();
				String V_UPDT_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
				String V_INSRT_YN = jsondata.get("INSRT_YN") == null ? "" : jsondata.get("INSRT_YN").toString().toUpperCase();
				String V_EMP_NO = jsondata.get("EMP_NO") == null ? "" : jsondata.get("EMP_NO").toString().toUpperCase();

				cs = conn.prepareCall("call USP_Z_USR_INFO_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_USR_ID);//V_USR_ID(: SYNC)
				cs.setString(4, V_USR_NM);//V_USR_NM
				cs.setString(5, V_PASSWORD);//V_PASSWORD
				cs.setString(6, V_BP_CD);//V_BP_CD
				cs.setString(7, V_DEPT_CD);//V_DEPT_CD
				cs.setString(8, V_POSIT_CD);//V_POSIT_CD
				cs.setString(9, V_ADDRESS);//V_ADDRESS
				cs.setString(10, V_TEL_NO);//V_TEL_NO
				cs.setString(11, V_FAX_NO);//V_FAX_NO
				cs.setString(12, V_HAND_TEL);//V_HAND_TEL
				cs.setString(13, V_EMAIL);//V_EMAIL
				cs.setString(14, V_ROLE_CD);//V_ROLE_CD
				cs.setString(15, V_USE_YN);//V_USE_YN
				cs.setString(16, V_QUERY_ALL_YN);//V_QUERY_ALL_YN
				cs.setString(17, V_PRINT_YN);//V_PRINT_YN
				cs.setString(18, V_UPDT_USR_ID);//V_UPDT_USR_ID
				cs.setString(19, V_INSRT_YN);//V_INSRT_YN
				cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(21, V_EMP_NO);//V_EMP_NO
				cs.executeQuery();
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
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


