<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/dbinfo.jsp" %>
<%@ include file="../include/head.jsp" %>
<%@ page import="java.util.*, java.text.*"  %>
<% request.setCharacterEncoding("utf-8"); %>
<%
//========== kor_write.jsp 에서 보내준 정보를 분석한다.
//목록에서 넘겨준 파라메터를 분석한다.
String key      = request.getParameter("key");
String pageno   = request.getParameter("pageno");

if(key == null || key.equals(""))
{
	key = "";
}
if(pageno == null || pageno.equals(""))
{
	pageno = "1";
}


//게시물 정보를 분석한다.
String no        = "";								//게시물 번호
String writer    = request.getParameter("writer");	//작성자
String pw        = request.getParameter("pw");		//비밀번호
String title     = request.getParameter("title");	//제목
String content   = request.getParameter("content"); //내용
String type      = request.getParameter("type");	//게시판 구분(A:자유, B:뉴스, C:토론 D:아고라)
String league    = request.getParameter("league");	//리그 구분(K:국내, I:해외)
String date      = "";								//게시물 등록일

//게시물 등록일 처리
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
date = formatter.format(new java.util.Date()); 

//게시물 정보를 DBMS에 저장한다.
myBoard.DBOpen();

//게시물 정보를 MySQL 에 저장한다.
String mInsertSQL = "";
mInsertSQL += "insert into board ";
mInsertSQL += "(writer,pw,title,content,date,type,league,hit) ";
mInsertSQL += "values ('" + writer + "','" + pw + "','" + title + "','" + content + "','" + date + "','" + "A" + "','" + "K" + "',0)";
//out.print(mInsertSQL);
myBoard.Excute(mInsertSQL);	

//등록된 게시물의 번호를 얻는다.
String mSelectSQL = "select max(no) as no from board";
myBoard.OpenQuery(mSelectSQL);
myBoard.ResultNext();
no =  myBoard.getString("no");
myBoard.CloseQuery();

//MySQL 접속을 종료한다.
myBoard.DBClose();

%>

<script language="javascript">
//자유게시판 목록으로 이동
	function GoList()
	{
		document.location = "kor_free.jsp?key=<%= key %>&pageno=<%= pageno %>";
	}
	
</script>
<br>
<table border="1" cellpadding="0" cellspacing="0" bgcolor="#fffff0" width="90%">
	<input type="hidden" id="key" name="key" value="<%= key %>">
	<input type="hidden" id="pageno" name="pageno" value="<%= pageno %>">
		<tr>
			<td height="50" align="center">게시물이 저장되었습니다.</td>
		</tr>
		<tr>
			<td align="center" height="30">
			<!--<a href="kor_free.jsp?key=<%= key %>&pageno=<%= pageno %>">back to list</a>-->
				<input type="button" value="목록으로" onClick="javascript:GoList();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="내용 보기" onClick="location.href='kor_view.jsp?no=<%= no %>';">
			</td>
		</tr>
</table>
<%@ include file="../include/tail.jsp" %>