<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
		String V_YYYYMMDD = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE").replace("-", "").substring(0, 8);
		String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
		String V_USR_NM = request.getParameter("V_USR_NM") == null ? "" : request.getParameter("V_USR_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_MAKER = request.getParameter("V_MAKER") == null ? "" : request.getParameter("V_MAKER").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_M_IMP_CHK_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMMDD);//V_YYYYMMDD
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.setString(6, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, "");//V_MR_NO
			cs.setString(9, "");//V_MR_SEQ
			cs.setString(10, "");//V_FR_ADD_QTY
			cs.setString(11, "");//V_REMARK
			cs.setString(12, V_USR_NM);//V_USR_NM
			cs.setString(13, "");//V_SF_DAY
			cs.setString(14, "");//V_FR_O_BP_QTY
			cs.setString(15, "");//V_LT_DAY
			cs.setString(16, V_MAKER);//V_MAKER
			cs.setString(17, "");//V_HSTN_QTY
			cs.setString(18, "");//V_HSMI_QTY
			cs.setString(19, "");//V_SYS_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MR_NO", rs.getString("MR_NO"));
				subObject.put("MR_SEQ", rs.getString("MR_SEQ"));
				subObject.put("YYYYMMDD", rs.getString("YYYYMMDD"));
				subObject.put("MAKER", rs.getString("MAKER"));
				subObject.put("S_ITEM_CD", rs.getString("S_ITEM_CD"));
				subObject.put("S_ITEM_NM", rs.getString("S_ITEM_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("SF_DAY", rs.getString("SF_DAY"));
				subObject.put("FR_I_BP_QTY", rs.getString("FR_I_BP_QTY"));
				subObject.put("FR_O_BP_QTY", rs.getString("FR_O_BP_QTY"));
// 				subObject.put("FR_MB_BP_QTY", rs.getString("FR_MB_BP_QTY"));
				subObject.put("FR_MT_BP_QTY", rs.getString("FR_MT_BP_QTY"));
				subObject.put("FR_ADD_QTY", rs.getString("FR_ADD_QTY"));
				subObject.put("HSTN_QTY", rs.getString("HSTN_QTY"));
				subObject.put("HSMI_QTY", rs.getString("HSMI_QTY"));
				subObject.put("FR_M_QTY", rs.getString("FR_M_QTY"));
				subObject.put("FR_D_QTY", rs.getString("FR_D_QTY"));
				subObject.put("ST_MT_QTY", rs.getString("ST_MT_QTY"));
				subObject.put("ST_TP_QTY", rs.getString("ST_TP_QTY"));
				subObject.put("ST_NET_QTY", rs.getString("ST_NET_QTY"));
				subObject.put("ST_CY_QTY", rs.getString("ST_CY_QTY"));
				subObject.put("ST_TOT_QTY", rs.getString("ST_TOT_QTY"));
				subObject.put("AVL_DT", rs.getString("AVL_DT"));
				subObject.put("AVL_DAY", rs.getString("AVL_DAY"));
				subObject.put("AVL_I_USE_QTY", rs.getString("AVL_I_USE_QTY"));
				subObject.put("AVL_O_USE_QTY", rs.getString("AVL_O_USE_QTY"));
				subObject.put("AVL_MT_USE_QTY", rs.getString("AVL_MT_USE_QTY"));
				subObject.put("AVL_TOT_USE_QTY", rs.getString("AVL_TOT_USE_QTY"));
				subObject.put("AVL_TOT_USE_RT", rs.getString("AVL_TOT_USE_RT"));
				subObject.put("AVL_DAY_USE_RT", rs.getString("AVL_DAY_USE_RT"));
// 				subObject.put("AVL_MT_USE_RT", rs.getString("AVL_MT_USE_RT"));
				subObject.put("FT_PO_DT", rs.getString("FT_PO_DT"));
				subObject.put("BF_MR_NO", rs.getString("BF_MR_NO"));
				subObject.put("BF_MR_SEQ", rs.getString("BF_MR_SEQ"));
				subObject.put("LT_MNTH", rs.getString("LT_MNTH"));
				subObject.put("LT_DAY", rs.getString("LT_DAY"));
				subObject.put("MIN_PO_QTY", rs.getString("MIN_PO_QTY"));
				subObject.put("STOCK_YN", rs.getString("STOCK_YN"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("USR_NM", rs.getString("USR_NM"));
				
				subObject.put("SYS_TYPE", rs.getString("SYS_TYPE"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				subObject.put("FR_QTY", rs.getString("FR_QTY"));
				subObject.put("FR_NEXT1_QTY", rs.getString("FR_NEXT1_QTY"));
				subObject.put("FR_NEXT2_QTY", rs.getString("FR_NEXT2_QTY"));
				subObject.put("FR_NEXT3_QTY", rs.getString("FR_NEXT3_QTY"));
				subObject.put("FR_NEXT4_QTY", rs.getString("FR_NEXT4_QTY"));
				subObject.put("FR_NEXT5_QTY", rs.getString("FR_NEXT5_QTY"));
				subObject.put("BEFORE1_QTY", rs.getString("BEFORE1_QTY"));
				subObject.put("BEFORE2_QTY", rs.getString("BEFORE2_QTY"));
				subObject.put("BEFORE3_QTY", rs.getString("BEFORE3_QTY"));
				subObject.put("BEFORE4_QTY", rs.getString("BEFORE4_QTY"));
				subObject.put("BEFORE5_QTY", rs.getString("BEFORE5_QTY"));
				subObject.put("PLAN_D_QTY", rs.getString("PLAN_D_QTY"));
				subObject.put("AVL_PLAN_DT", rs.getString("AVL_PLAN_DT"));

				subObject.put("PO_NO1", rs.getString("PO_NO1"));
				subObject.put("PO_SEQ1", rs.getString("PO_SEQ1"));
				subObject.put("PO_QTY1", rs.getString("PO_QTY1"));
				subObject.put("RTA1", rs.getString("RTA1"));
				subObject.put("ETA1", rs.getString("ETA1"));
				subObject.put("BL_DOC_NO1", rs.getString("BL_DOC_NO1"));
				subObject.put("AVL_DT1", rs.getString("AVL_DT1"));
				subObject.put("SF_DAY1", rs.getString("SF_DAY1"));
				subObject.put("REMARK1", rs.getString("REMARK1"));
				subObject.put("PO_NO2", rs.getString("PO_NO2"));
				subObject.put("PO_SEQ2", rs.getString("PO_SEQ2"));
				subObject.put("PO_QTY2", rs.getString("PO_QTY2"));
				subObject.put("RTA2", rs.getString("RTA2"));
				subObject.put("ETA2", rs.getString("ETA2"));
				subObject.put("BL_DOC_NO2", rs.getString("BL_DOC_NO2"));
				subObject.put("AVL_DT2", rs.getString("AVL_DT2"));
				subObject.put("SF_DAY2", rs.getString("SF_DAY2"));
				subObject.put("REMARK2", rs.getString("REMARK2"));
				subObject.put("PO_NO3", rs.getString("PO_NO3"));
				subObject.put("PO_SEQ3", rs.getString("PO_SEQ3"));
				subObject.put("PO_QTY3", rs.getString("PO_QTY3"));
				subObject.put("RTA3", rs.getString("RTA3"));
				subObject.put("ETA3", rs.getString("ETA3"));
				subObject.put("BL_DOC_NO3", rs.getString("BL_DOC_NO3"));
				subObject.put("AVL_DT3", rs.getString("AVL_DT3"));
				subObject.put("SF_DAY3", rs.getString("SF_DAY3"));
				subObject.put("REMARK3", rs.getString("REMARK3"));
				subObject.put("PO_NO4", rs.getString("PO_NO4"));
				subObject.put("PO_SEQ4", rs.getString("PO_SEQ4"));
				subObject.put("PO_QTY4", rs.getString("PO_QTY4"));
				subObject.put("RTA4", rs.getString("RTA4"));
				subObject.put("ETA4", rs.getString("ETA4"));
				subObject.put("BL_DOC_NO4", rs.getString("BL_DOC_NO4"));
				subObject.put("AVL_DT4", rs.getString("AVL_DT4"));
				subObject.put("SF_DAY4", rs.getString("SF_DAY4"));
				subObject.put("REMARK4", rs.getString("REMARK4"));
				subObject.put("PO_NO5", rs.getString("PO_NO5"));
				subObject.put("PO_SEQ5", rs.getString("PO_SEQ5"));
				subObject.put("PO_QTY5", rs.getString("PO_QTY5"));
				subObject.put("RTA5", rs.getString("RTA5"));
				subObject.put("ETA5", rs.getString("ETA5"));
				subObject.put("BL_DOC_NO5", rs.getString("BL_DOC_NO5"));
				subObject.put("AVL_DT5", rs.getString("AVL_DT5"));
				subObject.put("SF_DAY5", rs.getString("SF_DAY5"));
				subObject.put("REMARK5", rs.getString("REMARK5"));
				subObject.put("PO_NO6", rs.getString("PO_NO6"));
				subObject.put("PO_SEQ6", rs.getString("PO_SEQ6"));
				subObject.put("PO_QTY6", rs.getString("PO_QTY6"));
				subObject.put("RTA6", rs.getString("RTA6"));
				subObject.put("ETA6", rs.getString("ETA6"));
				subObject.put("BL_DOC_NO6", rs.getString("BL_DOC_NO6"));
				subObject.put("AVL_DT6", rs.getString("AVL_DT6"));
				subObject.put("SF_DAY6", rs.getString("SF_DAY6"));
				subObject.put("REMARK6", rs.getString("REMARK6"));
				subObject.put("PO_NO7", rs.getString("PO_NO7"));
				subObject.put("PO_SEQ7", rs.getString("PO_SEQ7"));
				subObject.put("PO_QTY7", rs.getString("PO_QTY7"));
				subObject.put("RTA7", rs.getString("RTA7"));
				subObject.put("ETA7", rs.getString("ETA7"));
				subObject.put("BL_DOC_NO7", rs.getString("BL_DOC_NO7"));
				subObject.put("AVL_DT7", rs.getString("AVL_DT7"));
				subObject.put("SF_DAY7", rs.getString("SF_DAY7"));
				subObject.put("REMARK7", rs.getString("REMARK7"));
				subObject.put("PO_NO8", rs.getString("PO_NO8"));
				subObject.put("PO_SEQ8", rs.getString("PO_SEQ8"));
				subObject.put("PO_QTY8", rs.getString("PO_QTY8"));
				subObject.put("RTA8", rs.getString("RTA8"));
				subObject.put("ETA8", rs.getString("ETA8"));
				subObject.put("BL_DOC_NO8", rs.getString("BL_DOC_NO8"));
				subObject.put("AVL_DT8", rs.getString("AVL_DT8"));
				subObject.put("SF_DAY8", rs.getString("SF_DAY8"));
				subObject.put("REMARK8", rs.getString("REMARK8"));
				subObject.put("PO_NO9", rs.getString("PO_NO9"));
				subObject.put("PO_SEQ9", rs.getString("PO_SEQ9"));
				subObject.put("PO_QTY9", rs.getString("PO_QTY9"));
				subObject.put("RTA9", rs.getString("RTA9"));
				subObject.put("ETA9", rs.getString("ETA9"));
				subObject.put("BL_DOC_NO9", rs.getString("BL_DOC_NO9"));
				subObject.put("AVL_DT9", rs.getString("AVL_DT9"));
				subObject.put("SF_DAY9", rs.getString("SF_DAY9"));
				subObject.put("REMARK9", rs.getString("REMARK9"));
				subObject.put("PO_NO10", rs.getString("PO_NO10"));
				subObject.put("PO_SEQ10", rs.getString("PO_SEQ10"));
				subObject.put("PO_QTY10", rs.getString("PO_QTY10"));
				subObject.put("RTA10", rs.getString("RTA10"));
				subObject.put("ETA10", rs.getString("ETA10"));
				subObject.put("BL_DOC_NO10", rs.getString("BL_DOC_NO10"));
				subObject.put("AVL_DT10", rs.getString("AVL_DT10"));
				subObject.put("SF_DAY10", rs.getString("SF_DAY10"));
				subObject.put("REMARK10", rs.getString("REMARK10"));
				
				subObject.put("PO_NO11", rs.getString("PO_NO11"));
				subObject.put("PO_SEQ11", rs.getString("PO_SEQ11"));
				subObject.put("PO_QTY11", rs.getString("PO_QTY11"));
				subObject.put("RTA11", rs.getString("RTA11"));
				subObject.put("ETA11", rs.getString("ETA11"));
				subObject.put("BL_DOC_NO11", rs.getString("BL_DOC_NO11"));
				subObject.put("AVL_DT11", rs.getString("AVL_DT11"));
				subObject.put("SF_DAY11", rs.getString("SF_DAY11"));
				subObject.put("REMARK11", rs.getString("REMARK11"));
				subObject.put("PO_NO12", rs.getString("PO_NO12"));
				subObject.put("PO_SEQ12", rs.getString("PO_SEQ12"));
				subObject.put("PO_QTY12", rs.getString("PO_QTY12"));
				subObject.put("RTA12", rs.getString("RTA12"));
				subObject.put("ETA12", rs.getString("ETA12"));
				subObject.put("BL_DOC_NO12", rs.getString("BL_DOC_NO12"));
				subObject.put("AVL_DT12", rs.getString("AVL_DT12"));
				subObject.put("SF_DAY12", rs.getString("SF_DAY12"));
				subObject.put("REMARK12", rs.getString("REMARK12"));
				subObject.put("PO_NO13", rs.getString("PO_NO13"));
				subObject.put("PO_SEQ13", rs.getString("PO_SEQ13"));
				subObject.put("PO_QTY13", rs.getString("PO_QTY13"));
				subObject.put("RTA13", rs.getString("RTA13"));
				subObject.put("ETA13", rs.getString("ETA13"));
				subObject.put("BL_DOC_NO13", rs.getString("BL_DOC_NO13"));
				subObject.put("AVL_DT13", rs.getString("AVL_DT13"));
				subObject.put("SF_DAY13", rs.getString("SF_DAY13"));
				subObject.put("REMARK13", rs.getString("REMARK13"));
				subObject.put("PO_NO14", rs.getString("PO_NO14"));
				subObject.put("PO_SEQ14", rs.getString("PO_SEQ14"));
				subObject.put("PO_QTY14", rs.getString("PO_QTY14"));
				subObject.put("RTA14", rs.getString("RTA14"));
				subObject.put("ETA14", rs.getString("ETA14"));
				subObject.put("BL_DOC_NO14", rs.getString("BL_DOC_NO14"));
				subObject.put("AVL_DT14", rs.getString("AVL_DT14"));
				subObject.put("SF_DAY14", rs.getString("SF_DAY14"));
				subObject.put("REMARK14", rs.getString("REMARK14"));
				subObject.put("PO_NO15", rs.getString("PO_NO15"));
				subObject.put("PO_SEQ15", rs.getString("PO_SEQ15"));
				subObject.put("PO_QTY15", rs.getString("PO_QTY15"));
				subObject.put("RTA15", rs.getString("RTA15"));
				subObject.put("ETA15", rs.getString("ETA15"));
				subObject.put("BL_DOC_NO15", rs.getString("BL_DOC_NO15"));
				subObject.put("AVL_DT15", rs.getString("AVL_DT15"));
				subObject.put("SF_DAY15", rs.getString("SF_DAY15"));
				subObject.put("REMARK15", rs.getString("REMARK15"));
				subObject.put("PO_NO16", rs.getString("PO_NO16"));
				subObject.put("PO_SEQ16", rs.getString("PO_SEQ16"));
				subObject.put("PO_QTY16", rs.getString("PO_QTY16"));
				subObject.put("RTA16", rs.getString("RTA16"));
				subObject.put("ETA16", rs.getString("ETA16"));
				subObject.put("BL_DOC_NO16", rs.getString("BL_DOC_NO16"));
				subObject.put("AVL_DT16", rs.getString("AVL_DT16"));
				subObject.put("SF_DAY16", rs.getString("SF_DAY16"));
				subObject.put("REMARK16", rs.getString("REMARK16"));
				subObject.put("PO_NO17", rs.getString("PO_NO17"));
				subObject.put("PO_SEQ17", rs.getString("PO_SEQ17"));
				subObject.put("PO_QTY17", rs.getString("PO_QTY17"));
				subObject.put("RTA17", rs.getString("RTA17"));
				subObject.put("ETA17", rs.getString("ETA17"));
				subObject.put("BL_DOC_NO17", rs.getString("BL_DOC_NO17"));
				subObject.put("AVL_DT17", rs.getString("AVL_DT17"));
				subObject.put("SF_DAY17", rs.getString("SF_DAY17"));
				subObject.put("REMARK17", rs.getString("REMARK17"));
				subObject.put("PO_NO18", rs.getString("PO_NO18"));
				subObject.put("PO_SEQ18", rs.getString("PO_SEQ18"));
				subObject.put("PO_QTY18", rs.getString("PO_QTY18"));
				subObject.put("RTA18", rs.getString("RTA18"));
				subObject.put("ETA18", rs.getString("ETA18"));
				subObject.put("BL_DOC_NO18", rs.getString("BL_DOC_NO18"));
				subObject.put("AVL_DT18", rs.getString("AVL_DT18"));
				subObject.put("SF_DAY18", rs.getString("SF_DAY18"));
				subObject.put("REMARK18", rs.getString("REMARK18"));
				subObject.put("PO_NO19", rs.getString("PO_NO19"));
				subObject.put("PO_SEQ19", rs.getString("PO_SEQ19"));
				subObject.put("PO_QTY19", rs.getString("PO_QTY19"));
				subObject.put("RTA19", rs.getString("RTA19"));
				subObject.put("ETA19", rs.getString("ETA19"));
				subObject.put("BL_DOC_NO19", rs.getString("BL_DOC_NO19"));
				subObject.put("AVL_DT19", rs.getString("AVL_DT19"));
				subObject.put("SF_DAY19", rs.getString("SF_DAY19"));
				subObject.put("REMARK19", rs.getString("REMARK19"));
				subObject.put("PO_NO20", rs.getString("PO_NO20"));
				subObject.put("PO_SEQ20", rs.getString("PO_SEQ20"));
				subObject.put("PO_QTY20", rs.getString("PO_QTY20"));
				subObject.put("RTA20", rs.getString("RTA20"));
				subObject.put("ETA20", rs.getString("ETA20"));
				subObject.put("BL_DOC_NO20", rs.getString("BL_DOC_NO20"));
				subObject.put("AVL_DT20", rs.getString("AVL_DT20"));
				subObject.put("SF_DAY20", rs.getString("SF_DAY20"));
				subObject.put("REMARK20", rs.getString("REMARK20"));
				
				subObject.put("AVL_PLAN_DT1", rs.getString("AVL_PLAN_DT1"));
				subObject.put("AVL_PLAN_DT2", rs.getString("AVL_PLAN_DT2"));
				subObject.put("AVL_PLAN_DT3", rs.getString("AVL_PLAN_DT3"));
				subObject.put("AVL_PLAN_DT4", rs.getString("AVL_PLAN_DT4"));
				subObject.put("AVL_PLAN_DT5", rs.getString("AVL_PLAN_DT5"));
				subObject.put("AVL_PLAN_DT6", rs.getString("AVL_PLAN_DT6"));
				subObject.put("AVL_PLAN_DT7", rs.getString("AVL_PLAN_DT7"));
				subObject.put("AVL_PLAN_DT8", rs.getString("AVL_PLAN_DT8"));
				subObject.put("AVL_PLAN_DT9", rs.getString("AVL_PLAN_DT9"));
				subObject.put("AVL_PLAN_DT10", rs.getString("AVL_PLAN_DT10"));
				subObject.put("AVL_PLAN_DT11", rs.getString("AVL_PLAN_DT11"));
				subObject.put("AVL_PLAN_DT12", rs.getString("AVL_PLAN_DT12"));
				subObject.put("AVL_PLAN_DT13", rs.getString("AVL_PLAN_DT13"));
				subObject.put("AVL_PLAN_DT14", rs.getString("AVL_PLAN_DT14"));
				subObject.put("AVL_PLAN_DT15", rs.getString("AVL_PLAN_DT15"));
				subObject.put("AVL_PLAN_DT16", rs.getString("AVL_PLAN_DT16"));
				subObject.put("AVL_PLAN_DT17", rs.getString("AVL_PLAN_DT17"));
				subObject.put("AVL_PLAN_DT18", rs.getString("AVL_PLAN_DT18"));
				subObject.put("AVL_PLAN_DT19", rs.getString("AVL_PLAN_DT19"));
				subObject.put("AVL_PLAN_DT20", rs.getString("AVL_PLAN_DT20"));
				
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("C")) {
			cs = conn.prepareCall("call USP_003_M_IMP_CHK_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMMDD);//V_YYYYMMDD
			cs.setString(4, "");//V_ITEM_CD
			cs.setString(5, "");//V_ITEM_NM
			cs.setString(6, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, "");//V_MR_NO
			cs.setString(9, "");//V_MR_SEQ
			cs.setString(10, "");//V_FR_ADD_QTY
			cs.setString(11, "");//V_REMARK
			cs.setString(12, "");//V_USR_NM
			cs.setString(13, "");//V_SF_DAY
			cs.setString(14, "");//V_FR_O_BP_QTY
			cs.setString(15, "");//V_LT_DAY
			cs.setString(16, "");//V_MAKER
			cs.setString(17, "");//V_HSTN_QTY
			cs.setString(18, "");//V_HSMI_QTY
			cs.setString(19, "");//V_SYS_TYPE
			cs.executeQuery();

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
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
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					
					String V_MR_NO = hashMap.get("MR_NO") == null ? "" : hashMap.get("MR_NO").toString();
					String V_MR_SEQ = hashMap.get("MR_SEQ") == null ? "" : hashMap.get("MR_SEQ").toString();
// 					String V_FR_I_BP_QTY = hashMap.get("FR_I_BP_QTY") == null ? "" : hashMap.get("FR_I_BP_QTY").toString();
					String V_FR_O_BP_QTY = hashMap.get("FR_O_BP_QTY") == null ? "" : hashMap.get("FR_O_BP_QTY").toString();
					String V_FR_ADD_QTY = hashMap.get("FR_ADD_QTY") == null ? "" : hashMap.get("FR_ADD_QTY").toString();
					String V_HSTN_QTY = hashMap.get("HSTN_QTY") == null ? "" : hashMap.get("HSTN_QTY").toString();
					String V_HSMI_QTY = hashMap.get("HSMI_QTY") == null ? "" : hashMap.get("HSMI_QTY").toString();
					String V_LT_DAY = hashMap.get("LT_DAY") == null ? "" : hashMap.get("LT_DAY").toString();
					String V_SF_DAY = hashMap.get("SF_DAY") == null ? "" : hashMap.get("SF_DAY").toString();
					String V_SYS_TYPE = hashMap.get("SYS_TYPE") == null ? "" : hashMap.get("SYS_TYPE").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
	
					cs = conn.prepareCall("call USP_003_M_IMP_CHK_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_YYYYMMDD);//V_YYYYMMDD
					cs.setString(4, V_ITEM_CD);//V_ITEM_CD
					cs.setString(5, "");//V_ITEM_NM
					cs.setString(6, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(8, V_MR_NO);//V_MR_NO
					cs.setString(9, V_MR_SEQ);//V_MR_SEQ
					cs.setString(10, V_FR_ADD_QTY);//V_FR_ADD_QTY
					cs.setString(11, V_REMARK);//V_REMARK
					cs.setString(12, "");//V_USR_NM
					cs.setString(13, V_SF_DAY);//V_SF_DAY
					cs.setString(14, V_FR_O_BP_QTY);//V_FR_O_BP_QTY
					cs.setString(15, V_LT_DAY);//V_LT_DAY
					cs.setString(16, "");//V_MAKER
					cs.setString(17, V_HSTN_QTY);//V_HSTN_QTY
					cs.setString(18, V_HSMI_QTY);//V_HSMI_QTY
					cs.setString(19, V_SYS_TYPE);//V_SYS_TYPE
					cs.executeQuery();
	
					for(int j=1; j<=20; j++){
						String V_PO_NO = hashMap.get("PO_NO"+String.valueOf(j)) == null ? null : hashMap.get("PO_NO"+String.valueOf(j)).toString();
						String V_PO_SEQ = hashMap.get("PO_SEQ"+String.valueOf(j)) == null ? null : hashMap.get("PO_SEQ"+String.valueOf(j)).toString();
						V_REMARK = hashMap.get("REMARK"+String.valueOf(j)) == null ? null : hashMap.get("REMARK"+String.valueOf(j)).toString();
						
						if(V_PO_NO != null && V_PO_SEQ != null && V_REMARK != null){
							cs = conn.prepareCall("call USP_003_M_IMP_CHK_DATA_PO_TOT_HSPF(?,?,?,?,?,?)");
							cs.setString(1, V_COMP_ID);//V_COMP_ID
							cs.setString(2, "I");//V_TYPE
							cs.setString(3, V_PO_NO);//V_PO_NO
							cs.setString(4, V_PO_SEQ);//V_PO_SEQ
							cs.setString(5, V_REMARK);//V_REMARK
							cs.setString(6, V_USR_ID);//V_USR_ID
							cs.executeQuery();
						}
					}
					
					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
					
				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				
				String V_MR_NO = jsondata.get("MR_NO") == null ? "" : jsondata.get("MR_NO").toString();
				String V_MR_SEQ = jsondata.get("MR_SEQ") == null ? "" : jsondata.get("MR_SEQ").toString();
// 				String V_FR_I_BP_QTY = jsondata.get("FR_I_BP_QTY") == null ? "" : jsondata.get("FR_I_BP_QTY").toString();
				String V_FR_O_BP_QTY = jsondata.get("FR_O_BP_QTY") == null ? "" : jsondata.get("FR_O_BP_QTY").toString();
				String V_FR_ADD_QTY = jsondata.get("FR_ADD_QTY") == null ? "" : jsondata.get("FR_ADD_QTY").toString();
				String V_HSTN_QTY = jsondata.get("HSTN_QTY") == null ? "" : jsondata.get("HSTN_QTY").toString();
				String V_HSMI_QTY = jsondata.get("HSMI_QTY") == null ? "" : jsondata.get("HSMI_QTY").toString();
				String V_LT_DAY = jsondata.get("LT_DAY") == null ? "" : jsondata.get("LT_DAY").toString();
				String V_SF_DAY = jsondata.get("SF_DAY") == null ? "" : jsondata.get("SF_DAY").toString();
				String V_SYS_TYPE = jsondata.get("SYS_TYPE") == null ? "" : jsondata.get("SYS_TYPE").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
	
				cs = conn.prepareCall("call USP_003_M_IMP_CHK_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_YYYYMMDD);//V_YYYYMMDD
				cs.setString(4, V_ITEM_CD);//V_ITEM_CD
				cs.setString(5, "");//V_ITEM_NM
				cs.setString(6, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(8, V_MR_NO);//V_MR_NO
				cs.setString(9, V_MR_SEQ);//V_MR_SEQ
				cs.setString(10, V_FR_ADD_QTY);//V_FR_ADD_QTY
				cs.setString(11, V_REMARK);//V_REMARK
				cs.setString(12, "");//V_USR_NM
				cs.setString(13, V_SF_DAY);//V_SF_DAY
				cs.setString(14, V_FR_O_BP_QTY);//V_FR_O_BP_QTY
				cs.setString(15, V_LT_DAY);//V_LT_DAY
				cs.setString(16, "");//V_MAKER
				cs.setString(17, V_HSTN_QTY);//V_HSTN_QTY
				cs.setString(18, V_HSMI_QTY);//V_HSMI_QTY
				cs.setString(19, V_SYS_TYPE);//V_SYS_TYPE
				cs.executeQuery();
	
				for(int j=1; j<=20; j++){
					String V_PO_NO = jsondata.get("PO_NO"+String.valueOf(j)) == null ? null : jsondata.get("PO_NO"+String.valueOf(j)).toString();
					String V_PO_SEQ = jsondata.get("PO_SEQ"+String.valueOf(j)) == null ? null : jsondata.get("PO_SEQ"+String.valueOf(j)).toString();
					V_REMARK = jsondata.get("REMARK"+String.valueOf(j)) == null ? null : jsondata.get("REMARK"+String.valueOf(j)).toString();
					
					if(V_PO_NO != null && V_PO_SEQ != null && V_REMARK != null){
						cs = conn.prepareCall("call USP_003_M_IMP_CHK_DATA_PO_TOT_HSPF(?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "I");//V_TYPE
						cs.setString(3, V_PO_NO);//V_PO_NO
						cs.setString(4, V_PO_SEQ);//V_PO_SEQ
						cs.setString(5, V_REMARK);//V_REMARK
						cs.setString(6, V_USR_ID);//V_USR_ID
						cs.executeQuery();
					}
				}
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
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

<%!
// 	void callProcedure(CallableStatement cs, String V_COMP_ID, String V_TYPE, String V_PO_NO, String V_PO_SEQ, String V_REMARK, String V_USR_ID) throws Exception {
// 		cs.setString(1, V_COMP_ID);//V_COMP_ID
// 		cs.setString(2, V_TYPE);//V_TYPE
// 		cs.setString(3, V_PO_NO);//V_PO_NO
// 		cs.setString(4, V_PO_SEQ);//V_PO_SEQ
// 		cs.setString(5, V_REMARK);//V_REMARK
// 		cs.setString(6, V_USR_ID);//V_USR_ID
// 		cs.executeQuery();
// 	}
%>


