<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "^" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "^" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		//조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_B_ITEM_SUPP_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_ITEM_CD);//V_ITEM_CD
			cs.setString(4, V_ITEM_NM);//V_ITEM_NM
			cs.setString(5, "");//V_BP_CD
			cs.setString(6, V_M_BP_NM);//V_M_BP_NM
			cs.setString(7, "");//V_VALID_DT
			cs.setString(8, "");//V_M_PRICE
			cs.setString(9, "");//V_M_PRICE
			cs.setString(10, "");//V_M_PRICE
			cs.setString(11, "");//V_M_PRICE
			cs.setString(12, "");//V_M_PRICE
			cs.setString(13, "");//V_M_PRICE
			cs.setString(14, "");//V_USR_ID
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(15);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));
				subObject.put("M_PRICE", rs.getString("M_PRICE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("CUR_NM", rs.getString("CUR_NM"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			//아이템수정
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
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String V_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString();
					String V_BP_NM = hashMap.get("BP_NM") == null ? "" : hashMap.get("BP_NM").toString();
					String V_VALID_DT = hashMap.get("VALID_DT") == null ? "" : hashMap.get("VALID_DT").toString().substring(0, 10);
					String V_M_PRICE = hashMap.get("M_PRICE") == null ? "" : hashMap.get("M_PRICE").toString();
					String V_PO_TYPE = hashMap.get("PO_TYPE") == null ? "" : hashMap.get("PO_TYPE").toString();
					String V_PAY_METH = hashMap.get("PAY_METH") == null ? "" : hashMap.get("PAY_METH").toString();
					String V_IN_TERMS = hashMap.get("IN_TERMS") == null ? "" : hashMap.get("IN_TERMS").toString();
					String V_CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String V_VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();

					// 					System.out.println("V_TYPE"  + V_TYPE);
					// 					System.out.println("V_ITEM_CD"  + V_ITEM_CD);
					// 					System.out.println("V_ITEM_NM"  + V_ITEM_NM);
					// 					System.out.println("V_BP_CD"  + V_BP_CD);
					// 					System.out.println("V_BP_NM"  + V_BP_NM);
					// 					System.out.println("V_VALID_DT"  + V_VALID_DT);
					// 					System.out.println("V_IN_SL_CD"  + V_IN_SL_CD);
					// 					System.out.println("V_M_PRICE"  + V_M_PRICE);

					cs = conn.prepareCall("call USP_B_ITEM_SUPP_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
					cs.setString(4, V_ITEM_NM);//V_ITEM_NM
					cs.setString(5, V_BP_CD);//V_BP_CD
					cs.setString(6, V_M_BP_NM);//V_M_BP_NM
					cs.setString(7, V_VALID_DT);//V_VALID_DT
					cs.setString(8, V_M_PRICE);//V_M_PRICE
					cs.setString(9, V_PO_TYPE);//V_PO_TYPE
					cs.setString(10, V_PAY_METH);//V_PAY_METH
					cs.setString(11, V_IN_TERMS);//V_IN_TERMS
					cs.setString(12, V_CUR);//V_CUR
					cs.setString(13, V_VAT_TYPE);//V_VAT_TYPE
					cs.setString(14, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String V_BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
				String V_VALID_DT = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString().substring(0, 10);
				String V_M_PRICE = jsondata.get("M_PRICE") == null ? "" : jsondata.get("M_PRICE").toString();
				String V_PO_TYPE = jsondata.get("PO_TYPE") == null ? "" : jsondata.get("PO_TYPE").toString();
				String V_PAY_METH = jsondata.get("PAY_METH") == null ? "" : jsondata.get("PAY_METH").toString();
				String V_IN_TERMS = jsondata.get("IN_TERMS") == null ? "" : jsondata.get("IN_TERMS").toString();
				String V_CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String V_VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();

				cs = conn.prepareCall("call USP_B_ITEM_SUPP_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
				cs.setString(4, V_ITEM_NM);//V_ITEM_NM
				cs.setString(5, V_BP_CD);//V_BP_CD
				cs.setString(6, V_M_BP_NM);//V_M_BP_NM
				cs.setString(7, V_VALID_DT);//V_VALID_DT
				cs.setString(8, V_M_PRICE);//V_M_PRICE
				cs.setString(9, V_PO_TYPE);//V_PO_TYPE
				cs.setString(10, V_PAY_METH);//V_PAY_METH
				cs.setString(11, V_IN_TERMS);//V_IN_TERMS
				cs.setString(12, V_CUR);//V_CUR
				cs.setString(13, V_VAT_TYPE);//V_VAT_TYPE
				cs.setString(14, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
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



