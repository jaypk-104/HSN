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
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
		String V_BL_SEQ = request.getParameter("V_BL_SEQ") == null ? "" : request.getParameter("V_BL_SEQ").toUpperCase();
		String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();

		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_003_M_BL_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_NO);//V_BL_NO
			cs.setString(4, V_BL_SEQ);//V_BL_SEQ
			cs.setString(5, "");//V_ITEM_CD
			cs.setString(6, "");//V_QTY
			cs.setString(7, "");//V_PRICE
			cs.setString(8, "");//V_DOC_AMT
			cs.setString(9, "");//V_LOC_AMT
			cs.setString(10, "");//V_PO_NO
			cs.setString(11, "");//V_PO_SEQ
			cs.setString(12, "");//V_CONT_NO
			cs.setString(13, "");//V_CONT_QTY
			cs.setString(14, "");//V_BOX_QTY
			cs.setString(15, "");//V_BOX_WGT_UNIT
			cs.setString(16, "");//V_FORWARD_XCH_AMT
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(19, "");//V_LC_NO
			cs.setString(20, "");//V_LC_SEQ
			cs.setString(21, "");//V_CONT_MGM_NO
// 			cs.setString(19, "");//V_VALID_DT
// 			cs.setString(20, "");//V_PLANT_NO
// 			cs.setString(21, "");//V_BRAND
// 			cs.setString(22, "");//V_ORIGIN
// 			cs.setString(23, "");//V_LC_NO
// 			cs.setString(24, "");//V_LC_SEQ
// 			cs.setString(25, "");//V_CONT_MGM_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("CONT_QTY", rs.getString("CONT_QTY"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("CC_QTY", rs.getString("CC_QTY"));
				subObject.put("CY_QTY", rs.getString("CY_QTY"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
				subObject.put("CHARGE_YN", rs.getString("CHARGE_YN"));
				subObject.put("CLS_YN", rs.getString("CLS_YN"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SP")) {

			String V_LOADING_DT_FR = request.getParameter("W_LOADING_DT_FR") == null ? "" : request.getParameter("W_LOADING_DT_FR").substring(0, 10);
			String V_LOADING_DT_TO = request.getParameter("W_LOADING_DT_TO") == null ? "" : request.getParameter("W_LOADING_DT_TO").substring(0, 10);
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("W_BL_DOC_NO") == null ? "" : request.getParameter("W_BL_DOC_NO").toUpperCase();
			String V_LC_DOC_NO = request.getParameter("W_LC_DOC_NO") == null ? "" : request.getParameter("W_LC_DOC_NO").toUpperCase();
			String V_PO_NO = request.getParameter("W_PO_NO") == null ? "" : request.getParameter("W_PO_NO").toUpperCase();

			cs = conn.prepareCall("call USP_003_M_BL_POPUP_TOT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_LOADING_DT_FR);//V_LOADING_DT_FR
			cs.setString(2, V_LOADING_DT_TO);//V_LOADING_DT_TO
			cs.setString(3, V_M_BP_NM);//V_M_BP_NM
			cs.setString(4, V_S_BP_NM);//V_S_BP_NM
			cs.setString(5, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(6, V_PO_NO);//V_PO_NO
			cs.setString(7, V_LC_DOC_NO);//V_CONT_NO
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("SO_BP_NM", rs.getString("SO_BP_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			// 			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//BL DTL 저장 / 수정 / 삭제 / 확정
		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
// 			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);

			if (!V_TYPE.equals("V")) {
				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
						V_BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
						String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
						String V_PRICE = hashMap.get("PRICE") == null ? "" : hashMap.get("PRICE").toString();
						String V_DOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
						String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
						
						double a = Math.round(Double.parseDouble(V_DOC_AMT) * 10000) / 10000.0;
						V_DOC_AMT = a + "";

						String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
						String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
						String V_CONT_NO = hashMap.get("CONT_NO") == null ? "" : hashMap.get("CONT_NO").toString();
						String V_CONT_QTY = hashMap.get("CONT_QTY") == null ? "" : hashMap.get("CONT_QTY").toString();
// 						String V_BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
// 						String V_BOX_WGT_UNIT = hashMap.get("BOX_WGT_UNIT") == null ? "" : hashMap.get("BOX_WGT_UNIT").toString();
						String V_FORWARD_XCH_AMT = hashMap.get("FORWARD_XCH_AMT") == null ? "" : hashMap.get("FORWARD_XCH_AMT").toString();
						String V_OVER_TOL = hashMap.get("OVER_TOL") == null ? "" : hashMap.get("OVER_TOL").toString();
// 						String V_VALID_DT = hashMap.get("VALID_DT") == null ? "" : hashMap.get("VALID_DT").toString().substring(0, 10);
// 						String V_PLANT_NO = hashMap.get("PLANT_NO") == null ? "" : hashMap.get("PLANT_NO").toString();
// 						String V_BRAND = hashMap.get("BRAND") == null ? "" : hashMap.get("BRAND").toString();
// 						String V_ORIGIN = hashMap.get("ORIGIN") == null ? "" : hashMap.get("ORIGIN").toString();
						String V_LC_NO = hashMap.get("LC_NO") == null ? "" : hashMap.get("LC_NO").toString();
						String V_LC_SEQ = hashMap.get("LC_SEQ") == null ? "" : hashMap.get("LC_SEQ").toString();

						String V_CONT_MGM_NO = hashMap.get("CONT_MGM_NO") == null ? "" : hashMap.get("CONT_MGM_NO").toString();

						if (V_TYPE.equals("I")) {
							V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO");
							V_BL_SEQ = (i + 1) + "";
						}

						// 						System.out.println("V_QTY: " + V_QTY);

						cs = conn.prepareCall("call USP_003_M_BL_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_BL_NO);//V_BL_NO
						cs.setString(4, V_BL_SEQ);//V_BL_SEQ
						cs.setString(5, V_ITEM_CD);//V_ITEM_CD
						cs.setString(6, V_QTY);//V_QTY
						cs.setString(7, V_PRICE);//V_PRICE
						cs.setString(8, V_DOC_AMT);//V_DOC_AMT
						cs.setString(9, V_LOC_AMT);//V_LOC_AMT
						cs.setString(10, V_PO_NO);//V_PO_NO
						cs.setString(11, V_PO_SEQ);//V_PO_SEQ
						cs.setString(12, V_CONT_NO);//V_CONT_NO
						cs.setString(13, V_CONT_QTY);//V_CONT_QTY
						cs.setString(14, "");//V_BOX_QTY
						cs.setString(15, V_CUR);//V_CUR
						cs.setString(16, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
						cs.setString(17, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(19, V_LC_NO);//V_LC_NO
						cs.setString(20, V_LC_SEQ);//V_LC_SEQ
						cs.setString(21, V_CONT_MGM_NO);//V_CONT_MGM_NO
// 						cs.setString(19, V_VALID_DT);//V_VALID_DT
// 						cs.setString(20, V_PLANT_NO);//V_PLANT_NO
// 						cs.setString(21, V_BRAND);//V_BRAND
// 						cs.setString(22, V_ORIGIN);//V_ORIGIN
// 						cs.setString(23, V_LC_NO);//V_LC_NO
// 						cs.setString(24, V_LC_SEQ);//V_LC_SEQ
// 						cs.setString(25, V_CONT_MGM_NO);//V_CONT_MGM_NO
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}
				} else {
// 					JSONObject jsondata = JSONObject.fromObject(jsonData);
					JSONParser parser = new JSONParser();
					Object obj = parser.parse(jsonData);
					JSONObject jsondata = (JSONObject) obj;
					
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
					V_BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
					String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
					String V_PRICE = jsondata.get("PRICE") == null ? "" : jsondata.get("PRICE").toString();
					String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
					String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();

					double a = Math.round(Double.parseDouble(V_DOC_AMT) * 10000) / 10000.0;
					V_DOC_AMT = a + "";

					String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
					String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					String V_CONT_NO = jsondata.get("CONT_NO") == null ? "" : jsondata.get("CONT_NO").toString();
					String V_CONT_QTY = jsondata.get("CONT_QTY") == null ? "" : jsondata.get("CONT_QTY").toString();
// 					String V_BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
// 					String V_BOX_WGT_UNIT = jsondata.get("BOX_WGT_UNIT") == null ? "" : jsondata.get("BOX_WGT_UNIT").toString();
					String V_FORWARD_XCH_AMT = jsondata.get("FORWARD_XCH_AMT") == null ? "" : jsondata.get("FORWARD_XCH_AMT").toString();
					String V_OVER_TOL = jsondata.get("OVER_TOL") == null ? "" : jsondata.get("OVER_TOL").toString();
// 					String V_VALID_DT = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString().substring(0, 10);
// 					String V_PLANT_NO = jsondata.get("PLANT_NO") == null ? "" : jsondata.get("PLANT_NO").toString();
// 					String V_BRAND = jsondata.get("BRAND") == null ? "" : jsondata.get("BRAND").toString();
// 					String V_ORIGIN = jsondata.get("ORIGIN") == null ? "" : jsondata.get("ORIGIN").toString();
					String V_LC_NO = jsondata.get("LC_NO") == null ? "" : jsondata.get("LC_NO").toString();
					String V_LC_SEQ = jsondata.get("LC_SEQ") == null ? "" : jsondata.get("LC_SEQ").toString();
					String V_CONT_MGM_NO = jsondata.get("CONT_MGM_NO") == null ? "" : jsondata.get("CONT_MGM_NO").toString();

					if (V_TYPE.equals("I")) {
						V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO");
						V_BL_SEQ = 1 + "";
					}

					// 										System.out.println("V_LOC_AMT: " + V_LOC_AMT);

					cs = conn.prepareCall("call USP_003_M_BL_D_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_BL_NO);//V_BL_NO
					cs.setString(4, V_BL_SEQ);//V_BL_SEQ
					cs.setString(5, V_ITEM_CD);//V_ITEM_CD
					cs.setString(6, V_QTY);//V_QTY
					cs.setString(7, V_PRICE);//V_PRICE
					cs.setString(8, V_DOC_AMT);//V_DOC_AMT
					cs.setString(9, V_LOC_AMT);//V_LOC_AMT
					cs.setString(10, V_PO_NO);//V_PO_NO
					cs.setString(11, V_PO_SEQ);//V_PO_SEQ
					cs.setString(12, V_CONT_NO);//V_CONT_NO
					cs.setString(13, V_CONT_QTY);//V_CONT_QTY
					cs.setString(14, "");//V_BOX_QTY
					cs.setString(15, V_CUR);//V_CUR
					cs.setString(16, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
					cs.setString(17, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(19, V_LC_NO);//V_LC_NO
					cs.setString(20, V_LC_SEQ);//V_LC_SEQ
					cs.setString(21, V_CONT_MGM_NO);//V_LC_SEQ
// 					cs.setString(19, V_VALID_DT);//V_VALID_DT
// 					cs.setString(20, V_PLANT_NO);//V_PLANT_NO
// 					cs.setString(21, V_BRAND);//V_BRAND
// 					cs.setString(22, V_ORIGIN);//V_ORIGIN
// 					cs.setString(23, V_LC_NO);//V_LC_NO
// 					cs.setString(24, V_LC_SEQ);//V_LC_SEQ
// 					cs.setString(25, V_CONT_MGM_NO);//V_LC_SEQ
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			}

			/*BL확정*/
		} else if (V_TYPE.equals("I") || V_TYPE.equals("D")) {

			cs = conn.prepareCall("call USP_003_A_TEMP_BL_FR_TOT(?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_NO);//V_BL_NO
			cs.setString(4, V_USR_ID);//V_BL_SEQ
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			String V_TEMP_GL_NO = "";
			if (rs.next()) {
				V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
			}
			
			if (V_TEMP_GL_NO.contains("M_BL")) {

				jsonObject.put("resString", "M_BL");
// 				jsonObject.put("resultList", jsonArray);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
				
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
				
 				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
 				pw.print(result);
 				pw.flush();
 				pw.close();
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

	}
%>


