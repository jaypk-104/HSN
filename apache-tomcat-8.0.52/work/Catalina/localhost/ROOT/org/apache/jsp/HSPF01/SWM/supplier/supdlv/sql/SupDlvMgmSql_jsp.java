/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.52
 * Generated at: 2021-01-29 04:46:20 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.HSPF01.SWM.supplier.supdlv.sql;

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

public final class SupDlvMgmSql_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write(" ");
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
		// 	 System.out.println("납품예정SQL");
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;

		//MyViewport
		String u_pay_from_dt = request.getParameter("u_pay_from_dt").substring(0, 10);
		String u_pay_to_dt = request.getParameter("u_pay_to_dt").substring(0, 10);
		String u_po_from_dt = request.getParameter("u_po_from_dt").substring(0, 10);
		String u_po_to_dt = request.getParameter("u_po_to_dt").substring(0, 10);
		String u_po_no = request.getParameter("u_po_no");
		String u_item_cd = request.getParameter("u_item_cd");
		String u_asn_no = request.getParameter("u_asn_no");
		String u_bp_nm = request.getParameter("u_bp_nm");
		String gbp_cd = request.getParameter("gbp_cd"); //거래처코드
		// 		String gbp_cd = "05116"; //거래처코드
		
		
		/*
		String sql = "";
		sql = "SELECT DISTINCT A.MAST_PO_NO, A.MAST_PO_SEQ, AX.BP_NM, A.ITEM_CD, B.ITEM_NM, B.SPEC,                                                ";
		sql += "                B.STOCK_UNIT, A.PO_DT, A.DLVY_DT, A.PO_QTY, NVL (C.GR_QTY, 0) GR_QTY, '' AVAIL_DT,                                  ";
		sql += "                0 AVAIL_QTY, D.BARCD_CNT, A.PO_QTY - NVL (E.DLVY_AVL_QTY, 0) AS REMAIN_QTY, '' AVAIL_DT, 0 AVAIL_QTY, D.BARCD_CNT, ";
		sql += "                CASE H.PLANT_CD WHEN '03' THEN 'HSAM(멕시코)' WHEN '01' THEN 'HSAA(미국)' ELSE 'HSAU(미국)' END PLANT_NM                   ";
		sql += "FROM            M_PO_SURVEY_DTL A                                                                                                   ";
		sql += "                LEFT OUTER JOIN B_ITEM_SWM B                                                                                        ";
		sql += "                ON              A.ITEM_CD = B.ITEM_CD                                                                               ";
		sql += "                LEFT OUTER JOIN B_BIZ_INFO AX                                                                                       ";
		sql += "                ON              A.BP_CD = AX.BP_CD                                                                                  ";
		sql += "                LEFT OUTER JOIN M_SUPP_TO_GR_SUM C                                                                                  ";
		sql += "                ON              A.MAST_PO_NO  = C.MAST_PO_NO                                                                        ";
		sql += "                AND             A.MAST_PO_SEQ = C.MAST_PO_SEQ                                                                       ";
		sql += "                LEFT OUTER JOIN SUPP_BARCD_MST_CNT D                                                                                ";
		sql += "                ON              A.MAST_PO_NO  = D.MAST_PO_NO                                                                        ";
		sql += "                AND             A.MAST_PO_SEQ = D.MAST_PO_SEQ                                                                       ";
		sql += "                LEFT OUTER JOIN M_SUPP_TO_AVL_QTY_SUM E                                                                             ";
		sql += "                ON              A.MAST_PO_NO  = E.MAST_PO_NO                                                                        ";
		sql += "                AND             A.MAST_PO_SEQ = E.MAST_PO_SEQ                                                                       ";
		sql += "                LEFT OUTER JOIN SUPP_BARCD_MST F                                                                                    ";
		sql += "                ON              A.MAST_PO_NO  = F.MAST_PO_NO                                                                        ";
		sql += "                AND             A.MAST_PO_SEQ = F.MAST_PO_SEQ                                                                       ";
		sql += "                LEFT OUTER JOIN M_PO_SURVEY G                                                                                       ";
		sql += "                ON A.PO_NO = G.PO_NO                                                                                                ";
		sql += "                AND A.PO_SEQ = G.PO_SEQ                                                                                             ";
		sql += "                LEFT OUTER JOIN M_PO_REC_HSNA H                                                                                     ";
		sql += "                ON G.CUST_PO_NO = H.PO_NO                                                                                           ";
		sql += "                AND G.CUST_PO_SEQ = H.PO_SEQ                                                                                        ";
		sql += "WHERE a.bp_cd='" + gbp_cd + "'";
		sql += " AND A.DLVY_DT <='" + u_pay_to_dt + "' AND A.DLVY_DT >='" + u_pay_from_dt + "'";
		sql += " AND A.PO_DT<= '" + u_po_to_dt + "' AND A.PO_DT>='" + u_po_from_dt + "' ";
		sql += " AND NVL(F.ASN_NO, ' ') LIKE '%" + u_asn_no + "%' ";
		sql += " AND A.MAST_PO_NO LIKE '%" + u_po_no + "%' AND A.ITEM_CD LIKE '%" + u_item_cd + "%' ORDER BY A.MAST_PO_NO, A.MAST_PO_SEQ";

		String adminSql = "";
		adminSql = "SELECT DISTINCT A.MAST_PO_NO, A.MAST_PO_SEQ, AX.BP_NM, A.ITEM_CD, B.ITEM_NM, B.SPEC,                                                ";
		adminSql += "                B.STOCK_UNIT, A.PO_DT, A.DLVY_DT, A.PO_QTY, NVL (C.GR_QTY, 0) GR_QTY, '' AVAIL_DT,                                  ";
		adminSql += "                0 AVAIL_QTY, D.BARCD_CNT, A.PO_QTY - NVL (E.DLVY_AVL_QTY, 0) AS REMAIN_QTY, '' AVAIL_DT, 0 AVAIL_QTY, D.BARCD_CNT, ";
		adminSql += "                CASE H.PLANT_CD WHEN '03' THEN 'HSAM(멕시코)' WHEN '01' THEN 'HSAA(미국)' ELSE 'HSAU(미국)' END PLANT_NM                   ";
		adminSql += "FROM            M_PO_SURVEY_DTL A                                                                                                   ";
		adminSql += "                LEFT OUTER JOIN B_BIZ_INFO AX                                                                                       ";
		adminSql += "                ON              A.BP_CD = AX.BP_CD                                                                                  ";
		adminSql += "                LEFT OUTER JOIN B_ITEM_SWM B                                                                                        ";
		adminSql += "                ON              A.ITEM_CD = B.ITEM_CD                                                                               ";
		adminSql += "                LEFT OUTER JOIN M_SUPP_TO_GR_SUM C                                                                                  ";
		adminSql += "                ON              A.MAST_PO_NO  = C.MAST_PO_NO                                                                        ";
		adminSql += "                AND             A.MAST_PO_SEQ = C.MAST_PO_SEQ                                                                       ";
		adminSql += "                LEFT OUTER JOIN SUPP_BARCD_MST_CNT D                                                                                ";
		adminSql += "                ON              A.MAST_PO_NO  = D.MAST_PO_NO                                                                        ";
		adminSql += "                AND             A.MAST_PO_SEQ = D.MAST_PO_SEQ                                                                       ";
		adminSql += "                LEFT OUTER JOIN M_SUPP_TO_AVL_QTY_SUM E                                                                             ";
		adminSql += "                ON              A.MAST_PO_NO  = E.MAST_PO_NO                                                                        ";
		adminSql += "                AND             A.MAST_PO_SEQ = E.MAST_PO_SEQ                                                                       ";
		adminSql += "                LEFT OUTER JOIN SUPP_BARCD_MST F                                                                                    ";
		adminSql += "                ON              A.MAST_PO_NO  = F.MAST_PO_NO                                                                        ";
		adminSql += "                AND             A.MAST_PO_SEQ = F.MAST_PO_SEQ                                                                       ";
		adminSql += "                LEFT OUTER JOIN M_PO_SURVEY G                                                                                       ";
		adminSql += "                ON A.PO_NO = G.PO_NO                                                                                                ";
		adminSql += "                AND A.PO_SEQ = G.PO_SEQ                                                                                             ";
		adminSql += "                LEFT OUTER JOIN M_PO_REC_HSNA H                                                                                     ";
		adminSql += "                ON G.CUST_PO_NO = H.PO_NO                                                                                           ";
		adminSql += "                AND G.CUST_PO_SEQ = H.PO_SEQ                                                                                        ";
		adminSql += " WHERE A.DLVY_DT <='" + u_pay_to_dt + "' AND A.DLVY_DT >='" + u_pay_from_dt + "'";
		adminSql += " AND A.PO_DT<= '" + u_po_to_dt + "' AND A.PO_DT>='" + u_po_from_dt + "' ";
		adminSql += " AND A.MAST_PO_NO LIKE '%" + u_po_no + "%' AND A.ITEM_CD LIKE '%" + u_item_cd + "%' ";
		adminSql += " AND NVL(F.ASN_NO, ' ') LIKE '%" + u_asn_no + "%' ";
		adminSql += " AND NVL(AX.BP_NM, ' ') LIKE '%" + u_bp_nm + "%' ";
		adminSql += "  ORDER BY A.MAST_PO_NO, A.MAST_PO_SEQ ";

		if (gbp_cd.equals("00000")) {
			rs = stmt.executeQuery(adminSql);
		} else {
			rs = stmt.executeQuery(sql);
		}
		*/
		
		//SQL 박혀있는것 SP로 수정.
		
		cs = conn.prepareCall("call USP_SUPP_SELECT(?,?,?,?,?,?,?,?,?,?,?)");
		cs.setString(1, "S");
		cs.setString(2, u_asn_no);
		cs.setString(3, u_po_no);
		cs.setString(4, u_po_from_dt);
		cs.setString(5, u_po_to_dt);
		cs.setString(6, u_pay_from_dt);
		cs.setString(7, u_pay_to_dt);
		cs.setString(8, u_item_cd);
		cs.setString(9, u_bp_nm);
		cs.setString(10, gbp_cd);
		cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
		
		cs.executeQuery();
		rs = (ResultSet) cs.getObject(11);
		
		
		while (rs.next()) {
			subObject = new JSONObject();

			subObject.put("MAST_PO_NO", rs.getString("MAST_PO_NO"));
			subObject.put("MAST_PO_SEQ", rs.getString("MAST_PO_SEQ"));
			subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
			subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
			subObject.put("SPEC", rs.getString("SPEC"));
			subObject.put("STOCK_UNIT", rs.getString("STOCK_UNIT"));
			subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
			subObject.put("DLVY_DT", rs.getString("DLVY_DT").substring(0, 10));
			subObject.put("PO_QTY", rs.getString("PO_QTY"));
			subObject.put("GR_QTY", rs.getString("GR_QTY"));
			subObject.put("REMAIN_QTY", rs.getString("REMAIN_QTY"));
			subObject.put("REMAIN_QTY2", rs.getString("REMAIN_QTY2"));
			subObject.put("AVAIL_DT", rs.getString("AVAIL_DT"));
			subObject.put("AVAIL_QTY", rs.getString("AVAIL_QTY"));
			subObject.put("BARCD_CNT", rs.getString("BARCD_CNT"));
			subObject.put("BP_NM", rs.getString("BP_NM"));
			subObject.put("PLANT_NM", rs.getString("PLANT_NM"));
			
			subObject.put("BL_NO", rs.getString("BL_NO")); 
			subObject.put("BL_SEQ", rs.getString("BL_SEQ")); 
			subObject.put("CC_NO", rs.getString("CC_NO")); 
			subObject.put("CC_SEQ", rs.getString("CC_SEQ")); 
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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
