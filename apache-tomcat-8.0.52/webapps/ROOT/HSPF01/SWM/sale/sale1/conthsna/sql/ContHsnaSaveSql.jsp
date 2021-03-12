<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%
	ResultSet rs = null;
	CallableStatement cs = null;
	//CallableStatement cs = null;
	//JSONObject jsonObject = new JSONObject();
	//JSONArray jsonArray = new JSONArray();
	//JSONObject subObject = null;
	//컨테이너 생성, 변경, 삭제
	
	try {

		request.setCharacterEncoding("utf-8");
		
		
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
    	String V_CONT_MGM_NO = request.getParameter("V_CONT_MGM_NO") == null ? "" : request.getParameter("V_CONT_MGM_NO");
		String V_CONT_NO = request.getParameter("V_CONT_NO") == null ? "" : request.getParameter("V_CONT_NO");
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD");
		String V_PLANT_CD = request.getParameter("V_PLANT_CD") == null ? "" : request.getParameter("V_PLANT_CD");
		String V_CFM_YN = request.getParameter("V_CFM_YN") == null ? "" : request.getParameter("V_CFM_YN");
		String V_USER_ID = request.getParameter("V_USER_ID") == null ? "" : request.getParameter("V_USER_ID");
		String V_CONT_SIZE = request.getParameter("V_CONT_SIZE") == null ? "" : request.getParameter("V_CONT_SIZE");
		String V_CONT_SEAL_NO = request.getParameter("V_CONT_SEAL_NO") == null ? "" : request.getParameter("V_CONT_SEAL_NO");

// 				System.out.println("BASIC");
// 		 	     System.out.println("V_TYPE : " + V_TYPE);
// 				 System.out.println("V_CONT_MGM_NO : " + V_CONT_MGM_NO);	
// 				 System.out.println("V_CONT_NO : " + V_CONT_NO);
// 				 System.out.println("V_BP_CD : " + V_BP_CD);
// 				 System.out.println("V_PLANT_CD : " + V_PLANT_CD);
// 				 System.out.println("V_CFM_YN : " + V_CFM_YN);
// 				 System.out.println("V_USER_ID : " + V_USER_ID);
// 				 System.out.println("V_CONT_SIZE : " + V_CONT_SIZE);
// 				 System.out.println("V_CONT_SEAL_NO : " + V_CONT_SEAL_NO); 
// 				 System.out.println("");

		//System.out.println("jsondata v_type : " +  jsondata.get("V_TYPE").toString() );


		if (V_TYPE.equals("SYNCU")) {//컨테이너 변경, 삭제
			String data = request.getParameter("data");//Sync 탈때만
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
				    V_CONT_MGM_NO = hashMap.get("CONT_MGM_NO") == null ? "" : hashMap.get("CONT_MGM_NO").toString();
					//V_CONT_NO = hashMap.get("u_cont_no") == null ? "" : hashMap.get("u_cont_no").toString();
					V_BP_CD = hashMap.get("u_BP_CD") == null ? "" : hashMap.get("u_BP_CD").toString();
// 					V_PLANT_CD = hashMap.get("PLANT_CD") == null ? "" : hashMap.get("PLANT_CD").toString();
					V_CFM_YN = hashMap.get("CFM_YN") == null ? "" : hashMap.get("CFM_YN").toString();
					//V_USER_ID = hashMap.get("GUSER_ID") == null ? "" : hashMap.get("GUSER_ID").toString();
					//V_CONT_SIZE = hashMap.get("U_CONT_SIZE") == null ? "" : hashMap.get("U_CONT_SIZE").toString();
					//V_CONT_SEAL_NO = hashMap.get("U_CONT_SEAL_NO") == null ? "" : hashMap.get("U_CONT_SEAL_NO").toString();
					
					if(V_TYPE == "D"){
						V_CONT_NO = hashMap.get("cont_no") == null ? "" : hashMap.get("cont_no").toString();//grid
					}
					
// 					System.out.println("배열");
// 				    System.out.println("V_TYPE : " + V_TYPE);
// 					 System.out.println("V_CONT_MGM_NO : " + V_CONT_MGM_NO);	
// 					 System.out.println("V_CONT_NO : " + V_CONT_NO);
// 					 System.out.println("V_BP_CD : " + V_BP_CD);
// 					 System.out.println("V_PLANT_CD : " + V_PLANT_CD);
// 					 System.out.println("V_CFM_YN : " + V_CFM_YN);
// 					 System.out.println("V_USER_ID : " + V_USER_ID);
// 					 System.out.println("V_CONT_SIZE : " + V_CONT_SIZE);
// 					 System.out.println("V_CONT_SEAL_NO : " + V_CONT_SEAL_NO);
// 					System.out.println("");


					cs = conn.prepareCall("call   USP_S_CONTAINER_INSERT_20190725(?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_CONT_MGM_NO);
					cs.setString(3, V_CONT_NO);
					cs.setString(4, V_BP_CD);
					cs.setString(5, V_PLANT_CD);
					cs.setString(6, V_CFM_YN);
					cs.setString(7, V_CONT_SIZE);
					cs.setString(8, V_CONT_SEAL_NO);
					cs.setString(9, V_USER_ID);
					cs.registerOutParameter(10, Types.VARCHAR);

					cs.execute();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);					
					
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_CONT_MGM_NO = jsondata.get("CONT_MGM_NO") == null ? "" : jsondata.get("CONT_MGM_NO").toString();
				//V_CONT_NO = jsondata.get("u_cont_no") == null ? "" : jsondata.get("u_cont_no").toString();
				V_BP_CD = jsondata.get("u_BP_CD") == null ? "" : jsondata.get("u_BP_CD").toString();
// 				V_PLANT_CD = jsondata.get("V_PLANT_CD") == null ? "" : jsondata.get("V_PLANT_CD").toString();
				V_CFM_YN = jsondata.get("V_CFM_YN") == null ? "" : jsondata.get("V_CFM_YN").toString();
				//V_USER_ID = jsondata.get("GUSER_ID") == null ? "" : jsondata.get("GUSER_ID").toString();
				//V_CONT_SIZE = jsondata.get("U_CONT_SIZE") == null ? "" : jsondata.get("U_CONT_SIZE").toString();
				//V_CONT_SEAL_NO = jsondata.get("U_CONT_SEAL_NO") == null ? "" : jsondata.get("U_CONT_SEAL_NO").toString();
				
				if(V_TYPE == "D"){
					V_CONT_NO = jsondata.get("cont_no") == null ? "" : jsondata.get("cont_no").toString();
				}
				
// 				System.out.println("N 배열");
// 			    System.out.println("V_TYPE : " + V_TYPE);
// 				 System.out.println("V_CONT_MGM_NO : " + V_CONT_MGM_NO);	
// 				 System.out.println("V_CONT_NO : " + V_CONT_NO);
// 				 System.out.println("V_BP_CD : " + V_BP_CD);
// 				 System.out.println("V_PLANT_CD : " + V_PLANT_CD);
// 				 System.out.println("V_CFM_YN : " + V_CFM_YN);
// 				 System.out.println("V_USER_ID : " + V_USER_ID);
// 				 System.out.println("V_CONT_SIZE : " + V_CONT_SIZE);
// 				 System.out.println("V_CONT_SEAL_NO : " + V_CONT_SEAL_NO);
// 				System.out.println("");
				
				cs = conn.prepareCall("call   USP_S_CONTAINER_INSERT_20190725(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_CONT_MGM_NO);
				cs.setString(3, V_CONT_NO);
				cs.setString(4, V_BP_CD);
				cs.setString(5, V_PLANT_CD);
				cs.setString(6, V_CFM_YN);
				cs.setString(7, V_CONT_SIZE);
				cs.setString(8, V_CONT_SEAL_NO);
				cs.setString(9, V_USER_ID);
				cs.registerOutParameter(10, Types.VARCHAR);

				cs.execute();
			}

			if (cs.getString(10).equals("ISCONT")) {
				PrintWriter pw = response.getWriter();
				pw.print(cs.getString(10));
				pw.flush();
				pw.close();
			} else {
				PrintWriter pw = response.getWriter();
				pw.print(cs.getString(10));
				pw.flush();
				pw.close();

			}
		}
							
		else { //IS NOT SYNU 컨테이너생성, 삭제
// 			System.out.println("CONT CREATE ! ");
// 		    System.out.println("V_TYPE : " + V_TYPE);
// 			 System.out.println("V_CONT_MGM_NO : " + V_CONT_MGM_NO);	
// 			 System.out.println("V_CONT_NO : " + V_CONT_NO);
// 			 System.out.println("V_BP_CD : " + V_BP_CD);
// 			 System.out.println("V_PLANT_CD : " + V_PLANT_CD);
// 			 System.out.println("V_CFM_YN : " + V_CFM_YN);
// 			 System.out.println("V_USER_ID : " + V_USER_ID);
// 			 System.out.println("V_CONT_SIZE : " + V_CONT_SIZE);
// 			 System.out.println("V_CONT_SEAL_NO : " + V_CONT_SEAL_NO);
// 			System.out.println();
			
			cs = conn.prepareCall("{call   USP_S_CONTAINER_INSERT_20190725(?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_CONT_MGM_NO);
			cs.setString(3, V_CONT_NO);
			cs.setString(4, V_BP_CD);
			cs.setString(5, V_PLANT_CD);
			cs.setString(6, V_CFM_YN);
			cs.setString(7, V_CONT_SIZE);
			cs.setString(8, V_CONT_SEAL_NO);
			cs.setString(9, V_USER_ID);
			cs.registerOutParameter(10, Types.VARCHAR); //CONT_MGM_NO

			cs.execute();

			if (cs.getString(10).equals("ISCONT")) {
				PrintWriter pw = response.getWriter();
				pw.print(cs.getString(10));
				pw.flush();
				pw.close();
			} else {
				PrintWriter pw = response.getWriter();
				pw.print(cs.getString(10));
				pw.flush();
				pw.close();

			}

		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>








