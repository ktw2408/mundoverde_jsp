<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/dbinfo.jsp" %>
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
//DB저장시 한글 깨짐 방지용
request.setCharacterEncoding("utf-8");

//========== modify.jsp 에서 보내준 정보를 분석한다.
//목록에서 넘겨준 파라메터를 분석한다.
String key        = request.getParameter("key");
String pageno   = request.getParameter("pageno");

//게시물 정보를 분석한다.
String board_no      =  myBoard.getString("no");
String board_writer  =  myBoard.getString("writer");
String board_pw      =  myBoard.getString("pw");
String board_title   =  myBoard.getString("title");
String board_content =  myBoard.getString("content");
String board_date    =  myBoard.getString("date");
String board_hit     =  myBoard.getString("hit");

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
board_date = formatter.format(new java.util.Date());

//게시물 정보를 DBMS에 저장한다.
myBoard.DBOpen();



		//비밀번호가 일치하는지 검사한다.
		if( !pw.equals(board_pw))
		{
			%>
			<script language="javascript">
				alert("비밀번호가 일치하지 않습니다.");
				document.location = "modify.jsp?no=<%= no %>";
			</script>
			<%
		}else if (pw.equals(board_pw))
		{		
			//게시물 정보를 MySQL 에 저장한다.
			String mUpdateSQL = "";
			mUpdateSQL += "update board ";
			mUpdateSQL += "set pw = '" + pw + "', ";
			mUpdateSQL += "title = '" + title + "', ";
			mUpdateSQL += "content = '" + content + "'  ";
			mUpdateSQL += "where no = '" + no + "' ";
			//out.print(mUpdateSQL);

			myBoard.Excute(mUpdateSQL);	

			%>
			<script language="javascript">
				alert("게시물을 수정하였습니다.");
				opener.document.location = "kor_view.jsp?&key=<%= key %>&pageno=<%= pageno %>&no=<%= no %>";
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