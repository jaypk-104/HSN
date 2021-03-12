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
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String V_PO_NO = "";
	String V_PO_SEQ = "";

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").substring(0, 10);
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD");
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM");

		if (V_TYPE.equals("S")) {
					
			cs = conn.prepareCall("call USP_003_M_GR_DISTR_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_MVMT_DT_FR);//V_MVMT_DT_FR
			cs.setString(4, V_MVMT_DT_TO);//V_MVMT_DT_TO
			cs.setString(5, V_M_BP_CD);//V_M_BP_CD
			cs.setString(6, "");//V_GR_NO
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ELEC_YN", rs.getString("ELEC_YN"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("DISTR_AMT", rs.getString("DISTR_AMT"));
				subObject.put("TOT_AMT", rs.getString("TOT_AMT"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("PRINT_ITEM")) {
			String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO");
			
			cs = conn.prepareCall("call USP_003_M_GR_CH_PRINT_TOT_HSPF(?,?)");
			cs.setString(1, V_GR_NO);//V_COMP_ID
			cs.registerOutParameter(2, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
		
			rs = (ResultSet) cs.getObject(2);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("GR_NO", rs.getString("GR_NO"));
				jsonArray.add(subObject);
			}
		
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
		
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_ELEC_YN = hashMap.get("ELEC_YN") == null ? "" : hashMap.get("ELEC_YN").toString();
					String V_LC_DOC_NO = hashMap.get("LC_DOC_NO") == null ? "" : hashMap.get("LC_DOC_NO").toString();
					String V_BL_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
					String V_GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
					String V_TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString();
					V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();

					cs = conn.prepareCall("call USP_003_M_GR_DISTR_TOT_HSPF(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_MVMT_DT_FR
					cs.setString(4, "");//V_MVMT_DT_TO
					cs.setString(5, "");//V_M_BP_CD
					cs.setString(6, V_GR_NO);//V_GR_NO
					cs.setString(7, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_ELEC_YN = jsondata.get("ELEC_YN") == null ? "" : jsondata.get("ELEC_YN").toString();
				String V_LC_DOC_NO = jsondata.get("LC_DOC_NO") == null ? "" : jsondata.get("LC_DOC_NO").toString();
				String V_BL_DOC_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
				String V_GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();
				String V_TEMP_GL_NO = jsondata.get("TEMP_GL_NO") == null ? "" : jsondata.get("TEMP_GL_NO").toString();
				V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();

				cs = conn.prepareCall("call USP_003_M_GR_DISTR_TOT_HSPF(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_MVMT_DT_FR
				cs.setString(4, "");//V_MVMT_DT_TO
				cs.setString(5, "");//V_M_BP_CD
				cs.setString(6, V_GR_NO);//V_GR_NO
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
		} else if (V_TYPE.equals("ERP")) {

			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE");

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			JSONObject anyObject = new JSONObject();
			JSONArray anyArray = new JSONArray();
			JSONObject anySubObject = new JSONObject();

			URL url = null;
 			if (U_TYPE.equals("I")) { //확정
 				url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert");
 			} else if (U_TYPE.equals("D")) { //확정취소
 				url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel");
 			}

 			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
 				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
 				ArrayList<String> grArr = new ArrayList<String>();
 				ArrayList<String> grArr_FIN = new ArrayList<String>();

 				for (int i = 0; i < jsonAr.size(); i++) {
 					HashMap hashMap = (HashMap) jsonAr.get(i);
 					String V_TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString();
					String V_GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
 					/*전표생성이고, 전표번호가 있으면 continue*/
 					if(U_TYPE.equals("I") && V_TEMP_GL_NO.length() > 0) {
 						continue;
 					} else {
 						grArr.add(V_GR_NO);
 					}
 				}
 				for (int j = 0; j < grArr.size(); j++) {
 					if (!grArr_FIN.contains(grArr.get(j))) grArr_FIN.add(grArr.get(j));
 				}

 				for (int k = 0; k < grArr_FIN.size(); k++) {
 					cs = conn.prepareCall("call USP_003_A_TEMP_GR_FR_TOT(?,?,?,?,?)");

 					cs.setString(1, V_COMP_ID);//V_COMP_ID
 					cs.setString(2, U_TYPE);//V_TYPE
 					cs.setString(3, grArr_FIN.get(k));//V_GR_NO
 					cs.setString(4, V_USR_ID);//V_USR_ID
 					cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
 					cs.executeQuery();

 					rs = (ResultSet) cs.getObject(5);

 					String V_TEMP_GL_NO = "";
 					if (rs.next()) {
 						V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
 					}
 					anySubObject = new JSONObject();
 					anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
 					anySubObject.put("V_USR_ID", V_USR_ID);
 					anySubObject.put("V_DB_ID", "sa");
 					anySubObject.put("V_DB_PW", "hsnadmin");

 					anyArray.add(anySubObject);		
 				}

 			} else {

 				JSONObject jsondata = JSONObject.fromObject(jsonData);
 				String V_GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();

 				cs = conn.prepareCall("call USP_003_A_TEMP_GR_FR_TOT(?,?,?,?,?)");

 				cs.setString(1, V_COMP_ID);//V_COMP_ID
 				cs.setString(2, U_TYPE);//V_TYPE
 				cs.setString(3, V_GR_NO);//V_BL_NO
 				cs.setString(4, V_USR_ID);//V_BL_SEQ
 				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
 				cs.executeQuery();

 				rs = (ResultSet) cs.getObject(5);

 				String V_TEMP_GL_NO = "";
 				if (rs.next()) {
 					V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
 				}

 				anySubObject = new JSONObject();
 				anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
 				anySubObject.put("V_USR_ID", V_USR_ID);
 				anySubObject.put("V_DB_ID", "sa");
 				anySubObject.put("V_DB_PW", "hsnadmin");

 				anyArray.add(anySubObject);
 			}

 			anyObject.put("data", anyArray);
 			String parameter = anyObject + "";

 			URLConnection con = url.openConnection();
 			con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
 			con.setDoOutput(true);

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

		} else if (V_TYPE.equals("ERP_DEL_CHECK")) {
			String V_TEMP_GL_NO = request.getParameter("V_TEMP_GL_NO") == null ? "" : request.getParameter("V_TEMP_GL_NO");
			
			cs = conn.prepareCall("call USP_003_M_GR_DISTR_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_MVMT_DT_FR
			cs.setString(4, "");//V_MVMT_DT_TO
			cs.setString(5, "");//V_M_BP_CD
			cs.setString(6, V_TEMP_GL_NO);//V_GR_NO
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			String res = "";
			if (rs.next()) {
				res = rs.getString("V_RET_VAL");
			}
		
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(res);
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
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>


