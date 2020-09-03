<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/dbinfo.jsp" %>
<%@ include file="../include/head.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>


<%
//검색 파라메터를 분석한다.
String key        = request.getParameter("key");
String pageno     = request.getParameter("pageno");
String no         = request.getParameter("no");
String isreply    = request.getParameter("isreply");

if(key == null || key.equals(""))
{
	key = "";
}
if(pageno == null || pageno.equals(""))
{
	pageno = "1";
}
if(isreply == null || isreply.equals(""))
{
	isreply = "N";
}

//게시물 정보를 가져온다.
myBoard.DBOpen();

String mSelectSQL = "";

mSelectSQL += "select no,writer,pw,title,content,date,hit ";
mSelectSQL += "from board ";
mSelectSQL += "where no = '" + no + "' ";
//out.print(mSelectSQL);


myBoard.OpenQuery(mSelectSQL);
myBoard.ResultNext();
String board_no      =  myBoard.getString("no");
String board_writer  =  myBoard.getString("writer");
String board_pw      =  myBoard.getString("pw");
String board_title   =  myBoard.getString("title");
String board_content =  myBoard.getString("content");
String board_date    =  myBoard.getString("date");
String board_hit     =  myBoard.getString("hit");
myBoard.CloseQuery(); 

mSelectSQL += "select reno,writer,pw,content,date ";
mSelectSQL += "from reply ";
mSelectSQL += "where no = '" + no + "' ";
//out.print(mSelectSQL);

//myBoard.OpenQuery(mSelectSQL);
//myBoard.ResultNext();
//String reply_no      =  myBoard.getString("reno");
//String reply_writer  =  myBoard.getString("writer");
//String reply_pw      =  myBoard.getString("pw");
//String reply_content =  myBoard.getString("content");
//String reply_date    =  myBoard.getString("date");
//myBoard.CloseQuery(); 

//조회수를 +1 한다.
String mUpdateSQL = "update board set hit = hit + 1 where no = '" + no + "' ";
//out.print(mUpdateSQL);
myBoard.Excute(mUpdateSQL);	

//MySQL 접속을 종료한다.
myBoard.DBClose();
%>
<script language="javascript">
	//게시물 수정
	function modifyArticle(){
	
		window.open("inter_modify_ask.jsp?pageno=<%= pageno %>&no=<%= no %>","_modify","width=300,height=400");
	}
	//게시물 삭제
	function delArticle() {
		
		window.open("inter_delete.jsp?no=<%= no %>","_delete","width=300,height=400");
		
	}
	//목록으로 이동
	function GoList()
	{
		document.location = "inter_free.jsp?key=<%= key %>&pageno=<%= pageno %>";
	}

</script>
<table border="1" width="50%" align="center">
	<tr>		
		<td align="center">작성자 : <%= board_writer %></td>
	</tr>
	<tr>
		<td align="center">조회수 : <%= board_hit %></td>		
	</tr>
	<tr>
		<td align="center">작성일 : <%= board_date %></td>		
	</tr>	
	<tr>
		<td align="center">제목 : <%= board_title %></td>		
	</tr>
	<tr>
		<td align="center">내용: <%= board_content %></td>		
	</tr>
	<tr>
		<td colspan="2" height="40" align="center">
			<input type="button" value="수정하기" onclick="modifyArticle();">
			<input type="button" value="삭제하기" onclick="delArticle();">
			<input type="button" value="목록으로" onClick="javascript:GoList();">
		</td>
	</tr>
	<%@ include file="../include/inter_reply.jsp" %>	
</table>
<%@ include file="../include/tail.jsp" %>