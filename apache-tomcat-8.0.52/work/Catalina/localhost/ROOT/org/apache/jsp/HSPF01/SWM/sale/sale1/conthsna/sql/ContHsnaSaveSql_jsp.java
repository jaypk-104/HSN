/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.52
 * Generated at: 2021-01-29 05:15:08 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.HSPF01.SWM.sale.sale1.conthsna.sql;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TryCatchFinally;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;
import net.sf.json.JSONObject;
import java.sql.*;
import java.util.Enumeration;
import java.util.Map;
import java.util.TreeMap;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public final class ContHsnaSaveSql_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("java.util.Enumeration");
    _jspx_imports_classes.add("java.util.HashMap");
    _jspx_imports_classes.add("javax.naming.NamingException");
    _jspx_imports_classes.add("org.json.simple.JSONArray");
    _jspx_imports_classes.add("java.util.TreeMap");
    _jspx_imports_classes.add("org.json.simple.JSONValue");
    _jspx_imports_classes.add("java.util.Map");
    _jspx_imports_classes.add("javax.sql.DataSource");
    _jspx_imports_classes.add("net.sf.json.JSONObject");
    _jspx_imports_classes.add("javax.naming.Context");
    _jspx_imports_classes.add("javax.servlet.jsp.tagext.TryCatchFinally");
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

      out.write('\r');
      out.write('\n');

	ResultSet rs = null;
	CallableStatement cs = null;
	//CallableStatement cs = null;
	//JSONObject jsonObject = new JSONObject();
	//JSONArray jsonArray = new JSONArray();
	//JSONObject subObject = null;
	//컨테이너 생성, 변경, 삭제
	
	try {

		request.setCharacterEncoding("utf-8");
		
		
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
    	String V_CONT_MGM_NO = request.getParameter("V_CONT_MGM_NO") == null ? "" : request.getParameter("V_CONT_MGM_NO");
		String V_CONT_NO = request.getParameter("V_CONT_NO") == null ? "" : request.getParameter("V_CONT_NO");
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD");
		String V_PLANT_CD = request.getParameter("V_PLANT_CD") == null ? "" : request.getParameter("V_PLANT_CD");
		String V_CFM_YN = request.getParameter("V_CFM_YN") == null ? "" : request.getParameter("V_CFM_YN");
		String V_USER_ID = request.getParameter("V_USER_ID") == null ? "" : request.getParameter("V_USER_ID");
		String V_CONT_SIZE = request.getParameter("V_CONT_SIZE") == null ? "" : request.getParameter("V_CONT_SIZE");
		String V_CONT_SEAL_NO = request.getParameter("V_CONT_SEAL_NO") == null ? "" : request.getParameter("V_CONT_SEAL_NO");

// 				System.out.println("BASIC");
// 		 	     System.out.println("V_TYPE : " + V_TYPE);
// 				 System.out.println("V_CONT_MGM_NO : " + V_CONT_MGM_NO);	
// 				 System.out.println("V_CONT_NO : " + V_CONT_NO);
// 				 System.out.println("V_BP_CD : " + V_BP_CD);
// 				 System.out.println("V_PLANT_CD : " + V_PLANT_CD);
// 				 System.out.println("V_CFM_YN : " + V_CFM_YN);
// 				 System.out.println("V_USER_ID : " + V_USER_ID);
// 				 System.out.println("V_CONT_SIZE : " + V_CONT_SIZE);
// 				 System.out.println("V_CONT_SEAL_NO : " + V_CONT_SEAL_NO); 
// 				 System.out.println("");

		//System.out.println("jsondata v_type : " +  jsondata.get("V_TYPE").toString() );


		if (V_TYPE.equals("SYNCU")) {//컨테이너 변경, 삭제
			String data = request.getParameter("data");//Sync 탈때만
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
				    V_CONT_MGM_NO = hashMap.get("CONT_MGM_NO") == null ? "" : hashMap.get("CONT_MGM_NO").toString();
					//V_CONT_NO = hashMap.get("u_cont_no") == null ? "" : hashMap.get("u_cont_no").toString();
					V_BP_CD = hashMap.get("u_BP_CD") == null ? "" : hashMap.get("u_BP_CD").toString();
// 					V_PLANT_CD = hashMap.get("PLANT_CD") == null ? "" : hashMap.get("PLANT_CD").toString();
					V_CFM_YN = hashMap.get("CFM_YN") == null ? "" : hashMap.get("CFM_YN").toString();
					//V_USER_ID = hashMap.get("GUSER_ID") == null ? "" : hashMap.get("GUSER_ID").toString();
					//V_CONT_SIZE = hashMap.get("U_CONT_SIZE") == null ? "" : hashMap.get("U_CONT_SIZE").toString();
					//V_CONT_SEAL_NO = hashMap.get("U_CONT_SEAL_NO") == null ? "" : hashMap.get("U_CONT_SEAL_NO").toString();
					
					if(V_TYPE == "D"){
						V_CONT_NO = hashMap.get("cont_no") == null ? "" : hashMap.get("cont_no").toString();//grid
					}
					
// 					System.out.println("배열");
// 				    System.out.println("V_TYPE : " + V_TYPE);
// 					 System.out.println("V_CONT_MGM_NO : " + V_CONT_MGM_NO);	
// 					 System.out.println("V_CONT_NO : " + V_CONT_NO);
// 					 System.out.println("V_BP_CD : " + V_BP_CD);
// 					 System.out.println("V_PLANT_CD : " + V_PLANT_CD);
// 					 System.out.println("V_CFM_YN : " + V_CFM_YN);
// 					 System.out.println("V_USER_ID : " + V_USER_ID);
// 					 System.out.println("V_CONT_SIZE : " + V_CONT_SIZE);
// 					 System.out.println("V_CONT_SEAL_NO : " + V_CONT_SEAL_NO);
// 					System.out.println("");


					cs = conn.prepareCall("call   USP_S_CONTAINER_INSERT_20190725(?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_CONT_MGM_NO);
					cs.setString(3, V_CONT_NO);
					cs.setString(4, V_BP_CD);
					cs.setString(5, V_PLANT_CD);
					cs.setString(6, V_CFM_YN);
					cs.setString(7, V_CONT_SIZE);
					cs.setString(8, V_CONT_SEAL_NO);
					cs.setString(9, V_USER_ID);
					cs.registerOutParameter(10, Types.VARCHAR);

					cs.execute();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);					
					
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_CONT_MGM_NO = jsondata.get("CONT_MGM_NO") == null ? "" : jsondata.get("CONT_MGM_NO").toString();
				//V_CONT_NO = jsondata.get("u_cont_no") == null ? "" : jsondata.get("u_cont_no").toString();
				V_BP_CD = jsondata.get("u_BP_CD") == null ? "" : jsondata.get("u_BP_CD").toString();
// 				V_PLANT_CD = jsondata.get("V_PLANT_CD") == null ? "" : jsondata.get("V_PLANT_CD").toString();
				V_CFM_YN = jsondata.get("V_CFM_YN") == null ? "" : jsondata.get("V_CFM_YN").toString();
				//V_USER_ID = jsondata.get("GUSER_ID") == null ? "" : jsondata.get("GUSER_ID").toString();
				//V_CONT_SIZE = jsondata.get("U_CONT_SIZE") == null ? "" : jsondata.get("U_CONT_SIZE").toString();
				//V_CONT_SEAL_NO = jsondata.get("U_CONT_SEAL_NO") == null ? "" : jsondata.get("U_CONT_SEAL_NO").toString();
				
				if(V_TYPE == "D"){
					V_CONT_NO = jsondata.get("cont_no") == null ? "" : jsondata.get("cont_no").toString();
				}
				
// 				System.out.println("N 배열");
// 			    System.out.println("V_TYPE : " + V_TYPE);
// 				 System.out.println("V_CONT_MGM_NO : " + V_CONT_MGM_NO);	
// 				 System.out.println("V_CONT_NO : " + V_CONT_NO);
// 				 System.out.println("V_BP_CD : " + V_BP_CD);
// 				 System.out.println("V_PLANT_CD : " + V_PLANT_CD);
// 				 System.out.println("V_CFM_YN : " + V_CFM_YN);
// 				 System.out.println("V_USER_ID : " + V_USER_ID);
// 				 System.out.println("V_CONT_SIZE : " + V_CONT_SIZE);
// 				 System.out.println("V_CONT_SEAL_NO : " + V_CONT_SEAL_NO);
// 				System.out.println("");
				
				cs = conn.prepareCall("call   USP_S_CONTAINER_INSERT_20190725(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_CONT_MGM_NO);
				cs.setString(3, V_CONT_NO);
				cs.setString(4, V_BP_CD);
				cs.setString(5, V_PLANT_CD);
				cs.setString(6, V_CFM_YN);
				cs.setString(7, V_CONT_SIZE);
				cs.setString(8, V_CONT_SEAL_NO);
				cs.setString(9, V_USER_ID);
				cs.registerOutParameter(10, Types.VARCHAR);

				cs.execute();
			}

			if (cs.getString(10).equals("ISCONT")) {
				PrintWriter pw = response.getWriter();
				pw.print(cs.getString(10));
				pw.flush();
				pw.close();
			} else {
				PrintWriter pw = response.getWriter();
				pw.print(cs.getString(10));
				pw.flush();
				pw.close();

			}
		}
							
		else { //IS NOT SYNU 컨테이너생성, 삭제
// 			System.out.println("CONT CREATE ! ");
// 		    System.out.println("V_TYPE : " + V_TYPE);
// 			 System.out.println("V_CONT_MGM_NO : " + V_CONT_MGM_NO);	
// 			 System.out.println("V_CONT_NO : " + V_CONT_NO);
// 			 System.out.println("V_BP_CD : " + V_BP_CD);
// 			 System.out.println("V_PLANT_CD : " + V_PLANT_CD);
// 			 System.out.println("V_CFM_YN : " + V_CFM_YN);
// 			 System.out.println("V_USER_ID : " + V_USER_ID);
// 			 System.out.println("V_CONT_SIZE : " + V_CONT_SIZE);
// 			 System.out.println("V_CONT_SEAL_NO : " + V_CONT_SEAL_NO);
// 			System.out.println();
			
			cs = conn.prepareCall("{call   USP_S_CONTAINER_INSERT_20190725(?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_CONT_MGM_NO);
			cs.setString(3, V_CONT_NO);
			cs.setString(4, V_BP_CD);
			cs.setString(5, V_PLANT_CD);
			cs.setString(6, V_CFM_YN);
			cs.setString(7, V_CONT_SIZE);
			cs.setString(8, V_CONT_SEAL_NO);
			cs.setString(9, V_USER_ID);
			cs.registerOutParameter(10, Types.VARCHAR); //CONT_MGM_NO

			cs.execute();

			if (cs.getString(10).equals("ISCONT")) {
				PrintWriter pw = response.getWriter();
				pw.print(cs.getString(10));
				pw.flush();
				pw.close();
			} else {
				PrintWriter pw = response.getWriter();
				pw.print(cs.getString(10));
				pw.flush();
				pw.close();

			}

		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
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
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
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
