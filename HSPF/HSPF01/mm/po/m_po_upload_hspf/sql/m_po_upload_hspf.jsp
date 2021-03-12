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

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	JSONObject anyObject = new JSONObject();
	JSONObject anyObject1 = new JSONObject();

	JSONArray anyArray = new JSONArray();
	JSONArray anyArray1 = new JSONArray();

	JSONObject anySubObject = new JSONObject();
	JSONObject anySubObject1 = new JSONObject();

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_TYPE2 = request.getParameter("V_TYPE2") == null ? "" : request.getParameter("V_TYPE2");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_PO_DESC = request.getParameter("V_PO_DESC") == null ? "" : request.getParameter("V_PO_DESC");
		String V_PO_DT = request.getParameter("V_PO_DT") == null ? "" : request.getParameter("V_PO_DT").substring(0, 10);
		String V_DLVY_HOPE_DT = request.getParameter("V_DLVY_HOPE_DT") == null ? "" : request.getParameter("V_DLVY_HOPE_DT").substring(0, 10);
		String V_ITEM_CD = "";

		// 		조회
		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_M_PO_UPLOAD_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, "");//V_COMP_ID
			cs.setString(3, "");//V_TEMP_ID
			cs.setString(4, V_PO_DESC);//V_PO_DESC
			cs.setString(5, V_PO_DT);//V_PO_DT
			cs.setString(6, "");//V_ITEM_CD
			cs.setString(7, "");//V_M_BP_CD
			cs.setString(8, "");//V_CUR
			cs.setString(9, "");//V_XCH_RT
			cs.setString(10, "");//V_QTY
			cs.setString(11, "");//V_PRC
			cs.setString(12, "");//V_AMT
			cs.setString(13, "");//V_LOC_AMT
			cs.setString(14, "");//V_PO_TYPE
			cs.setString(15, "");//V_VAT_TYPE
			cs.setString(16, "");//V_PAY_METH
			cs.setString(17, "");//V_IN_TERMS
			cs.setString(18, "");//V_CHECK_YN
			cs.setString(19, "");//V_PO_NO
			cs.setString(20, "");//V_PO_SEQ
			cs.setString(21, "");//V_PO_CFM_YN
			cs.setString(22, "");//V_REMARK
			cs.setString(23, "");//V_HOPE_SL_CD
			cs.setString(24, "");//V_DLVY_HOPE_DT
			cs.setString(25, "");//V_SUPP_REMARK
			cs.setString(26, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(27);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("TEMP_ID", rs.getString("TEMP_ID"));
				subObject.put("PO_DESC", rs.getString("PO_DESC"));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT").substring(0, 10));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("HOPE_SL_CD", rs.getString("HOPE_SL_CD"));
				subObject.put("HOPE_SL_NM", rs.getString("HOPE_SL_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("CUR_NM", rs.getString("CUR_NM"));
				subObject.put("XCH_RT", rs.getString("XCH_RT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("PRC", rs.getString("PRC"));
				subObject.put("AMT", rs.getString("AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("CHECK_YN", rs.getString("CHECK_YN"));
				subObject.put("ERROR_DESC", rs.getString("ERROR_DESC"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_CFM_YN", rs.getString("PO_CFM_YN"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("SUPP_REMARK", rs.getString("SUPP_REMARK"));
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

					String V_TEMP_ID = hashMap.get("TEMP_ID") == null ? "" : hashMap.get("TEMP_ID").toString();
					V_PO_DESC = hashMap.get("PO_DESC") == null ? "" : hashMap.get("PO_DESC").toString();
					V_DLVY_HOPE_DT = hashMap.get("DLVY_HOPE_DT") == null ? "" : hashMap.get("DLVY_HOPE_DT").toString().substring(0, 10);
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String V_HOPE_SL_CD = hashMap.get("HOPE_SL_CD") == null ? "" : hashMap.get("HOPE_SL_CD").toString();
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String V_M_BP_NM = hashMap.get("M_BP_NM") == null ? "" : hashMap.get("M_BP_NM").toString();
					String V_PO_TYPE = hashMap.get("PO_TYPE") == null ? "" : hashMap.get("PO_TYPE").toString();
					String V_PAY_METH = hashMap.get("PAY_METH") == null ? "" : hashMap.get("PAY_METH").toString();
					String V_IN_TERMS = hashMap.get("IN_TERMS") == null ? "" : hashMap.get("IN_TERMS").toString();
					String V_CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String V_XCH_RT = hashMap.get("XCH_RT") == null ? "" : hashMap.get("XCH_RT").toString();
					String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					String V_PRC = hashMap.get("PRC") == null ? "" : hashMap.get("PRC").toString();
					String V_AMT = hashMap.get("AMT") == null ? "" : hashMap.get("AMT").toString();
					String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String V_CHECK_YN = hashMap.get("CHECK_YN") == null ? "" : hashMap.get("CHECK_YN").toString();
					String V_ERROR_DESC = hashMap.get("ERROR_DESC") == null ? "" : hashMap.get("ERROR_DESC").toString();
					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String V_PO_CFM_YN = hashMap.get("PO_CFM_YN") == null ? "" : hashMap.get("PO_CFM_YN").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_SUPP_REMARK = hashMap.get("SUPP_REMARK") == null ? "" : hashMap.get("SUPP_REMARK").toString();

					// 					발주업로드 

					if (V_TYPE.equals("CFM")) {
						cs = conn.prepareCall("call USP_M_PO_UPLOAD_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_TEMP_ID);//V_TEMP_ID
						cs.setString(4, V_PO_DESC);//V_PO_DESC
						cs.setString(5, V_PO_DT);//V_PO_DT
						cs.setString(6, V_ITEM_CD);//V_ITEM_CD
						cs.setString(7, V_M_BP_CD);//V_M_BP_CD
						cs.setString(8, V_CUR);//V_CUR
						cs.setString(9, V_XCH_RT);//V_XCH_RT
						cs.setString(10, V_QTY);//V_QTY
						cs.setString(11, V_PRC);//V_PRC
						cs.setString(12, V_AMT);//V_AMT
						cs.setString(13, V_LOC_AMT);//V_LOC_AMT
						cs.setString(14, V_PO_TYPE);//V_PO_TYPE
						cs.setString(15, V_VAT_TYPE);//V_VAT_TYPE
						cs.setString(16, V_PAY_METH);//V_PAY_METH
						cs.setString(17, V_IN_TERMS);//V_IN_TERMS
						cs.setString(18, V_CHECK_YN);//V_CHECK_YN
						cs.setString(19, V_PO_NO);//V_PO_NO
						cs.setString(20, V_PO_SEQ);//V_PO_SEQ
						cs.setString(21, V_PO_CFM_YN);//V_PO_CFM_YN
						cs.setString(22, V_REMARK);//V_REMARK
						cs.setString(23, V_HOPE_SL_CD);//V_HOPE_SL_CD
						cs.setString(24, V_DLVY_HOPE_DT);//V_DLVY_HOPE_DT
						cs.setString(25, V_SUPP_REMARK);//V_SUPP_REMARK
						cs.setString(26, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}

					anySubObject = new JSONObject();
					anySubObject.put("V_TYPE", V_TYPE);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anySubObject.put("COMP_ID", V_COMP_ID);
					anySubObject.put("PO_DT", V_PO_DT);
					anySubObject.put("PO_DESC", V_PO_DESC);
					anySubObject.put("ITEM_CD", V_ITEM_CD);
					anySubObject.put("HOPE_SL_CD", V_HOPE_SL_CD);
					anySubObject.put("M_BP_CD", V_M_BP_CD);
					anySubObject.put("PO_TYPE", V_PO_TYPE);
					anySubObject.put("PAY_METH", V_PAY_METH);
					anySubObject.put("IN_TERMS", V_IN_TERMS);
					anySubObject.put("CUR", V_CUR);
					anySubObject.put("QTY", V_QTY);
					anySubObject.put("PRC", V_PRC);
					anySubObject.put("AMT", V_AMT);
					anySubObject.put("LOC_AMT", V_LOC_AMT);
					anySubObject.put("VAT_TYPE", V_VAT_TYPE);
					anySubObject.put("TEMP_ID", V_TEMP_ID);
					anySubObject.put("PO_NO", V_PO_NO);
					anySubObject.put("DLVY_HOPE_DT", V_DLVY_HOPE_DT);
					anySubObject.put("XCH_RT", V_XCH_RT);
					anySubObject.put("PO_SEQ", V_PO_SEQ);
					anySubObject.put("REMARK", V_REMARK);
					anySubObject.put("SUPP_REMARK", V_SUPP_REMARK);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anyArray.add(anySubObject);

					anySubObject1 = new JSONObject();
					anySubObject1.put("PO_NO", V_PO_NO);
					anyArray1.add(anySubObject1);
				}

			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_TEMP_ID = jsondata.get("TEMP_ID") == null ? "" : jsondata.get("TEMP_ID").toString();
				V_PO_DESC = jsondata.get("PO_DESC") == null ? "" : jsondata.get("PO_DESC").toString();
				V_DLVY_HOPE_DT = jsondata.get("DLVY_HOPE_DT") == null ? "" : jsondata.get("DLVY_HOPE_DT").toString().substring(0, 10);
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String V_HOPE_SL_CD = jsondata.get("HOPE_SL_CD") == null ? "" : jsondata.get("HOPE_SL_CD").toString();
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String V_M_BP_NM = jsondata.get("M_BP_NM") == null ? "" : jsondata.get("M_BP_NM").toString();
				String V_PO_TYPE = jsondata.get("PO_TYPE") == null ? "" : jsondata.get("PO_TYPE").toString();
				String V_PAY_METH = jsondata.get("PAY_METH") == null ? "" : jsondata.get("PAY_METH").toString();
				String V_IN_TERMS = jsondata.get("IN_TERMS") == null ? "" : jsondata.get("IN_TERMS").toString();
				String V_CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String V_XCH_RT = jsondata.get("XCH_RT") == null ? "" : jsondata.get("XCH_RT").toString();
				String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
				String V_PRC = jsondata.get("PRC") == null ? "" : jsondata.get("PRC").toString();
				String V_AMT = jsondata.get("AMT") == null ? "" : jsondata.get("AMT").toString();
				String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String V_CHECK_YN = jsondata.get("CHECK_YN") == null ? "" : jsondata.get("CHECK_YN").toString();
				String V_ERROR_DESC = jsondata.get("ERROR_DESC") == null ? "" : jsondata.get("ERROR_DESC").toString();
				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String V_PO_CFM_YN = jsondata.get("PO_CFM_YN") == null ? "" : jsondata.get("PO_CFM_YN").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_SUPP_REMARK = jsondata.get("SUPP_REMARK") == null ? "" : jsondata.get("SUPP_REMARK").toString();

				// 				System.out.println("V_TYPE" + V_TYPE);
				// 				System.out.println("V_TEMP_ID" + V_TEMP_ID);
				// 				System.out.println("V_PO_DESC" + V_PO_DESC);
				// 				System.out.println("V_PO_DT" + V_PO_DT);
				// 				System.out.println("V_M_BP_CD" + V_PO_DT);
				// 				System.out.println("V_DLVY_HOPE_DT" + V_DLVY_HOPE_DT);

				if (V_TYPE.equals("CFM")) {
					cs = conn.prepareCall("call USP_M_PO_UPLOAD_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_TEMP_ID);//V_TEMP_ID
					cs.setString(4, V_PO_DESC);//V_PO_DESC
					cs.setString(5, V_PO_DT);//V_PO_DT
					cs.setString(6, V_ITEM_CD);//V_ITEM_CD
					cs.setString(7, V_M_BP_CD);//V_M_BP_CD
					cs.setString(8, V_CUR);//V_CUR
					cs.setString(9, V_XCH_RT);//V_XCH_RT
					cs.setString(10, V_QTY);//V_QTY
					cs.setString(11, V_PRC);//V_PRC
					cs.setString(12, V_AMT);//V_AMT
					cs.setString(13, V_LOC_AMT);//V_LOC_AMT
					cs.setString(14, V_PO_TYPE);//V_PO_TYPE
					cs.setString(15, V_VAT_TYPE);//V_VAT_TYPE
					cs.setString(16, V_PAY_METH);//V_PAY_METH
					cs.setString(17, V_IN_TERMS);//V_IN_TERMS
					cs.setString(18, V_CHECK_YN);//V_CHECK_YN
					cs.setString(19, V_PO_NO);//V_PO_NO
					cs.setString(20, V_PO_SEQ);//V_PO_SEQ
					cs.setString(21, V_PO_CFM_YN);//V_PO_CFM_YN
					cs.setString(22, V_REMARK);//V_REMARK
					cs.setString(23, V_HOPE_SL_CD);//V_HOPE_SL_CD
					cs.setString(24, V_DLVY_HOPE_DT);//V_DLVY_HOPE_DT
					cs.setString(25, V_SUPP_REMARK);//V_SUPP_REMARK
					cs.setString(26, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}

				anySubObject = new JSONObject();
				anySubObject.put("V_TYPE", V_TYPE);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anySubObject.put("COMP_ID", V_COMP_ID);
				anySubObject.put("PO_DT", V_PO_DT);
				anySubObject.put("PO_DESC", V_PO_DESC);
				anySubObject.put("ITEM_CD", V_ITEM_CD);
				anySubObject.put("HOPE_SL_CD", V_HOPE_SL_CD);
				anySubObject.put("M_BP_CD", V_M_BP_CD);
				anySubObject.put("PO_TYPE", V_PO_TYPE);
				anySubObject.put("PAY_METH", V_PAY_METH);
				anySubObject.put("IN_TERMS", V_IN_TERMS);
				anySubObject.put("CUR", V_CUR);
				anySubObject.put("QTY", V_QTY);
				anySubObject.put("PRC", V_PRC);
				anySubObject.put("AMT", V_AMT);
				anySubObject.put("LOC_AMT", V_LOC_AMT);
				anySubObject.put("VAT_TYPE", V_VAT_TYPE);
				anySubObject.put("TEMP_ID", V_TEMP_ID);
				anySubObject.put("PO_NO", V_PO_NO);
				anySubObject.put("PO_SEQ", V_PO_SEQ);
				anySubObject.put("DLVY_HOPE_DT", V_DLVY_HOPE_DT);
				anySubObject.put("XCH_RT", V_XCH_RT);
				anySubObject.put("REMARK", V_REMARK);
				anySubObject.put("SUPP_REMARK", V_SUPP_REMARK);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anyArray.add(anySubObject);

				anySubObject1.put("PO_NO", V_PO_NO);
				anyArray1.add(anySubObject1);

			}

			URL url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_po_upload");
			URLConnection con = url1.openConnection();
			con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
			con.setDoOutput(true);

			anyObject.put("data", anyArray);
			String parameter = anyObject + "";
// 			System.out.println("ㅋㅋㅋ" + parameter );

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

			
			//발주확정일때만 실행
			if (V_TYPE2.equals("CFM")) {

				url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_po");
				// 				URL url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_po_test");
				con = url1.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

				anyObject1.put("data", anyArray1);
				parameter = anyObject1 + "";

// 				System.out.println(parameter);

				wr = new OutputStreamWriter(con.getOutputStream());
				wr.write(parameter);
				wr.flush();

				rd = null;

				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				line = null;
				result = null;
				while ((line = rd.readLine()) != null) {
					result = URLDecoder.decode(line, "UTF-8");
				}

				response.setContentType("text/plain; charset=UTF-8");
				pw = response.getWriter();
				pw.print(result);
				pw.flush();
				pw.close();
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



