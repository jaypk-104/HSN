/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.52
 * Generated at: 2021-02-08 01:10:04 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.HSPF01.HSPF02.mm2.po.m_005fcol_005fdistb.sql;

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
import java.net.*;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import org.apache.commons.beanutils.BeanUtils;

public final class A_005fAR_005fRECEIPT_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_packages.add("java.net");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("java.io");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.io.PrintWriter");
    _jspx_imports_classes.add("javax.naming.InitialContext");
    _jspx_imports_classes.add("org.apache.commons.lang.StringUtils");
    _jspx_imports_classes.add("java.util.Properties");
    _jspx_imports_classes.add("java.net.URLDecoder");
    _jspx_imports_classes.add("org.json.simple.parser.JSONParser");
    _jspx_imports_classes.add("org.apache.commons.beanutils.BeanUtils");
    _jspx_imports_classes.add("java.util.Date");
    _jspx_imports_classes.add("java.io.StringWriter");
    _jspx_imports_classes.add("java.text.SimpleDateFormat");
    _jspx_imports_classes.add("java.util.HashMap");
    _jspx_imports_classes.add("javax.naming.NamingException");
    _jspx_imports_classes.add("org.json.simple.JSONArray");
    _jspx_imports_classes.add("java.lang.reflect.InvocationTargetException");
    _jspx_imports_classes.add("java.util.ArrayList");
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
		String V_DT_FR = request.getParameter("V_DT_FR") == null ? "" : request.getParameter("V_DT_FR").toString().substring(0, 10);
		String V_DT_TO = request.getParameter("V_DT_TO") == null ? "" : request.getParameter("V_DT_TO").toString().substring(0, 10);
		String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_CUR = request.getParameter("V_CUR") == null ? "" : request.getParameter("V_CUR").toUpperCase();
		String V_CLS_AR_NO = request.getParameter("V_CLS_AR_NO") == null ? "" : request.getParameter("V_CLS_AR_NO").toUpperCase();
		String V_CLS_DT = request.getParameter("V_CLS_DT") == null ? "" : request.getParameter("V_CLS_DT").toString().substring(0, 10);
		String V_MAST_DB_NO = request.getParameter("V_MAST_DB_NO") == null ? "" : request.getParameter("V_MAST_DB_NO").toUpperCase();

		if (V_TYPE.equals("T1D1")) {
			cs = conn.prepareCall("call USP_A_DEPOSIT_STAT_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, "S");//V_TYPE
			cs.setString(3, V_DT_FR);//V_DT_FR
			cs.setString(4, V_DT_TO);//V_DT_TO
			cs.setString(5, V_DEPT_CD);//V_DEPT_CD
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(7, V_BP_CD);//V_BP_CD
			cs.setString(8, "");//V_REMARK
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BC_NO", rs.getString("BC_NO"));
				subObject.put("BANK_DT", rs.getString("BANK_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("IN_AMT", rs.getString("IN_AMT"));
				subObject.put("REMAIN_AMT", rs.getString("REMAIN_AMT"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("BANK_ACCT_NO", rs.getString("BANK_ACCT_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("TEMP_GL_YN", rs.getString("TEMP_GL_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("COL_S")) {
			cs = conn.prepareCall("call USP_A_CLS_AR_SELECT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, "");//V_AR_DT_FR
			cs.setString(5, "");//V_AR_DT_TO
			cs.setString(6, "");//V_CLS_DT_FR
			cs.setString(7, "");//V_CLS_DT_TO
			cs.setString(8, "");//V_DEPT_CD
			cs.setString(9, "");//V_S_BP_CD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(11, "");//V_CLS_TYPE
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BC_NO", rs.getString("BC_NO"));
				subObject.put("CLS_IN_AMT", rs.getString("CLS_IN_AMT"));
				subObject.put("COL_AMT", rs.getString("CLS_IN_AMT"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("WH_COL")) {
			V_TYPE = V_CLS_AR_NO.equals("") ? "I" : "U";
			
			cs = conn.prepareCall("call USP_A_AR_REC_HDR_HSPF(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
			cs.setString(4, V_CLS_DT);//V_CLS_DT
			cs.setString(5, V_BP_CD);//V_S_BP_CD
			cs.setString(6, V_DEPT_CD);//V_DEPT_CD
			cs.setString(7, V_CUR);//V_CUR
			cs.setString(8, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(10, "");//V_XCH_RATE
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(9);
			if (rs.next()) {
				V_CLS_AR_NO = rs.getString("CLS_AR_NO");
			}
			
			if(V_TYPE.equals("I")){
				cs = conn.prepareCall("call DISTR_M_COL.USP_M_COL_H_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "CLS_AR_NO");//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, "");//V_BS_DT_FR
				cs.setString(4, "");//V_BS_DT_TO
				cs.setString(5, V_MAST_DB_NO);//V_MAST_DB_NO
				cs.setString(6, "");//V_COL_DT
				cs.setString(7, "");//V_COL_AVL_AMT
				cs.setString(8, "");//V_COL_TYPE
				cs.setString(9, "");//V_M_BP_CD
				cs.setString(10, V_CLS_AR_NO);//V_PO_NO
				cs.setString(11, "");//V_APPROV_NO
				cs.setString(12, "");//V_REF_COL_NO
				cs.setString(13, "");//V_COL_MGM_NO
				cs.setString(14, "");// 추가담보 등록시 입력param 변경
				cs.setString(15, "");//V_COL_TOT_AMT
				cs.setString(16, "");//V_S_BP_CD
				cs.setString(17, "");//V_COL_NON_AMT
				cs.setString(18, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(V_CLS_AR_NO);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("WD_COL")) {
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
// 					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_BC_NO = hashMap.get("BC_NO") == null ? "" : hashMap.get("BC_NO").toString();
// 					String V_BC_TYPE = hashMap.get("BC_TYPE") == null ? "" : hashMap.get("BC_TYPE").toString();
					String V_AR_NO = hashMap.get("AR_NO") == null ? "" : hashMap.get("AR_NO").toString();
					String V_CLS_IN_AMT = hashMap.get("COL_AMT") == null ? "" : hashMap.get("COL_AMT").toString();
// 					String V_CLS_OUT_AMT = hashMap.get("CLS_OUT_AMT") == null ? "" : hashMap.get("CLS_OUT_AMT").toString();
					String V_BAL_IN_AMT = hashMap.get("REMAIN_AMT") == null ? "" : hashMap.get("REMAIN_AMT").toString();
// 					String V_BAL_OUT_AMT = hashMap.get("BAL_OUT_AMT") == null ? "" : hashMap.get("BAL_OUT_AMT").toString();

					cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
					cs.setString(4, V_BC_NO);//V_BC_NO
					cs.setString(5, "B");//V_BC_TYPE
					cs.setString(6, V_MAST_DB_NO);//V_AR_NO
					cs.setString(7, V_CLS_DT);//V_CLS_DT
					cs.setString(8, V_CUR);//V_CUR
					cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
					cs.setString(10, "");//V_CLS_OUT_AMT
					cs.setString(11, V_BAL_IN_AMT);//V_BAL_IN_AMT
					cs.setString(12, "");//V_BAL_OUT_AMT
					cs.setString(13, V_USR_ID);//V_USR_ID
					cs.setString(14, "");//V_SEQ
					cs.executeQuery();

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
				
// 				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_BC_NO = jsondata.get("BC_NO") == null ? "" : jsondata.get("BC_NO").toString();
// 				String V_BC_TYPE = jsondata.get("BC_TYPE") == null ? "" : jsondata.get("BC_TYPE").toString();
				String V_AR_NO = jsondata.get("AR_NO") == null ? "" : jsondata.get("AR_NO").toString();
				String V_CLS_IN_AMT = jsondata.get("COL_AMT") == null ? "" : jsondata.get("COL_AMT").toString();
// 				String V_CLS_OUT_AMT = jsondata.get("CLS_OUT_AMT") == null ? "" : jsondata.get("CLS_OUT_AMT").toString();
				String V_BAL_IN_AMT = jsondata.get("REMAIN_AMT") == null ? "" : jsondata.get("REMAIN_AMT").toString();
// 				String V_BAL_OUT_AMT = jsondata.get("BAL_OUT_AMT") == null ? "" : jsondata.get("BAL_OUT_AMT").toString();

				cs = conn.prepareCall("call USP_A_BANK_REMAIN_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_CLS_AR_NO);//V_CLS_AR_NO
				cs.setString(4, V_BC_NO);//V_BC_NO
				cs.setString(5, "B");//V_BC_TYPE
				cs.setString(6, V_MAST_DB_NO);//V_AR_NO
				cs.setString(7, V_CLS_DT);//V_CLS_DT
				cs.setString(8, V_CUR);//V_CUR
				cs.setString(9, V_CLS_IN_AMT);//V_CLS_IN_AMT
				cs.setString(10, "");//V_CLS_OUT_AMT
				cs.setString(11, V_BAL_IN_AMT);//V_BAL_IN_AMT
				cs.setString(12, "");//V_BAL_OUT_AMT
				cs.setString(13, V_USR_ID);//V_USR_ID
				cs.setString(14, "");//V_SEQ
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

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