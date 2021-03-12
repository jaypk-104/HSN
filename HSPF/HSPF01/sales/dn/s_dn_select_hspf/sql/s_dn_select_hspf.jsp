<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		//출고조회 조회
		if (V_TYPE.equals("S")) {
			// 			System.out.println("S");
			String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").substring(0, 10);
			String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").substring(0, 10);
			String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();

			cs = conn.prepareCall("call USP_S_DN_SELECT(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_DN_DT_FR); //V_DN_DT_FR
			cs.setString(2, V_DN_DT_TO); //V_DN_DT_TO
			cs.setString(3, V_S_BP_NM); //V_S_BP_CD
			cs.setString(4, V_ITEM_CD); //V_ITEM_CD
			cs.setString(5, V_ITEM_NM); //V_ITEM_NM
			cs.setString(6, V_BL_NO); //V_TYPE
			cs.setString(7, V_TYPE); //V_TYPE
			cs.setString(8, ""); //V_DN_DT
			cs.setString(9, ""); //V_DN_QTY
			cs.setString(10, ""); //V_SL_CD
			cs.setString(11, ""); //V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("TO_SL_NM", rs.getString("TO_SL_NM"));
				subObject.put("IF_ERP_YN", rs.getString("IF_ERP_YN"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("DN_USR_NM", rs.getString("DN_USR_NM"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("OLD_DN_DT", rs.getString("OLD_DN_DT"));
				subObject.put("OLD_S_BP_CD", rs.getString("OLD_S_BP_CD"));

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
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_DN_DT = hashMap.get("DN_DT") == null ? "" : hashMap.get("DN_DT").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();
					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
					String V_ERP_DN_NO = hashMap.get("ERP_DN_NO") == null ? "" : hashMap.get("ERP_DN_NO").toString();


					cs = conn.prepareCall("call USP_S_DN_SELECT(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, ""); //V_DN_DT_FR
					cs.setString(2, ""); //V_DN_DT_TO
					cs.setString(3, ""); //V_S_BP_CD
					cs.setString(4, V_ITEM_CD); //V_ITEM_CD
					cs.setString(5, V_DN_NO); //V_ITEM_NM - V_DN_NO
					cs.setString(6, ""); //V_TYPE
					cs.setString(7, V_TYPE); //V_TYPE
					cs.setString(8, V_DN_DT); //V_DN_DT
					cs.setString(9, V_DN_QTY); //V_DN_QTY
					cs.setString(10, V_SL_CD); //V_SL_CD
					cs.setString(11, V_USR_ID); //V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					String status = "";
					rs = (ResultSet) cs.getObject(12);

					while (rs.next()) {
						status = rs.getString("STATUS");
						//원래 삭제 쿼리 while 밖에있었는데 하나의 DN_NO 에 ERP_DN_NO 2개 이상인 경우 삭제 안되는 문제가 발생해서 수정함. 20200113 김장운.
						/*
						if (status.equals("SUCCESS")) { //출고삭제성공시
							e_cs = e_conn.prepareCall("{call USP_HSPF_DN_DELETE(?,?,?)}");
							e_cs.setString(1, V_ITEM_CD);
							e_cs.setString(2, V_DN_DT);
							e_cs.setString(3, rs.getString("ERP_DN_NO"));
							e_cs.execute();
						}
						System.out.println("=================");
						System.out.println("status" + status);
						System.out.println("V_DN_NO:" + V_DN_NO);
						System.out.println("V_ERP_DN_NO:" + rs.getString("ERP_DN_NO"));
						//20200707 이제 ERP 안쓰니까 주석처리
						*/
						//출고삭제하는데 ERP_DN_NO가 여러개인경우 하나만 삭제되어 로그보기위해 추가.(ERP_DN_NO가 각각 다르고 700KG 10장인 경우 700KG 1장만 삭제되는 문제가 있음.) 20190429 김장운.
					}



					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("SUCCESS");
					pw.flush();
					pw.close();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_DN_DT = jsondata.get("DN_DT") == null ? "" : jsondata.get("DN_DT").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
				String V_ERP_DN_NO = jsondata.get("ERP_DN_NO") == null ? "" : jsondata.get("ERP_DN_NO").toString();

				// 				System.out.println("V_TYPE" + V_TYPE);
				// 				System.out.println("V_DN_DT" + V_DN_DT);
				// 				System.out.println("V_DN_QTY" + V_DN_QTY);
				// 				System.out.println("V_ITEM_CD" + V_ITEM_CD);
// 				System.out.println("V_ERP_DN_NO" + V_ERP_DN_NO);

				cs = conn.prepareCall("call USP_S_DN_SELECT(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, ""); //V_DN_DT_FR
				cs.setString(2, ""); //V_DN_DT_TO
				cs.setString(3, ""); //V_S_BP_CD
				cs.setString(4, V_ITEM_CD); //V_ITEM_CD
				cs.setString(5, V_DN_NO); //V_ITEM_NM - V_DN_NO
				cs.setString(6, ""); //V_TYPE
				cs.setString(7, V_TYPE); //V_TYPE
				cs.setString(8, V_DN_DT); //V_DN_DT
				cs.setString(9, V_DN_QTY); //V_DN_QTY
				cs.setString(10, V_SL_CD); //V_SL_CD
				cs.setString(11, V_USR_ID); //V_USR_ID
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				String status = "";

				rs = (ResultSet) cs.getObject(12);
				while (rs.next()) {
					status = rs.getString("STATUS");
				}
				

				/*
				System.out.println("=================");
				System.out.println("status" + status);
				System.out.println("status" + status);
				System.out.println("V_DN_NO:" + V_DN_NO);
				System.out.println("V_ERP_DN_NO:" + V_ERP_DN_NO);
				//출고삭제하는데 ERP_DN_NO가 여러개인경우 하나만 삭제되어 로그보기위해 추가.(ERP_DN_NO가 각각 다르고 700KG 10장인 경우 700KG 1장만 삭제되는 문제가 있음.) 20190429 김장운.
				
				if (status.equals("SUCCESS")) { //출고삭제성공시
					e_cs = e_conn.prepareCall("{call USP_HSPF_DN_DELETE(?,?,?)}");
					e_cs.setString(1, V_ITEM_CD);
					e_cs.setString(2, V_DN_DT);
					e_cs.setString(3, V_ERP_DN_NO);
					e_cs.execute();
				}
				//20200707 이제 ERP 안쓰니까 주석처리
				*/

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("SUCCESS");
				pw.flush();
				pw.close();
			}
		}
			
		else if (V_TYPE.equals("SYNC2")) {
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
					String V_DN_DT = hashMap.get("DN_DT") == null ? "" : hashMap.get("DN_DT").toString();
					String V_OLD_DN_DT = hashMap.get("OLD_DN_DT") == null ? "" : hashMap.get("OLD_DN_DT").toString();
					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_OLD_S_BP_CD = hashMap.get("OLD_S_BP_CD") == null ? "" : hashMap.get("OLD_S_BP_CD").toString();
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();


					if (V_DN_DT.length() > 10 ){
						V_DN_DT = V_DN_DT.substring(0,10);
					}
					if (V_OLD_DN_DT.length() > 10 ){
						V_OLD_DN_DT = V_OLD_DN_DT.substring(0,10);
					}
	
					cs = conn.prepareCall("call USP_S_DN_SELECT_CHG(?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //V_TYPE
					cs.setString(2, V_DN_DT); //V_DN_DT
					cs.setString(3, V_OLD_DN_DT); //V_OLD_DN_DT
					cs.setString(4, V_S_BP_CD); //V_S_BP_CD
					cs.setString(5, V_OLD_S_BP_CD); // V_OLD_S_BP_CD
					cs.setString(6, V_ITEM_CD); //V_ITEM_CD
					cs.setString(7, V_SL_CD); //V_SL_CD
					cs.setString(8, V_DN_NO); //V_DN_NO
					cs.setString(9, V_USR_ID); //V_USR_ID
					cs.executeQuery();
					
					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("SUCCESS");
					pw.flush();
					pw.close();


				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_DN_DT = jsondata.get("DN_DT") == null ? "" : jsondata.get("DN_DT").toString();
				String V_OLD_DN_DT = jsondata.get("OLD_DN_DT") == null ? "" : jsondata.get("OLD_DN_DT").toString();
				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_OLD_S_BP_CD = jsondata.get("OLD_S_BP_CD") == null ? "" : jsondata.get("OLD_S_BP_CD").toString();
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();

				if (V_DN_DT.length() > 10 ){
					V_DN_DT = V_DN_DT.substring(0,10);
				}
				if (V_OLD_DN_DT.length() > 10 ){
					V_OLD_DN_DT = V_OLD_DN_DT.substring(0,10);
				}

				cs = conn.prepareCall("call USP_S_DN_SELECT_CHG(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //V_TYPE
				cs.setString(2, V_DN_DT); //V_DN_DT
				cs.setString(3, V_OLD_DN_DT); //V_OLD_DN_DT
				cs.setString(4, V_S_BP_CD); //V_S_BP_CD
				cs.setString(5, V_OLD_S_BP_CD); // V_OLD_S_BP_CD
				cs.setString(6, V_ITEM_CD); //V_ITEM_CD
				cs.setString(7, V_SL_CD); //V_SL_CD
				cs.setString(8, V_DN_NO); //V_DN_NO
				cs.setString(9, V_USR_ID); //V_USR_ID
				cs.executeQuery();
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("SUCCESS");
				pw.flush();
				pw.close();

			}
		}

		if (V_TYPE.equals("IF")) {
			URL url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_dn_to_erp");
			URLConnection con = url1.openConnection();
			con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
			con.setDoOutput(true);
			JSONObject anySubObject = new JSONObject();

			anySubObject.put("V_DN_NO", "1");
			anySubObject.put("V_DN_SEQ", "1");
			anySubObject.put("V_COMP_ID", "HSN");
			anySubObject.put("V_USR_ID", V_USR_ID);
			JSONArray anyArray = new JSONArray();
			anyArray.add(anySubObject);
			JSONObject anyObject = new JSONObject();
			anyObject.put("data", anyArray);
			String parameter = anyObject + "";

			// 			System.out.println(parameter);
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
			//                   System.out.println(result);
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(result);
			pw.flush();
			pw.close();
		}

	} catch (Exception e) {
		e.printStackTrace();
	
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

		
// 		e.printStackTrace();
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


