/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.52
 * Generated at: 2021-02-01 00:05:47 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.HSPF01.SWM.custom.rawpurchase.sql;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.PrintWriter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import java.sql.*;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public final class HsnCustomPoreqSql_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("org.json.simple.JSONObject");
    _jspx_imports_classes.add("javax.sql.DataSource");
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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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

      out.write('\n');
      out.write('\n');

	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		String u_na_dt_to = request.getParameter("u_na_dt_to").substring(0, 10);
		String u_na_dt_from = request.getParameter("u_na_dt_from").substring(0, 10);
		String u_dt_to = request.getParameter("u_dt_to").substring(0, 10);
		String u_dt_from = request.getParameter("u_dt_from").substring(0, 10);
		String u_po_no = request.getParameter("u_po_no");
		String poradio = request.getParameter("poradio");

		String V_chk_AA = request.getParameter("V_chk_AA");
		String V_chk_AU = request.getParameter("V_chk_AU");
		String V_chk_AM = request.getParameter("V_chk_AM");
		String V_chk_TN = request.getParameter("V_chk_TN");
		String V_ITEM_CD = request.getParameter("V_ITEM_CD");
		
// 		System.out.println("V_chk_TN : " + V_chk_TN);
// 		System.out.println("u_na_dt_to : " + u_na_dt_to);
// 		System.out.println("u_na_dt_from : " + u_na_dt_from);
// 		System.out.println("u_dt_to : " + u_dt_to);
// 		System.out.println("u_dt_from : " + u_dt_from);
// 		System.out.println("u_po_no : " + u_po_no);
// 		System.out.println("poradio : " + poradio);

		String V_PLANT_CD = "";
		
		
		
		
		
		/*
		if (poradio.equals("Y")) {
			poradio = " ='" + poradio + "'";
		} else if (poradio.equals("N")) {
			poradio = " ='" + poradio + "'";
		} else if (poradio.equals("ALL")) {
			poradio = " in('Y','N')";
		}

		String sql = "SELECT A.PO_NO, TO_NUMBER(A.PO_SEQ) PO_SEQ, A.PO_DT, A.PLANT_CD, ";
		sql += " CASE A.PLANT_CD WHEN '03' THEN 'HSAM' WHEN '01' THEN 'HSAA' ELSE 'HSAU' END PLANT_NM, TRIM(A.ITEM_CD) ITEM_CD, ";
		sql += " B.BP_ITEM_CD, D.ITEM_NM,D.SPEC,A.SL_QTY,A.SL_PRC,A.SL_AMT,B.S_PRICE BASE_SL_PRC,A.DLV_DT, ";
		sql += " A.PO_YN,A.REMARK, EX.BP_CD M_BP_CD,F.BP_NM M_BP_NM,EX.M_PRICE M_PRC ";
		sql += " FROM M_PO_REC_HSNA A LEFT OUTER JOIN S_BP_ITEM_PRICE_SWM B ON  A.ITEM_CD=B.ITEM_CD ";
		sql += " AND B.VALID_FR_DT=(SELECT MAX(C.VALID_FR_DT) FROM S_BP_ITEM_PRICE_SWM C  WHERE B.ITEM_CD=C.ITEM_CD AND B.BP_CD=C.BP_CD) ";
		sql += " LEFT OUTER JOIN m_bp_item_price_swm EX ON A.ITEM_CD = EX.ITEM_CD ";
		sql += " AND EX.VALID_FR_DT = (SELECT MAX(EXX.VALID_FR_DT) FROM m_bp_item_price_swm EXX WHERE EXX.ITEM_CD = A.ITEM_CD AND EXX.BP_CD=EX.BP_CD) ";
		sql += " LEFT OUTER JOIN B_ITEM_SWM D ON A.ITEM_CD=D.ITEM_CD ";
		sql += "LEFT OUTER JOIN B_BIZ_INFO F ON EX.BP_CD=F.BP_CD  ";
		sql += " WHERE PO_DT <='" + u_na_dt_to + "' AND PO_DT >='" + u_na_dt_from + "'";
		sql += " AND PO_YN" + poradio + " AND DLV_DT>= '" + u_dt_from + "' AND DLV_DT<='" + u_dt_to + "' ";
		sql += " AND (B.BP_CD IS NULL OR B.BP_CD = CASE A.PLANT_CD WHEN '03' THEN '04529' ELSE '00296' END  )";
		sql += " AND PO_NO LIKE '%" + u_po_no + "%' ";

		if (V_chk_AA.equals("false")) {
			sql += "AND A.PLANT_CD <> '01'";
		}
		if (V_chk_AU.equals("false")) {
			sql += "AND A.PLANT_CD <> '02'";
		}
		if (V_chk_AM.equals("false")) {
			sql += "AND A.PLANT_CD <> '03'";
		}

		sql += " ORDER BY A.PO_DT,A.PO_NO,A.PO_SEQ,EX.BP_CD";

		rs = stmt.executeQuery(sql);
		*/
		
		
		//SQL 박혀있는것 SP로 수정.
		cs = conn.prepareCall("call USP_M_PREQ_TO_SURVEY_SELECT(?,?,?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, u_po_no);
		cs.setString(3, u_na_dt_from);
		cs.setString(4, u_na_dt_to);
		cs.setString(5, u_dt_from);
		cs.setString(6, u_dt_to);
		cs.setString(7, poradio);
		cs.setString(8, V_chk_AA);
		cs.setString(9, V_chk_AU);
		cs.setString(10, V_chk_AM);
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		cs.setString(12, V_chk_TN);
		cs.setString(13, V_ITEM_CD);
		
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(11);
		
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("PO_CFM", rs.getString("PO_CFM"));
			subObject.put("PO_YN", rs.getString("PO_YN"));
			subObject.put("PO_NO", rs.getString("PO_NO"));
			subObject.put("PO_SEQ", Integer.parseInt(rs.getString("PO_SEQ")));
			subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
			subObject.put("PLANT_CD", rs.getString("PLANT_CD"));
			subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("SL_QTY", rs.getFloat("SL_QTY"));
			subObject.put("SL_PRC", rs.getFloat("SL_PRC"));
			subObject.put("SL_AMT", rs.getFloat("SL_AMT"));
			subObject.put("BASE_SL_PRC", rs.getFloat("BASE_SL_PRC"));
			subObject.put("DLV_DT", rs.getString("DLV_DT").substring(0, 10));
			subObject.put("REMARK", rs.getString("REMARK"));
			subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
			subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
			subObject.put("M_PRC", rs.getFloat("M_PRC"));
			subObject.put("PLANT_NM", rs.getString("PLANT_NM"));
			subObject.put("ASN_YN", rs.getString("ASN_YN"));
			subObject.put("MID_PACK_QTY", rs.getString("MID_PACK_QTY"));
			subObject.put("PO_NO2", rs.getString("PO_NO2"));
			subObject.put("PO_SEQ2", rs.getString("PO_SEQ2"));
			subObject.put("HS_PO_NO", rs.getString("HS_PO_NO"));
			subObject.put("HS_PO_SEQ", rs.getString("HS_PO_SEQ"));

			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);

// 				System.out.println(jsonObject);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}

      out.write('\n');
      out.write('\n');
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
