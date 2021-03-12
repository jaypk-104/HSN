<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>

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
		
		
		if (V_TYPE.equals("SH")) {
			String V_GR_DT_FROM = request.getParameter("V_GR_DT_FROM") == null ? "" : request.getParameter("V_GR_DT_FROM").toUpperCase();
			String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null ? "" : request.getParameter("V_GR_DT_TO").toUpperCase();
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
			String V_JIGUB_DT = request.getParameter("V_JIGUB_DT") == null ? "" : request.getParameter("V_JIGUB_DT").toUpperCase();
			
			if(V_GR_DT_FROM.length() > 10){
				V_GR_DT_FROM = V_GR_DT_FROM.substring(0,10);
			}
			if(V_GR_DT_TO.length() > 10){
				V_GR_DT_TO = V_GR_DT_TO.substring(0,10);
			}
			if(V_JIGUB_DT.length() > 10){
				V_JIGUB_DT = V_JIGUB_DT.substring(0,10);
			}
			
			
			
			cs = conn.prepareCall("call USP_001_GOCHUL_IV_STEEL(?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_GR_DT_FROM);//V_IV_DT_FR
			cs.setString(3, V_GR_DT_TO);//V_IV_DT_TO
			cs.setString(4, V_M_BP_NM);//V_M_BP_CD
			cs.setString(5, "");//V_IV_DN_NO
			cs.setString(6, "");//V_DEPT_CD
			cs.setString(7, "");//V_JIGUB_DT
			cs.setString(8, "");//V_JIGUB_AMT
			cs.setString(9, "");//V_TEMP_GL_NO
			cs.setString(10, "");//V_USER_ID
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IV_DN_NO", rs.getString("IV_DN_NO"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("IV_DT", rs.getString("IV_DT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("CAR_NO", rs.getString("CAR_NO"));
				subObject.put("LOC_NM", rs.getString("LOC_NM"));
				subObject.put("TOTAL_KG", rs.getString("TOTAL_KG"));
				subObject.put("GONG_KG", rs.getString("GONG_KG"));
				subObject.put("MINUS_KG", rs.getString("MINUS_KG"));
				subObject.put("GR_KG", rs.getString("GR_KG"));
				subObject.put("PRC", rs.getString("PRC"));
				subObject.put("GR_AMT", rs.getString("GR_AMT"));
				subObject.put("GR_VAT", rs.getString("GR_VAT"));
				subObject.put("GR_TOTAL_AMT", rs.getString("GR_TOTAL_AMT"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("IV_LOC_AMT", rs.getString("IV_LOC_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("TOTAL_AMT", rs.getString("TOTAL_AMT"));
				subObject.put("JAN_AMT", rs.getString("JAN_AMT"));
				subObject.put("JIGUB_AMTS", rs.getString("JIGUB_AMTS"));
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} 
		else if (V_TYPE.equals("SD")) {
			String V_IV_DN_NO = request.getParameter("V_IV_DN_NO") == null ? "" : request.getParameter("V_IV_DN_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_001_GOCHUL_IV_STEEL(?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, "");//V_IV_DT_FR
			cs.setString(3, "");//V_IV_DT_TO
			cs.setString(4, "");//V_M_BP_CD
			cs.setString(5, V_IV_DN_NO);//V_IV_DN_NO
			cs.setString(6, "");//V_DEPT_CD
			cs.setString(7, "");//V_JIGUB_DT
			cs.setString(8, "");//V_JIGUB_AMT
			cs.setString(9, "");//V_TEMP_GL_NO
			cs.setString(10, "");//V_USER_ID
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("GL_NO", rs.getString("GL_NO"));
				subObject.put("JIGUB_DT", rs.getString("JIGUB_DT"));
				subObject.put("JIGUB_AMT", rs.getString("JIGUB_AMT"));
				subObject.put("ELEC_YN", rs.getString("ELEC_YN"));
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		}
		else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);
			
			String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
			String V_JIGUB_DT = request.getParameter("V_JIGUB_DT") == null ? "" : request.getParameter("V_JIGUB_DT").toString().substring(0,10);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String IV_DN_NO = hashMap.get("IV_DN_NO") == null ? "" : hashMap.get("IV_DN_NO").toString();
					String JIGUB_AMTS = hashMap.get("JIGUB_AMTS") == null ? "" : hashMap.get("JIGUB_AMTS").toString();
					String TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString();

					cs = conn.prepareCall("call USP_001_GOCHUL_IV_STEEL(?,?,?,?,?,?,?,?,?,?,?)");

					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, "");//V_IV_DT_FR
					cs.setString(3, "");//V_IV_DT_TO
					cs.setString(4, "");//V_M_BP_CD
					cs.setString(5, IV_DN_NO);//V_IV_DN_NO
					cs.setString(6, V_DEPT_CD);//V_DEPT_CD
					cs.setString(7, V_JIGUB_DT);//V_JIGUB_DT
					cs.setString(8, JIGUB_AMTS);//V_JIGUB_AMT
					cs.setString(9, TEMP_GL_NO);//V_TEMP_GL_NO
					cs.setString(10, V_USR_ID);//V_USER_ID
					cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
				
				String V_TEMP_GL_NO = "";
				if (V_TYPE.equals("I")) { //확정
				cs = conn.prepareCall("call USP_001_GOCHUL_IV_GL_MAKE(?,?,?,?,?)");
					cs.setString(1, "");//V_IV_DN_NO
					cs.setString(2, V_USR_ID);//V_USR_ID
					cs.setString(3, "5128");//V_DEPT_CD
					cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(5, V_JIGUB_DT);//V_JIGUB_DT
					cs.executeQuery();
					
					rs = (ResultSet) cs.getObject(4);
					
					if (rs.next()) {
						V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
					}
				}
// 				else if(V_TYPE.equals("D")) { 
// 					V_TEMP_GL_NO = TEMP_GL_NO;
// 				}
				
				

				if (V_TEMP_GL_NO.contains("TG")) {
					//애니링크 시작
					JSONObject anyObject = new JSONObject();
					JSONArray anyArray = new JSONArray();
					JSONObject anySubObject = new JSONObject();

					URL url = null;

					if (V_TYPE.equals("I")) { //확정
						url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert");
					} else if (V_TYPE.equals("D")) { //확정취소
						url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel");
					}

					URLConnection con = url.openConnection();
					con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
					con.setDoOutput(true);

					anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anySubObject.put("V_DB_ID", "sa");
					anySubObject.put("V_DB_PW", "hsnadmin");

					anyArray.add(anySubObject);
					anyObject.put("data", anyArray);
					String parameter = anyObject + "";

					OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
					wr.write(parameter);
					wr.flush();

					BufferedReader rd = null;

					rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
					String line = null;
					String result = null;
					while ((line = rd.readLine()) != null) {
						result = URLDecoder.decode(line, "UTF-8");
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(result);
					pw.flush();
					pw.close();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String IV_DN_NO = jsondata.get("IV_DN_NO") == null ? "" : jsondata.get("IV_DN_NO").toString();
				String JIGUB_AMTS = jsondata.get("JIGUB_AMTS") == null ? "" : jsondata.get("JIGUB_AMTS").toString();
				String TEMP_GL_NO = jsondata.get("TEMP_GL_NO") == null ? "" : jsondata.get("TEMP_GL_NO").toString();

				cs = conn.prepareCall("call USP_001_GOCHUL_IV_STEEL(?,?,?,?,?,?,?,?,?,?,?)");

				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, "");//V_IV_DT_FR
				cs.setString(3, "");//V_IV_DT_TO
				cs.setString(4, "");//V_M_BP_CD
				cs.setString(5, IV_DN_NO);//V_IV_DN_NO
				cs.setString(6, V_DEPT_CD);//V_DEPT_CD
				cs.setString(7, V_JIGUB_DT);//V_JIGUB_DT
				cs.setString(8, JIGUB_AMTS);//V_JIGUB_AMT
				cs.setString(9, TEMP_GL_NO);//V_TEMP_GL_NO
				cs.setString(10, V_USR_ID);//V_USER_ID
				cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				String V_TEMP_GL_NO = "";
				if (V_TYPE.equals("I")) { //확정
				cs = conn.prepareCall("call USP_001_GOCHUL_IV_GL_MAKE(?,?,?,?,?)");
					cs.setString(1, "");//V_IV_DN_NO
					cs.setString(2, V_USR_ID);//V_USR_ID
					cs.setString(3, "5128");//V_DEPT_CD
					cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(5, V_JIGUB_DT);//V_JIGUB_DT
					cs.executeQuery();
					
					rs = (ResultSet) cs.getObject(4);
					
					if (rs.next()) {
						V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
					}
				}
				else if(V_TYPE.equals("D")) { 
					V_TEMP_GL_NO = TEMP_GL_NO;
				}
				

				if (V_TEMP_GL_NO.contains("TG")) {
					//애니링크 시작
					JSONObject anyObject = new JSONObject();
					JSONArray anyArray = new JSONArray();
					JSONObject anySubObject = new JSONObject();

					URL url = null;

					if (V_TYPE.equals("I")) { //확정
						url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert");
					} else if (V_TYPE.equals("D")) { //확정취소
						url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel");
					}

					URLConnection con = url.openConnection();
					con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
					con.setDoOutput(true);

					anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anySubObject.put("V_DB_ID", "sa");
					anySubObject.put("V_DB_PW", "hsnadmin");

					anyArray.add(anySubObject);
					anyObject.put("data", anyArray);
					String parameter = anyObject + "";

					OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
					wr.write(parameter);
					wr.flush();

					BufferedReader rd = null;

					rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
					String line = null;
					String result = null;
					while ((line = rd.readLine()) != null) {
						result = URLDecoder.decode(line, "UTF-8");
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print(result);
					pw.flush();
					pw.close();
				}
				

			}
		}

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

		e.printStackTrace();
	} finally {
// 		System.out.println(cs);
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


