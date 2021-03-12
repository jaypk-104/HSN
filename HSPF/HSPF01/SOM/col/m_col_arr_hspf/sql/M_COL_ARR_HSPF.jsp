<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.internet.MimeBodyPart"%>
<%@ page import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.mail.BodyPart"%>
<%@ page import="javax.mail.Multipart"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_YYYYMM = request.getParameter("V_YYYYMM") == null ? "" : request.getParameter("V_YYYYMM").replace("-", "").substring(0, 6);
		String V_SL_NM = request.getParameter("V_SL_NM") == null ? "" : request.getParameter("V_SL_NM").toUpperCase();

		if (V_TYPE.equals("T1S")) {
			cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMM);//V_YYYYMM
			cs.setString(4, "");//V_S_BP_CD
			cs.setString(5, "");//V_SL_CD
			cs.setString(6, V_SL_NM);//V_SL_NM
			cs.setString(7, "");//V_SL_AMT
			cs.setString(8, "");//V_VAT_AMT
			cs.setString(9, "");//V_REMARK
			cs.setString(10, "");//V_TEMP_GL_NO
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_VAT_TYPE
			cs.setString(14, "");//V_S_B_BP_CD
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("BP_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("T1I")) {

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					
					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String V_SL_AMT = hashMap.get("SL_AMT") == null ? "" : hashMap.get("SL_AMT").toString();
					String V_VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString();
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();

					cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_YYYYMM);//V_YYYYMM
					cs.setString(4, V_S_BP_CD);//V_S_BP_CD
					cs.setString(5, V_SL_CD);//V_SL_CD
					cs.setString(6, "");//V_SL_NM
					cs.setString(7, V_SL_AMT);//V_SL_AMT
					cs.setString(8, V_VAT_AMT);//V_VAT_AMT
					cs.setString(9, V_REMARK);//V_REMARK
					cs.setString(10, "");//V_TEMP_GL_NO
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(13, V_VAT_TYPE);//V_USR_ID
					cs.setString(14, V_M_BP_CD);//V_S_B_BP_CD
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;

				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String V_SL_AMT = jsondata.get("SL_AMT") == null ? "" : jsondata.get("SL_AMT").toString();
				String V_VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_TEMP_GL_NO = jsondata.get("TEMP_GL_NO") == null ? "" : jsondata.get("TEMP_GL_NO").toString();
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();

				cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_YYYYMM);//V_YYYYMM
				cs.setString(4, V_S_BP_CD);//V_S_BP_CD
				cs.setString(5, V_SL_CD);//V_SL_CD
				cs.setString(6, "");//V_SL_NM
				cs.setString(7, V_SL_AMT);//V_SL_AMT
				cs.setString(8, V_VAT_AMT);//V_VAT_AMT
				cs.setString(9, V_REMARK);//V_REMARK
				cs.setString(10, V_TEMP_GL_NO);//V_TEMP_GL_NO
				cs.setString(11, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(13, V_VAT_TYPE);//V_VAT_TYPE
				cs.setString(14, V_M_BP_CD);//V_S_B_BP_CD
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			}

		} else if (V_TYPE.equals("T2S")) {
			cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMM);//V_YYYYMM
			cs.setString(4, "");//V_S_BP_CD
			cs.setString(5, "");//V_SL_CD
			cs.setString(6, "");//V_SL_NM
			cs.setString(7, "");//V_SL_AMT
			cs.setString(8, "");//V_VAT_AMT
			cs.setString(9, "");//V_REMARK
			cs.setString(10, "");//V_TEMP_GL_NO
			cs.setString(11, V_USR_ID);//11, V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_VAT_TYPE
			cs.setString(14, "");//V_S_B_BP_CD
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		} else if (V_TYPE.equals("T3S")) {
			cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMM);//V_YYYYMM
			cs.setString(4, "");//V_S_BP_CD
			cs.setString(5, "");//V_SL_CD
			cs.setString(6, "");//V_SL_NM
			cs.setString(7, "");//V_SL_AMT
			cs.setString(8, "");//V_VAT_AMT
			cs.setString(9, "");//V_REMARK
			cs.setString(10, "");//V_TEMP_GL_NO
			cs.setString(11, V_USR_ID);//11, V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_VAT_TYPE
			cs.setString(14, "");//V_S_B_BP_CD
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		} else if (V_TYPE.equals("T4S")) {

		}

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

		e.printStackTrace();
	} finally {
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (cs2 != null) try {
			cs2.close();
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


