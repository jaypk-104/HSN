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
		String V_YYYYMM = request.getParameter("V_YYYYMM") == null ? "" : request.getParameter("V_YYYYMM").replace("-", "").substring(0, 6);
		String V_SL_NM = request.getParameter("V_SL_NM") == null ? "" : request.getParameter("V_SL_NM").toUpperCase();
		String V_TEMP_GL_DT = request.getParameter("V_TEMP_GL_DT") == null ? "" : request.getParameter("V_TEMP_GL_DT").toString().substring(0, 10);

		if (V_TYPE.equals("T1S")) {
			cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
			cs.setString(15, "");//
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
				subObject.put("SALE_ISSUE_DT", rs.getString("SALE_ISSUE_DT"));
				//subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				//subObject.put("GL_YN", rs.getString("GL_YN"));
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
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

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
					
					String V_ISSUE_DT = request.getParameter("V_ISSUE_DT") == null ? "" : request.getParameter("V_ISSUE_DT").toUpperCase();
					

					cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
					cs.setString(15, V_ISSUE_DT);//
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
				
				String V_ISSUE_DT = request.getParameter("V_ISSUE_DT") == null ? "" : request.getParameter("V_ISSUE_DT").toUpperCase();

				cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
				cs.setString(15, V_ISSUE_DT);//
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			}

		} else if (V_TYPE.equals("T2S")) {
			cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
			cs.setString(15, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("TOT_AMT", rs.getString("TOT_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("GL_YN", rs.getString("GL_YN"));
				subObject.put("SALE_ISSUE_DT", rs.getString("SALE_ISSUE_DT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		} else if (V_TYPE.equals("T2I")) {

			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					
					/* String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString(); */
					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
/* 					String V_SL_AMT = hashMap.get("SL_AMT") == null ? "" : hashMap.get("SL_AMT").toString();
					String V_VAT_AMT = hashMap.get("VAT_AMT") == null ? "" : hashMap.get("VAT_AMT").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString(); */
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();

					cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_YYYYMM
					cs.setString(4, "");//V_S_BP_CD
					cs.setString(5, V_SL_CD);//V_SL_CD
					cs.setString(6, "");//V_SL_NM
					cs.setString(7, "");//V_SL_AMT
					cs.setString(8, "");//V_VAT_AMT
					cs.setString(9, "");//V_REMARK
					cs.setString(10, "");//V_TEMP_GL_NO
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(13, "");//V_USR_ID
					cs.setString(14, V_M_BP_CD);//V_S_B_BP_CD
					cs.setString(15, "");//
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

			/* 	String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString(); */
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				/* String V_SL_AMT = jsondata.get("SL_AMT") == null ? "" : jsondata.get("SL_AMT").toString();
				String V_VAT_AMT = jsondata.get("VAT_AMT") == null ? "" : jsondata.get("VAT_AMT").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_TEMP_GL_NO = jsondata.get("TEMP_GL_NO") == null ? "" : jsondata.get("TEMP_GL_NO").toString(); */
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();

				cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_YYYYMM
				cs.setString(4, "");//V_S_BP_CD
				cs.setString(5, V_SL_CD);//V_SL_CD
				cs.setString(6, "");//V_SL_NM
				cs.setString(7, "");//V_SL_AMT
				cs.setString(8, "");//V_VAT_AMT
				cs.setString(9, "");//V_REMARK
				cs.setString(10, "");//V_TEMP_GL_NO
				cs.setString(11, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(13, "");//V_USR_ID
				cs.setString(14, V_M_BP_CD);//V_S_B_BP_CD
				cs.setString(15, "");//
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			} 
			}else if (V_TYPE.equals("T3S")) {
			cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, "");//V_VAT_TYPE
			cs.setString(14, "");//V_S_B_BP_CD
			cs.setString(15, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("TOT_AMT", rs.getString("TOT_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("SALE_ISSUE_DT", rs.getString("SALE_ISSUE_DT"));
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
			cs = conn.prepareCall("call USP_003_S_M_SL_MGM_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
			cs.setString(15, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("S_B_BP_CD", rs.getString("S_B_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("TOT_AMT", rs.getString("TOT_AMT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("GL_YN", rs.getString("GL_YN"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("SALE_ISSUE_DT", rs.getString("SALE_ISSUE_DT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("GL_IV")) { //매입전표
			
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			String V_TYPE2 = "";
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				String spid_flag = "N";
				String V_SP_ID = "";
				
				String V_SL_CD = "";
				String V_M_BP_CD = "";
				String V_TEMP_GL_NO = "";
				
				
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					//V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					//V_M_BP_CD = hashMap.get("M_BP_CD1") == null ? "" : hashMap.get("M_BP_CD1").toString();
					V_M_BP_CD = request.getParameter("M_BP_CD") == null ? "" : request.getParameter("M_BP_CD").toUpperCase();
					V_TEMP_GL_NO = "";
						
		
					if (V_TYPE.equals("I") || V_TYPE.equals("D")) {
						if (spid_flag.equals("N")) {
							V_SP_ID = System.currentTimeMillis() + "";
							spid_flag = "Y";

							V_TYPE2 = V_TYPE;
						}
						
						cs = conn.prepareCall("call USP_002_TEMP_S_M_SL_MGM_DISTR(?,?,?,?)");
						cs.setString(1, V_YYYYMM);//V_COMP_ID	
						cs.setString(2, V_SL_CD);//V_CHARGE_NO
						//cs.setString(3, V_M_BP_CD);//V_CHARGE_NO
						cs.setString(3, V_M_BP_CD);//V_CHARGE_NO
						cs.setString(4, V_SP_ID);//V_CHARGE_NO
						cs.executeQuery();
					}			
				}
				
/*  				System.out.println("V_COMP_ID " + V_COMP_ID);
 				System.out.println("V_TYPE " + V_TYPE);
				System.out.println("V_TYPE " + V_TYPE2);
				System.out.println("V_YYYYMM " + V_YYYYMM);
				System.out.println("V_M_BP_CD " + V_M_BP_CD);
				System.out.println("V_TEMP_GL_DT " + V_TEMP_GL_DT);
				System.out.println("V_USR_ID " + V_USR_ID);
				System.out.println("V_SP_ID " + V_SP_ID); */ 
				
				cs = conn.prepareCall("call DISTR_TEMP_GL.USP_A_TEMP_SL_IV(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE2);//V_TYPE
				cs.setString(3, V_YYYYMM);//V_YYYYMM
				//cs.setString(4, V_SL_CD);//V_SL_CD
				cs.setString(4, V_M_BP_CD);//V_SL_CD
				cs.setString(5, V_TEMP_GL_DT);//V_TEMP_GL_DT
				cs.setString(6, V_USR_ID);//V_USR_ID
				cs.setString(7, V_SP_ID);//V_USR_ID
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(8);
				
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				//String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				//String V_M_BP_CD = jsondata.get("M_BP_CD1") == null ? "" : jsondata.get("M_BP_CD1").toString();
				String V_M_BP_CD = request.getParameter("M_BP_CD") == null ? "" : request.getParameter("M_BP_CD").toUpperCase();
				String V_SP_ID = "";
				String spid_flag = "N";
				
				if (V_TYPE.equals("I") || V_TYPE.equals("D")) {
					if (spid_flag.equals("N")) {
						V_SP_ID = System.currentTimeMillis() + "";
						spid_flag = "Y";
						V_TYPE2 = V_TYPE;
					}
	
					cs = conn.prepareCall("call USP_002_TEMP_S_M_SL_MGM_DISTR(?,?,?,?)");
					cs.setString(1, V_YYYYMM);//V_COMP_ID	
					cs.setString(2, V_SL_CD);//V_CHARGE_NO
					//cs.setString(3, V_M_BP_CD);//V_CHARGE_NO
					cs.setString(3, V_M_BP_CD);//V_CHARGE_NO
					cs.setString(4, V_SP_ID);//V_CHARGE_NO
					cs.executeQuery();
				}
/* 				
				System.out.println("V_COMP_ID " + V_COMP_ID);
				System.out.println("V_TYPE " + V_TYPE2);
				System.out.println("V_YYYYMM " + V_YYYYMM);
				System.out.println("V_M_BP_CD " + V_M_BP_CD);
				System.out.println("V_TEMP_GL_DT " + V_TEMP_GL_DT);
				System.out.println("V_USR_ID " + V_USR_ID);
				System.out.println("V_SP_ID " + V_SP_ID);  */
				
				cs = conn.prepareCall("call DISTR_TEMP_GL.USP_A_TEMP_SL_IV(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE2);//V_TYPE
				cs.setString(3, V_YYYYMM);//V_YYYYMM
				cs.setString(4, V_M_BP_CD);//V_SL_CD
				cs.setString(5, V_TEMP_GL_DT);//V_TEMP_GL_DT
				cs.setString(6, V_USR_ID);//V_USR_ID
				cs.setString(7, V_SP_ID);//V_USR_ID
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(8);
			}
			

			
			
			String V_TEMP_GL_NO = "";
			if (rs.next()) {
				V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
				V_TYPE = V_TYPE2;
			}

			

	 		if (V_TEMP_GL_NO.contains("TG")) {
 				/*애니링크 시작*/
 				JSONObject anyObject = new JSONObject();
 				JSONArray anyArray = new JSONArray();
 				JSONObject anySubObject = new JSONObject();

 				URL url = null;
			
 				if(V_TYPE.equals("I")) { //확정
 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert"); 
 				} else if(V_TYPE.equals("D")) { //확정취소
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
 			}

	 		
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("GL_BN")) { //매출전표
			
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_S_BP_CD = hashMap.get("S_B_BP_CD") == null ? "" : hashMap.get("S_B_BP_CD").toString();
					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					
					cs = conn.prepareCall("call DISTR_TEMP_GL.USP_A_TEMP_SL_BN(?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_YYYYMM);//V_YYYYMM
					cs.setString(4, V_S_BP_CD);//V_BP_CD
					cs.setString(5, V_TEMP_GL_DT);//V_TEMP_GL_DT
					cs.setString(6, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
					
					rs = (ResultSet) cs.getObject(7);

					String V_TEMP_GL_NO = "";
					if (rs.next()) {
						V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
					}
					
		 			if (V_TEMP_GL_NO.contains("TG")) {
		 				/*애니링크 시작*/
		 				JSONObject anyObject = new JSONObject();
		 				JSONArray anyArray = new JSONArray();
		 				JSONObject anySubObject = new JSONObject();
	
		 				URL url = null;
						
		 				if(V_TYPE.equals("I")) { //확정
		 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert"); 
		 				} else if(V_TYPE.equals("D")) { //확정취소
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
		 			}
				}
				
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_S_BP_CD = jsondata.get("S_B_BP_CD") == null ? "" : jsondata.get("S_B_BP_CD").toString();
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();

				cs = conn.prepareCall("call DISTR_TEMP_GL.USP_A_TEMP_SL_BN(?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_YYYYMM);//V_YYYYMM
				cs.setString(4, V_S_BP_CD);//V_BP_CD
				cs.setString(5, V_TEMP_GL_DT);//V_TEMP_GL_DT
				cs.setString(6, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(7);

				String V_TEMP_GL_NO = "";
				if (rs.next()) {
					V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
				}
				
				if (V_TEMP_GL_NO.contains("TG")) {
	 				/*애니링크 시작*/
	 				JSONObject anyObject = new JSONObject();
	 				JSONArray anyArray = new JSONArray();
	 				JSONObject anySubObject = new JSONObject();

	 				URL url = null;
					
	 				if(V_TYPE.equals("I")) { //확정
	 					url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert"); 
	 				} else if(V_TYPE.equals("D")) { //확정취소
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
	 			}
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
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


