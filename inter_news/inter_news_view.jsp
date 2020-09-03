<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/dbinfo.jsp" %>
<%@ include file="../../include/head.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>



<%
//검색 파라메터를 분석한다.
//String category = request.getParameter("category");
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

mSelectSQL += "select no,writer,pw,title,content,date,hit,link ";
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
String board_link    =  myBoard.getString("link");
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
		
			window.open("inter_news_modify_ask.jsp?pageno=<%= pageno %>&no=<%= no %>","_modify","width=300,height=400");
	}

//게시물 삭제
	function delArticle()
	{		
		window.open("inter_news_delete.jsp?no=<%= no %>","_delete","width=300,height=400");
	}
//목록으로 이동
	function GoList()
	{
		document.location = "inter_news.jsp?key=<%= key %>&pageno=<%= pageno %>";
	}	

</script>

<table class="freeboard">
	<tr >
		<td class="readboard" >
			
			<div class="readboard_title_title"><%= board_title %></div><!--게시글 제목부분-->
			</div>
		</td>
	</tr>
	<tr>		<td class="readboard" >
		</td></tr>
	<tr>
		<td>
		<div class="readboard_title" >
				<div class="readboard_title_no">no.<%= board_no %></div>
				<div class="readboard_title_writer">작성자 : <%= board_writer %></div>
				<div class="readboard_title_hit">hit.<%= board_hit %></div>
				<div class="readboard_title_link"><a href="<%= board_link %>"><%= board_link %></a></div>
			</div>
		</td>		
	</tr>
	<tr>		<td class="readboard" >
		</td></tr>
	
	<td class="readboard_content"><!--글 내용-->
		<%		
		board_content = board_content.replaceAll("<","&lt;");
		board_content = board_content.replaceAll(">","&gt;");

		board_content = board_content.replaceAll("\n","<br>");
		%>
		<%= board_content %>
	</td>		
	
	

	
	<tr>
		<td class="readboard"></td>		
	</tr>

<!--	<td class="readboard_content">
	<div class="reply_content">내용: %= reply_content %></div>
				<div class="reply_writer">작성자 %= reply_writer %></div>
				<div class="reply_pw">비밀번호%= reply_pw %></div>
				<div class="reply_date">날짜%= reply_date %>
				</div>
	</td>-->
	

	
	

	<tr>
		<td colspan="2" align="center" style="padding-top: 20px">
			<input type="button" value="수정하기" onclick="modifyArticle();">
			<input type="button" value="삭제하기" onclick="delArticle();">
			<input type="button" value="목록으로" onClick="javascript:GoList();">
		</td>
	</tr>
<%@ include file="inter_news_reply.jsp" %>	
</table>
<%@ include file="../../include/tail.jsp" %>