<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/dbinfo.jsp" %>
<%@ include file="../../include/head.jsp" %>
<%@ include file="../../include/side.jsp" %>
<%
//DB저장시 한글 깨짐 방지용
request.setCharacterEncoding("utf-8");

//========== inter_news_modify.jsp 에서 보내준 정보를 분석한다.
//목록에서 넘겨준 파라메터를 분석한다.
String key        = request.getParameter("key");
String pageno   = request.getParameter("pageno");

//게시물 정보를 분석한다.
String no        = request.getParameter("no");
String writer    = request.getParameter("writer");
String pw        = request.getParameter("pw");
String title     = request.getParameter("title");
String content   = request.getParameter("content");
String link      = request.getParameter("link");
String date      = "";

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
date = formatter.format(new java.util.Date());

//게시물 정보를 DBMS에 저장한다.
myBoard.DBOpen();

//게시물 정보를 MySQL 에 저장한다.
String mUpdateSQL = "";
mUpdateSQL += "update board ";
mUpdateSQL += "set pw = '" + pw + "', ";
mUpdateSQL += "title = '" + title + "', ";
mUpdateSQL += "content = '" + content + "', ";
mUpdateSQL += "link = '" + link + "' ";
mUpdateSQL += "where no = '" + no + "' ";

//out.print(mUpdateSQL);

myBoard.Excute(mUpdateSQL);	

//MySQL 접속을 종료한다.
myBoard.DBClose();

session.setAttribute("ispass", "");
%>
<script language="javascript">
//뉴스게시판 목록으로 이동
	function GoList()
	{
		document.location = "inter_news.jsp?key=<%= key %>&pageno=<%= pageno %>";
	}
	
</script>

<br>
<table border="1" cellpadding="0" cellspacing="0" bgcolor="#fffff0" width="90%">
		<tr>
			<td height="50" align="center">게시물이 수정되었습니다.</td>
		</tr>
		<tr>
			<td align="center" height="30">
				<input type="button" value="목록으로" onClick="javascript:GoList();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="내용 보기" onClick="location.href='inter_news.jsp?no=<%= no %>';">
			</td>
		</tr>
</table>
<%@ include file="../../include/tail.jsp" %>




