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
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD");
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");
		String V_DN_DT_FROM = request.getParameter("V_DN_DT_FROM") == null ? "" : request.getParameter("V_DN_DT_FROM").substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").substring(0, 10);
		String V_TO_SL_CD = request.getParameter("V_TO_SL_CD") == null ? "" : request.getParameter("V_TO_SL_CD");
		String V_DD_NO = request.getParameter("V_DD_NO") == null ? "" : request.getParameter("V_DD_NO");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
		String V_BC_NO = request.getParameter("V_BC_NO") == null ? "" : request.getParameter("V_BC_NO");

		if(V_TO_SL_CD.equals("T")){
			V_TO_SL_CD = "";
		}
		// 바코드입고조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_S_DN_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_DN_DT_FROM);//V_DN_DT_FR
			cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO
			cs.setString(5, V_S_BP_NM);//V_S_BP_CD
			cs.setString(6, V_TO_SL_CD);//V_TO_SL_CD
			cs.setString(7, "");//V_DN_NO
			cs.setString(8, "");//V_DN_SEQ 
			cs.setString(9, V_BC_NO);//V_LOT_BC_NO  가 들어가야하는데 임시로 V_BOX_BC_NO 로 사용함. 20180710 김장운.
			cs.setString(10, V_DD_NO);//V_DD_NO
			cs.setString(11, V_ITEM_CD);//V_ITEM_CD
			cs.setString(12, V_ITEM_NM);//V_ITEM_NM

			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("DN_TYPE", rs.getString("DN_TYPE"));
				subObject.put("DD_NO", rs.getString("DD_NO"));
				subObject.put("DD_SEQ", rs.getString("DD_SEQ"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("FR_SL_CD", rs.getString("FR_SL_CD"));
				subObject.put("FR_SL_NM", rs.getString("FR_SL_NM"));
				subObject.put("FR_LC_CD", rs.getString("FR_LC_CD"));
				subObject.put("FR_LC_NM", rs.getString("FR_LC_NM"));
				subObject.put("FR_RACK_CD", rs.getString("FR_RACK_CD"));
				subObject.put("FR_RACK_NM", rs.getString("FR_RACK_NM"));
				subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("TO_SL_NM", rs.getString("TO_SL_NM"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("IF_YN", rs.getString("IF_YN"));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));

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
			String V_BOX_BC_NO_NEW = "";

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
					String DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString();
					String BOX_BC_NO = hashMap.get("BOX_BC_NO") == null ? "" : hashMap.get("BOX_BC_NO").toString();
					String LOT_BC_NO = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();

					if (V_TYPE.equals("IF") || V_TYPE.equals("IF_CANCEL")) {
						anySubObject = new JSONObject();
						anySubObject.put("V_DN_NO", DN_NO);
						anySubObject.put("V_DN_SEQ", DN_SEQ);
						anySubObject.put("V_USR_ID", V_USR_ID);
						anySubObject.put("V_COMP_ID", V_COMP_ID);
						anyArray.add(anySubObject);
					} else {

						if (V_TYPE.equals("B2") && i == 0) {
							cs = conn.prepareCall("call USP_S_DN_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, "B1");//V_TYPE
							cs.setString(2, V_COMP_ID);//V_COMP_ID
							cs.setString(3, V_DN_DT_FROM);//V_DN_DT_FRf
							cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO
							cs.setString(5, V_S_BP_CD);//V_S_BP_CD
							cs.setString(6, V_TO_SL_CD);//V_TO_SL_CD
							cs.setString(7, DN_NO);//V_DN_NO
							cs.setString(8, DN_SEQ);//V_DN_SEQ
							cs.setString(9, LOT_BC_NO);//V_LOT_BC_NO
							cs.setString(10, "");//V_DD_NO
							cs.setString(11, "");//V_ITEM_CD
							cs.setString(12, "");//V_ITEM_NM
							cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
							cs.executeQuery();

							rs = (ResultSet) cs.getObject(13);
							while (rs.next()) {
								V_BOX_BC_NO_NEW = rs.getString("V_BOX_BC_NO_NEW");
							}

						}
						if (V_TYPE.equals("B2")) {
							cs = conn.prepareCall("call USP_S_DN_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, V_TYPE);//V_TYPE
							cs.setString(2, V_COMP_ID);//V_COMP_ID
							cs.setString(3, V_DN_DT_FROM);//V_DN_DT_FRf
							cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO
							cs.setString(5, V_S_BP_CD);//V_S_BP_CD
							cs.setString(6, V_TO_SL_CD);//V_TO_SL_CD
							cs.setString(7, BOX_BC_NO);//V_DN_NO - BOX_BC_NO로 재사용	
							cs.setString(8, DN_SEQ);//V_DN_SEQ
							cs.setString(9, LOT_BC_NO);//V_LOT_BC_NO
							cs.setString(10, V_BOX_BC_NO_NEW);//V_DD_NO - V_BOX_BC_NO_NEW로 재사용
							cs.setString(11, "");//V_ITEM_CD
							cs.setString(12, "");//V_ITEM_NM
							cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
							cs.executeQuery();
						} else {
							cs = conn.prepareCall("call USP_S_DN_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, V_TYPE);//V_TYPE
							cs.setString(2, V_COMP_ID);//V_COMP_ID
							cs.setString(3, V_DN_DT_FROM);//V_DN_DT_FRf
							cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO
							cs.setString(5, V_S_BP_CD);//V_S_BP_CD
							cs.setString(6, V_TO_SL_CD);//V_TO_SL_CD
							cs.setString(7, DN_NO);//V_DN_NO 
							cs.setString(8, DN_SEQ);//V_DN_SEQ
							cs.setString(9, LOT_BC_NO);//V_LOT_BC_NO
							cs.setString(10, V_DD_NO);//V_DD_NO 
							cs.setString(11, "");//V_ITEM_CD
							cs.setString(12, "");//V_ITEM_NM
							cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
							cs.executeQuery();
						}
					}
				}

			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
				String DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString();
				String BOX_BC_NO = jsondata.get("BOX_BC_NO") == null ? "" : jsondata.get("BOX_BC_NO").toString();
				String LOT_BC_NO = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();

				if (V_TYPE.equals("IF") || V_TYPE.equals("IF_CANCEL")) {
					anySubObject = new JSONObject();
					anySubObject.put("V_DN_NO", DN_NO);
					anySubObject.put("V_DN_SEQ", DN_SEQ);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anySubObject.put("V_COMP_ID", V_COMP_ID);
					anyArray.add(anySubObject);
				} else {

					if (V_TYPE.equals("B2")) {
						cs = conn.prepareCall("call USP_S_DN_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, "B1");//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_DN_DT_FROM);//V_DN_DT_FRf
						cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO
						cs.setString(5, V_S_BP_CD);//V_S_BP_CD
						cs.setString(6, V_TO_SL_CD);//V_TO_SL_CD
						cs.setString(7, DN_NO);//V_DN_NO
						cs.setString(8, DN_SEQ);//V_DN_SEQ
						cs.setString(9, LOT_BC_NO);//V_LOT_BC_NO
						cs.setString(10, "");//V_DD_NO
						cs.setString(11, "");//V_ITEM_CD
						cs.setString(12, "");//V_ITEM_NM
						cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(13);
						while (rs.next()) {
							V_BOX_BC_NO_NEW = rs.getString("V_BOX_BC_NO_NEW");
						}

					}
					if (V_TYPE.equals("B2")) {
						cs = conn.prepareCall("call USP_S_DN_BC_HSPF2(?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_DN_DT_FROM);//V_DN_DT_FRf
						cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO
						cs.setString(5, V_S_BP_CD);//V_S_BP_CD
						cs.setString(6, V_TO_SL_CD);//V_TO_SL_CD
						cs.setString(7, BOX_BC_NO);//V_DN_NO - BOX_BC_NO로 재사용	
						cs.setString(8, DN_SEQ);//V_DN_SEQ
						cs.setString(9, LOT_BC_NO);//V_LOT_BC_NO
						cs.setString(10, V_BOX_BC_NO_NEW);//V_DD_NO - V_BOX_BC_NO_NEW로 재사용
						cs.setString(11, "");//V_ITEM_CD
						cs.setString(12, "");//V_ITEM_NM
						cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					} else {
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_DN_DT_FROM);//V_DN_DT_FR
						cs.setString(4, V_DN_DT_TO);//V_DN_DT_TO
						cs.setString(5, V_S_BP_CD);//V_S_BP_CD
						cs.setString(6, V_TO_SL_CD);//V_TO_SL_CD
						cs.setString(7, DN_NO);//V_DN_NO
						cs.setString(8, DN_SEQ);//V_DN_SEQ
						cs.setString(9, LOT_BC_NO);//V_LOT_BC_NO
						cs.setString(10, "");//V_DD_NO
						cs.setString(11, "");//V_ITEM_CD
						cs.setString(12, "");//V_ITEM_NM

						cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}

				}
			}

			if (V_TYPE.equals("IF") || V_TYPE.equals("IF_CANCEL")) {
				URL url1 = null;
				if (V_TYPE.equals("IF")) {
					url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_dn_to_erp");
				} else {
					url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_dn_to_erp_cancel");
				}
				URLConnection con = url1.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

				anyObject.put("data", anyArray);
				String parameter = anyObject + "";
				System.out.println(parameter);

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

// 				System.out.println(result);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
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




