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
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

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
		String V_ID_DT_FR = request.getParameter("V_ID_DT_FR") == null ? "" : request.getParameter("V_ID_DT_FR").toUpperCase().substring(0, 10);
		String V_ID_DT_TO = request.getParameter("V_ID_DT_TO") == null ? "" : request.getParameter("V_ID_DT_TO").toUpperCase().substring(0, 10);
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();

		if (V_SL_CD.equals("T")) {
			V_SL_CD = "";
		}

		if (V_TYPE.equals("SH")) {

			cs = conn.prepareCall("call DISTR_GR.USP_M_GR_DISTR_REF(?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_ID_DT_FR);//V_ID_DT_FR
			cs.setString(3, V_ID_DT_TO);//V_ID_DT_TO
			cs.setString(4, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(5, V_M_BP_NM);//V_M_BP_NM
			cs.setString(6, V_SL_CD);//V_SL_CD
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("CC_SEQ", rs.getString("CC_SEQ"));
				subObject.put("ID_NO", rs.getString("ID_NO"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("INBOARD_DT", rs.getString("INBOARD_DT"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("REQ_QTY", rs.getString("REQ_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("FORWARD_XCH_RT", rs.getString("FORWARD_XCH_RT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("GR_SEQ", rs.getString("GR_SEQ"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("TEMP_PRC_YN", rs.getString("TEMP_PRC_YN"));
				subObject.put("CC_CHARGE_YN", rs.getString("CC_CHARGE_YN"));
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

			String V_CC_NO = request.getParameter("V_CC_NO") == null ? "" : request.getParameter("V_CC_NO").toUpperCase();
			String V_CC_SEQ = request.getParameter("V_CC_SEQ") == null ? "" : request.getParameter("V_CC_SEQ").toUpperCase();
			String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").toUpperCase().substring(0, 10);
			String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").toUpperCase().substring(0, 10);

			String sql = "";
			sql = "";
			sql += "SELECT   A.MVMT_NO, A.M_BP_CD, B.BP_NM M_BP_NM, A.IV_TYPE, D.DTL_NM IV_TYPE_NM, A.MVMT_DT,                                 ";
			sql += "         I.LC_DOC_NO, G.BL_DOC_NO, '' PAY_TYPE_NM, A.ITEM_CD, C.ITEM_NM, C.SPEC,                                           ";
			sql += "         A.CUR, C.UNIT, A.BOX_QTY, A.BOX_WGT_UNIT, A.BOX_WGT_UNIT * A.BOX_QTY AS TOTAL_QTY, A.QTY,                         ";
			sql += "         A.DOC_AMT, A.LOC_AMT, A.FORWARD_XCH_AMT, O.LO_OPEN_AMT LC_OPEN_AMT, L.DISTR_CC_AMT TONG_AMT, M.DISTR_TAX GWAN_AMT,";
			sql += "         N.DISTR_REC INSU_AMT, Q.DISTR_ETC ETC_AMT, A.DISTR_AMT2 TOTAL_AMT, A.SL_CD, J.SL_NM, A.LOC_AMT AC_AMT,             ";
			sql += "         A.FORWARD_XCH_AMT SL_AMT, A.CC_NO, A.CC_SEQ, F.PRICE, A.PO_NO, A.PO_SEQ,                                          ";
			sql += "         A.XCHG_RT, K.USR_NM GR_USR_NM, A.FORWARD_XCH_RT, P.INSUR_AMT INSUR_AMT, A.GR_NO, A.TEMP_GL_NO                                           ";
			sql += "         ,R.LO_OPEN_AMT LC_AMEND_AMT,CASE WHEN S.MVMT_NO IS NULL THEN 'N' ELSE 'Y' END DN_YN, A.TEMP_PRC_YN                                          ";
			sql += "FROM     M_GR_DISTR A                                                                                                      ";
			sql += "         LEFT OUTER JOIN B_BIZ_HSPF B                                                                                      ";
			sql += "         ON       A.COMP_ID=B.COMP_ID                                                                                      ";
			sql += "         AND      A.M_BP_CD=B.BP_CD                                                                                        ";
			sql += "         LEFT OUTER JOIN B_ITEM_HSPF C                                                                                     ";
			sql += "         ON       A.COMP_ID=C.COMP_ID                                                                                      ";
			sql += "         AND      A.ITEM_CD=C.ITEM_CD                                                                                      ";
			sql += "         LEFT OUTER JOIN B_DTL_INFO D                                                                                      ";
			sql += "         ON       A.COMP_ID=D.COMP_ID                                                                                      ";
			sql += "         AND      A.IV_TYPE=D.DTL_CD                                                                                       ";
			sql += "         AND      D.MAST_CD='MA02'                                                                                         ";
			sql += "         LEFT OUTER JOIN M_CC_DTL_DISTR E                                                                                  ";
			sql += "         ON       A.COMP_ID=E.COMP_ID                                                                                      ";
			sql += "         AND      A.CC_NO  =E.CC_NO                                                                                        ";
			sql += "         AND      A.CC_SEQ =E.CC_SEQ                                                                                       ";
			sql += "         LEFT OUTER JOIN M_BL_DTL_DISTR F                                                                                  ";
			sql += "         ON       E.COMP_ID=F.COMP_ID                                                                                      ";
			sql += "         AND      E.BL_NO  =F.BL_NO                                                                                        ";
			sql += "         AND      E.BL_SEQ =F.BL_SEQ                                                                                       ";
			sql += "         LEFT OUTER JOIN M_BL_HDR_DISTR G                                                                                  ";
			sql += "         ON       F.COMP_ID=G.COMP_ID                                                                                      ";
			sql += "         AND      F.BL_NO  =G.BL_NO                                                                                        ";
			sql += "         LEFT OUTER JOIN M_LC_DTL_DISTR H                                                                                  ";
			sql += "         ON       F.COMP_ID=H.COMP_ID                                                                                      ";
			sql += "         AND      F.LC_NO  =H.LC_NO                                                                                        ";
			sql += "         AND      F.LC_SEQ =H.LC_SEQ                                                                                       ";
			sql += "         LEFT OUTER JOIN M_LC_HDR_DISTR I                                                                                  ";
			sql += "         ON       H.COMP_ID=I.COMP_ID                                                                                      ";
			sql += "         AND      H.LC_NO  =I.LC_NO                                                                                        ";
			sql += "         LEFT OUTER JOIN B_STORAGE_DISTR J                                                                                 ";
			sql += "         ON       A.COMP_ID=J.COMP_ID                                                                                      ";
			sql += "         AND      A.SL_CD  =J.SL_CD                                                                                        ";
			sql += "         LEFT OUTER JOIN Z_USR_INFO_HSPF K                                                                                 ";
			sql += "         ON       A.INSRT_USR_ID = K.USR_ID                                                                                ";
			sql += "         LEFT OUTER JOIN M_CHARGE_DISTR_CC L                                                                               ";
			sql += "         ON       A.MVMT_NO = L.MVMT_NO                                                                                    ";
			sql += "         LEFT OUTER JOIN M_CHARGE_DISTR_TAX M                                                                              ";
			sql += "         ON       A.MVMT_NO = M.MVMT_NO                                                                                    ";
			sql += "         LEFT OUTER JOIN M_CHARGE_DISTR_REC N                                                                              ";
			sql += "         ON       A.MVMT_NO = N.MVMT_NO                                                                                    ";
			sql += "         LEFT OUTER JOIN M_CHARGE_DISTR_LC_OPEN_ONLY O                                                                          ";
			sql += "         ON       A.MVMT_NO = O.MVMT_NO                                                                                    ";
			sql += "         LEFT OUTER JOIN M_CHARGE_DISTR_LC_OPEN_AMEND R                                                                     ";
			sql += "          ON A.MVMT_NO=R.MVMT_NO                                                                                    ";
			sql += "         LEFT OUTER JOIN M_CHARGE_DISTR_INS P                                                                              ";
			sql += "         ON       A.MVMT_NO = P.MVMT_NO                                                                                    ";
			sql += "         LEFT OUTER JOIN M_CHARGE_DISTR_ETC Q                                                                              ";
			sql += "         ON       A.MVMT_NO = Q.MVMT_NO                                                                                    ";
			sql += "         LEFT OUTER JOIN M_GR_DN_CHECK S                                                                             ";
			sql += "        ON A.MVMT_NO=S.MVMT_NO                                                                              ";
			sql += " WHERE    A.COMP_ID          = '" + V_COMP_ID + "'                                                                                     ";
			//전체보기
			if (V_BL_DOC_NO.equals("")) {
				sql += " AND      A.CC_NO IN " + V_CC_NO + "                                                                                      ";
			} else if (!V_BL_DOC_NO.equals("*")) {
				sql += " AND      G.BL_DOC_NO LIKE '%" + V_BL_DOC_NO + "%'                                                                               ";
			} else if (V_BL_DOC_NO.equals("*")) {
				sql += " AND      A.MVMT_DT >= '" + V_MVMT_DT_FR + "'";
				sql += " AND      A.MVMT_DT <= '" + V_MVMT_DT_TO + "'";
			}
			sql += " ORDER BY A.GR_NO, A.GR_SEQ;                                                                                                ";

			rs = stmt.executeQuery(sql);
// 			System.out.println(sql);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("TOTAL_QTY", rs.getString("TOTAL_QTY"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("PAY_TYPE_NM", rs.getString("PAY_TYPE_NM"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("LC_OPEN_AMT", rs.getString("LC_OPEN_AMT"));
				subObject.put("TONG_AMT", rs.getString("TONG_AMT"));
				subObject.put("GWAN_AMT", rs.getString("GWAN_AMT"));
				subObject.put("INSU_AMT", rs.getString("INSU_AMT"));
				subObject.put("ETC_AMT", rs.getString("ETC_AMT"));
				subObject.put("TOTAL_AMT", rs.getString("TOTAL_AMT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("ETC_AMT", rs.getString("ETC_AMT"));
				subObject.put("AC_AMT", rs.getString("AC_AMT"));
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("CC_SEQ", rs.getString("CC_SEQ"));
				subObject.put("PRICE", rs.getString("PRICE"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
				subObject.put("GR_USR_NM", rs.getString("GR_USR_NM"));
				subObject.put("FORWARD_XCH_RT", rs.getString("FORWARD_XCH_RT"));
				subObject.put("INSUR_AMT", rs.getString("INSUR_AMT"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("LC_AMEND_AMT", rs.getString("LC_AMEND_AMT"));
				subObject.put("DN_YN", rs.getString("DN_YN"));
				subObject.put("TEMP_PRC_YN", rs.getString("TEMP_PRC_YN"));
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

// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_CC_NO = hashMap.get("CC_NO") == null ? "" : hashMap.get("CC_NO").toString();
					String V_CC_SEQ = hashMap.get("CC_SEQ") == null ? "" : hashMap.get("CC_SEQ").toString();
					String V_ID_NO = hashMap.get("ID_NO") == null ? "" : hashMap.get("ID_NO").toString();
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String V_CONT_NO = hashMap.get("CONT_NO") == null ? "" : hashMap.get("CONT_NO").toString();
					String V_LOADING_DT = hashMap.get("LOADING_DT") == null ? "" : hashMap.get("LOADING_DT").toString().substring(0, 10);
					String V_INBOARD_DT = hashMap.get("INBOARD_DT") == null ? "" : hashMap.get("INBOARD_DT").toString().substring(0, 10);
					String V_ID_DT = hashMap.get("ID_DT") == null ? "" : hashMap.get("ID_DT").toString().substring(0, 10);
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String V_SPEC = hashMap.get("SPEC") == null ? "" : hashMap.get("SPEC").toString();
					String V_UNIT = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
					String V_BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
					String V_QTY = hashMap.get("QTY") == null ? "" : hashMap.get("QTY").toString();
					String V_REQ_QTY = hashMap.get("REQ_QTY") == null ? "" : hashMap.get("REQ_QTY").toString();
					String V_PRC = hashMap.get("PRICE") == null ? "" : hashMap.get("PRICE").toString();
					String V_XCHG_RT = hashMap.get("XCH_RATE") == null ? "" : hashMap.get("XCH_RATE").toString();
					String V_DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
					String V_LOC_AMT = hashMap.get("LOC_AMT") == null ? "" : hashMap.get("LOC_AMT").toString();
					String V_BOX_WGT_UNIT = hashMap.get("BOX_WGT_UNIT") == null ? "" : hashMap.get("BOX_WGT_UNIT").toString();
					String V_FORWARD_XCH_RT = hashMap.get("FORWARD_XCH_RT") == null ? "" : hashMap.get("FORWARD_XCH_RT").toString();
					String V_FORWARD_XCH_AMT = hashMap.get("FORWARD_XCH_AMT") == null ? "" : hashMap.get("FORWARD_XCH_AMT").toString();
					String V_SL_CD2 = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();

					String V_FIRST_YN = "";
					String V_GR_NO = "";
					String V_GR_SEQ = "";
					String V_MVMT_DT = "";

					if (V_TYPE.equals("IH") || V_TYPE.equals("ID")) {
						V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO");
						V_MVMT_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").substring(0, 10);
					} else {
						V_GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
						V_GR_SEQ = hashMap.get("GR_SEQ") == null ? "" : hashMap.get("GR_SEQ").toString();
						V_MVMT_DT = hashMap.get("MVMT_DT") == null ? "" : hashMap.get("MVMT_DT").toString().substring(0, 10);
					}

					String V_IV_TYPE = hashMap.get("IV_TYPE") == null ? "" : hashMap.get("IV_TYPE").toString();
					String V_M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();

					String V_TEMP_PRC_YN = hashMap.get("TEMP_PRC_YN") == null ? "" : hashMap.get("TEMP_PRC_YN").toString();

					cs = conn.prepareCall("call DISTR_GR.USP_M_GR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_MVMT_NO);//V_MVMT_NO
					cs.setString(4, V_FIRST_YN);//V_FIRST_YN
					cs.setString(5, V_IV_TYPE);//V_IV_TYPE
					cs.setString(6, V_MVMT_DT);//V_MVMT_DT
					cs.setString(7, V_M_BP_CD);//V_M_BP_CD
					cs.setString(8, V_GR_NO);//V_GR_SEQ
					cs.setString(9, V_GR_SEQ);//V_GR_SEQ
					cs.setString(10, V_CUR);//V_CUR
					cs.setString(11, V_XCHG_RT);//V_XCHG_RT
					cs.setString(12, V_FORWARD_XCH_RT);//V_FORWARD_XCH_RT
					cs.setString(13, V_ITEM_CD);//V_ITEM_CD
					cs.setString(14, V_QTY);//V_QTY
					if (V_TYPE.equals("I")) {
						cs.setString(14, V_REQ_QTY);//V_REQ_QTY --입고등록시 요청수량을 수량으로
					}

					cs.setString(15, V_DOC_AMT);//V_DOC_AMT
					cs.setString(16, V_LOC_AMT);//V_LOC_AMT
					cs.setString(17, V_PO_NO);//V_PO_NO
					cs.setString(18, V_PO_SEQ);//V_PO_SEQ
					cs.setString(19, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
					cs.setString(20, V_BOX_QTY);//V_BOX_QTY
					cs.setString(21, V_BOX_WGT_UNIT);//V_BOX_WGT_UNIT
					cs.setString(22, V_DN_QTY);//V_DN_QTY
					cs.setString(23, V_SL_CD2);//V_SL_CD
					cs.setString(24, V_CC_NO);//V_CC_NO
					cs.setString(25, V_CC_SEQ);//V_CC_SEQ
					cs.setString(26, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(28, V_TEMP_PRC_YN);//V_TEMP_PRC_YN
					cs.executeQuery();

					String MVMT_NO = "";
					if (V_TYPE.equals("ID")) {
						rs = (ResultSet) cs.getObject(27);
						while (rs.next()) {
							MVMT_NO = rs.getString("MVMT_NO");
						}
						cs2 = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_2(?,?,?)");
						cs2.setString(1, V_COMP_ID);//V_COMP_ID
						cs2.setString(2, MVMT_NO);//MVMT_NO
						cs2.setString(3, V_USR_ID);//V_MVMT_NO
						cs2.executeQuery();
					} else if (V_TYPE.equals("U")) {

						// 						V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();

						// 						cs2 = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_2(?,?,?)");
						// 						cs2.setString(1, V_COMP_ID);//V_COMP_ID
						// 						cs2.setString(2, V_MVMT_NO);//V_MVMT_NO
						// 						cs2.setString(3, V_USR_ID);//V_MVMT_NO
						// 						cs2.executeQuery();
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_CC_NO = jsondata.get("CC_NO") == null ? "" : jsondata.get("CC_NO").toString();
				String V_CC_SEQ = jsondata.get("CC_SEQ") == null ? "" : jsondata.get("CC_SEQ").toString();
				String V_ID_NO = jsondata.get("ID_NO") == null ? "" : jsondata.get("ID_NO").toString();
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String V_CONT_NO = jsondata.get("CONT_NO") == null ? "" : jsondata.get("CONT_NO").toString();
				String V_LOADING_DT = jsondata.get("LOADING_DT") == null ? "" : jsondata.get("LOADING_DT").toString().substring(0, 10);
				String V_INBOARD_DT = jsondata.get("INBOARD_DT") == null ? "" : jsondata.get("INBOARD_DT").toString().substring(0, 10);
				String V_ID_DT = jsondata.get("ID_DT") == null ? "" : jsondata.get("ID_DT").toString().substring(0, 10);
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String V_SPEC = jsondata.get("SPEC") == null ? "" : jsondata.get("SPEC").toString();
				String V_UNIT = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
				String V_BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
				String V_QTY = jsondata.get("QTY") == null ? "" : jsondata.get("QTY").toString();
				String V_REQ_QTY = jsondata.get("REQ_QTY") == null ? "" : jsondata.get("REQ_QTY").toString();
				String V_PRC = jsondata.get("PRICE") == null ? "" : jsondata.get("PRICE").toString();
				String V_XCHG_RT = jsondata.get("XCH_RATE") == null ? "" : jsondata.get("XCH_RATE").toString();
				String V_DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
				String V_LOC_AMT = jsondata.get("LOC_AMT") == null ? "" : jsondata.get("LOC_AMT").toString();
				String V_BOX_WGT_UNIT = jsondata.get("BOX_WGT_UNIT") == null ? "" : jsondata.get("BOX_WGT_UNIT").toString();
				String V_FORWARD_XCH_RT = jsondata.get("FORWARD_XCH_RT") == null ? "" : jsondata.get("FORWARD_XCH_RT").toString();
				String V_FORWARD_XCH_AMT = jsondata.get("FORWARD_XCH_AMT") == null ? "" : jsondata.get("FORWARD_XCH_AMT").toString();
				String V_SL_CD2 = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();

				String V_FIRST_YN = "";
				String V_GR_NO = "";
				String V_GR_SEQ = "";
				String V_MVMT_DT = "";

				if (V_TYPE.equals("IH") || V_TYPE.equals("ID")) {
					V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO");
					V_MVMT_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").substring(0, 10);
				} else {
					V_GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();
					V_GR_SEQ = jsondata.get("GR_SEQ") == null ? "" : jsondata.get("GR_SEQ").toString();
					V_MVMT_DT = jsondata.get("MVMT_DT") == null ? "" : jsondata.get("MVMT_DT").toString().substring(0, 10);
				}

				String V_IV_TYPE = jsondata.get("IV_TYPE") == null ? "" : jsondata.get("IV_TYPE").toString();
				String V_M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();

				String V_TEMP_PRC_YN = jsondata.get("TEMP_PRC_YN") == null ? "" : jsondata.get("TEMP_PRC_YN").toString();
				cs = conn.prepareCall("call DISTR_GR.USP_M_GR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_MVMT_NO);//V_MVMT_NO
				cs.setString(4, V_FIRST_YN);//V_FIRST_YN
				cs.setString(5, V_IV_TYPE);//V_IV_TYPE
				cs.setString(6, V_MVMT_DT);//V_MVMT_DT
				cs.setString(7, V_M_BP_CD);//V_M_BP_CD
				cs.setString(8, V_GR_NO);//V_GR_SEQ
				cs.setString(9, V_GR_SEQ);//V_GR_SEQ
				cs.setString(10, V_CUR);//V_CUR
				cs.setString(11, V_XCHG_RT);//V_XCHG_RT
				cs.setString(12, V_FORWARD_XCH_RT);//V_FORWARD_XCH_RT
				cs.setString(13, V_ITEM_CD);//V_ITEM_CD
				cs.setString(14, V_QTY);//V_QTY
				if (V_TYPE.equals("I")) {
					cs.setString(14, V_REQ_QTY);//V_REQ_QTY --입고등록시 요청수량을 수량으로
				}

				cs.setString(15, V_DOC_AMT);//V_DOC_AMT
				cs.setString(16, V_LOC_AMT);//V_LOC_AMT
				cs.setString(17, V_PO_NO);//V_PO_NO
				cs.setString(18, V_PO_SEQ);//V_PO_SEQ
				cs.setString(19, V_FORWARD_XCH_AMT);//V_FORWARD_XCH_AMT
				cs.setString(20, V_BOX_QTY);//V_BOX_QTY
				cs.setString(21, V_BOX_WGT_UNIT);//V_BOX_WGT_UNIT
				cs.setString(22, V_DN_QTY);//V_DN_QTY
				cs.setString(23, V_SL_CD2);//V_SL_CD
				cs.setString(24, V_CC_NO);//V_CC_NO
				cs.setString(25, V_CC_SEQ);//V_CC_SEQ
				cs.setString(26, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(28, V_TEMP_PRC_YN);//V_TEMP_PRC_YN
				cs.executeQuery();

				String MVMT_NO = "";

				if (V_TYPE.equals("ID")) {
					rs = (ResultSet) cs.getObject(27);
					while (rs.next()) {
						MVMT_NO = rs.getString("MVMT_NO");
					}
					cs2 = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_2(?,?,?)");
					cs2.setString(1, V_COMP_ID);//V_COMP_ID
					cs2.setString(2, MVMT_NO);//MVMT_NO
					cs2.setString(3, V_USR_ID);//V_MVMT_NO
					cs2.executeQuery();
				} else if (V_TYPE.equals("U")) {
					// 					V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();

					// 	 				System.out.println("V_COMP_ID" + V_COMP_ID);
					// 	 				System.out.println("V_MVMT_NO" + V_MVMT_NO);
					// 	 				System.out.println("V_USR_ID" + V_USR_ID);

					// 					cs2 = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_2(?,?,?)");
					// 					cs2.setString(1, V_COMP_ID);//V_COMP_ID
					// 					cs2.setString(2, V_MVMT_NO);//V_MVMT_NO
					// 					cs2.setString(3, V_USR_ID);//V_MVMT_NO
					// 					cs2.executeQuery();
				}

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			}
		} else if (V_TYPE.equals("IH")) {
			String V_MVMT_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").substring(0, 10);

			cs = conn.prepareCall("call DISTR_GR.USP_M_GR_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_MVMT_NO
			cs.setString(4, "");//V_FIRST_YN
			cs.setString(5, "");//V_IV_TYPE
			cs.setString(6, V_MVMT_DT);//V_MVMT_DT
			cs.setString(7, "");//V_M_BP_CD
			cs.setString(8, "");//V_GR_SEQ
			cs.setString(9, "");//V_GR_SEQ
			cs.setString(10, "");//V_CUR
			cs.setString(11, "");//V_XCHG_RT
			cs.setString(12, "");//V_FORWARD_XCH_RT
			cs.setString(13, "");//V_ITEM_CD
			cs.setString(14, "");//V_QTY
			cs.setString(15, "");//V_DOC_AMT
			cs.setString(16, "");//V_LOC_AMT
			cs.setString(17, "");//V_PO_NO
			cs.setString(18, "");//V_PO_SEQ
			cs.setString(19, "");//V_FORWARD_XCH_AMT
			cs.setString(20, "");//V_BOX_QTY
			cs.setString(21, "");//V_BOX_WGT_UNIT
			cs.setString(22, "");//V_DN_QTY
			cs.setString(23, "");//V_SL_CD
			cs.setString(24, "");//V_CC_NO
			cs.setString(25, "");//V_CC_SEQ
			cs.setString(26, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, "");//V_TEMP_PRC_YN
			cs.executeQuery();

			String GR_NO = "";

			rs = (ResultSet) cs.getObject(27);
			while (rs.next()) {
				GR_NO = rs.getString("GR_NO");
			}
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(GR_NO);
			pw.flush();
			pw.close();
		} else if (V_TYPE.equals("CHARGE_RECALC")) {

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
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();

					cs = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_2(?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_MVMT_NO);//V_TYPE
					cs.setString(3, V_USR_ID);//V_MVMT_NO
					cs.executeQuery();
				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();

				cs = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_CALC_2(?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_MVMT_NO);//V_TYPE
				cs.setString(3, V_USR_ID);//V_MVMT_NO
				cs.executeQuery();
			}

			/*경비수정 조회*/
		} else if (V_TYPE.equals("CHARGE")) {
			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE");
			String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO");

			// 			System.out.println("U_TYPE" + U_TYPE);
			// 			System.out.println("V_MVMT_NO" + V_MVMT_NO);

			/*-CHARGE_AMT :경비금액 , TOT_DISB_AMT :배분경비합계, 
			DISB_AMT 수정경비금액,ODD_DISB_AMT : 숨어있는 경비금액, DISTRIBT_AMT :경비합계  */
			/*CHARGE_SEQ HIDDEN */

			/*조회헤더*/
			if (U_TYPE.equals("H")) {
				cs = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_RE_CALC(?,?,?,?,?,?,?,?)");
				cs.setString(1, U_TYPE);//V_COMP_ID
				cs.setString(2, V_COMP_ID);//V_TYPE
				cs.setString(3, V_MVMT_NO);//V_MVMT_NO
				cs.setString(4, "");//V_CHARGE_NO
				cs.setString(5, "");//V_CHARGE_SEQ
				cs.setString(6, "");//V_DISTB_AMT
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(8);
				while (rs.next()) {
					subObject = new JSONObject();

					subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
					subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
					subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
					subObject.put("QTY", rs.getString("QTY"));

					jsonArray.add(subObject);
				}

				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
				/*조회디테일*/
			} else if (U_TYPE.equals("S")) {

				cs = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_RE_CALC(?,?,?,?,?,?,?,?)");
				cs.setString(1, U_TYPE);//V_COMP_ID
				cs.setString(2, V_COMP_ID);//V_TYPE
				cs.setString(3, V_MVMT_NO);//V_MVMT_NO
				cs.setString(4, "");//V_CHARGE_NO
				cs.setString(5, "");//V_CHARGE_SEQ
				cs.setString(6, "");//V_DISTB_AMT
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(8);
				while (rs.next()) {
					subObject = new JSONObject();

					subObject.put("TYPE", rs.getString("TYPE"));
					subObject.put("CHARGE_NM", rs.getString("CHARGE_NM"));
					subObject.put("CHARGE_AMT", rs.getString("CHARGE_AMT"));
					subObject.put("TOT_DISB_AMT", rs.getString("TOT_DISB_AMT"));
					subObject.put("DISTB_AMT", rs.getString("DISTB_AMT"));
					subObject.put("OLD_DISB_AMT", rs.getString("OLD_DISB_AMT"));
					subObject.put("CHARGE_NO", rs.getString("CHARGE_NO"));
					subObject.put("CHARGE_SEQ", rs.getString("CHARGE_SEQ"));
					subObject.put("OLD_DISB_AMT", rs.getString("OLD_DISB_AMT"));
					subObject.put("DISTRIBT_AMT", rs.getString("DISTRIBT_AMT"));

					jsonArray.add(subObject);
				}

				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
			} else if (U_TYPE.equals("SYNC")) {
				request.setCharacterEncoding("utf-8");
				String[] findList = { "#", "+", "&", "%", " " };
				String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

				String data = request.getParameter("data");
				data = StringUtils.replaceEach(data, findList, replList);
				String jsonData = URLDecoder.decode(data, "UTF-8");

				// 				System.out.println(jsonData);

				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						String V_CHARGE_NO = hashMap.get("CHARGE_NO") == null ? "" : hashMap.get("CHARGE_NO").toString();
						String V_CHARGE_SEQ = hashMap.get("CHARGE_SEQ") == null ? "" : hashMap.get("CHARGE_SEQ").toString();
						String V_DISTB_AMT = hashMap.get("DISTB_AMT") == null ? "" : hashMap.get("DISTB_AMT").toString();

						cs = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_RE_CALC(?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_COMP_ID
						cs.setString(2, V_COMP_ID);//V_TYPE
						cs.setString(3, V_MVMT_NO);//V_MVMT_NO
						cs.setString(4, V_CHARGE_NO);//V_CHARGE_NO
						cs.setString(5, V_CHARGE_SEQ);//V_CHARGE_SEQ
						cs.setString(6, V_DISTB_AMT);//V_DISTB_AMT
						cs.setString(7, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

					}
				} else {

					JSONObject jsondata = JSONObject.fromObject(jsonData);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					String V_CHARGE_NO = jsondata.get("CHARGE_NO") == null ? "" : jsondata.get("CHARGE_NO").toString();
					String V_CHARGE_SEQ = jsondata.get("CHARGE_SEQ") == null ? "" : jsondata.get("CHARGE_SEQ").toString();
					String V_DISTB_AMT = jsondata.get("DISTB_AMT") == null ? "" : jsondata.get("DISTB_AMT").toString();

					// 					System.out.println("V_TYPE: " + V_TYPE );
					// 					System.out.println("V_COMP_ID: " + V_COMP_ID );
					// 					System.out.println("V_MVMT_NO: " + V_MVMT_NO );
					// 					System.out.println("V_CHARGE_NO: " + V_CHARGE_NO );
					// 					System.out.println("V_CHARGE_SEQ: " + V_CHARGE_SEQ );
					// 					System.out.println("V_DISTB_AMT: " + V_DISTB_AMT );

					cs = conn.prepareCall("call DISTR_M_CH_CALC.USP_M_CHARGE_RE_CALC(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//U_TYPE
					cs.setString(2, V_COMP_ID);//V_TYPE
					cs.setString(3, V_MVMT_NO);//V_MVMT_NO
					cs.setString(4, V_CHARGE_NO);//V_CHARGE_NO
					cs.setString(5, V_CHARGE_SEQ);//V_CHARGE_SEQ
					cs.setString(6, V_DISTB_AMT);//V_DISTB_AMT
					cs.setString(7, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			}

		} else if (V_TYPE.equals("ERP")) {

			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE");

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			JSONObject anyObject = new JSONObject();
			JSONArray anyArray = new JSONArray();
			JSONObject anySubObject = new JSONObject();

			URL url = null;
			if (U_TYPE.equals("I")) { //확정
				url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_insert");
			} else if (U_TYPE.equals("D")) { //확정취소
				url = new URL("http://123.142.124.155:8088/http/hspf_erp_temp_gl_cancel");
			}

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				ArrayList<String> grArr = new ArrayList<String>();
				ArrayList<String> grArr_FIN = new ArrayList<String>();

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					String V_TEMP_GL_NO = hashMap.get("TEMP_GL_NO") == null ? "" : hashMap.get("TEMP_GL_NO").toString();
					String V_GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
					/*전표생성이고, 전표번호가 있으면 continue*/
					if(U_TYPE.equals("I") && V_TEMP_GL_NO.length() > 0) {
						continue;
					} else {
						grArr.add(V_GR_NO);
					}
				}
				for (int j = 0; j < grArr.size(); j++) {
					if (!grArr_FIN.contains(grArr.get(j))) grArr_FIN.add(grArr.get(j));
				}

				for (int k = 0; k < grArr_FIN.size(); k++) {
					cs = conn.prepareCall("call DISTR_TEMP_GL.USP_A_TEMP_GR_FR(?,?,?,?,?)");

					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, U_TYPE);//V_TYPE
					cs.setString(3, grArr_FIN.get(k));//V_GR_NO
					cs.setString(4, V_USR_ID);//V_BL_SEQ
					cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(5);

					String V_TEMP_GL_NO = "";
					if (rs.next()) {
						V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
					}
					anySubObject = new JSONObject();
					anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
					anySubObject.put("V_USR_ID", V_USR_ID);
					anySubObject.put("V_DB_ID", "sa");
					anySubObject.put("V_DB_PW", "hsnadmin");

					anyArray.add(anySubObject);
				}

			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				String V_GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();

				cs = conn.prepareCall("call DISTR_TEMP_GL.USP_A_TEMP_GR_FR(?,?,?,?,?)");

				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, U_TYPE);//V_TYPE
				cs.setString(3, V_GR_NO);//V_BL_NO
				cs.setString(4, V_USR_ID);//V_BL_SEQ
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(5);

				String V_TEMP_GL_NO = "";
				if (rs.next()) {
					V_TEMP_GL_NO = rs.getString("V_TEMP_GL_NO");
				}

				anySubObject = new JSONObject();
				anySubObject.put("V_TEMP_GL_NO", V_TEMP_GL_NO);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anySubObject.put("V_DB_ID", "sa");
				anySubObject.put("V_DB_PW", "hsnadmin");

				anyArray.add(anySubObject);
			}

			anyObject.put("data", anyArray);
			String parameter = anyObject + "";

			// 			System.out.println(parameter);

			URLConnection con = url.openConnection();
			con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
			con.setDoOutput(true);

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


