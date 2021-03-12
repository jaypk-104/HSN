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
	JSONArray anyArray = new JSONArray();
	JSONObject anySubObject = new JSONObject();

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_DN_NO = request.getParameter("V_DN_NO") == null ? "" : request.getParameter("V_DN_NO");
		String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").substring(0, 10);
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD");
		String V_DN_USR_ID = request.getParameter("V_DN_USR") == null ? "" : request.getParameter("V_DN_USR");
		String V_CUST_ORDER_NO = request.getParameter("V_CUST_ORDER_NO") == null ? "" : request.getParameter("V_CUST_ORDER_NO");
		String V_FROM_SL_CD = request.getParameter("V_FROM_SL_CD") == null ? "" : request.getParameter("V_FROM_SL_CD");
		if (V_FROM_SL_CD.equals("T")) {
			V_FROM_SL_CD = "";
		}
		String V_TO_SL_CD = request.getParameter("V_TO_SL_CD") == null ? "" : request.getParameter("V_TO_SL_CD");
		if (V_TO_SL_CD.equals("T")) {
			V_TO_SL_CD = "";
		}
		String V_CHECK = request.getParameter("V_CHECK") == null ? "" : request.getParameter("V_CHECK");


		/*조회*/
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_S_DN_TO_SRM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_S_BP_CD);//V_S_BP_CD
			cs.setString(3, V_DN_NO);//V_DN_NO
			cs.setString(4, V_DN_DT);//V_DN_DT
			cs.setString(5, V_DN_USR_ID);//V_DN_USR_ID
			cs.setString(6, "");//V_CUST_ORDER_NO = V_MAT_DLV_NO 새로 채번한...
			cs.setString(7, "");//V_DD_NO
			cs.setString(8, "");//V_DD_SEQ
			cs.setString(9, V_FROM_SL_CD);//V_FROM_SL_CD
			cs.setString(10, V_TO_SL_CD);//V_TO_SL_CD
			cs.setString(11, V_CHECK);//V_CHECK
			cs.setString(12, V_COMP_ID);//V_CHECK
			cs.setString(13, V_USR_ID);//V_CHECK
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(14);
			
			while (rs.next()) {

				subObject = new JSONObject();
				subObject.put("CUST_ORDER_NO", rs.getString("CUST_ORDER_NO"));
				subObject.put("MAT_IF_DLV_NO", rs.getString("MAT_IF_DLV_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("IF_YN", rs.getString("IF_YN"));
				subObject.put("DD_NO", rs.getString("DD_NO"));
				subObject.put("HSCOMP", rs.getString("HSCOMP"));
				subObject.put("PLANTC", rs.getString("PLANTC"));
				subObject.put("SUPP_CD", rs.getString("SUPP_CD"));
				subObject.put("SUPP_NM", rs.getString("SUPP_NM"));
				subObject.put("DLV_CD", rs.getString("DLV_CD"));
				subObject.put("DNV_NM", rs.getString("DNV_NM"));
				subObject.put("CURS", rs.getString("CURS"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_USR_ID", rs.getString("PO_USR_ID"));
				subObject.put("LINE_NO", rs.getString("LINE_NO"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("S_PRICE", rs.getString("S_PRICE"));
				subObject.put("DLV_DT", rs.getString("DLV_DT"));
				subObject.put("REQ_PO_USR_ID", rs.getString("REQ_PO_USR_ID"));
				subObject.put("IV_TORY", rs.getString("IV_TORY"));
				subObject.put("FROM_SL_CD", rs.getString("FROM_SL_CD"));
				subObject.put("FROM_SL_NM", rs.getString("FROM_SL_NM"));
				subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("TO_SL_NM", rs.getString("TO_SL_NM"));
				subObject.put("Y_DEPT", rs.getString("Y_DEPT"));
				subObject.put("B_DEPT", rs.getString("B_DEPT"));
				subObject.put("Y_ACCNT", rs.getString("Y_ACCNT"));
				subObject.put("GRP_ID", rs.getString("GRP_ID"));
				subObject.put("EROR_CD", rs.getString("EROR_CD"));

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

		} else if (V_TYPE.equals("DN_REQ_IF")) {

			URL url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_if_dn_req");
			URLConnection con = url1.openConnection();
			con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
			con.setDoOutput(true);

			anySubObject.put("V_USR_ID", V_USR_ID);
			anyArray.add(anySubObject);
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
			// 			System.out.println(result);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(result);
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
					// 					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					// 					V_DR_NO = hashMap.get("DR_NO") == null ? "" : hashMap.get("DR_NO").toString();
					// 					String V_DR_SEQ = hashMap.get("DR_SEQ") == null ? "" : hashMap.get("DR_SEQ").toString();
					// 					String V_DR_QTY = hashMap.get("DR_QTY") == null ? "" : hashMap.get("DR_QTY").toString();
					// 					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					// 					String V_TO_SL_CD = hashMap.get("TO_SL_CD") == null ? "" : hashMap.get("TO_SL_CD").toString();
					// 					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();

					cs = conn.prepareCall("call USP_S_DN_TO_SRM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_S_BP_CD);//V_S_BP_CD
					cs.setString(3, V_DN_NO);//V_DN_NO
					cs.setString(4, V_DN_DT);//V_DN_DT
					cs.setString(5, V_DN_USR_ID);//V_DN_USR_ID
					cs.setString(6, "");//V_CUST_ORDER_NO = V_MAT_DLV_NO 새로 채번한...
					cs.setString(7, "");//V_DD_NO
					cs.setString(8, "");//V_DD_SEQ
					cs.setString(9, V_FROM_SL_CD);//V_FROM_SL_CD
					cs.setString(10, V_TO_SL_CD);//V_TO_SL_CD
					cs.setString(11, V_CHECK);//V_CHECK
					cs.setString(12, V_COMP_ID);//V_CHECK
					cs.setString(13, V_USR_ID);//V_CHECK
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				// 				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				// 				V_DR_NO = jsondata.get("DR_NO") == null ? "" : jsondata.get("DR_NO").toString();
				// 				String V_DR_SEQ = jsondata.get("DR_SEQ") == null ? "" : jsondata.get("DR_SEQ").toString();
				// 				String V_DR_QTY = jsondata.get("DR_QTY") == null ? "" : jsondata.get("DR_QTY").toString();
				// 				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				// 				String V_TO_SL_CD = jsondata.get("TO_SL_CD") == null ? "" : jsondata.get("TO_SL_CD").toString();
				// 				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();

				// 				System.out.println("V_TYPE : " + V_TYPE);
				// 				System.out.println("V_DR_NO : " + V_DR_NO);
				// 				System.out.println("V_DR_SEQ : " + V_DR_SEQ);
				// 				System.out.println("V_DR_QTY : " + V_DR_QTY);
				// 				System.out.println("V_S_BP_CD : " + V_S_BP_CD);
				// 				System.out.println("V_TO_SL_CD : " + V_TO_SL_CD);
				// 				System.out.println("V_ITEM_CD : " + V_ITEM_CD);

				cs = conn.prepareCall("call USP_S_DN_TO_SRM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_S_BP_CD);//V_S_BP_CD
				cs.setString(3, V_DN_NO);//V_DN_NO
				cs.setString(4, V_DN_DT);//V_DN_DT
				cs.setString(5, V_DN_USR_ID);//V_DN_USR_ID
				cs.setString(6, "");//V_CUST_ORDER_NO = V_MAT_DLV_NO 새로 채번한...
				cs.setString(7, "");//V_DD_NO
				cs.setString(8, "");//V_DD_SEQ
				cs.setString(9, V_FROM_SL_CD);//V_FROM_SL_CD
				cs.setString(10, V_TO_SL_CD);//V_TO_SL_CD
				cs.setString(11, V_CHECK);//V_CHECK
				cs.setString(12, V_COMP_ID);//V_CHECK
				cs.setString(13, V_USR_ID);//V_CHECK
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();


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




