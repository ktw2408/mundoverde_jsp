<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/dbinfo.jsp" %>
<%@ include file="../../include/head.jsp" %>
<%@ include file="../../include/side.jsp" %>

<%
//검색 파라메터를 분석한다.
//String category = request.getParameter("category");
String key       = request.getParameter("key");
String pageno  = request.getParameter("pageno");
String no         = request.getParameter("no");
String ispass = (String)session.getAttribute("ispass");

//직접 주소를 입력하여 수정 페이지로 접근할 때 메인화면으로 돌려보냄
if(ispass == null || ispass.equals(""))
{
	%>
	<script language="javascript">
		alert("잘못된 접근입니다. 메인 화면으로 돌아갑니다.");
		document.location("home.jsp");
	</script>
	<%
	return;
}
//게시물 정보를 가져온다.

myBoard.DBOpen();

String mSelectSQL = "";

mSelectSQL += "select no,writer,pw,title,content,date,type,league,hit,link ";
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

//MySQL 접속을 종료한다.
myBoard.DBClose();
%>
<script language="javascript">

	function GoList()
	{
		if(confirm("글쓰기를 취소하고 글보기로 이동하시겠습니까?") != 1)
		{
			return;
		}
		document.location = "inter_news_view.jsp?key=<%= key %>&pageno=<%= pageno %>&no=<%= no %>";
	}
		//수정하기를 누르면 호출되는 함수
	function FormCheck()
	{
		if(modify_form.pw.value == "")
		{
			alert("비밀번호를 입력하세요.");
			modify_form.pw.focus();
			return;
		}
		if(modify_form.title.value == "")
		{
			alert("제목을 입력하세요.");
			modify_form.title.focus();
			return;
		}
		if(modify_form.link.value == "")
		{
			alert("링크를 입력하세요.");
			modify_form.link.focus();
			return;
		}
		if(modify_form.content.value == "")
		{
			alert("내용을 입력하세요.");
			modify_form.content.focus();
			return;
		}
		modify_form.submit();
	}

</script>
<form id="modify_form" name="modify_form" method="post" action="inter_news_modify_ok.jsp">
	
	<input type="hidden" id="key" name="key" value="<%= key %>">
	<input type="hidden" id="pageno" name="pageno" value="<%= pageno %>">
	<input type="hidden" id="no" name="no" value="<%= no %>">
	<table border="1" width="100" height="150" align="center">
		<tr>
			<td>
				작성자 : <%= board_writer %>
				<input type="password" id="pw" name="pw" size="24" placeholder="비밀번호를 입력하세요.">
			</td>
			
		</tr>
		<tr>			
			<td>
				<textarea id="title" name="title" class="nosize" cols="100" rows="1" placeholder="제목을 입력하세요."><%= board_title %></textarea><br />
				<textarea id="link" name="link" class="nosize" cols="100" rows="1" placeholder="링크를 입력하세요."><%= board_link %></textarea><br />
				<div class="write_infobx">
					<p>※ "게시판과 관련된 내용을 작성해주시길 바랍니다."</p>
					<p>※ "초상권, 저작권 침해 게시물은 민,형사상의 책임을 질 수 있습니다."</p>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<textarea id="content" name="content" class="nosize" cols="100" rows="10" placeholder="내용을 입력하세요."><%= board_content %></textarea><br />
			</td>
		</tr>
<!----------------------------------------------게시글 올리기/돌아가기 버튼-------------------------------------------------->
		<tr>
			<td>			
				<input type="button" value="수정하기" onclick="javascript:FormCheck();"/>
				<input type="button" value="돌아가기" onclick="javascript:GoList();"/>				
			</td>
		</tr>
	</table>
</form>
<%@ include file="../../include/tail.jsp" %>