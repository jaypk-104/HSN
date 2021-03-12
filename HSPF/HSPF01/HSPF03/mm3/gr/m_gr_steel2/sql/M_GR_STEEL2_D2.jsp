<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%-- <%@page import="net.sf.json.JSONObject"%> --%>
<%@page import="org.json.simple.JSONObject"%>
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
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").toUpperCase().substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").toUpperCase().substring(0, 10);
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
		String V_APPROV_NO = request.getParameter("V_APPROV_NO") == null ? "" : request.getParameter("V_APPROV_NO").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO").toUpperCase();
		String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO").toUpperCase();
		String V_GR_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").toUpperCase().substring(0, 10);
		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").toUpperCase().substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").toUpperCase().substring(0, 10);
		String V_M_BP_NM2 = request.getParameter("V_M_BP_NM2") == null ? "" : request.getParameter("V_M_BP_NM2").toUpperCase();

// 		System.out.println("V_TYPE : " + V_TYPE);
		
		if (V_TYPE.equals("SD2")) {
			
			cs = conn.prepareCall("call USP_001_M_GR_KOR_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_MVMT_NO);//V_MVMT_NO
			cs.setString(4, "");//V_MVMT_SEQ
			cs.setString(5, "");//V_FIRST_YN
			cs.setString(6, "");//V_IV_TYPE
			cs.setString(7, "");//V_MVMT_DT
			cs.setString(8, "");//V_M_BP_CD
			cs.setString(9, "");//V_GR_NO
			cs.setString(10, "");//V_GR_SEQ
			cs.setString(11, "");//V_CUR
			cs.setString(12, "");//V_XCHG_RT
			cs.setString(13, "");//V_FORWARD_XCH_RT
			cs.setString(14, "");//V_ITEM_GROUP_CD
			cs.setString(15, "");//V_QTY
			cs.setString(16, "");//V_DOC_AMT
			cs.setString(17, "");//V_LOC_AMT
			cs.setString(18, "");//V_PO_NO
			cs.setString(19, "");//V_PO_SEQ
			cs.setString(20, "");//V_FORWARD_XCH_AMT
			cs.setString(21, "");//V_BON_QTY
			cs.setString(22, "");//V_BON_WGT_QTY
			cs.setString(23, "");//V_DN_QTY
			cs.setString(24, "");//V_SL_CD
			cs.setString(25, "");//V_USR_ID
			cs.registerOutParameter(26, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(27, "");//
			cs.setString(28, "");//
			cs.setString(29, "");//
			cs.setString(30, "");//
			cs.setString(31, "");//
			cs.setString(32, "");//
			cs.setString(33, "");//
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(26);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("BON_QTY", rs.getString("BON_QTY"));
				subObject.put("BON_WGT_UNIT", rs.getString("BON_WGT_UNIT"));
				subObject.put("SPEC1", rs.getString("SPEC1"));
				subObject.put("SPEC2", rs.getString("SPEC2"));
				subObject.put("SPEC3", rs.getString("SPEC3"));
				subObject.put("LENGTH", rs.getString("LENGTH"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ST_TYPE", rs.getString("ST_TYPE"));
				subObject.put("ITEM_GROUP_CD", rs.getString("ITEM_GROUP_CD"));
				subObject.put("ST_TYPE_NM", rs.getString("ST_TYPE_NM"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("MVMT_SEQ", rs.getString("MVMT_SEQ"));
				subObject.put("PRICE", rs.getString("PRICE"));
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
		
		else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String MVMT_SEQ= hashMap.get("MVMT_SEQ") == null ? "" : hashMap.get("MVMT_SEQ").toString();
					String ITEM_GROUP_CD = hashMap.get("ITEM_GROUP_CD") == null ? "" : hashMap.get("ITEM_GROUP_CD").toString();
					String QTY= hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					String LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
					String BON_QTY= hashMap.get("BON_QTY") == null ? "" : hashMap.get("BON_QTY").toString();
					String BON_WGT_UNIT= hashMap.get("BON_WGT_UNIT") == null ? "" : hashMap.get("BON_WGT_UNIT").toString();
					String ST_TYPE_NM = hashMap.get("ST_TYPE_NM") == null ? "" : hashMap.get("ST_TYPE_NM").toString();
					String ST_TYPE = hashMap.get("ST_TYPE") == null ? "" : hashMap.get("ST_TYPE").toString();
					String SPEC1 = hashMap.get("SPEC1") == null ? "" : hashMap.get("SPEC1").toString();
					String SPEC2 = hashMap.get("SPEC2") == null ? "" : hashMap.get("SPEC2").toString();
					String SPEC3 = hashMap.get("SPEC3") == null ? "" : hashMap.get("SPEC3").toString();
					String LENGTH = hashMap.get("LENGTH") == null ? "" : hashMap.get("LENGTH").toString();

					cs = conn.prepareCall("call USP_001_M_GR_KOR_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, MVMT_NO);//V_MVMT_NO
					cs.setString(4, MVMT_SEQ);//V_MVMT_SEQ
					cs.setString(5, "");//V_FIRST_YN
					cs.setString(6, "");//V_IV_TYPE
					cs.setString(7, "");//V_MVMT_DT
					cs.setString(8, "");//V_M_BP_CD
					cs.setString(9, "");//V_GR_NO
					cs.setString(10, "");//V_GR_SEQ
					cs.setString(11, "");//V_CUR
					cs.setString(12, "");//V_XCHG_RT
					cs.setString(13, "");//V_FORWARD_XCH_RT
					cs.setString(14, ITEM_GROUP_CD);//V_ITEM_GROUP_CD
					cs.setString(15, QTY);//V_QTY
					cs.setString(16, LOC_AMT);//V_DOC_AMT
					cs.setString(17, LOC_AMT);//V_LOC_AMT
					cs.setString(18, "");//V_PO_NO
					cs.setString(19, "");//V_PO_SEQ
					cs.setString(20, "");//V_FORWARD_XCH_AMT
					cs.setString(21, BON_QTY);//V_BON_QTY
					cs.setString(22, BON_WGT_UNIT);//V_BON_WGT_QTY
					cs.setString(23, "");//V_DN_QTY
					cs.setString(24, "");//V_SL_CD
					cs.setString(25, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(26, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(27, ST_TYPE_NM);//ST_TYPE_NM
					cs.setString(28, ST_TYPE);//ST_TYPE
					cs.setString(29, SPEC1);//SPEC1
					cs.setString(30, SPEC2);//SPEC2
					cs.setString(31, SPEC3);//SPEC3
					cs.setString(32, LENGTH);//LENGTH
					cs.setString(33, "");//
					cs.executeQuery();
					

// 					response.setContentType("text/plain; charset=UTF-8");
// 					PrintWriter pw = response.getWriter();
// 					pw.print("success");
// 					pw.flush();
// 					pw.close();

				}
			} else {

// 				JSONObject jsondata = JSONObject.fromObject(jsonData);
				//큰수에 소수점이 있는경우 숫자계산이 이상해서 수정함. 20200108 김장운

				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);					
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String MVMT_SEQ= jsondata.get("MVMT_SEQ") == null ? "" : jsondata.get("MVMT_SEQ").toString();
				String ITEM_GROUP_CD = jsondata.get("ITEM_GROUP_CD") == null ? "" : jsondata.get("ITEM_GROUP_CD").toString();
				String QTY= jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
				String LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
				String BON_QTY= jsondata.get("BON_QTY") == null ? "" : jsondata.get("BON_QTY").toString();
				String BON_WGT_UNIT= jsondata.get("BON_WGT_UNIT") == null ? "" : jsondata.get("BON_WGT_UNIT").toString();
				String ST_TYPE_NM = jsondata.get("ST_TYPE_NM") == null ? "" : jsondata.get("ST_TYPE_NM").toString();
				String ST_TYPE = jsondata.get("ST_TYPE") == null ? "" : jsondata.get("ST_TYPE").toString();
				String SPEC1 = jsondata.get("SPEC1") == null ? "" : jsondata.get("SPEC1").toString();
				String SPEC2 = jsondata.get("SPEC2") == null ? "" : jsondata.get("SPEC2").toString();
				String SPEC3 = jsondata.get("SPEC3") == null ? "" : jsondata.get("SPEC3").toString();
				String LENGTH = jsondata.get("LENGTH") == null ? "" : jsondata.get("LENGTH").toString();
				
				cs = conn.prepareCall("call USP_001_M_GR_KOR_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, MVMT_NO);//V_MVMT_NO
				cs.setString(4, MVMT_SEQ);//V_MVMT_SEQ
				cs.setString(5, "");//V_FIRST_YN
				cs.setString(6, "");//V_IV_TYPE
				cs.setString(7, "");//V_MVMT_DT
				cs.setString(8, "");//V_M_BP_CD
				cs.setString(9, "");//V_GR_NO
				cs.setString(10, "");//V_GR_SEQ
				cs.setString(11, "");//V_CUR
				cs.setString(12, "");//V_XCHG_RT
				cs.setString(13, "");//V_FORWARD_XCH_RT
				cs.setString(14, ITEM_GROUP_CD);//V_ITEM_GROUP_CD
				cs.setString(15, QTY);//V_QTY
				cs.setString(16, LOC_AMT);//V_DOC_AMT
				cs.setString(17, LOC_AMT);//V_LOC_AMT
				cs.setString(18, "");//V_PO_NO
				cs.setString(19, "");//V_PO_SEQ
				cs.setString(20, "");//V_FORWARD_XCH_AMT
				cs.setString(21, BON_QTY);//V_BON_QTY
				cs.setString(22, BON_WGT_UNIT);//V_BON_WGT_QTY
				cs.setString(23, "");//V_DN_QTY
				cs.setString(24, "");//V_SL_CD
				cs.setString(25, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(26, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(27, ST_TYPE_NM);//ST_TYPE_NM
				cs.setString(28, ST_TYPE);//ST_TYPE
				cs.setString(29, SPEC1);//SPEC1
				cs.setString(30, SPEC2);//SPEC2
				cs.setString(31, SPEC3);//SPEC3
				cs.setString(32, LENGTH);//LENGTH
				cs.setString(33, "");//
				cs.executeQuery();
				

// 				response.setContentType("text/plain; charset=UTF-8");
// 				PrintWriter pw = response.getWriter();
// 				pw.print("success");
// 				pw.flush();
// 				pw.close();

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


