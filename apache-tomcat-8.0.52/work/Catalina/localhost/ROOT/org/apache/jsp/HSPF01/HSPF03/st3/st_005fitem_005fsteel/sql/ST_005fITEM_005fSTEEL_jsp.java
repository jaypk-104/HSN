/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.52
 * Generated at: 2021-01-31 23:00:18 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.HSPF01.HSPF03.st3.st_005fitem_005fsteel.sql;

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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.mail.BodyPart;
import javax.mail.Multipart;
import java.text.SimpleDateFormat;

public final class ST_005fITEM_005fSTEEL_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("javax.mail.Message");
    _jspx_imports_classes.add("javax.naming.InitialContext");
    _jspx_imports_classes.add("javax.mail.internet.MimeMultipart");
    _jspx_imports_classes.add("org.apache.commons.lang.StringUtils");
    _jspx_imports_classes.add("java.util.Properties");
    _jspx_imports_classes.add("java.net.URLDecoder");
    _jspx_imports_classes.add("javax.mail.Transport");
    _jspx_imports_classes.add("java.util.Date");
    _jspx_imports_classes.add("javax.mail.internet.MimeBodyPart");
    _jspx_imports_classes.add("java.io.StringWriter");
    _jspx_imports_classes.add("java.text.SimpleDateFormat");
    _jspx_imports_classes.add("java.util.HashMap");
    _jspx_imports_classes.add("javax.mail.Multipart");
    _jspx_imports_classes.add("javax.naming.NamingException");
    _jspx_imports_classes.add("javax.mail.internet.MimeMessage");
    _jspx_imports_classes.add("org.json.simple.JSONArray");
    _jspx_imports_classes.add("javax.mail.BodyPart");
    _jspx_imports_classes.add("javax.mail.internet.InternetAddress");
    _jspx_imports_classes.add("org.json.simple.JSONValue");
    _jspx_imports_classes.add("javax.sql.DataSource");
    _jspx_imports_classes.add("net.sf.json.JSONObject");
    _jspx_imports_classes.add("javax.mail.Session");
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
		String V_DATE = request.getParameter("V_DATE") == null ? "" : request.getParameter("V_DATE").toUpperCase().substring(0, 10);
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_SALE_TYPE = request.getParameter("V_SALE_TYPE") == null ? "" : request.getParameter("V_SALE_TYPE").toUpperCase();
		String V_IV_TYPE = request.getParameter("V_IV_TYPE") == null ? "" : request.getParameter("V_IV_TYPE").toUpperCase();
		String V_REGION = request.getParameter("V_REGION") == null ? "" : request.getParameter("V_REGION").toUpperCase();
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_SL_NM = request.getParameter("V_SL_NM") == null ? "" : request.getParameter("V_SL_NM").toUpperCase();

		if (V_SALE_TYPE.equals("T")) {
			V_SALE_TYPE = "";
		}
		if (V_IV_TYPE.equals("T")) {
			V_IV_TYPE = "";
		}
		if (V_REGION.equals("T")) {
			V_REGION = "";
		}

// 		System.out.println(V_DATE);
		//상단
		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_I_STOCK_BY_ITEM_STEEL(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_DATE);//V_COMP_ID
			cs.setString(2, V_ITEM_CD);//V_DN_DT
			cs.setString(3, V_S_BP_NM);//V_S_BP_NM
			cs.setString(4, V_REGION);//V_S_BP_NM
			cs.setString(5, V_SALE_TYPE);//V_S_BP_NM
			cs.setString(6, V_IV_TYPE);//V_S_BP_NM
			cs.setString(7, V_LC_DOC_NO);//V_S_BP_NM
			cs.setString(8, V_BL_DOC_NO);//V_S_BP_NM
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(10, V_SL_NM);//V_SL_NM
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(9);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("MVMT_DT", rs.getString("MVMT_DT"));
				subObject.put("BON_QTY", rs.getString("BON_QTY"));
				subObject.put("BON_WGT_UNIT", rs.getString("BON_WGT_UNIT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("GL_QTY", rs.getString("GL_QTY"));
				subObject.put("S_DAY", rs.getString("S_DAY"));
				subObject.put("N_ST_AMT", rs.getString("N_ST_AMT"));
				subObject.put("O_ST_AMT", rs.getString("O_ST_AMT"));
				subObject.put("L_ST_AMT", rs.getString("L_ST_AMT"));
				subObject.put("ST_AMT", rs.getString("ST_AMT"));
				subObject.put("ST_GL_AMT", rs.getString("ST_GL_AMT"));
				subObject.put("COST_CD", rs.getString("COST_CD"));
				subObject.put("TAX_AMT", rs.getString("TAX_AMT"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("NON_AMT", rs.getString("NON_AMT"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("APPROV_DT", rs.getString("APPROV_DT"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("ORIGIN_NM", rs.getString("ORIGIN_NM"));
				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
				subObject.put("GRADE_NM", rs.getString("GRADE_NM"));
				subObject.put("IV_PRC", rs.getString("IV_PRC"));
				subObject.put("F_S_PRC", rs.getString("F_S_PRC"));
				subObject.put("COST_NM", rs.getString("COST_NM"));
				

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			//출고요청서 번호 채번

		} else if (V_TYPE.equals("CALC")) {

// 			System.out.println("zz" + V_DATE);

			cs = conn.prepareCall("call DISTR_STOCK.USP_I_STOCK_SALE_CALC(?,?)");
			cs.setString(1, V_DATE);//V_COMP_ID
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.executeQuery();

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
