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

<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.reflect.InvocationTargetException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Properties"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

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
		String V_CH_DT_FR = request.getParameter("V_CH_DT_FR") == null ? "" : request.getParameter("V_CH_DT_FR").substring(0, 10);
		String V_CH_DT_TO = request.getParameter("V_CH_DT_TO") == null ? "" : request.getParameter("V_CH_DT_TO").substring(0, 10);
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_CHARGE_CD = request.getParameter("V_CHARGE_CD") == null ? "" : request.getParameter("V_CHARGE_CD").toUpperCase();
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_TEMP_GL_NO = request.getParameter("V_TEMP_GL_NO") == null ? "" : request.getParameter("V_TEMP_GL_NO").toUpperCase();

		if (V_TYPE.equals("T1S")) {
			cs = conn.prepareCall("call USP_003_M_CHARGE_BATCH_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 
			cs.setString(2, V_TYPE);//V_TYPE 
			cs.setString(3, V_CH_DT_FR);//V_CH_DT_FR 
			cs.setString(4, V_CH_DT_TO);//V_CH_DT_TO 
			cs.setString(5, "");//V_TEMP_GL_NO
			cs.setString(6, V_BP_CD);//V_BP_CD 
			cs.setString(7, V_CHARGE_CD);//V_CHARGE_CD
			cs.setString(8, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(9, "");//V_CHARGE_NO
			cs.setString(10, "");//V_BATCH_NO
			cs.setString(11, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_CHARGE_NO", rs.getString("MAST_CHARGE_NO"));
				subObject.put("BAS_NO", rs.getString("BAS_NO"));
				subObject.put("BAS_DOC_NO", rs.getString("BAS_DOC_NO"));
				subObject.put("CHARGE_NO", rs.getString("CHARGE_NO"));
				subObject.put("CHARGE_DT", rs.getString("CHARGE_DT"));
				subObject.put("CHARGE_CD", rs.getString("CHARGE_CD"));
				subObject.put("CHARGE_NM", rs.getString("CHARGE_NM"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("TAX_BIZ_CD", rs.getString("TAX_BIZ_CD"));
				subObject.put("TAX_BIZ_NM", rs.getString("TAX_BIZ_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("T2SH")) {
			cs = conn.prepareCall("call USP_003_M_CHARGE_BATCH_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 
			cs.setString(2, V_TYPE);//V_TYPE 
			cs.setString(3, V_CH_DT_FR);//V_CH_DT_FR 
			cs.setString(4, V_CH_DT_TO);//V_CH_DT_TO 
			cs.setString(5, V_TEMP_GL_NO);//V_TEMP_GL_NO
			cs.setString(6, V_BP_CD);//V_BP_CD 
			cs.setString(7, V_CHARGE_CD);//V_CHARGE_CD
			cs.setString(8, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(9, "");//V_CHARGE_NO
			cs.setString(10, "");//V_BATCH_NO
			cs.setString(11, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BATCH_NO", rs.getString("BATCH_NO"));
				subObject.put("CHARGE_CD", rs.getString("CHARGE_CD"));
				subObject.put("CHARGE_NM", rs.getString("CHARGE_NM"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("TAX_BIZ_CD", rs.getString("TAX_BIZ_CD"));
				subObject.put("TAX_BIZ_NM", rs.getString("TAX_BIZ_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("TEMP_GL_DT", rs.getString("TEMP_GL_DT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("T2SD")) {
			String V_BATCH_NO = request.getParameter("V_BATCH_NO") == null ? "" : request.getParameter("V_BATCH_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_003_M_CHARGE_BATCH_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 
			cs.setString(2, V_TYPE);//V_TYPE 
			cs.setString(3, "");//V_CH_DT_FR 
			cs.setString(4, "");//V_CH_DT_TO 
			cs.setString(5, "");//V_TEMP_GL_NO
			cs.setString(6, "");//V_BP_CD 
			cs.setString(7, "");//V_CHARGE_CD
			cs.setString(8, "");//V_LC_DOC_NO
			cs.setString(9, "");//V_CHARGE_NO
			cs.setString(10, V_BATCH_NO);//V_BATCH_NO
			cs.setString(11, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_CHARGE_NO", rs.getString("MAST_CHARGE_NO"));
				subObject.put("BAS_NO", rs.getString("BAS_NO"));
				subObject.put("BAS_DOC_NO", rs.getString("BAS_DOC_NO"));
				subObject.put("CHARGE_NO", rs.getString("CHARGE_NO"));
				subObject.put("CHARGE_DT", rs.getString("CHARGE_DT"));
				subObject.put("CHARGE_CD", rs.getString("CHARGE_CD"));
				subObject.put("CHARGE_NM", rs.getString("CHARGE_NM"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("TAX_BIZ_CD", rs.getString("TAX_BIZ_CD"));
				subObject.put("TAX_BIZ_NM", rs.getString("TAX_BIZ_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("ERP")) {
			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE").toUpperCase();
			String V_BATCH_NO = request.getParameter("V_BATCH_NO") == null ? "" : request.getParameter("V_BATCH_NO").toUpperCase();
			String V_TEMP_GL_DT = request.getParameter("V_TEMP_GL_DT") == null ? "" : request.getParameter("V_TEMP_GL_DT").substring(0, 10);
			String V_TEMP_GL_NO2 = "";
			
			cs = conn.prepareCall("call USP_003_A_TEMP_CH_BATCH_FR_TOT(?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 
			cs.setString(2, U_TYPE);//V_TYPE 
			cs.setString(3, V_BATCH_NO);//V_BATCH_NO 
			cs.setString(4, V_TEMP_GL_DT);//V_TEMP_GL_DT 
			cs.setString(5, V_USR_ID);//V_USR_ID 
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(7, V_TEMP_GL_NO);//V_TEMP_GL_NO2
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(6);
			if (rs.next()) {
				V_TEMP_GL_NO2 = rs.getString("V_TEMP_GL_NO");
			}
			
			if (V_TEMP_GL_NO2.contains("TG")) {
				/*애니링크 시작*/
				JSONObject anyObject = new JSONObject();
				JSONArray anyArray = new JSONArray();
				JSONObject anySubObject = new JSONObject();
				
 				URL url = null;

 				if (U_TYPE.equals("I")) { //확정
 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert");
 				} else if (U_TYPE.equals("D")) { //확정취소
 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel");
 				}

 				URLConnection con = url.openConnection();
 				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
 				con.setDoOutput(true);

 				anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO2);
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
			
// 			response.setContentType("text/plain; charset=UTF-8");
// 			PrintWriter pw = response.getWriter();
// 			jsonObject.put("resMSG", "SUCCESS");
// 			pw.print(jsonObject);
// 			pw.flush();
// 			pw.close();
			
		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			String V_BATCH_NO = "";
			String V_TEMP_GL_DT = request.getParameter("V_TEMP_GL_DT") == null ? "" : request.getParameter("V_TEMP_GL_DT").substring(0, 10);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_CHARGE_NO = hashMap.get("CHARGE_NO") == null ? "" : hashMap.get("CHARGE_NO").toString();

					if(V_TYPE.equals("I") && i==0){
						cs = conn.prepareCall("call USP_003_M_CHARGE_BATCH_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 
						cs.setString(2, "IH");//V_TYPE 
						cs.setString(3, V_TEMP_GL_DT);//V_CH_DT_FR 
						cs.setString(4, "");//V_CH_DT_TO 
						cs.setString(5, "");//V_TEMP_GL_NO
						cs.setString(6, "");//V_BP_CD 
						cs.setString(7, "");//V_CHARGE_CD
						cs.setString(8, "");//V_LC_DOC_NO
						cs.setString(9, V_CHARGE_NO);//V_CHARGE_NO
						cs.setString(10, "");//V_BATCH_NO
						cs.setString(11, V_USR_ID);//V_USR_ID 
						cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(12);
						if (rs.next()) {
							V_BATCH_NO = rs.getString("RES");
						}
					}
					
					cs = conn.prepareCall("call USP_003_M_CHARGE_BATCH_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 
					cs.setString(2, V_TYPE);//V_TYPE 
					cs.setString(3, "");//V_CH_DT_FR 
					cs.setString(4, "");//V_CH_DT_TO 
					cs.setString(5, "");//V_TEMP_GL_NO
					cs.setString(6, "");//V_BP_CD 
					cs.setString(7, "");//V_CHARGE_CD
					cs.setString(8, "");//V_LC_DOC_NO
					cs.setString(9, V_CHARGE_NO);//V_CHARGE_NO
					cs.setString(10, V_BATCH_NO);//V_BATCH_NO
					cs.setString(11, V_USR_ID);//V_USR_ID 
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {

				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_LC_DOC_NO = jsondata.get("BAS_DOC_NO") == null ? "" : jsondata.get("BAS_DOC_NO").toString();
				V_CHARGE_CD = jsondata.get("CHARGE_CD") == null ? "" : jsondata.get("CHARGE_CD").toString();
				String V_CHARGE_NO = jsondata.get("CHARGE_NO") == null ? "" : jsondata.get("CHARGE_NO").toString();

				if(V_TYPE.equals("I")){
					cs = conn.prepareCall("call USP_003_M_CHARGE_BATCH_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 
					cs.setString(2, "IH");//V_TYPE 
					cs.setString(3, V_TEMP_GL_DT);//V_CH_DT_FR 
					cs.setString(4, "");//V_CH_DT_TO 
					cs.setString(5, "");//V_TEMP_GL_NO
					cs.setString(6, "");//V_BP_CD 
					cs.setString(7, "");//V_CHARGE_CD
					cs.setString(8, "");//V_LC_DOC_NO
					cs.setString(9, V_CHARGE_NO);//V_CHARGE_NO
					cs.setString(10, "");//V_BATCH_NO
					cs.setString(11, V_USR_ID);//V_USR_ID 
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
					
					rs = (ResultSet) cs.getObject(12);
					if (rs.next()) {
						V_BATCH_NO = rs.getString("RES");
					}
				}
				
				cs = conn.prepareCall("call USP_003_M_CHARGE_BATCH_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 
				cs.setString(2, V_TYPE);//V_TYPE 
				cs.setString(3, "");//V_CH_DT_FR 
				cs.setString(4, "");//V_CH_DT_TO 
				cs.setString(5, "");//V_TEMP_GL_NO
				cs.setString(6, "");//V_BP_CD 
				cs.setString(7, "");//V_CHARGE_CD
				cs.setString(8, "");//V_LC_DOC_NO
				cs.setString(9, V_CHARGE_NO);//V_CHARGE_NO
				cs.setString(10, V_BATCH_NO);//V_BATCH_NO
				cs.setString(11, V_USR_ID);//V_USR_ID 
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(V_BATCH_NO);
			pw.flush();
			pw.close();
			
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


