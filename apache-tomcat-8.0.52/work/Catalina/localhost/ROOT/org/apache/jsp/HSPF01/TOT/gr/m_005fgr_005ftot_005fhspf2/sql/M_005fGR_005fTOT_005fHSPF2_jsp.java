/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.52
 * Generated at: 2021-01-29 04:40:12 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.HSPF01.TOT.gr.m_005fgr_005ftot_005fhspf2.sql;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;
import net.sf.json.JSONObject;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import org.apache.commons.lang.StringUtils;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public final class M_005fGR_005fTOT_005fHSPF2_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/HSPF01/common/DB_Connection.jsp", Long.valueOf(1551915626000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.io.PrintWriter");
    _jspx_imports_classes.add("javax.naming.InitialContext");
    _jspx_imports_classes.add("org.apache.commons.lang.StringUtils");
    _jspx_imports_classes.add("java.net.URLDecoder");
    _jspx_imports_classes.add("org.json.simple.JSONValue");
    _jspx_imports_classes.add("java.io.StringWriter");
    _jspx_imports_classes.add("javax.sql.DataSource");
    _jspx_imports_classes.add("net.sf.json.JSONObject");
    _jspx_imports_classes.add("java.util.HashMap");
    _jspx_imports_classes.add("javax.naming.Context");
    _jspx_imports_classes.add("javax.naming.NamingException");
    _jspx_imports_classes.add("org.json.simple.JSONArray");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;

	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource dataSource = (DataSource) envCtx.lookup("jdbc/Tibero");
		conn = dataSource.getConnection();
		stmt = conn.createStatement();

	} catch (NamingException e) {

	}

      out.write("\r\n");
      out.write("\r\n");

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
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO").toUpperCase();
		String V_MVMT_NO = request.getParameter("V_MVMT_NO") == null ? "" : request.getParameter("V_MVMT_NO").toUpperCase();
		String V_GR_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").toUpperCase().substring(0, 10);
		String V_MVMT_DT_FR = request.getParameter("V_MVMT_DT_FR") == null ? "" : request.getParameter("V_MVMT_DT_FR").toUpperCase().substring(0, 10);
		String V_MVMT_DT_TO = request.getParameter("V_MVMT_DT_TO") == null ? "" : request.getParameter("V_MVMT_DT_TO").toUpperCase().substring(0, 10);
		String V_M_BP_NM2 = request.getParameter("V_M_BP_NM2") == null ? "" : request.getParameter("V_M_BP_NM2").toUpperCase();
		String V_GR_SL_CD = request.getParameter("V_GR_SL_CD") == null ? "" : request.getParameter("V_GR_SL_CD").toUpperCase();

// 		System.out.println("V_PO_NO" + V_PO_NO);
		
		if (V_TYPE.equals("SH")) {

			cs = conn.prepareCall("call USP_003_M_GR_KOR_REF_TOT_HSPF(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_PO_NO);//V_PO_NO
			cs.setString(3, V_APPROV_NO);//V_APPROV_NO
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_PO_DT_FR);//V_PO_DT_FR
			cs.setString(6, V_PO_DT_TO);//V_PO_DT_TO
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(8, V_M_BP_NM);//V_M_BP_NM
			cs.setString(9, V_ITEM_NM);//V_ITEM_NM
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(7);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
// 				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
// 				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RT", rs.getString("XCH_RT"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
// 				subObject.put("VAT_RATE", rs.getString("VAT_RATE"));
// 				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("GR_YN", rs.getString("GR_YN"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("HOPE_SL_NM", rs.getString("HOPE_SL_NM"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("GR_USR_NM", rs.getString("GR_USR_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
// 				subObject.put("DATA", rs.getString("DATA"));
// 				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
// 				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SD")) {

			String sql = "";
			sql += "SELECT A.MVMT_NO, A.M_BP_CD, C.BP_NM M_BP_NM, A.IV_TYPE, E.DTL_NM IV_TYPE_NM, H.PAY_METH,";
			sql += "       F.DTL_NM PAY_METH_NM, A.ITEM_CD, B.ITEM_NM, '' SPEC, G.SL_NM,                     ";
			sql += "       A.QTY, A.CUR, A.SL_CD, A.DOC_AMT, A.LOC_AMT, TO_CHAR(A.MVMT_DT, 'YYYY-MM-DD') MVMT_DT, ";
			sql += "       NVL(I.USR_NM,H.PO_USR_ID) PO_USR_NM, NVL(J.USR_NM,A.INSRT_USR_ID) GR_USR_NM, H.REMARK ";
			
			sql += "FROM   M_GR_TOT_HSPF A                                                                   ";
			sql += "       LEFT OUTER JOIN M_PO_HDR_TOT_HSPF H                                               ";
			sql += "       ON     A.COMP_ID=H.COMP_ID                                                        ";
			sql += "       AND    A.PO_NO  =H.PO_NO                                                          ";
			sql += "       LEFT OUTER JOIN B_ITEM_HSPF B                                                     ";
			sql += "       ON     A.COMP_ID=B.COMP_ID                                                        ";
			sql += "       AND    A.ITEM_CD=B.ITEM_CD                                                        ";
			sql += "       LEFT OUTER JOIN B_BIZ_HSPF C                                                      ";
			sql += "       ON     A.COMP_ID=C.COMP_ID                                                        ";
			sql += "       AND    A.M_BP_CD=C.BP_CD                                                          ";
			sql += "       LEFT OUTER JOIN B_DTL_INFO E                                                      ";
			sql += "       ON     A.COMP_ID=E.COMP_ID                                                        ";
			sql += "       AND    A.IV_TYPE=E.DTL_CD                                                         ";
			sql += "       AND    E.MAST_CD='MA02'                                                           ";
			sql += "       LEFT OUTER JOIN B_DTL_INFO F                                                      ";
			sql += "       ON     A.COMP_ID =F.COMP_ID                                                       ";
			sql += "       AND    H.PAY_METH=F.DTL_CD                                                        ";
			sql += "       AND    F.MAST_CD ='MA03'                                                          ";
			sql += "       LEFT OUTER JOIN B_STORAGE_HSPF G                                                  ";
			sql += "       ON     A.COMP_ID=G.COMP_ID                                                        ";
			sql += "       AND    A.SL_CD  =G.SL_CD                                                          ";
			sql += "       LEFT OUTER JOIN Z_USR_INFO_HSPF I                                                 ";
            sql += "       ON     H.COMP_ID = I.COMP_ID                                                      ";
            sql += "       AND    H.PO_USR_ID = I.USR_ID                                                     ";
            sql += "       LEFT OUTER JOIN Z_USR_INFO_HSPF J                                                 ";
            sql += "       ON     A.COMP_ID = J.COMP_ID                                                      ";
            sql += "       AND    A.INSRT_USR_ID = J.USR_ID                                                  ";
			                                                                                                 
			sql += "       WHERE 1=1                                                                         ";
			sql += "       AND    A.IV_TYPE IN ('DO', 'MLO', 'TB')                                           ";
			// 			sql += "WHERE  A.GR_NO IN " + V_MVMT_NO + "";
			if (V_M_BP_NM2.equals("")) {
				sql += " AND       A.GR_NO IN " + V_MVMT_NO + "";
			} else if (V_M_BP_NM2.equals("*")) {
				sql += " AND      A.MVMT_DT >= '" + V_MVMT_DT_FR + "'";
				sql += " AND      A.MVMT_DT <= '" + V_MVMT_DT_TO + "'";
			} else {
				sql += " AND      C.BP_NM LIKE '%" + V_M_BP_NM2 + "%'";
				sql += " AND      A.MVMT_DT >= '" + V_MVMT_DT_FR + "'";
				sql += " AND      A.MVMT_DT <= '" + V_MVMT_DT_TO + "'";
			}
			sql += "       ORDER BY A.MVMT_DT DESC                                                           ";

			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("IV_TYPE", rs.getString("IV_TYPE"));
				subObject.put("IV_TYPE_NM", rs.getString("IV_TYPE_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				// 				subObject.put("SPEC", rs.getString("SPEC"));
				// 				subObject.put("UNIT", rs.getString("UNIT"));
// 				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("QTY", rs.getString("QTY"));
// 				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				// 				subObject.put("TOTAL_QTY", rs.getString("TOTAL_QTY"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("LOC_AMT", rs.getString("LOC_AMT"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("GR_USR_NM", rs.getString("GR_USR_NM"));
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
					String PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String PO_DT = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_DT").toString().substring(0, 10);
					String BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString();
					String BP_NM = hashMap.get("BP_NM") == null ? "" : hashMap.get("BP_NM").toString();
					String PO_TYPE = hashMap.get("PO_TYPE") == null ? "" : hashMap.get("PO_TYPE").toString();
					String PAY_METH = hashMap.get("PAY_METH") == null ? "" : hashMap.get("PAY_METH").toString();
					String ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String SPEC = hashMap.get("SPEC") == null ? "" : hashMap.get("SPEC").toString();
// 					String BOX_QTY = hashMap.get("BOX_QTY") == null ? "" : hashMap.get("BOX_QTY").toString();
// 					String BOX_WGT_UNIT = hashMap.get("BOX_WGT_UNIT") == null ? "" : hashMap.get("BOX_WGT_UNIT").toString();
					String PO_QTY = hashMap.get("PO_QTY") == null ? "" : hashMap.get("PO_QTY").toString();
					String CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String XCH_RT = hashMap.get("XCH_RT") == null ? "" : hashMap.get("XCH_RT").toString();
					String PO_AMT = hashMap.get("PO_AMT") == null ? "" : hashMap.get("PO_AMT").toString();
					String PO_LOC_AMT = hashMap.get("PO_LOC_AMT") == null ? "" : hashMap.get("PO_LOC_AMT").toString();
// 					String SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
// 					String DATA = hashMap.get("DATA") == null ? "" : hashMap.get("DATA").toString();
// 					String BL_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
// 					String PLANT_NO = hashMap.get("PLANT_NO") == null ? "" : hashMap.get("PLANT_NO").toString();

					cs = conn.prepareCall("call USP_003_M_GR_KOR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, MVMT_NO);//MVMT_NO
					cs.setString(4, "");//FIRST_YN
					cs.setString(5, PO_TYPE);//ITYPE
					cs.setString(6, V_GR_DT);//MVMT_DT
					cs.setString(7, BP_CD);//M_BP_CD
					cs.setString(8, V_GR_NO);//V_GR_NO
					cs.setString(9, "");//GR_SEQ
					cs.setString(10, CUR);//CUR
					cs.setString(11, XCH_RT);//XCHG_RT
					cs.setString(12, "");//FORWARD_XCH_RT
					cs.setString(13, ITEM_CD);//ITEM_CD
					cs.setString(14, PO_QTY);//QTY
					cs.setString(15, PO_AMT);//DOC_AMT
					cs.setString(16, PO_LOC_AMT);//LOC_AMT
					cs.setString(17, PO_NO);//PO_NO
					cs.setString(18, PO_SEQ);//PO_SEQ
					cs.setString(19, "");//FORWARD_XCH_AMT
					cs.setString(20, "");//BOX_QTY
					cs.setString(21, "");//BOX_WGT_UNIT
					cs.setString(22, "");//DN_QTY
					cs.setString(23, V_GR_SL_CD);//SL_CD
					cs.setString(24, "");//BL_DOC_NO
					cs.setString(25, "");//CC_SEQ
					cs.setString(26, V_USR_ID);//USR_ID
					cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(28, "");//DATA
					cs.setString(29, "");//PLANT_NO
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				String PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String PO_DT = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_DT").toString().substring(0, 10);
				String BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
				String PO_TYPE = jsondata.get("PO_TYPE") == null ? "" : jsondata.get("PO_TYPE").toString();
				String PAY_METH = jsondata.get("PAY_METH") == null ? "" : jsondata.get("PAY_METH").toString();
				String ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String SPEC = jsondata.get("SPEC") == null ? "" : jsondata.get("SPEC").toString();
// 				String BOX_QTY = jsondata.get("BOX_QTY") == null ? "" : jsondata.get("BOX_QTY").toString();
// 				String BOX_WGT_UNIT = jsondata.get("BOX_WGT_UNIT") == null ? "" : jsondata.get("BOX_WGT_UNIT").toString();
				String PO_QTY = jsondata.get("PO_QTY") == null ? "" : jsondata.get("PO_QTY").toString();
				String CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String XCH_RT = jsondata.get("XCH_RT") == null ? "" : jsondata.get("XCH_RT").toString();
				String PO_AMT = jsondata.get("PO_AMT") == null ? "" : jsondata.get("PO_AMT").toString();
				String PO_LOC_AMT = jsondata.get("PO_LOC_AMT") == null ? "" : jsondata.get("PO_LOC_AMT").toString();
// 				String SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
// 				String DATA = jsondata.get("DATA") == null ? "" : jsondata.get("DATA").toString();
// 				String BL_DOC_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
// 				String PLANT_NO = jsondata.get("PLANT_NO") == null ? "" : jsondata.get("PLANT_NO").toString();

				cs = conn.prepareCall("call USP_003_M_GR_KOR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, MVMT_NO);//MVMT_NO
				cs.setString(4, "");//FIRST_YN
				cs.setString(5, PO_TYPE);//ITYPE
				cs.setString(6, V_GR_DT);//MVMT_DT
				cs.setString(7, BP_CD);//M_BP_CD
				cs.setString(8, V_GR_NO);//V_GR_NO
				cs.setString(9, "");//GR_SEQ
				cs.setString(10, CUR);//CUR
				cs.setString(11, XCH_RT);//XCHG_RT
				cs.setString(12, "");//FORWARD_XCH_RT
				cs.setString(13, ITEM_CD);//ITEM_CD
				cs.setString(14, PO_QTY);//QTY
				cs.setString(15, PO_AMT);//DOC_AMT
				cs.setString(16, PO_LOC_AMT);//LOC_AMT
				cs.setString(17, PO_NO);//PO_NO
				cs.setString(18, PO_SEQ);//PO_SEQ
				cs.setString(19, "");//FORWARD_XCH_AMT
				cs.setString(20, "");//BOX_QTY
				cs.setString(21, "");//BOX_WGT_UNIT
				cs.setString(22, "");//DN_QTY
				cs.setString(23, V_GR_SL_CD);//SL_CD
				cs.setString(24, "");//BL_DOC_NO
				cs.setString(25, "");//CC_SEQ
				cs.setString(26, V_USR_ID);//USR_ID
				cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(28, "");//DATA
				cs.setString(29, "");//PLANT_NO
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
		} else if (V_TYPE.equals("IH")) {
			String V_MVMT_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").substring(0, 10);

			cs = conn.prepareCall("call USP_003_M_GR_KOR_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//MVMT_NO
			cs.setString(4, "");//FIRST_YN
			cs.setString(5, "");//ITYPE
			cs.setString(6, V_MVMT_DT);//V_MVMT_DT
			cs.setString(7, "");//M_BP_CD
			cs.setString(8, "");//V_GR_NO
			cs.setString(9, "");//GR_SEQ
			cs.setString(10, "");//CUR
			cs.setString(11, "");//XCHG_RT
			cs.setString(12, "");//FORWARD_XCH_RT
			cs.setString(13, "");//ITEM_CD
			cs.setString(14, "");//QTY
			cs.setString(15, "");//DOC_AMT
			cs.setString(16, "");//LOC_AMT
			cs.setString(17, "");//PO_NO
			cs.setString(18, "");//PO_SEQ
			cs.setString(19, "");//FORWARD_XCH_AMT
			cs.setString(20, "");//BOX_QTY
			cs.setString(21, "");//BOX_WGT_UNIT
			cs.setString(22, "");//DN_QTY
			cs.setString(23, "");//SL_CD
			cs.setString(24, "");//BL_DOC_NO
			cs.setString(25, "");//CC_SEQ
			cs.setString(26, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(27, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(28, "");//DATA
			cs.setString(29, "");//PLANT_NO
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}