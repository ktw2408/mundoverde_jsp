<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/dbinfo.jsp" %>
<%@ include file="../include/head.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>


<%
//검색 파라메터를 분석한다.
//String category = request.getParameter("category");
String key        = request.getParameter("key");
String pageno     = request.getParameter("pageno");
String no         = request.getParameter("no");
String isreply    = request.getParameter("isreply");
//String contents   = contents.replace("\r\n","<br>");

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
		/*
		var wrote_pw = prompt("게시물 작성시 입력한 비밀번호를 입력하세요.", "********");
		
			if (wrote_pw == "<%= board_pw %>") {
				document.location="kor_modify.jsp?key=<%= key %>&pageno=<%= pageno %>&no=<%= no %>";
			} else {
				alert("비밀번호가 틀립니다. 정확한 비밀번호를 입력하세요.")
			}
//			window.open("modify.jsp?no=<%= no %>","_modify","width=300,height=400");
		*/
		window.open("kor_modify_ask.jsp?pageno=<%= pageno %>&no=<%= no %>","_modify","width=300,height=400");
	}

//게시물 삭제
	function delArticle()
	{
		/*
		var wrote_pw = prompt("게시물 작성시 입력한 비밀번호를 입력하세요.");
		
			if (wrote_pw == "<%= board_pw %>") {
			
			delConfirm = window.confirm("게시물을 삭제하시겠습니까?");
			
			}
			if (delConfirm == true){
				alert("게시물을 삭제합니다.");
				document.location = "kor_delete.jsp?key=<%= key %>&pageno=<%= pageno %>&no=<%= no %>";
				
				else if (delConfirm == false){
				alert("게시물 삭제를 취소합니다.");
				}
			}
			else {
				alert("비밀번호가 틀립니다. 정확한 비밀번호를 입력하세요.")
			}	
		*/
		window.open("kor_delete.jsp?no=<%= no %>","_delete","width=300,height=400");
			
	}
//목록으로 이동
	function GoList()
	{
		document.location = "kor_free.jsp?key=<%= key %>&pageno=<%= pageno %>";
	}	
	
</script>

<table class="freeboard">
	<tr>
		<td class="readboard">
			<div class="readboard_title">
				<div class="readboard_title_no">no.<%= board_no %></div>
				<div class="readboard_title_title">제목 : <%= board_title %></div>
				<div class="readboard_title_writer">작성자 : <%= board_writer %></div>
				<div class="readboard_title_hit">hit.<%= board_hit %>
				</div>
			</div>
		</td>		
	</tr>	
	
	<td class="readboard_content"><%= board_content %></td>		
	
	<td class="readboard" style="height:0px"></td>

	
	<tr>
		<td class="readboard"></td>		
	</tr>

	<!--<td class="readboard_content">
		<div class="reply_content">내용: %= reply_content %></div>
				<div class="reply_writer">작성자 %= reply_writer %></div>
				<div class="reply_pw">비밀번호%= reply_pw %></div>
				<div class="reply_date">날짜%= reply_date %>
				</div>
	</td>
	-->
	<tr>
		<td class="readboard">
			
		</td>
	</tr>	

	<tr>
		<td colspan="2" align="center" style="padding-top: 20px">
			<input type="button" value="수정하기" onclick="modifyArticle();">
			<input type="button" value="삭제하기" onclick="delArticle();">
			<input type="button" value="목록으로" onClick="javascript:GoList();">
		</td>
	</tr>
<%@ include file="../include/kor_reply.jsp" %>	
</table>
<%@ include file="../include/tail.jsp" %>