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
<%@ include file="/HSPF01/common/DB_Connection_ERP_TEMP.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;


	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		
		

		if (V_TYPE.equals("S")) {
			//영업담당자 비율 조회
			String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO");
			
			cs = conn.prepareCall("call USP_E_APPROV_PL_DISTR(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_APPROV_NO);//V_APPROV_MGM_NO
			cs.setString(4, "");//V_BAS_DT
			cs.setString(5, "");//V_PL_SEQ
			cs.setString(6, "");//V_EMP_NO
			cs.setString(7, "");//V_PL_RATE
			cs.setString(8, "");//V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(9);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BAS_DT", rs.getString("BAS_DT"));
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("NAME", rs.getString("NAME"));
				subObject.put("EMP_NO", rs.getString("EMP_NO"));
				subObject.put("RATE", rs.getString("RATE"));
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			// 				System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
			
			
		}
		else if (V_TYPE.equals("ADD_S")) {
			//영업담당자 추가 조회
			String sql = "select EMP_NO, NAME from HAA010T where DEPT_CD = '5124' and (RETIRE_DT is null or isnull(RETIRE_DT, '1900-01-01') = '1900-01-01') ";
			e_cs = e_conn.prepareCall("{call dbo.getData(?)}");
			e_cs.setString(1, sql); 
			
			rs = e_cs.executeQuery();
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("EMP_NO", rs.getString("EMP_NO"));
				subObject.put("NAME", rs.getString("NAME"));
				
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
		else if (V_TYPE.equals("D")) {
			//영업담당자 비율 조회
			String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO");
			String V_SEQ = request.getParameter("V_SEQ") == null ? "" : request.getParameter("V_SEQ");
			String V_BAS_DT = request.getParameter("V_BAS_DT") == null ? "" : request.getParameter("V_BAS_DT");
			
			if(V_BAS_DT.length() > 10){
				V_BAS_DT = V_BAS_DT.substring(0,10);
			}
			
			cs = conn.prepareCall("call USP_E_APPROV_PL_DISTR(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_APPROV_NO);//V_APPROV_MGM_NO
			cs.setString(4, V_BAS_DT);//V_BAS_DT
			cs.setString(5, V_SEQ);//V_PL_SEQ
			cs.setString(6, "");//V_EMP_NO
			cs.setString(7, "");//V_PL_RATE
			cs.setString(8, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
		}
		else if (V_TYPE.equals("SYNC")) {
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
					String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO");
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_BAS_DT = hashMap.get("BAS_DT") == null ? "" : hashMap.get("BAS_DT").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_EMP_NO = hashMap.get("EMP_NO") == null ? "" : hashMap.get("EMP_NO").toString();
					String V_RATE = hashMap.get("RATE") == null ? "" : hashMap.get("RATE").toString();
					
					if(V_BAS_DT.length() > 10){
						V_BAS_DT = V_BAS_DT.substring(0,10);
					}
					
					cs = conn.prepareCall("call USP_E_APPROV_PL_DISTR(?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_APPROV_NO);//V_APPROV_MGM_NO
					cs.setString(4, V_BAS_DT);//V_BAS_DT
					cs.setString(5, V_SEQ);//V_PL_SEQ
					cs.setString(6, V_EMP_NO);//V_EMP_NO
					cs.setString(7, V_RATE);//V_PL_RATE
					cs.setString(8, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} 
			else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO");
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_BAS_DT = jsondata.get("BAS_DT") == null ? "" : jsondata.get("BAS_DT").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_EMP_NO = jsondata.get("EMP_NO") == null ? "" : jsondata.get("EMP_NO").toString();
				String V_RATE = jsondata.get("RATE") == null ? "" : jsondata.get("RATE").toString();
				
				if(V_BAS_DT.length() > 10){
					V_BAS_DT = V_BAS_DT.substring(0,10);
				}

				cs = conn.prepareCall("call USP_E_APPROV_PL_DISTR(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_APPROV_NO);//V_APPROV_MGM_NO
				cs.setString(4, V_BAS_DT);//V_BAS_DT
				cs.setString(5, V_SEQ);//V_PL_SEQ
				cs.setString(6, V_EMP_NO);//V_EMP_NO
				cs.setString(7, V_RATE);//V_PL_RATE
				cs.setString(8, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

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
		
		//MSSQL
		if (e_cs != null) try {
			e_cs.close();
		} catch (SQLException ex) {}
		if (e_rs != null) try {
			e_rs.close();
		} catch (SQLException ex) {}
		if (e_stmt != null) try {
			e_stmt.close();
		} catch (SQLException ex) {}
		if (e_conn != null) try {
			e_conn.close();
		} catch (SQLException ex) {}
	}
%>


