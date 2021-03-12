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
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "^" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "^" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_SPEC = request.getParameter("V_SPEC") == null ? "" : request.getParameter("V_SPEC").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_GUBUN = "";
		//조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_B_ITEM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
			cs.setString(4, "");//V_ITEM_GROUP_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.setString(6, V_SPEC);//V_SPEC
			cs.setString(7, "");//V_MAKER
			cs.setString(8, "");//V_UNIT
			cs.setString(9, "");//V_SAFE_QTY
			cs.setString(10, "");//V_MIN_PO_QTY
			cs.setString(11, "");//V_SUPP_LT_DT
			cs.setString(12, "");//V_HS_CD
			cs.setString(13, "");//V_IN_SL_CD
			cs.setString(14, "");//V_BAR_MAKE_UNIT
			cs.setString(15, "");//V_MAX_PACK_QTY
			cs.setString(16, "");//V_MAX_PACK_UNIT
			cs.setString(17, "");//V_MID_PACK_QTY
			cs.setString(18, "");//V_MID_PACK_UNIT
			cs.setString(19, "");//V_MIN_PACK_QTY
			cs.setString(20, "");//V_MIN_PACK_UNIT
			cs.setString(21, "");//V_USR_ID
			cs.setString(22, "");//V_REMARK
			cs.registerOutParameter(23, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(23);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ITEM_GROUP_CD", rs.getString("ITEM_GROUP_CD"));
				subObject.put("ITEM_GROUP_NM", rs.getString("ITEM_GROUP_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("MIN_PO_QTY", rs.getString("MIN_PO_QTY"));
				subObject.put("SAFE_QTY", rs.getString("SAFE_QTY"));
				subObject.put("MAX_PACK_QTY", rs.getString("MAX_PACK_QTY"));
				subObject.put("MID_PACK_QTY", rs.getString("MID_PACK_QTY"));
				subObject.put("MIN_PACK_QTY", rs.getString("MIN_PACK_QTY"));
				subObject.put("MAX_PACK_UNIT", rs.getString("MAX_PACK_UNIT"));
				subObject.put("MID_PACK_UNIT", rs.getString("MID_PACK_UNIT"));
				subObject.put("MIN_PACK_UNIT", rs.getString("MIN_PACK_UNIT"));
				subObject.put("SUPP_LT_DT", rs.getString("SUPP_LT_DT"));
				subObject.put("HS_CD", rs.getString("HS_CD"));
				subObject.put("MAKER", rs.getString("MAKER"));
				subObject.put("IN_SL_CD", rs.getString("IN_SL_CD"));
				subObject.put("BAR_MAKE_UNIT", rs.getString("BAR_MAKE_UNIT"));
				subObject.put("REMARK", rs.getString("REMARK"));
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
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString().toUpperCase();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString().toUpperCase();
					String V_ITEM_GROUP_CD = hashMap.get("ITEM_GROUP_CD") == null ? "" : hashMap.get("ITEM_GROUP_CD").toString().toUpperCase();
					V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString().toUpperCase();
					V_SPEC = hashMap.get("SPEC") == null ? "" : hashMap.get("SPEC").toString().toUpperCase();
					String V_UNIT = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString().toUpperCase();
					String V_MIN_PO_QTY = hashMap.get("MIN_PO_QTY") == null ? "" : hashMap.get("MIN_PO_QTY").toString().toUpperCase();
					String V_SAFE_QTY = hashMap.get("SAFE_QTY") == null ? "" : hashMap.get("SAFE_QTY").toString().toUpperCase();
					String V_MAX_PACK_QTY = hashMap.get("MAX_PACK_QTY") == null ? "" : hashMap.get("MAX_PACK_QTY").toString().toUpperCase();
					String V_MAX_PACK_UNIT = hashMap.get("MAX_PACK_UNIT") == null ? "" : hashMap.get("MAX_PACK_UNIT").toString().toUpperCase();
					String V_MID_PACK_QTY = hashMap.get("MID_PACK_QTY") == null ? "" : hashMap.get("MID_PACK_QTY").toString().toUpperCase();
					String V_MID_PACK_UNIT = hashMap.get("MID_PACK_UNIT") == null ? "" : hashMap.get("MID_PACK_UNIT").toString().toUpperCase();
					String V_MIN_PACK_QTY = hashMap.get("MIN_PACK_QTY") == null ? "" : hashMap.get("MIN_PACK_QTY").toString().toUpperCase();
					String V_MIN_PACK_UNIT = hashMap.get("MIN_PACK_UNIT") == null ? "" : hashMap.get("MIN_PACK_UNIT").toString().toUpperCase();
					String V_SUPP_LT_DT = hashMap.get("SUPP_LT_DT") == null ? "" : hashMap.get("SUPP_LT_DT").toString().toUpperCase();
					String V_HS_CD = hashMap.get("HS_CD") == null ? "" : hashMap.get("HS_CD").toString().toUpperCase();
					String V_MAKER = hashMap.get("MAKER") == null ? "" : hashMap.get("MAKER").toString().toUpperCase();
					String V_IN_SL_CD = hashMap.get("IN_SL_CD") == null ? "" : hashMap.get("IN_SL_CD").toString().toUpperCase();
					String V_BAR_MAKE_UNIT = hashMap.get("BAR_MAKE_UNIT") == null ? "" : hashMap.get("BAR_MAKE_UNIT").toString().toUpperCase();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();

					if (V_TYPE.equals("I") || V_TYPE.equals("U") || V_TYPE.equals("D")) {
						if (V_TYPE.equals("I")) {
							V_GUBUN = "C";
						} else if (V_TYPE.equals("U")) {
							V_GUBUN = "U";
						} else if (V_TYPE.equals("D")) {
							V_GUBUN = "D";
						}
						anySubObject = new JSONObject();
						anySubObject.put("GUBUN", V_GUBUN);
						anySubObject.put("ITEM_CD", V_ITEM_CD.trim());
						anySubObject.put("ITEM_GROUP_CD", V_ITEM_GROUP_CD);
						anySubObject.put("ITEM_NM", V_ITEM_NM);
						anySubObject.put("SPEC", V_SPEC);
						anySubObject.put("UNIT", V_UNIT);
						anySubObject.put("MIN_PO_QTY", V_MIN_PO_QTY);
						anySubObject.put("SAFE_QTY", V_SAFE_QTY);
						anySubObject.put("MAX_PACK_QTY", V_MAX_PACK_QTY);
						anySubObject.put("MAX_PACK_UNIT", V_MAX_PACK_UNIT);
						anySubObject.put("MID_PACK_QTY", V_MID_PACK_QTY);
						anySubObject.put("MID_PACK_UNIT", V_MID_PACK_UNIT);
						anySubObject.put("MIN_PACK_QTY", V_MIN_PACK_QTY);
						anySubObject.put("MIN_PACK_UNIT", V_MIN_PACK_UNIT);
						anySubObject.put("SUPP_LT_DT", V_SUPP_LT_DT);
						anySubObject.put("MAKER", V_MAKER);
						anySubObject.put("V_USR_ID", V_USR_ID);
						anyArray.add(anySubObject);
					}

					cs = conn.prepareCall("call USP_B_ITEM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
					cs.setString(4, V_ITEM_GROUP_CD);//V_ITEM_GROUP_CD
					cs.setString(5, V_ITEM_NM);//V_ITEM_NM
					cs.setString(6, V_SPEC);//V_SPEC
					cs.setString(7, V_MAKER);//V_MAKER
					cs.setString(8, V_UNIT);//V_UNIT
					cs.setString(9, V_SAFE_QTY);//V_SAFE_QTY
					cs.setString(10, V_MIN_PO_QTY);//V_MIN_PO_QTY
					cs.setString(11, V_SUPP_LT_DT);//V_SUPP_LT_DT
					cs.setString(12, V_HS_CD);//V_HS_CD
					cs.setString(13, V_IN_SL_CD);//V_IN_SL_CD
					cs.setString(14, V_BAR_MAKE_UNIT);//V_BAR_MAKE_UNIT
					cs.setString(15, V_MAX_PACK_QTY);//V_MAX_PACK_QTY
					cs.setString(16, V_MAX_PACK_UNIT);//V_MAX_PACK_UNIT
					cs.setString(17, V_MID_PACK_QTY);//V_MID_PACK_QTY
					cs.setString(18, V_MID_PACK_UNIT);//V_MID_PACK_UNIT
					cs.setString(19, V_MIN_PACK_QTY);//V_MIN_PACK_QTY
					cs.setString(20, V_MIN_PACK_UNIT);//V_MIN_PACK_UNIT
					cs.setString(21, V_USR_ID);//V_USR_ID
					cs.setString(22, V_REMARK);//V_REMARK
					cs.registerOutParameter(23, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString().toUpperCase();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString().toUpperCase();
				String V_ITEM_GROUP_CD = jsondata.get("ITEM_GROUP_CD") == null ? "" : jsondata.get("ITEM_GROUP_CD").toString().toUpperCase();
				V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString().toUpperCase();
				V_SPEC = jsondata.get("SPEC") == null ? "" : jsondata.get("SPEC").toString().toUpperCase();
				String V_UNIT = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString().toUpperCase();
				String V_MIN_PO_QTY = jsondata.get("MIN_PO_QTY") == null ? "" : jsondata.get("MIN_PO_QTY").toString().toUpperCase();
				String V_SAFE_QTY = jsondata.get("SAFE_QTY") == null ? "" : jsondata.get("SAFE_QTY").toString().toUpperCase();
				String V_MAX_PACK_QTY = jsondata.get("MAX_PACK_QTY") == null ? "" : jsondata.get("MAX_PACK_QTY").toString().toUpperCase();
				String V_MID_PACK_QTY = jsondata.get("MID_PACK_QTY") == null ? "" : jsondata.get("MID_PACK_QTY").toString().toUpperCase();
				String V_MIN_PACK_QTY = jsondata.get("MIN_PACK_QTY") == null ? "" : jsondata.get("MIN_PACK_QTY").toString().toUpperCase();
				String V_SUPP_LT_DT = jsondata.get("SUPP_LT_DT") == null ? "" : jsondata.get("SUPP_LT_DT").toString().toUpperCase();
				String V_HS_CD = jsondata.get("HS_CD") == null ? "" : jsondata.get("HS_CD").toString().toUpperCase();
				String V_MAKER = jsondata.get("MAKER") == null ? "" : jsondata.get("MAKER").toString().toUpperCase();
				String V_IN_SL_CD = jsondata.get("IN_SL_CD") == null ? "" : jsondata.get("IN_SL_CD").toString().toUpperCase();
				String V_BAR_MAKE_UNIT = jsondata.get("BAR_MAKE_UNIT") == null ? "" : jsondata.get("BAR_MAKE_UNIT").toString().toUpperCase();

				String V_MAX_PACK_UNIT = jsondata.get("MAX_PACK_UNIT") == null ? "" : jsondata.get("MAX_PACK_UNIT").toString().toUpperCase();
				String V_MID_PACK_UNIT = jsondata.get("MID_PACK_UNIT") == null ? "" : jsondata.get("MID_PACK_UNIT").toString().toUpperCase();
				String V_MIN_PACK_UNIT = jsondata.get("MIN_PACK_UNIT") == null ? "" : jsondata.get("MIN_PACK_UNIT").toString().toUpperCase();

				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				
				if (V_TYPE.equals("I") || V_TYPE.equals("U") || V_TYPE.equals("D")) {
					if (V_TYPE.equals("I")) {
						V_GUBUN = "C";
					} else if (V_TYPE.equals("U")) {
						V_GUBUN = "U";
					} else if (V_TYPE.equals("D")) {
						V_GUBUN = "D";
					}
					anySubObject = new JSONObject();
					anySubObject.put("GUBUN", V_GUBUN);
					anySubObject.put("ITEM_CD", V_ITEM_CD.trim());
					anySubObject.put("ITEM_GROUP_CD", V_ITEM_GROUP_CD);
					anySubObject.put("ITEM_NM", V_ITEM_NM);
					anySubObject.put("SPEC", V_SPEC);
					anySubObject.put("UNIT", V_UNIT);
					anySubObject.put("MIN_PO_QTY", V_MIN_PO_QTY);
					anySubObject.put("SAFE_QTY", V_SAFE_QTY);
					anySubObject.put("MAX_PACK_QTY", V_MAX_PACK_QTY);
					anySubObject.put("MAX_PACK_UNIT", V_MAX_PACK_UNIT);
					anySubObject.put("MID_PACK_QTY", V_MID_PACK_QTY);
					anySubObject.put("MID_PACK_UNIT", V_MID_PACK_UNIT);
					anySubObject.put("MIN_PACK_QTY", V_MIN_PACK_QTY);
					anySubObject.put("MIN_PACK_UNIT", V_MIN_PACK_UNIT);
					anySubObject.put("SUPP_LT_DT", V_SUPP_LT_DT);
					anySubObject.put("MAKER", V_MAKER);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anyArray.add(anySubObject);
				}

				cs = conn.prepareCall("call USP_B_ITEM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
				cs.setString(4, V_ITEM_GROUP_CD);//V_ITEM_GROUP_CD
				cs.setString(5, V_ITEM_NM);//V_ITEM_NM
				cs.setString(6, V_SPEC);//V_SPEC
				cs.setString(7, V_MAKER);//V_MAKER
				cs.setString(8, V_UNIT);//V_UNIT
				cs.setString(9, V_SAFE_QTY);//V_SAFE_QTY
				cs.setString(10, V_MIN_PO_QTY);//V_MIN_PO_QTY
				cs.setString(11, V_SUPP_LT_DT);//V_SUPP_LT_DT
				cs.setString(12, V_HS_CD);//V_HS_CD
				cs.setString(13, V_IN_SL_CD);//V_IN_SL_CD
				cs.setString(14, V_BAR_MAKE_UNIT);//V_BAR_MAKE_UNIT
				cs.setString(15, V_MAX_PACK_QTY);//V_MAX_PACK_QTY
				cs.setString(16, V_MAX_PACK_UNIT);//V_MAX_PACK_UNIT
				cs.setString(17, V_MID_PACK_QTY);//V_MID_PACK_QTY
				cs.setString(18, V_MID_PACK_UNIT);//V_MID_PACK_UNIT
				cs.setString(19, V_MIN_PACK_QTY);//V_MIN_PACK_QTY
				cs.setString(20, V_MIN_PACK_UNIT);//V_MIN_PACK_UNIT
				cs.setString(21, V_USR_ID);//V_USR_ID
				cs.setString(22, V_REMARK);//V_REMARK
				cs.registerOutParameter(23, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}

			//여기할차례!
// 			if (V_GUBUN.equals("I") || V_GUBUN.equals("U") || V_GUBUN.equals("D")) {

// 				URL url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_erp_item");
// 				URLConnection con = url1.openConnection();
// 				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
// 				con.setDoOutput(true);

// 				anyObject.put("data", anyArray);
// 				String parameter = anyObject + "";
// 				// 				System.out.println(parameter);

// 				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
// 				wr.write(parameter);
// 				wr.flush();

// 				BufferedReader rd = null;

// 				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
// 				String line = null;
// 				String result = null;
// 				while ((line = rd.readLine()) != null) {
// 					result = URLDecoder.decode(line, "UTF-8");
// 				}

// 				// 				System.out.println(result);

// 				response.setContentType("text/plain; charset=UTF-8");
// 				PrintWriter pw = response.getWriter();
// 				pw.print(result);
// 				pw.flush();
// 				pw.close();
// 			}

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


