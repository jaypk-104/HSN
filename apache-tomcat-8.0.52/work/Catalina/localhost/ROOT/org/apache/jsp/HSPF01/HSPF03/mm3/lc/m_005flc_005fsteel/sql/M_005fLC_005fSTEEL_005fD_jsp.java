/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.52
 * Generated at: 2021-02-07 23:09:45 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.HSPF01.HSPF03.mm3.lc.m_005flc_005fsteel.sql;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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

public final class M_005fLC_005fSTEEL_005fD_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("org.json.simple.parser.JSONParser");
    _jspx_imports_classes.add("java.io.StringWriter");
    _jspx_imports_classes.add("java.util.HashMap");
    _jspx_imports_classes.add("javax.naming.NamingException");
    _jspx_imports_classes.add("org.json.simple.JSONArray");
    _jspx_imports_classes.add("org.json.simple.JSONObject");
    _jspx_imports_classes.add("org.json.simple.JSONValue");
    _jspx_imports_classes.add("javax.sql.DataSource");
    _jspx_imports_classes.add("javax.naming.Context");
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
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO").toUpperCase();
		String V_LC_SEQ = request.getParameter("V_LC_SEQ") == null ? "" : request.getParameter("V_LC_SEQ").toUpperCase();
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();

// 				System.out.println("V_PO_NO"  + V_PO_NO);

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_001_M_LC_D_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_LC_NO);//V_LC_NO
			cs.setString(4, V_LC_SEQ);//V_LC_SEQ
			cs.setString(5, "");//V_HS_CD
			cs.setString(6, "");//V_ITEM_CD
			cs.setString(7, "");//V_QTY
			cs.setString(8, "");//V_PRICE
			cs.setString(9, "");//V_DOC_AMT
			cs.setString(10, "");//V_LOC_AMT
			cs.setString(11, "");//V_UNIT
			cs.setString(12, "");//V_OVER_TOL
			cs.setString(13, "");//V_UNDER_TOL
			cs.setString(14, "");//V_PO_NO
			cs.setString(15, "");//V_PO_SEQ
			cs.setString(16, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(18, "");//V_COL_NO
			cs.setString(19, "");//V_COL_SEQ
			cs.setString(20, "");//V_CONT_MGM_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(17);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("HS_CD", rs.getString("HS_CD"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("UNDER_TOL", rs.getString("UNDER_TOL"));
				subObject.put("OVER_TOL", rs.getString("OVER_TOL"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("COL_TYPE_NM", rs.getString("COL_TYPE_NM"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
				subObject.put("CHARGE_YN", rs.getString("CHARGE_YN"));
				subObject.put("BL_YN", rs.getString("BL_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SP")) {

			String V_LC_DT_FR = request.getParameter("V_LC_DT_FR") == null ? "" : request.getParameter("V_LC_DT_FR").toString().substring(0, 10);
			String V_LC_DT_TO = request.getParameter("V_LC_DT_TO") == null ? "" : request.getParameter("V_LC_DT_TO").toString().substring(0, 10);
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
			String V_SO_BP_NM = request.getParameter("V_SO_BP_NM") == null ? "" : request.getParameter("V_SO_BP_NM").toUpperCase();

			cs = conn.prepareCall("call USP_001_M_LC_POPUP_STEEL(?,?,?,?,?,?,?)");
			cs.setString(1, V_LC_DT_FR);//V_TYPE
			cs.setString(2, V_LC_DT_TO);//V_COMP_ID
			cs.setString(3, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(4, V_M_BP_NM);//V_PO_NO
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(6, V_PO_NO);//V_PO_NO
			cs.setString(7, V_SO_BP_NM);//V_SO_BP_NM
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_USR_NM", rs.getString("LC_USR_NM"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("BP_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("SO_BP_NM", rs.getString("SO_BP_NM"));
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
// 			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			System.out.println(jsonData);

			if (!V_TYPE.equals("V")) {
				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						V_LC_NO = hashMap.get("LC_NO") == null ? "" : hashMap.get("LC_NO").toString();
						V_LC_SEQ = hashMap.get("LC_SEQ") == null ? "" : hashMap.get("LC_SEQ").toString();
						V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
						String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
						String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						String V_PO_QTY = hashMap.get("PO_QTY") == null ? "" : hashMap.get("PO_QTY").toString();
						String V_PO_PRC = hashMap.get("PO_PRC") == null ? "" : hashMap.get("PO_PRC").toString();
						String V_PO_AMT = hashMap.get("PO_AMT") == null ? "" : hashMap.get("PO_AMT").toString();
						String V_PO_LOC_AMT = hashMap.get("PO_LOC_AMT") == null ? "" : hashMap.get("PO_LOC_AMT").toString();
						String V_HS_CD = hashMap.get("HS_CD") == null ? "" : hashMap.get("HS_CD").toString();
						String V_OVER_TOL = hashMap.get("OVER_TOL") == null ? "" : hashMap.get("OVER_TOL").toString();
						String V_UNDER_TOL = hashMap.get("UNDER_TOL") == null ? "" : hashMap.get("UNDER_TOL").toString();
						String V_COL_NO = hashMap.get("COL_NO") == null ? "" : hashMap.get("COL_NO").toString();
						String V_COL_SEQ = hashMap.get("COL_SEQ") == null ? "" : hashMap.get("COL_SEQ").toString();
						String V_CONT_MGM_NO = hashMap.get("CONT_MGM_NO") == null ? "" : hashMap.get("CONT_MGM_NO").toString();

						if (V_TYPE.equals("I")) {
							V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO");
							V_LC_SEQ = (i + 1) + "";
						}

						cs = conn.prepareCall("call USP_001_M_LC_D_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_LC_NO);//V_LC_NO
						cs.setString(4, V_LC_SEQ);//V_LC_SEQ
						cs.setString(5, V_HS_CD);//V_HS_CD
						cs.setString(6, V_ITEM_CD);//V_ITEM_CD
						cs.setString(7, V_PO_QTY);//V_QTY
						cs.setString(8, V_PO_PRC);//V_PRICE
						cs.setString(9, V_PO_AMT);//V_DOC_AMT
						cs.setString(10, V_PO_LOC_AMT);//V_LOC_AMT
						cs.setString(11, "");//V_UNIT
						cs.setString(12, V_OVER_TOL);//V_OVER_TOL
						cs.setString(13, V_UNDER_TOL);//V_UNDER_TOL
						cs.setString(14, V_PO_NO);//V_PO_NO
						cs.setString(15, V_PO_SEQ);//V_PO_SEQ
						cs.setString(16, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(18, V_COL_NO);//V_COL_NO
						cs.setString(19, V_COL_SEQ);//V_COL_SEQ
						cs.setString(20, V_CONT_MGM_NO);//V_CONT_MGM_NO
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}
				} else {
// 					JSONObject jsondata = JSONObject.fromObject(jsonData);
					JSONParser parser = new JSONParser();
					Object obj = parser.parse( jsonData );
					JSONObject jsondata = (JSONObject) obj;
							
// 					System.out.println(jsonObj);
					System.out.println(jsondata);
					
					
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					V_LC_NO = jsondata.get("LC_NO") == null ? "" : jsondata.get("LC_NO").toString();
					V_LC_SEQ = jsondata.get("LC_SEQ") == null ? "" : jsondata.get("LC_SEQ").toString();
					V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
					String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					String V_PO_QTY = jsondata.get("PO_QTY") == null ? "" : jsondata.get("PO_QTY").toString();
					String V_PO_PRC = jsondata.get("PO_PRC") == null ? "" : jsondata.get("PO_PRC").toString();
					String V_PO_AMT = jsondata.get("PO_AMT") == null ? "" : jsondata.get("PO_AMT").toString();
					String V_PO_LOC_AMT = jsondata.get("PO_LOC_AMT") == null ? "" :  jsondata.get("PO_LOC_AMT").toString();
					String V_HS_CD = jsondata.get("HS_CD") == null ? "" : jsondata.get("HS_CD").toString();
					String V_OVER_TOL = jsondata.get("OVER_TOL") == null ? "" : jsondata.get("OVER_TOL").toString();
					String V_UNDER_TOL = jsondata.get("UNDER_TOL") == null ? "" : jsondata.get("UNDER_TOL").toString();
					String V_COL_NO = jsondata.get("COL_NO") == null ? "" : jsondata.get("COL_NO").toString();
					String V_COL_SEQ = jsondata.get("COL_SEQ") == null ? "" : jsondata.get("COL_SEQ").toString();
					String V_CONT_MGM_NO = jsondata.get("CONT_MGM_NO") == null ? "" : jsondata.get("CONT_MGM_NO").toString();

					if (V_TYPE.equals("I")) {
						V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO");
						V_LC_SEQ = 1 + "";
					}
					
					cs = conn.prepareCall("call USP_001_M_LC_D_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_LC_NO);//V_LC_NO
					cs.setString(4, V_LC_SEQ);//V_LC_SEQ
					cs.setString(5, V_HS_CD);//V_HS_CD
					cs.setString(6, V_ITEM_CD);//V_ITEM_CD
					cs.setString(7, V_PO_QTY);//V_QTY
					cs.setString(8, V_PO_PRC);//V_PRICE
					cs.setString(9, V_PO_AMT);//V_DOC_AMT
					cs.setString(10, V_PO_LOC_AMT);//V_LOC_AMT
					cs.setString(11, "");//V_UNIT
					cs.setString(12, V_OVER_TOL);//V_OVER_TOL
					cs.setString(13, V_UNDER_TOL);//V_UNDER_TOL
					cs.setString(14, V_PO_NO);//V_PO_NO
					cs.setString(15, V_PO_SEQ);//V_PO_SEQ
					cs.setString(16, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(18, V_COL_NO);//V_COL_NO
					cs.setString(19, V_COL_SEQ);//V_COL_SEQ
					cs.setString(20, V_CONT_MGM_NO);//V_CONT_MGM_NO
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
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
