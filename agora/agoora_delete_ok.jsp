<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/dbinfo.jsp" %>
<%
String no         = request.getParameter("no");
String pw         = request.getParameter("pw");
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

		//비밀번호가 일치하는지 검사한다.
		if( !pw.equals(board_pw))
		{
			%>
			<script language="javascript">
				alert("비밀번호가 일치하지 않습니다.");
				document.location = "agora_delete.jsp?no=<%= no %>";
			</script>
			<%
		//비밀번호가 일치하면 게시물과 게시물에 달린 댓글을 모두 삭제한다.
		}else if (pw.equals(board_pw))
		{		
			String mDeleteSQL = "";
			mDeleteSQL = "delete from reply where no = '" + no + "' ";
			//out.print(mDeleteSQL);
			myBoard.Excute(mDeleteSQL);

			mDeleteSQL = "delete from board where no = '" + no + "' ";
			//out.print(mDeleteSQL);
			myBoard.Excute(mDeleteSQL);

			%>
			
			<script language="javascript">
			//게시물 삭제를 알리는 팝업창을 띄우고 agoraMain으로 이동한다.
				alert("게시물을 삭제하였습니다.");
				opener.document.location = "agoraMain.jsp";
				window.close();
			</script>
			<%
		}		
		%>
		게시물 번호 : <%= no %>
		<br>
		비밀번호 : <%= board_pw %>
		

	</BODY>
</HTML>
<%
//MySQL 접속을 종료한다.
myBoard.DBClose();
%>