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
		String V_DLVY_DT_FR = request.getParameter("V_DLVY_DT_FR") == null ? "" : request.getParameter("V_DLVY_DT_FR").substring(0, 10);
		String V_DLVY_DT_TO = request.getParameter("V_DLVY_DT_TO") == null ? "" : request.getParameter("V_DLVY_DT_TO").substring(0, 10);
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_PO_SEQ = request.getParameter("V_PO_SEQ") == null ? "" : request.getParameter("V_PO_SEQ").toUpperCase();
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0, 10);
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_DLVY_AVL_DT = request.getParameter("V_DLVY_AVL_DT") == null ? "" : request.getParameter("V_DLVY_AVL_DT").substring(0, 10);
		String V_DLVY_AVL_QTY = request.getParameter("V_DLVY_AVL_QTY") == null ? "" : request.getParameter("V_DLVY_AVL_QTY").substring(0, 10);
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();

		String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
		String V_ASN_NO_TF = request.getParameter("V_ASN_NO_TF") == null ? "" : request.getParameter("V_ASN_NO_TF").toUpperCase();
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();

		//납기현황조회[상단HEADER 조회]
		if (V_TYPE.equals("HS")) {
			cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DLVY_DT_FR);//V_DLVY_DT_FR
			cs.setString(4, V_DLVY_DT_TO);//V_DLVY_DT_TO
			cs.setString(5, V_PO_NO);//V_PO_NO
			cs.setString(6, V_PO_SEQ);//V_PO_SEQ
			cs.setString(7, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(8, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(9, V_BP_CD);//V_BP_CD
			cs.setString(10, V_ASN_NO_TF);//V_ASN_NO ( 검색조건 )
			cs.setString(11, V_DLVY_AVL_DT);//V_DLVY_AVL_DT
			cs.setString(12, V_DLVY_AVL_QTY);//V_DLVY_AVL_QTY
			cs.setString(13, V_ITEM_CD);//V_ITEM_CD
			cs.setString(14, V_ITEM_NM);//V_ITEM_NM
			cs.setString(15, V_M_BP_CD);//V_M_BP_CD
			cs.setString(16, V_M_BP_NM);//V_M_BP_NM
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.setString(18, V_BL_NO);//V_BL_NO
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(20, "");//
			cs.setString(21, "");//
			cs.setString(22, "");//
			cs.setString(23, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("BAR_CD_CNT", rs.getString("BAR_CD_CNT"));
				subObject.put("ASN_NO_QTY", rs.getString("ASN_NO_QTY"));
				subObject.put("DLVY_AVL_QTY", rs.getString("DLVY_AVL_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("ASN_STS", rs.getString("ASN_STS"));
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("SUPP_REMARK", rs.getString("SUPP_REMARK"));
				subObject.put("BL_DOC_NO", rs.getString("BL_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("BL_NO2", rs.getString("BL_NO2"));
				subObject.put("BL_SEQ2", rs.getString("BL_SEQ2"));
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("CC_SEQ", rs.getString("CC_SEQ"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
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

		}

		//납기현황조회[하단DETAIL 조회]
		else if (V_TYPE.equals("DS")) {
			cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DLVY_DT_FR);//V_DLVY_DT_FR
			cs.setString(4, V_DLVY_DT_TO);//V_DLVY_DT_TO
			cs.setString(5, V_PO_NO);//V_PO_NO
			cs.setString(6, V_PO_SEQ);//V_PO_SEQ
			cs.setString(7, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(8, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(9, V_BP_CD);//V_BP_CD
			cs.setString(10, V_ASN_NO);//V_ASN_NO
			cs.setString(11, V_DLVY_AVL_DT);//V_DLVY_AVL_DT
			cs.setString(12, V_DLVY_AVL_QTY);//V_DLVY_AVL_QTY
			cs.setString(13, V_ITEM_CD);//V_ITEM_CD
			cs.setString(14, V_ITEM_NM);//V_ITEM_NM
			cs.setString(15, V_M_BP_CD);//V_M_BP_CD
			cs.setString(16, V_M_BP_NM);//V_M_BP_NM
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.setString(18, "");//V_BL_NO
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(20, "");//
			cs.setString(21, "");//
			cs.setString(22, "");//
			cs.setString(23, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(19);

			while (rs.next()) {
				subObject = new JSONObject();

				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("ASN_STS", rs.getString("ASN_STS"));
				subObject.put("ASN_STS_NM", rs.getString("ASN_STS_NM"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("DLVY_REQ_DT", rs.getString("DLVY_REQ_DT"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("DLVY_AVL_QTY", rs.getString("DLVY_AVL_QTY"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
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

		}
		//납기현황조회[상단HEADER - I(저장)]
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
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					V_DLVY_AVL_DT = hashMap.get("DLVY_AVL_DT") == null ? "" : hashMap.get("DLVY_AVL_DT").toString().substring(0, 10);
					V_DLVY_AVL_QTY = hashMap.get("DLVY_AVL_QTY") == null ? "" : hashMap.get("DLVY_AVL_QTY").toString();
					V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
					V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
					
					String CC_NO = hashMap.get("CC_NO") == null ? "" : hashMap.get("CC_NO").toString();
					String CC_SEQ = hashMap.get("CC_SEQ") == null ? "" : hashMap.get("CC_SEQ").toString();
					String BL_NO2 = hashMap.get("BL_NO2") == null ? "" : hashMap.get("BL_NO2").toString();
					String BL_SEQ2 = hashMap.get("BL_SEQ2") == null ? "" : hashMap.get("BL_SEQ2").toString();

					//ASN번호 채번
					if (i == 0) {
						cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_H_AUTONUM(?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(3);
						while (rs.next()) {
							V_ASN_NO = rs.getString("ASN_NO");
						}
					}
					cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_DLVY_DT_FR);//V_DLVY_DT_FR
					cs.setString(4, V_DLVY_DT_TO);//V_DLVY_DT_TO
					cs.setString(5, V_PO_NO);//V_PO_NO
					cs.setString(6, V_PO_SEQ);//V_PO_SEQ
					cs.setString(7, V_PO_DT_FR);//V_PO_DT_FR
					cs.setString(8, V_PO_DT_TO);//V_PO_DT_TO
					cs.setString(9, V_BP_CD);//V_BP_CD
					cs.setString(10, V_ASN_NO);//V_ASN_NO
					cs.setString(11, V_DLVY_AVL_DT);//V_DLVY_AVL_DT
					cs.setString(12, V_DLVY_AVL_QTY);//V_DLVY_AVL_QTY
					cs.setString(13, V_ITEM_CD);//V_ITEM_CD
					cs.setString(14, V_ITEM_NM);//V_ITEM_NM
					cs.setString(15, V_M_BP_CD);//V_M_BP_CD
					cs.setString(16, V_M_BP_NM);//V_M_BP_NM
					cs.setString(17, V_USR_ID);//V_USR_ID
					cs.setString(18, "");//V_BL_NO
					cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(20, CC_NO);//
					cs.setString(21, CC_SEQ);//
					cs.setString(22, BL_NO2);//
					cs.setString(23, BL_SEQ2);//
					cs.executeQuery();


				}

			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				V_DLVY_AVL_DT = jsondata.get("DLVY_AVL_DT") == null ? "" : jsondata.get("DLVY_AVL_DT").toString().substring(0, 10);
				V_DLVY_AVL_QTY = jsondata.get("DLVY_AVL_QTY") == null ? "" : jsondata.get("DLVY_AVL_QTY").toString();
				V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
				V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
				String CC_NO = jsondata.get("CC_NO") == null ? "" : jsondata.get("CC_NO").toString();
				String CC_SEQ = jsondata.get("CC_SEQ") == null ? "" : jsondata.get("CC_SEQ").toString();
				String BL_NO2 = jsondata.get("BL_NO2") == null ? "" : jsondata.get("BL_NO2").toString();
				String BL_SEQ2 = jsondata.get("BL_SEQ2") == null ? "" : jsondata.get("BL_SEQ2").toString();

				cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_H_AUTONUM(?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(3);
				while (rs.next()) {
					V_ASN_NO = rs.getString("ASN_NO");
				}

				cs = conn.prepareCall("call USP_SCM_DLVY_HSPF_H(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_DLVY_DT_FR);//V_DLVY_DT_FR
				cs.setString(4, V_DLVY_DT_TO);//V_DLVY_DT_TO
				cs.setString(5, V_PO_NO);//V_PO_NO
				cs.setString(6, V_PO_SEQ);//V_PO_SEQ
				cs.setString(7, V_PO_DT_FR);//V_PO_DT_FR
				cs.setString(8, V_PO_DT_TO);//V_PO_DT_TO
				cs.setString(9, V_BP_CD);//V_BP_CD
				cs.setString(10, V_ASN_NO);//V_ASN_NO
				cs.setString(11, V_DLVY_AVL_DT);//V_DLVY_AVL_DT
				cs.setString(12, V_DLVY_AVL_QTY);//V_DLVY_AVL_QTY
				cs.setString(13, V_ITEM_CD);//V_ITEM_CD
				cs.setString(14, V_ITEM_NM);//V_ITEM_NM
				cs.setString(15, V_M_BP_CD);//V_M_BP_CD
				cs.setString(16, V_M_BP_NM);//V_M_BP_NM
				cs.setString(17, V_USR_ID);//V_USR_ID
				cs.setString(18, "");//V_BL_NO
				cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(20, CC_NO);//
				cs.setString(21, CC_SEQ);//
				cs.setString(22, BL_NO2);//
				cs.setString(23, BL_SEQ2);//
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


