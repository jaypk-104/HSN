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

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


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
		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").toUpperCase().substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").toUpperCase().substring(0, 10);
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO").toUpperCase();
		String V_DN_DT_FR = request.getParameter("V_DN_DT_FR") == null ? "" : request.getParameter("V_DN_DT_FR").toUpperCase().substring(0, 10);
		String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase().substring(0, 10);
		String V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_SO_BP_NM = request.getParameter("V_SO_BP_NM") == null ? "" : request.getParameter("V_SO_BP_NM").toUpperCase();
		String V_SALE_TYPE2 = request.getParameter("V_SALE_TYPE2") == null ? "" : request.getParameter("V_SALE_TYPE2").toUpperCase(); //아래쪽에서 V_SALE_TYPE 변수를 사용하는게 있어서 V_SALE_TYPE2로 사용함.

// 		System.out.println("V_SO_BP_NM :" + V_SO_BP_NM);
// 		System.out.println("V_SALE_TYPE2 :" + V_SALE_TYPE2);
		
		if(V_SALE_TYPE2.equals("T")){
			V_SALE_TYPE2 = "";
		}

		//상단
		if (V_TYPE.equals("SH")) {

			cs = conn.prepareCall("call USP_001_M_GR_TO_DN_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_ITS_NO
			cs.setString(4, V_MVMT_DT_FR);//V_MVMT_DT_FR
			cs.setString(5, V_MVMT_DT_TO);//V_DN_DT
			cs.setString(6, "");//V_DN_DT
			cs.setString(7, "");//V_DN_NO
			cs.setString(8, "");//V_DN_SEQ
			cs.setString(9, V_S_BP_NM);//V_S_BP_CD
			cs.setString(10, V_SALE_TYPE2);//V_SALE_TYPE
			cs.setString(11, "");//V_CUR
			cs.setString(12, "");//V_DN_XCHG_RT
			cs.setString(13, "");//V_ITEM_CD
			cs.setString(14, "");//V_DN_QTY
			cs.setString(15, "");//V_DN_BON_QTY
			cs.setString(16, "");//V_DN_BON_WGT_UNIT
			cs.setString(17, "");//V_DN_REAL_QTY
			cs.setString(18, "");//V_DN_PRC
			cs.setString(19, "");//V_DN_AMT
			cs.setString(20, "");//V_DN_LOC_AMT
			cs.setString(21, "");//V_SALE_ISSUE_DT
			cs.setString(22, "");//V_REMARK
			cs.setString(23, "");//V_MVMT_NO
			cs.setString(24, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(25, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(26, "");//V_USR_ID
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, "");//V_FIRST_YN
			cs.setString(29, "");//V_FIRST_YN
			cs.setString(30, "");//V_FIRST_YN
			cs.setString(31, "");//V_FIRST_YN
			cs.setString(32, V_SO_BP_NM);//
			cs.setString(33, "");//V_SL_FREE_DAY
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(27);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_TYPE", rs.getString("APPROV_TYPE"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("CONT_QTY", rs.getString("CONT_QTY"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BON_QTY", rs.getString("BON_QTY"));
				subObject.put("BON_WGT_UNIT", rs.getString("BON_WGT_UNIT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCHG_RT", rs.getString("XCHG_RT"));
				subObject.put("FORWARD_XCH_RT", rs.getString("FORWARD_XCH_RT"));
				subObject.put("FORWARD_XCH_AMT", rs.getString("FORWARD_XCH_AMT"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("RE_BON_QTY", rs.getString("RE_BON_QTY"));
				subObject.put("STOCK_QTY", rs.getString("STOCK_QTY"));
				subObject.put("REMAIN", rs.getString("REMAIN"));
				subObject.put("SALE_TYPE", rs.getString("SALE_TYPE"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_CUR", rs.getString("DN_CUR"));
				subObject.put("DN_XCHG_RT", rs.getString("DN_XCHG_RT"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("DN_LOC_AMT", rs.getString("DN_LOC_AMT"));
				subObject.put("DN_CONT_QTY", rs.getString("DN_CONT_QTY"));
				subObject.put("REMAIN_BON_QTY", rs.getString("REQ_BON_QTY"));
				subObject.put("DN_BON_QTY", rs.getString("DN_BON_QTY"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("ADD_DN_AMT", rs.getString("ADD_DN_AMT"));
				subObject.put("SALE_PRC", rs.getString("SALE_PRC"));
				subObject.put("MVMT_SEQ", rs.getString("MVMT_SEQ"));
				subObject.put("ST_TYPE_NM", rs.getString("ST_TYPE_NM"));
				subObject.put("SPEC1", rs.getString("SPEC1"));
				subObject.put("SPEC2", rs.getString("SPEC2"));
				subObject.put("SPEC3", rs.getString("SPEC3"));
				subObject.put("SPEC4", rs.getString("SPEC4"));
				subObject.put("SPOT_XCH_RT", rs.getString("SPOT_XCH_RT"));
				
				
				if(rs.getString("SL_CHARGE_YN").equals("true")){
					subObject.put("SL_CHARGE_YN", rs.getString("SL_CHARGE_YN"));
				}
				else{
					subObject.put("SL_CHARGE_YN", "");
				}
				

				
				
				if (rs.getString("DN_BON_QTY").equals("0")) {
					subObject.put("SALE_TYPE", "DSO");
					subObject.put("DN_CUR", "KRW");
					subObject.put("DN_XCHG_RT", "1");
					subObject.put("DN_DT", V_DN_DT);
					subObject.put("ISSUE_DT", V_DN_DT);
				}
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

			//하단
		} else if (V_TYPE.equals("SD")) {

			String sql = "";
			sql = "";
			sql = "";
			sql += "SELECT   TO_CHAR(A.DN_DT, 'YYYY-MM-DD') DN_DT, A.ITS_NO, A.DN_NO, A.DN_SEQ, A.ITEM_CD, C.ITEM_NM,                                                                               ";
			sql += "         A.DN_NO, A.DN_SEQ, A.S_BP_CD, B.BP_NM S_BP_NM, A.DN_QTY, DN_BON_QTY,                                                                                                   ";
			sql += "         CEIL((DN_LOC_AMT              + NVL(ADD_DN_AMT, 0))/A.DN_QTY) DN_PRC, DN_LOC_AMT + NVL(ADD_DN_AMT,0) AS DN_LOC_AMT, COG_AMT, COG_FORWAD_AMT, A.SL_AMT, '' FORD_AMT,               ";
			sql += "         case when NVL(A.SL_AMT, 0) > 0 then 'true' else 'false' end SL_CHARGE_YN,               ";
			sql += "         A.INTER_AMT, (NVL(A.SL_AMT, 0) + NVL(A.INTER_AMT, 0)) SALE_COGS_SUM_AMT, case when MARGIN_RATE > 40 then MARGIN_RATE/1000 || '원' else MARGIN_RATE || '%' end MARGIN_RATE, MARGIN_AMT, A.MVMT_NO, A.MVMT_SEQ, E.BL_DOC_NO,                                              ";
			sql += "         NVL(ROUND(A.COG_AMT            /A.DN_QTY, 2), 0) SALE_PRC, A.DN_REAL_QTY, TO_CHAR(G.APPROV_DT, 'YYYY') ||'년 ' || G.APPROV_SEQ || '차' AS APPROV_INFO           ";
			/*
			sql += "         , ROUND(  CASE                                                                                                                                                                   ";
			sql += "                  WHEN A.DN_REAL_QTY IS NULL OR NVL(A.DN_REAL_QTY, 0)=0                                                                                                         ";
			sql += "                  THEN A.DN_LOC_AMT                                                                                                                                             ";
			sql += "                  ELSE A.DN_REAL_QTY * A.DN_PRC                                                                                                                                 ";
			sql += "         END                         + A.ADD_DN_AMT, 0) AS DN_FINAL_AMT 	 , A.DN_PRC + NVL(A.ADD_DN_PRC, 0) DN_FINAL_PRC			                                  			";
			*/
			// 최종매출금액,단가 계산 변경 20200103 김장운.
			sql += "        , case when A.INSRT_USR_ID = 'erpupload' then ";  
			sql += "                ROUND(  CASE                                                                                                                                                                   ";
			sql += "                      WHEN A.DN_REAL_QTY IS NULL OR NVL(A.DN_REAL_QTY, 0)=0                                                                                                         ";
			sql += "                      THEN A.DN_LOC_AMT                                                                                                                                             ";
			sql += "                      ELSE A.DN_REAL_QTY * A.DN_PRC                                                                                                                                 ";
			sql += "                   END                         + A.ADD_DN_AMT, 0)			                                  			";
			sql += "         else NVL(A.DN_LOC_AMT, 0) + NVL(A.INTER_AMT, 0) end  DN_FINAL_AMT  ";
			sql += "         , case when A.INSRT_USR_ID = 'erpupload' then  A.DN_PRC + NVL(A.ADD_DN_PRC, 0)  else  (NVL(A.DN_LOC_AMT, 0) + NVL(A.INTER_AMT, 0)) / A.DN_QTY end  DN_FINAL_PRC ";
			//erpupload 인 경우 팀장님이 만든 단가계산. 다른 경우는 KJW가 수정한 계산방식으로 보이게.
			
			sql += "		, '' CUSTOM_REQ_FLAG, D.BON_QTY MVMT_BON_QTY, '' TEMP_GL_NO , A.SL_FREE_DAY, TO_CHAR(A.SALE_ISSUE_DT, 'YYYY-MM-DD') SALE_ISSUE_DT													";
			sql += "FROM     M_GR_TO_DN_STEEL A                                                                                                                                                     ";
			sql += "         LEFT OUTER JOIN B_BIZ_HSPF B                                                                                                                                           ";
			sql += "         ON       A.COMP_ID=B.COMP_ID                                                                                                                                           ";
			sql += "         AND      A.S_BP_CD=B.BP_CD                                                                                                                                             ";
			sql += "         LEFT OUTER JOIN B_ITEM_HSPF C                                                                                                                                          ";
			sql += "         ON       A.COMP_ID=C.COMP_ID                                                                                                                                           ";
			sql += "         AND      A.ITEM_CD=C.ITEM_CD                                                                                                                                           ";
			sql += "         LEFT OUTER JOIN M_GR_STEEL D                                                                                                                                           ";
			sql += "         ON       A.MVMT_NO  = D.MVMT_NO                                                                                                                                        ";
			sql += "         AND      A.MVMT_sEQ = D.MVMT_SEQ                                                                                                                                       ";
			sql += "         LEFT OUTER JOIN M_CC_HDR_STEEL E                                                                                                                                       ";
			sql += "         ON       D.CC_NO = E.CC_NO                                                                                                                                             ";
			sql += "         LEFT OUTER JOIN M_PO_DTL_STEEL F                                                                                                                                       ";
			sql += "         ON       D.PO_NO  = F.PO_NO                                                                                                                                            ";
			sql += "         AND      D.PO_SEQ = F.PO_SEQ                                                                                                                                           ";
			sql += "         LEFT OUTER JOIN E_APPROV_H_STEEL G                                                                                                                                     ";
			sql += "         ON       F.APPROV_MGM_NO = G.APPROV_MGM_NO                                                                                                                             ";

			//전체보기
			if (V_BL_DOC_NO.equals("")) {
				sql += " WHERE A.MVMT_NO||A.MVMT_SEQ IN " + V_MVMT_NO + "";
			} else if (!V_BL_DOC_NO.equals("*")) {
				sql += " WHERE      E.BL_DOC_NO LIKE '%" + V_BL_DOC_NO + "%'                                                                               ";
				sql += " AND      B.BP_NM LIKE '%" + V_S_BP_NM + "%'";
			} else if (V_BL_DOC_NO.equals("*")) {
				sql += " WHERE      A.DN_DT >= '" + V_DN_DT_FR + "'";
				sql += " AND      A.DN_DT <= '" + V_DN_DT_TO + "'";
				sql += " AND      B.BP_NM LIKE '%" + V_S_BP_NM + "%'";
			}
			sql += " order by A.DN_DT, A.ITS_NO";

// 									System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("ITS_NO", rs.getString("ITS_NO"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_REAL_QTY", rs.getString("DN_REAL_QTY"));
				subObject.put("DN_BON_QTY", rs.getString("DN_BON_QTY"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_LOC_AMT", rs.getString("DN_LOC_AMT"));
				subObject.put("COG_AMT", rs.getString("COG_AMT"));
				subObject.put("COG_FORWAD_AMT", rs.getString("COG_FORWAD_AMT"));
				subObject.put("SL_AMT", rs.getString("SL_AMT"));
				subObject.put("INTER_AMT", rs.getString("INTER_AMT"));
				subObject.put("FORD_AMT", rs.getString("FORD_AMT"));
				subObject.put("MARGIN_RATE", rs.getString("MARGIN_RATE"));
				subObject.put("MARGIN_AMT", rs.getString("MARGIN_AMT"));
				subObject.put("SALE_COGS_SUM_AMT", rs.getString("SALE_COGS_SUM_AMT"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("MVMT_SEQ", rs.getString("MVMT_SEQ"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("SALE_PRC", rs.getString("SALE_PRC"));
				subObject.put("DN_FINAL_AMT", rs.getString("DN_FINAL_AMT"));
				subObject.put("DN_FINAL_PRC", rs.getString("DN_FINAL_PRC"));
				subObject.put("APPROV_INFO", rs.getString("APPROV_INFO"));
				subObject.put("CUSTOM_REQ_FLAG", rs.getString("CUSTOM_REQ_FLAG"));
				subObject.put("MVMT_BON_QTY", rs.getString("MVMT_BON_QTY"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("SL_CHARGE_YN", rs.getString("SL_CHARGE_YN"));
				subObject.put("SL_FREE_DAY", rs.getString("SL_FREE_DAY"));
				subObject.put("SALE_ISSUE_DT", rs.getString("SALE_ISSUE_DT"));
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

			// 			System.out.println(jsonData);
			String V_DN_SEQ = "";

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					String V_DN_NO = request.getParameter("V_DN_NO") == null ? "" : request.getParameter("V_DN_NO").toUpperCase();
					V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();

					if (!V_TYPE.equals("")) {
						String V_ITS_NO = hashMap.get("ITS_NO") == null ? "" : hashMap.get("ITS_NO").toString();
						String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
						String V_SALE_TYPE = hashMap.get("SALE_TYPE") == null ? "" : hashMap.get("SALE_TYPE").toString();
						String V_DN_CUR = hashMap.get("DN_CUR") == null ? "" : hashMap.get("DN_CUR").toString();
						String V_DN_XCHG_RT = hashMap.get("DN_XCHG_RT") == null ? "" : hashMap.get("DN_XCHG_RT").toString();
						String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						String V_DN_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();
						String V_REQ_QTY = hashMap.get("REQ_QTY") == null ? "" : hashMap.get("REQ_QTY").toString();
						String V_SPEC = hashMap.get("SPEC") == null ? "" : hashMap.get("SPEC").toString();
						String V_UNIT = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
						String V_DN_BON_QTY = hashMap.get("REQ_BON_QTY") == null ? "" : hashMap.get("REQ_BON_QTY").toString();
						String V_DN_BON_WGT_UNIT = hashMap.get("BON_WGT_UNIT") == null ? "" : hashMap.get("BON_WGT_UNIT").toString();
						String V_DN_REAL_QTY = hashMap.get("DN_REAL_QTY") == null ? "" : hashMap.get("DN_REAL_QTY").toString();
						String V_DN_PRC = hashMap.get("DN_PRC") == null ? "" : hashMap.get("DN_PRC").toString();
						String V_DN_AMT = hashMap.get("DN_AMT") == null ? "" : hashMap.get("DN_AMT").toString();
						String V_DN_LOC_AMT = hashMap.get("DN_LOC_AMT") == null ? "" : hashMap.get("DN_LOC_AMT").toString();
						String V_SALE_ISSUE_DT = hashMap.get("ISSUE_DT") == null ? "" : hashMap.get("ISSUE_DT").toString().substring(0, 10);
						String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
						V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
						String V_DN_FINAL_AMT = hashMap.get("DN_TOTAL_AMT") == null ? "" : hashMap.get("DN_FINAL_AMT").toString();

						String V_ADD_DN_AMT = hashMap.get("ADD_DN_AMT") == null ? "" : hashMap.get("ADD_DN_AMT").toString();
						String V_MVMT_SEQ = hashMap.get("MVMT_SEQ") == null ? "" : hashMap.get("MVMT_SEQ").toString();
						String V_SL_CHARGE_YN = hashMap.get("SL_CHARGE_YN") == null ? "" : hashMap.get("SL_CHARGE_YN").toString();
						String V_SL_FREE_DAY = hashMap.get("SL_FREE_DAY") == null ? "" : hashMap.get("SL_FREE_DAY").toString();

						if (!V_TYPE.equals("IH") && !V_TYPE.equals("ID")) {
							V_DN_NO = hashMap.get("DN_NO") == null ? "" : hashMap.get("DN_NO").toString();
							V_DN_SEQ = hashMap.get("DN_SEQ") == null ? "" : hashMap.get("DN_SEQ").toString();
							V_DN_DT = hashMap.get("DN_DT") == null ? "" : hashMap.get("DN_DT").toString().substring(0, 10);
						}
						String V_DN_ISSUE_DT = request.getParameter("V_DN_ISSUE_DT") == null ? "" : request.getParameter("V_DN_ISSUE_DT").toUpperCase().substring(0, 10);

						cs = conn.prepareCall("call USP_001_M_GR_TO_DN_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_ITS_NO);//V_ITS_NO
						cs.setString(4, V_MVMT_DT_FR);//V_MVMT_DT_FR
						cs.setString(5, V_MVMT_DT_TO);//V_DN_DT
						cs.setString(6, V_DN_DT);//V_DN_DT
						cs.setString(7, V_DN_NO);//V_DN_NO
						cs.setString(8, V_DN_SEQ);//V_DN_SEQ
						cs.setString(9, V_S_BP_CD);//V_S_BP_CD
						cs.setString(10, V_SALE_TYPE);//V_SALE_TYPE
						cs.setString(11, V_DN_CUR);//V_CUR
						cs.setString(12, V_DN_XCHG_RT);//V_DN_XCHG_RT
						cs.setString(13, V_ITEM_CD);//V_ITEM_CD

						String DN_QTY = "";
						if (V_TYPE.equals("ID")) {
							DN_QTY = V_REQ_QTY;

							double V_DN_QTY1 = Double.parseDouble(V_REQ_QTY);
							double V_DN_QTY2 = (Math.round(V_DN_QTY1 * 10000) / 10000.0);

							DN_QTY = V_DN_QTY2 + "";

						} else {
							double V_DN_QTY1 = Double.parseDouble(V_DN_QTY);
							double V_DN_QTY2 = (Math.round(V_DN_QTY1 * 10000) / 10000.0);

							DN_QTY = V_DN_QTY2 + "";
						}
						cs.setString(14, DN_QTY);//V_DN_BON_QTY
						cs.setString(15, V_DN_BON_QTY);//V_DN_BON_QTY
						cs.setString(16, V_DN_BON_WGT_UNIT);//V_DN_BON_WGT_UNIT
						cs.setString(17, V_DN_REAL_QTY);//V_DN_REAL_QTY
						cs.setString(18, V_DN_PRC);//V_DN_PRC
						cs.setString(19, V_DN_AMT);//V_DN_AMT
						cs.setString(20, V_DN_LOC_AMT);//V_DN_LOC_AMT
						cs.setString(21, V_DN_ISSUE_DT);//V_SALE_ISSUE_DT
						cs.setString(22, V_REMARK);//V_REMARK
						cs.setString(23, V_MVMT_NO);//V_MVMT_NO
						cs.setString(24, V_LC_DOC_NO);//V_LC_DOC_NO
						cs.setString(25, V_BL_DOC_NO);//V_BL_DOC_NO
						cs.setString(26, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(28, "");//V_FIRST_YN
						cs.setString(29, V_DN_FINAL_AMT);//V_DN_FINAL_AMT
						cs.setString(30, V_ADD_DN_AMT);//V_ADD_DN_AMT
						cs.setString(31, V_MVMT_SEQ);//V_ADD_DN_AMT
						cs.setString(32, "");//
						cs.setString(33, V_SL_FREE_DAY);//
						cs.executeQuery();

						/*계산LOG남기기*/
						/*계산LOG남기기*/
						/*계산LOG남기기*/
						
						String V_BS_DT = V_DN_DT;
						String V_BS_BON_QTY = V_DN_BON_QTY;
						String V_BS_QTY = DN_QTY;
						String V_BAS_STEP = "DS";

						rs = (ResultSet) cs.getObject(27);

						String V_BAS_NO = "NO";
						while (rs.next()) {
							V_BAS_NO = rs.getString("BAS_NO");
						}

// 						System.out.println("+++++++++V_BAS_NO" + V_BAS_NO);
// 						System.out.println("+++++++++V_BAS_STEP" + V_BAS_STEP);

// 						System.out.println("V_COMP_ID" + V_COMP_ID);
// 						System.out.println("V_TYPE" + V_TYPE);
// 						System.out.println("V_BS_DT" + V_BS_DT);
// 						System.out.println("V_BS_BON_QTY" + V_BS_BON_QTY);
// 						System.out.println("V_BS_QTY" + V_BS_QTY);
// 						System.out.println("V_BAS_STEP" + V_BAS_STEP);
// 						System.out.println("V_BAS_NO" + V_BAS_NO);
// 						System.out.println("V_MVMT_NO" + V_MVMT_NO);
// 						System.out.println("V_ITEM_CD" + V_ITEM_CD);

						if (!V_BAS_NO.equals("NO")) {
							cs = conn.prepareCall("call USP_001_Z_A_LOG_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, V_COMP_ID);
							cs.setString(2, "I");
							cs.setString(3, V_BS_DT);
							cs.setString(4, V_BS_BON_QTY);
							cs.setString(5, V_BS_QTY);
							cs.setString(6, V_BAS_NO);
							cs.setString(7, V_BAS_STEP);
							cs.setString(8, V_ITEM_CD);
							cs.setString(9, V_MVMT_NO);
							cs.setString(10, V_MVMT_SEQ);
							cs.setString(11, V_USR_ID);
							cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
							cs.setString(13, V_SL_CHARGE_YN);
							cs.setString(14, V_SL_FREE_DAY);
							cs.executeQuery();
						}
						
						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}

				}
			} else {

// 				JSONObject jsondata = JSONObject.fromObject(jsonData);
				//큰수에 소수점이 있는경우 숫자계산이 이상해서 수정함. 20200108 김장운

				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);					
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				if (!V_TYPE.equals("")) {
					String V_ITS_NO = jsondata.get("ITS_NO") == null ? "" : jsondata.get("ITS_NO").toString();
					String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
					String V_SALE_TYPE = jsondata.get("SALE_TYPE") == null ? "" : jsondata.get("SALE_TYPE").toString();
					String V_DN_CUR = jsondata.get("DN_CUR") == null ? "" : jsondata.get("DN_CUR").toString();
					String V_DN_XCHG_RT = jsondata.get("DN_XCHG_RT") == null ? "" : jsondata.get("DN_XCHG_RT").toString();
					String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					String V_DN_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();
					String V_REQ_QTY = jsondata.get("REQ_QTY") == null ? "" : jsondata.get("REQ_QTY").toString();
					String V_SPEC = jsondata.get("SPEC") == null ? "" : jsondata.get("SPEC").toString();
					String V_UNIT = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
					String V_DN_BON_QTY = jsondata.get("REQ_BON_QTY") == null ? "" : jsondata.get("REQ_BON_QTY").toString();
					String V_DN_BON_WGT_UNIT = jsondata.get("BON_WGT_UNIT") == null ? "" : jsondata.get("BON_WGT_UNIT").toString();
					String V_DN_REAL_QTY = jsondata.get("DN_REAL_QTY") == null ? "" : jsondata.get("DN_REAL_QTY").toString();
					String V_DN_PRC = jsondata.get("DN_PRC") == null ? "" : jsondata.get("DN_PRC").toString();
					String V_DN_AMT = jsondata.get("DN_AMT") == null ? "" : jsondata.get("DN_AMT").toString();
					String V_DN_LOC_AMT = jsondata.get("DN_LOC_AMT") == null ? "" : jsondata.get("DN_LOC_AMT").toString();
					String V_SALE_ISSUE_DT = jsondata.get("ISSUE_DT") == null ? "" : jsondata.get("ISSUE_DT").toString().substring(0, 10);
					String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
					V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
					String V_DN_FINAL_AMT = jsondata.get("DN_TOTAL_AMT") == null ? "" : jsondata.get("DN_FINAL_AMT").toString();
					String V_ADD_DN_AMT = jsondata.get("ADD_DN_AMT") == null ? "" : jsondata.get("ADD_DN_AMT").toString();
					String V_DN_NO = request.getParameter("V_DN_NO") == null ? "" : request.getParameter("V_DN_NO").toUpperCase();
					V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);
					String V_MVMT_SEQ = jsondata.get("MVMT_SEQ") == null ? "" : jsondata.get("MVMT_SEQ").toString();
					String V_SL_CHARGE_YN = jsondata.get("SL_CHARGE_YN") == null ? "" : jsondata.get("SL_CHARGE_YN").toString();
					String V_SL_FREE_DAY = jsondata.get("SL_FREE_DAY") == null ? "" : jsondata.get("SL_FREE_DAY").toString();


					if (!V_TYPE.equals("IH") && !V_TYPE.equals("ID")) {
						V_DN_NO = jsondata.get("DN_NO") == null ? "" : jsondata.get("DN_NO").toString();
						V_DN_SEQ = jsondata.get("DN_SEQ") == null ? "" : jsondata.get("DN_SEQ").toString();
						V_DN_DT = jsondata.get("DN_DT") == null ? "" : jsondata.get("DN_DT").toString().substring(0, 10);
					}
					
					String V_DN_ISSUE_DT = request.getParameter("V_DN_ISSUE_DT") == null ? "" : request.getParameter("V_DN_ISSUE_DT").toUpperCase().substring(0, 10);

					cs = conn.prepareCall("call USP_001_M_GR_TO_DN_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_ITS_NO);//V_ITS_NO
					cs.setString(4, V_MVMT_DT_FR);//V_MVMT_DT_FR
					cs.setString(5, V_MVMT_DT_TO);//V_DN_DT
					cs.setString(6, V_DN_DT);//V_DN_DT
					cs.setString(7, V_DN_NO);//V_DN_NO
					cs.setString(8, V_DN_SEQ);//V_DN_SEQ
					cs.setString(9, V_S_BP_CD);//V_S_BP_CD
					cs.setString(10, V_SALE_TYPE);//V_SALE_TYPE
					cs.setString(11, V_DN_CUR);//V_CUR
					cs.setString(12, V_DN_XCHG_RT);//V_DN_XCHG_RT
					cs.setString(13, V_ITEM_CD);//V_ITEM_CD

					String DN_QTY = "";
					if (V_TYPE.equals("ID")) {

						double V_DN_QTY1 = Double.parseDouble(V_REQ_QTY);
						double V_DN_QTY2 = (Math.round(V_DN_QTY1 * 10000) / 10000.0);

						DN_QTY = V_DN_QTY2 + "";

					} else {
						double V_DN_QTY1 = Double.parseDouble(V_DN_QTY);
						double V_DN_QTY2 = (Math.round(V_DN_QTY1 * 10000) / 10000.0);

						DN_QTY = V_DN_QTY2 + "";
					}

					cs.setString(14, DN_QTY);//V_DN_BON_QTY
					cs.setString(15, V_DN_BON_QTY);//V_DN_BON_QTY
					cs.setString(16, V_DN_BON_WGT_UNIT);//V_DN_BON_WGT_UNIT
					cs.setString(17, V_DN_REAL_QTY);//V_DN_REAL_QTY
					cs.setString(18, V_DN_PRC);//V_DN_PRC
					cs.setString(19, V_DN_AMT);//V_DN_AMT
					cs.setString(20, V_DN_LOC_AMT);//V_DN_LOC_AMT
					cs.setString(21, V_DN_ISSUE_DT);//V_SALE_ISSUE_DT
					cs.setString(22, V_REMARK);//V_REMARK
					cs.setString(23, V_MVMT_NO);//V_MVMT_NO
					cs.setString(24, V_LC_DOC_NO);//V_LC_DOC_NO
					cs.setString(25, V_BL_DOC_NO);//V_BL_DOC_NO
					cs.setString(26, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(28, "");//V_FIRST_YN
					cs.setString(29, V_DN_FINAL_AMT);//V_DN_FINAL_AMT
					cs.setString(30, V_ADD_DN_AMT);//V_ADD_DN_AMT
					cs.setString(31, V_MVMT_SEQ);//V_ADD_DN_AMT
					cs.setString(32, "");//
					cs.setString(33, V_SL_FREE_DAY);//
					cs.executeQuery();

					/*계산LOG남기기*/
					/*계산LOG남기기*/
					/*계산LOG남기기*/
					
					String V_BS_DT = V_DN_DT;
					String V_BS_BON_QTY = V_DN_BON_QTY;
					String V_BS_QTY = DN_QTY;
					String V_BAS_STEP = "DS";

					rs = (ResultSet) cs.getObject(27);

					String V_BAS_NO = "NO";
					while (rs.next()) {
						V_BAS_NO = rs.getString("BAS_NO");
					}

// 					System.out.println("+++++++++V_BAS_NO" + V_BAS_NO);
// 					System.out.println("+++++++++V_BAS_STEP" + V_BAS_STEP);

// 					System.out.println("V_COMP_ID" + V_COMP_ID);
// 					System.out.println("V_TYPE" + V_TYPE);
// 					System.out.println("V_BS_DT" + V_BS_DT);
// 					System.out.println("V_BS_BON_QTY" + V_BS_BON_QTY);
// 					System.out.println("V_BS_QTY" + V_BS_QTY);
// 					System.out.println("V_BAS_STEP" + V_BAS_STEP);
// 					System.out.println("V_BAS_NO" + V_BAS_NO);
// 					System.out.println("V_MVMT_NO" + V_MVMT_NO);
// 					System.out.println("V_ITEM_CD" + V_ITEM_CD);

					if (!V_BAS_NO.equals("NO")) {
						cs = conn.prepareCall("call USP_001_Z_A_LOG_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);
						cs.setString(2, "I");
						cs.setString(3, V_BS_DT);
						cs.setString(4, V_BS_BON_QTY);
						cs.setString(5, V_BS_QTY);
						cs.setString(6, V_BAS_NO);
						cs.setString(7, V_BAS_STEP);
						cs.setString(8, V_ITEM_CD);
						cs.setString(9, V_MVMT_NO);
						cs.setString(10, V_MVMT_SEQ);
						cs.setString(11, V_USR_ID);
						cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(13, V_SL_CHARGE_YN);
						cs.setString(14, V_SL_FREE_DAY);
						cs.executeQuery();
					}
					
					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
				}

			}
		} 
		else if (V_TYPE.equals("DT_SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);
			String V_DN_SEQ = "";

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();

					if (!V_TYPE.equals("")) {
						
						
						String V_ITS_NO = hashMap.get("ITS_NO") == null ? "" : hashMap.get("ITS_NO").toString();
						String V_SALE_ISSUE_DT = hashMap.get("SALE_ISSUE_DT") == null ? "" : hashMap.get("SALE_ISSUE_DT").toString().substring(0, 10);

						cs = conn.prepareCall("call USP_001_M_GR_TO_DN_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_ITS_NO);//V_ITS_NO
						cs.setString(4, "");//V_MVMT_DT_FR
						cs.setString(5, "");//V_DN_DT
						cs.setString(6, "");//V_DN_DT
						cs.setString(7, "");//V_DN_NO
						cs.setString(8, "");//V_DN_SEQ
						cs.setString(9, "");//V_S_BP_CD
						cs.setString(10, "");//V_SALE_TYPE
						cs.setString(11, "");//V_CUR
						cs.setString(12, "");//V_DN_XCHG_RT
						cs.setString(13, "");//V_ITEM_CD
						cs.setString(14, "");//V_DN_BON_QTY
						cs.setString(15, "");//V_DN_BON_QTY
						cs.setString(16, "");//V_DN_BON_WGT_UNIT
						cs.setString(17, "");//V_DN_REAL_QTY
						cs.setString(18, "");//V_DN_PRC
						cs.setString(19, "");//V_DN_AMT
						cs.setString(20, "");//V_DN_LOC_AMT
						cs.setString(21, V_SALE_ISSUE_DT);//V_SALE_ISSUE_DT
						cs.setString(22, "");//V_REMARK
						cs.setString(23, "");//V_MVMT_NO
						cs.setString(24, "");//V_LC_DOC_NO
						cs.setString(25, "");//V_BL_DOC_NO
						cs.setString(26, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(28, "");//V_FIRST_YN
						cs.setString(29, "");//V_DN_FINAL_AMT
						cs.setString(30, "");//V_ADD_DN_AMT
						cs.setString(31, "");//V_ADD_DN_AMT
						cs.setString(32, "");//
						cs.setString(33, "");//
						cs.executeQuery();

					}

				}
			} else {
	
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);					
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				if (!V_TYPE.equals("")) {
					String V_ITS_NO = jsondata.get("ITS_NO") == null ? "" : jsondata.get("ITS_NO").toString();
					String V_SALE_ISSUE_DT = jsondata.get("SALE_ISSUE_DT") == null ? "" : jsondata.get("SALE_ISSUE_DT").toString().substring(0, 10);

					cs = conn.prepareCall("call USP_001_M_GR_TO_DN_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_ITS_NO);//V_ITS_NO
					cs.setString(4, "");//V_MVMT_DT_FR
					cs.setString(5, "");//V_DN_DT
					cs.setString(6, "");//V_DN_DT
					cs.setString(7, "");//V_DN_NO
					cs.setString(8, "");//V_DN_SEQ
					cs.setString(9, "");//V_S_BP_CD
					cs.setString(10, "");//V_SALE_TYPE
					cs.setString(11, "");//V_CUR
					cs.setString(12, "");//V_DN_XCHG_RT
					cs.setString(13, "");//V_ITEM_CD
					cs.setString(14, "");//V_DN_BON_QTY
					cs.setString(15, "");//V_DN_BON_QTY
					cs.setString(16, "");//V_DN_BON_WGT_UNIT
					cs.setString(17, "");//V_DN_REAL_QTY
					cs.setString(18, "");//V_DN_PRC
					cs.setString(19, "");//V_DN_AMT
					cs.setString(20, "");//V_DN_LOC_AMT
					cs.setString(21, V_SALE_ISSUE_DT);//V_SALE_ISSUE_DT
					cs.setString(22, "");//V_REMARK
					cs.setString(23, "");//V_MVMT_NO
					cs.setString(24, "");//V_LC_DOC_NO
					cs.setString(25, "");//V_BL_DOC_NO
					cs.setString(26, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(28, "");//V_FIRST_YN
					cs.setString(29, "");//V_DN_FINAL_AMT
					cs.setString(30, "");//V_ADD_DN_AMT
					cs.setString(31, "");//V_ADD_DN_AMT
					cs.setString(32, "");//
					cs.setString(33, "");//
					cs.executeQuery();
				}

			}
		}
			else if (V_TYPE.equals("IH")) {

			V_DN_DT = request.getParameter("V_DN_DT") == null ? "" : request.getParameter("V_DN_DT").toUpperCase().substring(0, 10);

			cs = conn.prepareCall("call USP_001_M_GR_TO_DN_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_ITS_NO
			cs.setString(4, "");//V_MVMT_DT_FR
			cs.setString(5, "");//V_MVMT_DT_TO
			cs.setString(6, V_DN_DT);//V_DN_DT
			cs.setString(7, "");//V_DN_NO
			cs.setString(8, "");//V_DN_SEQ
			cs.setString(9, "");//V_S_BP_CD
			cs.setString(10, "");//V_SALE_TYPE
			cs.setString(11, "");//V_CUR
			cs.setString(12, "");//V_DN_XCHG_RT
			cs.setString(13, "");//V_ITEM_CD
			cs.setString(14, "");//V_DN_QTY
			cs.setString(15, "");//V_DN_BON_QTY
			cs.setString(16, "");//V_DN_BON_WGT_UNIT
			cs.setString(17, "");//V_DN_REAL_QTY
			cs.setString(18, "");//V_DN_PRC
			cs.setString(19, "");//V_DN_AMT
			cs.setString(20, "");//V_DN_LOC_AMT
			cs.setString(21, "");//V_SALE_ISSUE_DT
			cs.setString(22, "");//V_REMARK
			cs.setString(23, "");//V_MVMT_NO
			cs.setString(24, "");//V_LC_DOC_NO
			cs.setString(25, "");//V_BL_DOC_NO
			cs.setString(26, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, "");//V_FIRST_YN
			cs.setString(29, "");//V_FIRST_YN
			cs.setString(30, "");//V_FIRST_YN
			cs.setString(31, "");//V_FIRST_YN
			cs.setString(32, "");//
			cs.setString(33, "");//
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(27);
			String DN_NO = "";

			while (rs.next()) {
				DN_NO = rs.getString("DN_NO");
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(DN_NO);
			pw.flush();
			pw.close();
		} else if (V_TYPE.equals("CALC_POP")) {
			String V_BS_DT = request.getParameter("V_BS_DT") == null ? "" : request.getParameter("V_BS_DT").substring(0, 10);
			String V_BS_BON_QTY = request.getParameter("V_BS_BON_QTY") == null ? "" : request.getParameter("V_BS_BON_QTY");
			String V_BS_QTY = request.getParameter("V_BS_QTY") == null ? "" : request.getParameter("V_BS_QTY");
			String V_BAS_STEP = request.getParameter("V_BAS_STEP") == null ? "" : request.getParameter("V_BAS_STEP");
			String V_BAS_NO = request.getParameter("V_BAS_NO") == null ? "" : request.getParameter("V_BAS_NO");
			V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO");
			String V_MVMT_SEQ = request.getParameter("V_MVMT_SEQ") == null ? "" : request.getParameter("V_MVMT_SEQ");
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");
			String V_SL_CHARGE_YN = request.getParameter("V_SL_CHARGE_YN") == null ? "" : request.getParameter("V_SL_CHARGE_YN");
			String V_SL_FREE_DAY = request.getParameter("V_SL_FREE_DAY") == null ? "" : request.getParameter("V_SL_FREE_DAY");

// 			System.out.println("V_COMP_ID : " + V_COMP_ID);
// 			System.out.println("V_TYPE : " + V_TYPE);
// 			System.out.println("V_BS_DT : " + V_BS_DT);
// 			System.out.println("V_BS_BON_QTY : " + V_BS_BON_QTY);
// 			System.out.println("V_BS_QTY : " + V_BS_QTY);
// 			System.out.println("V_BAS_STEP : " + V_BAS_STEP);
// 			System.out.println("V_BAS_NO : " + V_BAS_NO);
// 			System.out.println("V_MVMT_NO : " + V_MVMT_NO);
// 			System.out.println("V_MVMT_SEQ : " + V_MVMT_SEQ);
// 			System.out.println("V_ITEM_CD : " + V_ITEM_CD);
// 			System.out.println("V_SL_CHARGE_YN : " + V_SL_CHARGE_YN);
// 			System.out.println("V_SL_FREE_DAY : " + V_SL_FREE_DAY);

			cs = conn.prepareCall("call USP_001_Z_A_LOG_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);
			cs.setString(2, "I");
			cs.setString(3, V_BS_DT);
			cs.setString(4, V_BS_BON_QTY);
			cs.setString(5, V_BS_QTY);
			cs.setString(6, V_BAS_NO);
			cs.setString(7, V_BAS_STEP);
			cs.setString(8, V_ITEM_CD);
			cs.setString(9, V_MVMT_NO);
			cs.setString(10, V_MVMT_SEQ);
			cs.setString(11, V_USR_ID);
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, V_SL_CHARGE_YN);
			cs.setString(14, V_SL_FREE_DAY);
			cs.executeQuery();

			cs = conn.prepareCall("call USP_001_Z_A_LOG_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);
			cs.setString(2, "S");
			cs.setString(3, V_BS_DT);
			cs.setString(4, V_BS_BON_QTY);
			cs.setString(5, V_BS_QTY);
			cs.setString(6, V_BAS_NO);
			cs.setString(7, V_BAS_STEP);
			cs.setString(8, V_ITEM_CD);
			cs.setString(9, V_MVMT_NO);
			cs.setString(10, V_MVMT_SEQ);
			cs.setString(11, V_USR_ID);
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(13, V_SL_CHARGE_YN);
			cs.setString(14, V_SL_FREE_DAY);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("EX_NO", rs.getString("EX_NO"));
				subObject.put("EX_DT", rs.getString("EX_DT"));
				subObject.put("BAS_STEP", rs.getString("BAS_STEP"));
				subObject.put("BAS_NO", rs.getString("BAS_NO"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("PRC_FLG", rs.getString("PRC_FLG"));
				subObject.put("IV_BON_QTY", rs.getString("IV_BON_QTY"));
				subObject.put("IV_QTY", rs.getString("IV_QTY"));
				subObject.put("IV_AMT", rs.getString("IV_AMT"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("LC_OPEN_AMT", rs.getString("LC_OPEN_AMT"));
				subObject.put("LC_AMEND_AMT", rs.getString("LC_AMEND_AMT"));
				subObject.put("ETC_AMT", rs.getString("ETC_AMT"));
				subObject.put("INSUR_AMT", rs.getString("INSUR_AMT"));
				subObject.put("STEEL_CC_AMT", rs.getString("STEEL_CC_AMT"));
				subObject.put("TAX_AMT", rs.getString("TAX_AMT"));
				subObject.put("REC_AMT", rs.getString("REC_AMT"));
				subObject.put("STEEL_AMT", rs.getString("STEEL_AMT"));
				subObject.put("IV_E_AMT", rs.getString("IV_E_AMT"));
				subObject.put("IV_BASE_PRC", rs.getString("IV_BASE_PRC"));

				subObject.put("DN_BON_QTY", rs.getString("DN_BON_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_COG_AMT", rs.getString("DN_COG_AMT"));
				subObject.put("DN_ETC_COG_AMT", rs.getString("DN_ETC_COG_AMT"));
				subObject.put("DN_CALC_AMT", rs.getString("DN_CALC_AMT"));
				subObject.put("PER_AMT", rs.getString("PER_AMT"));
				subObject.put("OV_AMT", rs.getString("OV_AMT"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("F_DN_PRC", rs.getString("F_DN_PRC"));
				subObject.put("REAL_QTY", rs.getString("REAL_QTY"));
				subObject.put("LAST_DN_AMT", rs.getString("LAST_DN_AMT"));
				subObject.put("LAST_DN_PRC", rs.getString("LAST_DN_PRC"));
				subObject.put("LAST_COG_AMT", rs.getString("LAST_COG_AMT"));
				subObject.put("PROF_AMT", rs.getString("PROF_AMT"));
				subObject.put("ST_AMT", rs.getString("ST_AMT"));
				subObject.put("IO_AMT", rs.getString("IO_AMT"));
				subObject.put("JOB_AMT", rs.getString("JOB_AMT"));
				subObject.put("WT_AMT", rs.getString("WT_AMT"));
				subObject.put("CK_AMT", rs.getString("CK_AMT"));
				subObject.put("AP_AMT", rs.getString("AP_AMT"));
				subObject.put("SL_TOT_AMT", rs.getString("SL_TOT_AMT"));
				subObject.put("MV_AMT", rs.getString("MV_AMT"));
				subObject.put("BK_AMT", rs.getString("BK_AMT"));
				subObject.put("MG_RT", rs.getString("MG_RT"));
				subObject.put("MG_AMT", rs.getString("MG_AMT"));
				subObject.put("DN_CALC_AMT", rs.getString("DN_CALC_AMT"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_COG_AMT", rs.getString("DN_COG_AMT"));
				subObject.put("DN_ETC_COG_SUM_AMT", rs.getString("DN_ETC_COG_SUM_AMT"));

				subObject.put("REAL_QTY", rs.getString("REAL_QTY"));
				subObject.put("LAST_DN_AMT", rs.getString("LAST_DN_AMT"));
				subObject.put("LAST_DN_PRC", rs.getString("LAST_DN_PRC"));

				subObject.put("PROF_AMT", rs.getString("PROF_AMT"));
				subObject.put("PROF_RT", rs.getString("PROF_RT"));

				subObject.put("MID_DN_PRC", rs.getString("MID_DN_PRC")); //BL 매출단가/금액
				subObject.put("MID_DN_AMT", rs.getString("MID_DN_AMT")); //BL 매출단가/금액
				
				subObject.put("FORWARD_XCH_RT", rs.getString("FORWARD_XCH_RT")); //선물환율
				subObject.put("SPOT_XCH_RT", rs.getString("SPOT_XCH_RT")); //현물환율
				
				subObject.put("USANCE_AMT", rs.getString("USANCE_AMT")); //유산스이자
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("CHARGE")) {
			String U_TYPE = request.getParameter("U_TYPE") == null ? "" : request.getParameter("U_TYPE");
			V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO");

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
					subObject.put("BON_QTY", rs.getString("BON_QTY"));
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

// 					JSONObject jsondata = JSONObject.fromObject(jsonData);
					//큰수에 소수점이 있는경우 숫자계산이 이상해서 수정함. 20200108 김장운

					JSONParser parser = new JSONParser();
					Object obj = parser.parse(jsonData);					
					JSONObject jsondata = (JSONObject) obj;
					
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					String V_CHARGE_NO = jsondata.get("CHARGE_NO") == null ? "" : jsondata.get("CHARGE_NO").toString();
					String V_CHARGE_SEQ = jsondata.get("CHARGE_SEQ") == null ? "" : jsondata.get("CHARGE_SEQ").toString();
					String V_DISTB_AMT = jsondata.get("DISTB_AMT") == null ? "" : jsondata.get("DISTB_AMT").toString();

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


