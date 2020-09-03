<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/dbinfo.jsp" %>
<%		
		String key       = request.getParameter("key");
		String pageno  = request.getParameter("pageno");
		String no         = request.getParameter("no");
		String pw		  = request.getParameter("pw");
		
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
		<script language="javascript">
		
		function CheckPW()
		{
			if(frm.pw.value == "")
			{
				alert("비밀번호를 입력하세요.");
				return;
			}
			frm.submit();
			
			
		}
		</script>
		
		
		<form id="frm" name="frm" method="post" action="inter_news_modify_ask_ok.jsp">
			<input type="hidden" id="pageno" name="pageno" value="<%= pageno %>">
			<input type="hidden" id="no" name="no" value="<%= no %>">
			비밀번호를 입력하세요.
			<br>
			<input type="password" id="pw" name="pw">
			<br>
			<input type="button" value="비밀번호 입력" onclick="javascript:CheckPW();">
			<input type="button" value="취소" onclick="javascript:window.close();">
		</form>
	</BODY>
</HTML>