<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/dbinfo.jsp" %>
<%
String pageno = request.getParameter("pageno");
String no     = request.getParameter("no");
String pw     = request.getParameter("pw");
%>
<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<TITLE> MUNDO VERDE </TITLE>
			<link rel="stylesheet" href="/football/css/style.css">
			<link href="https://fonts.googleapis.com/css2?family=Holtwood+One+SC&display=swap" rel="stylesheet">
			<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap&subset=korean" rel="stylesheet">
			<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap&subset=korean" rel="stylesheet">
			<link href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/CookieRunOTF-Black00.woff">
			<link href="https://fonts.googleapis.com/css?family=Girassol&display=swap&subset=latin-ext" rel="stylesheet">
			<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo:400,700,800&display=swap" rel="stylesheet">
	</HEAD>
	<BODY>	
<%		

myBoard.DBOpen();
//게시물의 비밀번호를 찾는다.
String mSelectSQL = "";
mSelectSQL = "select pw from board where no = '" + no + "' ";

myBoard.OpenQuery(mSelectSQL);
myBoard.ResultNext();
String board_pw =  myBoard.getString("pw");
myBoard.CloseQuery(); 
%>
<% if (!pw.equals(board_pw))
{
	session.setAttribute("ispass", "");
	%> 
	<script language="javascript">
		alert("비밀번호가 일치하지 않습니다. 정확한 비밀번호를 입력하세요.");
		document.location = "inter_modify_ask.jsp?pageno=<%= pageno %>&no=<%= no %>";
	</script>
<%}
else if (pw.equals(board_pw))
{
	session.setAttribute("ispass", "Y");
	%>
	<script language="javascript">
		alert("비밀번호가 일치합니다. 수정 페이지로 이동합니다.");		
		opener.document.location = "inter_modify.jsp?pageno=<%= pageno %>&no=<%= no %>";
		window.close();
		
	</script>
<%
}		
%>
	</BODY>
</HTML>
<%
//MySQL 접속을 종료한다.
myBoard.DBClose();
%>