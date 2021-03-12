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
		if (V_TYPE.equals("SH")) {
			String V_GR_DT_FR = request.getParameter("V_GR_DT_FR") == null ? "" : request.getParameter("V_GR_DT_FR").substring(0, 10);
			String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null ? "" : request.getParameter("V_GR_DT_TO").substring(0, 10);
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM");
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM");

// 			System.out.println("V_GR_DT_FR" + V_GR_DT_FR);
// 			System.out.println("V_GR_DT_TO" + V_GR_DT_TO);
// 			System.out.println("V_ITEM_CD" + V_ITEM_CD);
// 			System.out.println("V_ITEM_NM" + V_ITEM_NM);
// 			System.out.println("V_M_BP_NM" + V_M_BP_NM);
			
			cs = conn.prepareCall("call USP_I_CHNG_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, ""); //V_SL_CD
			cs.setString(4, V_ITEM_CD); //V_ITEM_CD
			cs.setString(5, V_ITEM_NM); //V_ITEM_NM
			cs.setString(6, V_GR_DT_FR); //V_GR_DT_FR
			cs.setString(7, V_GR_DT_TO); //V_GR_DT_TO
			cs.setString(8, V_M_BP_NM); //V_BP_CD
			cs.setString(9, ""); //V_FR_SL_CD
			cs.setString(10, ""); //V_MV_NO
			cs.setString(11, ""); //V_GR_NO
			cs.setString(12, ""); //V_GR_SEQ
			cs.setString(13, ""); //V_TO_SL_CD
			cs.setString(14, ""); //V_TO_LC_CD
			cs.setString(15, ""); //V_TO_RACK_NO
			cs.setString(16, ""); //V_MOV_QTY
			cs.setString(17, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {

				subObject = new JSONObject();
				subObject.put("FR_SL_CD", rs.getString("FR_SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("GR_SEQ", rs.getString("GR_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("STOCK_QTY", rs.getString("STOCK_QTY"));
				subObject.put("STOCK_AMT", rs.getString("STOCK_AMT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("TO_LC_CD", rs.getString("TO_LC_CD"));
				subObject.put("TO_RC_CD", rs.getString("TO_RC_CD"));
				subObject.put("MOVE_QTY", rs.getString("MOVE_QTY"));
// 				subObject.put("MOVE_USR_NM", rs.getString("MOVE_USR_NM"));
// 				subObject.put("INSRT_DT", rs.getString("INSRT_DT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));

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
		} else if (V_TYPE.equals("SD")) {
			String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO");
			String V_GR_SEQ = request.getParameter("V_GR_SEQ") == null ? "" : request.getParameter("V_GR_SEQ");

			// 			System.out.println("V_GR_NO" + V_GR_NO);
			// 			System.out.println("V_GR_SEQ" + V_GR_SEQ);

			cs = conn.prepareCall("call USP_I_CHNG_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, ""); //V_SL_CD
			cs.setString(4, ""); //V_ITEM_CD
			cs.setString(5, ""); //V_ITEM_NM
			cs.setString(6, ""); //V_GR_DT_FR
			cs.setString(7, ""); //V_GR_DT_TO
			cs.setString(8, ""); //V_BP_CD
			cs.setString(9, ""); //V_FR_SL_CD
			cs.setString(10, ""); //V_MV_NO
			cs.setString(11, V_GR_NO); //V_GR_NO
			cs.setString(12, V_GR_SEQ); //V_GR_SEQ
			cs.setString(13, ""); //V_TO_SL_CD
			cs.setString(14, ""); //V_TO_LC_CD
			cs.setString(15, ""); //V_TO_RACK_NO
			cs.setString(16, ""); //V_MOV_QTY
			cs.setString(17, V_USR_ID); //V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {

				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));

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
					String V_FR_SL_CD = hashMap.get("FR_SL_CD") == null ? "" : hashMap.get("FR_SL_CD").toString();
					String V_TO_SL_CD = hashMap.get("TO_SL_CD") == null ? "" : hashMap.get("TO_SL_CD").toString();
					String V_TO_LC_CD = hashMap.get("TO_LC_CD") == null ? "" : hashMap.get("TO_LC_CD").toString();
					String V_TO_RC_CD = hashMap.get("TO_RC_CD") == null ? "" : hashMap.get("TO_RC_CD").toString();
					String V_GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
					String V_GR_SEQ = hashMap.get("GR_SEQ") == null ? "" : hashMap.get("GR_SEQ").toString();
					String V_NEW_MOVE_QTY = hashMap.get("NEW_MOVE_QTY") == null ? "" : hashMap.get("NEW_MOVE_QTY").toString();
					String V_INSRT_DT = hashMap.get("INSRT_DT") == null ? "" : hashMap.get("INSRT_DT").toString();
					if( V_INSRT_DT.length() > 10){
						V_INSRT_DT = V_INSRT_DT.substring(0,10);
					}

					cs = conn.prepareCall("call USP_I_CHNG_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //V_TYPE
					cs.setString(2, V_COMP_ID); //V_COMP_ID
					cs.setString(3, ""); //V_SL_CD
					cs.setString(4, ""); //V_ITEM_CD
					cs.setString(5, ""); //V_ITEM_NM
					cs.setString(6, V_INSRT_DT); //V_GR_DT_FR  20181122 김장운. 유상열사원이 창고이동일 직접 넣게 해달라해서  임시변수로 사용.
					cs.setString(7, ""); //V_GR_DT_TO
					cs.setString(8, ""); //V_BP_CD
					cs.setString(9, V_FR_SL_CD); //V_FR_SL_CD
					cs.setString(10, ""); //V_MV_NO
					cs.setString(11, V_GR_NO); //V_GR_NO
					cs.setString(12, V_GR_SEQ); //V_GR_SEQ
					cs.setString(13, V_TO_SL_CD); //V_TO_SL_CD
					cs.setString(14, V_TO_LC_CD); //V_TO_LC_CD
					cs.setString(15, V_TO_RC_CD); //V_TO_RACK_NO
					cs.setString(16, V_NEW_MOVE_QTY); //V_MOV_QTY
					cs.setString(17, V_USR_ID); //V_USR_ID
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_FR_SL_CD = jsondata.get("FR_SL_CD") == null ? "" : jsondata.get("FR_SL_CD").toString();
				String V_TO_SL_CD = jsondata.get("TO_SL_CD") == null ? "" : jsondata.get("TO_SL_CD").toString();
				String V_TO_LC_CD = jsondata.get("TO_LC_CD") == null ? "" : jsondata.get("TO_LC_CD").toString();
				String V_TO_RC_CD = jsondata.get("TO_RC_CD") == null ? "" : jsondata.get("TO_RC_CD").toString();
				String V_GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();
				String V_GR_SEQ = jsondata.get("GR_SEQ") == null ? "" : jsondata.get("GR_SEQ").toString();
				String V_NEW_MOVE_QTY = jsondata.get("NEW_MOVE_QTY") == null ? "" : jsondata.get("NEW_MOVE_QTY").toString();
				String V_INSRT_DT = jsondata.get("INSRT_DT") == null ? "" : jsondata.get("INSRT_DT").toString();
				if( V_INSRT_DT.length() > 10){
					V_INSRT_DT = V_INSRT_DT.substring(0,10);
				}

				// 				System.out.println("V_TO_SL_CD" + V_TO_SL_CD);

				cs = conn.prepareCall("call USP_I_CHNG_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //V_TYPE
				cs.setString(2, V_COMP_ID); //V_COMP_ID
				cs.setString(3, ""); //V_SL_CD
				cs.setString(4, ""); //V_ITEM_CD
				cs.setString(5, ""); //V_ITEM_NM
				cs.setString(6, V_INSRT_DT); //V_GR_DT_FR  20181122 김장운. 유상열사원이 창고이동일 직접 넣게 해달라해서  임시변수로 사용.
				cs.setString(7, ""); //V_GR_DT_TO
				cs.setString(8, ""); //V_BP_CD
				cs.setString(9, V_FR_SL_CD); //V_FR_SL_CD
				cs.setString(10, ""); //V_MV_NO
				cs.setString(11, V_GR_NO); //V_GR_NO
				cs.setString(12, V_GR_SEQ); //V_GR_SEQ
				cs.setString(13, V_TO_SL_CD); //V_TO_SL_CD
				cs.setString(14, V_TO_LC_CD); //V_TO_LC_CD
				cs.setString(15, V_TO_RC_CD); //V_TO_RACK_NO
				cs.setString(16, V_NEW_MOVE_QTY); //V_MOV_QTY
				cs.setString(17, V_USR_ID); //V_USR_ID
				cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
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


