<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/head.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
//========== inter_news.jsp 에서 보내준 정보를 분석한다.
//목록에서 넘겨준 파라메터를 분석한다.

String key        = request.getParameter("key");
String pageno   = request.getParameter("pageno");

%>
<script language="javascript">

	function GoList()
	{
		if(confirm("글쓰기를 취소하고 목록으로 이동하시겠습니까?") != 1)
		{
			return;
		}
		document.location = "inter_news.jsp";
	}

	//저장하기를 누르면 호출되는 함수
	function FormCheck()
	{
		if(write_form.writer.value == "")
		{
			alert("닉네임을 입력하세요.");
			write_form.writer.focus();
			return;
		}
		if(write_form.pw.value == "")
		{
			alert("비밀번호를 입력하세요.");
			write_form.pw.focus();
			return;
		}
		if(write_form.title.value == "")
		{
			alert("제목을 입력하세요.");
			write_form.title.focus();
			return;
		}
		if(write_form.link.value == "")
		{
			alert("링크를 입력하세요.");
			write_form.link.focus();
			return;
		}
		if(write_form.content.value == "")
		{
			alert("내용을 입력하세요.");
			write_form.content.focus();
			return;
		}
		write_form.submit();
	}

</script>
<!----------------------------------------------내용부-------------------------------------------------->	
<form id="write_form" name="write_form" method="post" action="inter_news_write_ok.jsp">
	
	<input type="hidden" id="key" name="key" value="<%= key %>">
	<input type="hidden" id="pageno" name="pageno" value="<%= pageno %>">
	<table border="1" width="100" height="150" align="center">
		<tr>
			<td>
				<input type="text" id="writer" name="writer" size="20" placeholder="닉네임을 입력하세요.">
				<input type="password" id="pw" name="pw" size="24" placeholder="비밀번호를 입력하세요.">
			</td>
			
		</tr>
		<tr>			
			<td>
				<textarea id="title" name="title" class="nosize" cols="100" rows="1" placeholder="제목을 입력하세요."></textarea><br />
				<textarea id="link" name="link" class="nosize" cols="100" rows="1" placeholder="링크를 입력하세요."></textarea><br />
				<div class="write_infobx">
					<p> ※ 게시판과 관련된 내용을 작성해주시길 바랍니다.</p>
					<p> ※ 초상권, 저작권 침해 게시물은 민,형사상의 책임을 질 수 있습니다.</p>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<textarea id="content" name="content" class="nosize" cols="100" rows="10" placeholder="내용을 입력하세요."></textarea><br />
			</td>
		</tr>
<!----------------------------------------------게시글 올리기/돌아가기 버튼-------------------------------------------------->
		<tr>
			<td>			
				<input type="button" value="올리기" onclick="javascript:FormCheck();"/>
				<input type="button" value="돌아가기" onclick="javascript:GoList();"/>				
			</td>
		</tr>
	</table>
</form>
<%@ include file="../../include/tail.jsp" %>