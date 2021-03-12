<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<html>
<head>
<title>출하요청서</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<body>
	<div id="top_div" style="display:none">
		<button onclick="allowBtn()" id="allowBtn">승인</button>
	</div>
	<iframe
		src="http://123.142.124.170:8080/aireport/on_server/STEEL/S_DN_PAPER_Y_STEEL_TEST.jsp?PRINT_NO=<%=request.getParameter("PRINT_NO")%>"
		frameborder="0" width="100%" height="900px"></iframe>

</body>

<script language="javascript">
	window.onload = function() {
<%request.setCharacterEncoding("utf-8");
			ResultSet rs1 = null;
			CallableStatement cs1 = null;
			String status = "";
			try {
				
				cs1 = conn.prepareCall("call USP_PRINT_CNT_STEEL(?,?)");
				cs1.setString(1, request.getParameter("PRINT_NO"));
				cs1.registerOutParameter(2, com.tmax.tibero.TbTypes.CURSOR);
				cs1.executeQuery();
				
				rs1 =(ResultSet)cs1.getObject(2);
				
				while (rs1.next()) {
					 status = rs1.getString("STATUS");
				}
				System.out.println(status);

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (cs1 != null)
					try {
						cs1.close();
					} catch (SQLException ex) {
					}
				if (rs1 != null)
					try {
						rs1.close();
					} catch (SQLException ex) {
					}
				if (stmt != null)
					try {
						stmt.close();
					} catch (SQLException ex) {
					}
			}
			
			%>

			<%
// 			if (status > 0) { //승인필요하면, 버튼 보이기
			%>
// 			document.getElementById("top_div").style.display = "block";
			<%
// 			} else { //승인필요없으면, 버튼 숨기기
			%>
// 			document.getElementById("top_div").style.display = "none";
			<%
// 			}
			%>
	}

	function allowBtn() {
<%ResultSet rs = null;
			CallableStatement cs = null;
			try {

				cs = conn.prepareCall("call USP_001_S_DN_PRINT_NEW(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "AC");//V_TYPE
				cs.setString(2, "HSN");//V_COMP_ID
				cs.setString(3, "");//V_DN_NO
				cs.setString(4, "");//V_DN_SEQ
				cs.setString(5, "");//V_DN_REQ_DT
				cs.setString(6, "");//V_DN_REQ_NO
				cs.setString(7, request.getParameter("PRINT_NO"));//V_PRINT_NO
				cs.setString(8, "");//V_BLCN_NO
				cs.setString(9, "");//V_ITEM_NM2
				cs.setString(10, "");//V_REMARK
				cs.setString(11, "");//V_USR_ID
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

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
			}%>
	alert('결재가 완료되었습니다.');
		document.getElementById("top_div").style.display = "none";
	}
</script>
</html>


