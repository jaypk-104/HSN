/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.52
 * Generated at: 2021-02-17 06:50:09 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.HSPF01.mm.po.m_005fpur_005fhspf.sql;

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
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public final class M_005fPUR_005fHSPF_jsp extends org.apache.jasper.runtime.HttpJspBase
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
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	CallableStatement cs = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_PUR_SEQ = request.getParameter("V_PUR_SEQ") == null ? "" : request.getParameter("V_PUR_SEQ").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
		String V_PUR_FR_DT = request.getParameter("V_PUR_FR_DT") == null ? "" : request.getParameter("V_PUR_FR_DT").substring(0, 10);
		String V_PUR_TO_DT = request.getParameter("V_PUR_TO_DT") == null ? "" : request.getParameter("V_PUR_TO_DT").substring(0, 10);
		String V_PO_STS = request.getParameter("V_PO_STS") == "" ? "" : request.getParameter("V_PO_STS").toUpperCase();

		// 		System.out.println("V_PUR_FR_DT" + V_PUR_FR_DT);
		// 		System.out.println("V_PUR_TO_DT" + V_PUR_TO_DT);

		cs = conn.prepareCall("call USP_M_PUR_HSPF(?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, V_TYPE);//V_TYPE
		cs.setString(2, V_COMP_ID);//V_COMP_ID
		cs.setString(3, V_PUR_SEQ);//V_PUR_SEQ
		cs.setString(4, V_ITEM_CD);//V_ITEM_CD
		cs.setString(5, V_S_BP_NM);//V_S_BP_NM
		cs.setString(6, V_M_BP_NM);//V_M_BP_NM
		cs.setString(7, V_PUR_FR_DT);//V_PUR_FR_DT
		cs.setString(8, V_PUR_TO_DT);//V_PUR_TO_DT
		cs.setString(9, V_PO_STS);//V_PO_STS
		cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();

		rs = (ResultSet) cs.getObject(10);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("PUR_NO", rs.getString("PUR_NO"));
			subObject.put("PUR_SEQ", rs.getString("PUR_SEQ"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
			subObject.put("BP_ITEM_NM", rs.getString("BP_ITEM_NM"));
			subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
			subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
			subObject.put("FR_TYPE", rs.getString("FR_TYPE"));
			subObject.put("FR_TYPE_NM", rs.getString("FR_TYPE_NM"));
			subObject.put("PUR_DT", rs.getString("PUR_DT"));
			subObject.put("PUR_QTY", rs.getString("PUR_QTY"));
// 			subObject.put("PO_NO", rs.getString("PO_NO"));
			subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
			subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
// 			subObject.put("PO_DT", rs.getString("PO_DT"));
			subObject.put("PO_QTY", rs.getString("PO_QTY"));
			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
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