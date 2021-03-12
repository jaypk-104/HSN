<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>
<%@ page language="java" contentType = "application/vnd.ms-excel;charset=euc-kr" 

	     pageEncoding="EUC-KR"%>
  <html> 

<head><meta http-equiv="Content-Type" content="text/html; charset=euc-kr" /></head>
<% 
    //�߿��� ���� : "attachment; filename=excel.xls" �� ������ excel.xls ������ �����ǰ� �ٿ�ε�ȴ�. 
    response.setHeader("Content-Disposition", "attachment; filename=excel.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data"); 
    
%>
<%@ page import = "java.sql.*" %>
    <%
    String url = "jdbc:tibero:thin:@123.142.124.138:8629:hsnetwork";
	String id = "swm";
	String pwd = "hsnadmin";                             
	Connection conn = null;
	Statement stmt = null;
	Class.forName("com.tmax.tibero.jdbc.TbDriver");
	conn=DriverManager.getConnection(url,id,pwd);
		stmt = conn.createStatement();
	ResultSet rs = null;
    try{
	String ASN_NO = (String)session.getAttribute("ASN_NO");
	
	 String sql = "SELECT A.ASN_NO,A.ASN_SEQ,A.ITEM_CD,B.ITEM_NM,PAL_BC_SEQ,PAL_BC_NO,PAL_QTY,BOX_BC_SEQ,BOX_BC_NO,BOX_QTY,LOT_NO,MAKE_DT,A.VALID_DT ";
 			sql += " FROM SUPP_BARCD_DTL A LEFT OUTER JOIN B_ITEM_SWM B ON A.ITEM_CD=B.ITEM_CD ";
			sql += " WHERE A.ASN_NO='"+ASN_NO+"'";
	 
	rs = stmt.executeQuery(sql);
	%>
	
	
<body>
   <table border="1" cellpadding="0" cellspacing="0">
        <tbody>
          <tr class="row0">
            <td rowspan="2">ASN��ȣ</td>
            <td rowspan="2">ASN ����</td>
            <td rowspan="2">ǰ���ڵ�</td>
            <td rowspan="2">ǰ���</td>
            <td colspan="3" align="center">�ȷ�Ʈ</td>
            <td colspan="3" align="center">�ڽ�</td>
            <td colspan="3" align="center">��Ʈ(YYYYMMDD)</td>
          </tr>
          <tr>
            <td>����</td>
            <td>�ȷ�Ʈ ���ڵ��ȣ</td>
            <td>��ǰ����</td>
            <td>����</td>
            <td>�ڽ� ���ڵ��ȣ</td>
            <td>��ǰ����</td>
            <td>��Ʈ��ȣ</td>
            <td>������</td>
            <td>��ȿ��</td>
          </tr>
          <% while(rs.next()) { %>
          <tr>
            <td><%=rs.getString("ASN_NO")%></td>
            <td><%=rs.getString("ASN_SEQ")%></td>
            <td><%=rs.getString("ITEM_CD")%></td>
            <td><%=rs.getString("ITEM_NM")%></td>
            <td><%=rs.getString("PAL_BC_SEQ")%></td>
            <td><%=rs.getString("PAL_BC_NO")%></td>
            <td><%=rs.getString("PAL_QTY")%></td>
            <td><%=rs.getString("BOX_BC_SEQ")%></td>
            <td><%=rs.getString("BOX_BC_NO")%></td>
            <td><%=rs.getString("BOX_QTY")%></td>
            <%
            String LOT_NO = ((rs.getString("LOT_NO")==null||rs.getString("LOT_NO").equals(""))?"":rs.getString("LOT_NO"));
            %>
            <td><%=LOT_NO%></td>
            <%
            String MAKE_DT = ((rs.getString("MAKE_DT")==null)||rs.getString("MAKE_DT").equals(""))?"":rs.getString("MAKE_DT").substring(0, 10);
            %>
            <td><%=MAKE_DT%></td>
            <%
            String VALID_DT = ((rs.getString("VALID_DT")==null)||rs.getString("VALID_DT").equals(""))?"":rs.getString("VALID_DT").substring(0, 10);
            %>
            <td><%=VALID_DT%></td>
          </tr>
          <% } %>
      </tbody>
    </table>
</body> 
</html>
	<%
    }catch(Exception e){
	 e.printStackTrace();
	 }finally{
 	  if (rs != null) try { rs.close(); } catch(SQLException ex) {}
      if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
 }
%>
