<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<link rel="stylesheet" href="/football/css/style.css">
<%
if( isreply.equals("Y") )
{
	//댓글 정보를 분석한다.
	String reno      = "";								      //댓글 번
	String writer    = request.getParameter("reply_writer");  //댓글 작성자
	String pw        = request.getParameter("reply_pw");	  //댓글 비밀번호
	String content   = request.getParameter("reply_content"); //내용
	//String type      = request.getParameter("type");		  //게시판 구분(A:자유, B:뉴스, C:토론)
	//String league    = request.getParameter("league");	  //리그 구분(K:국내, I:해외)
	String date      = "";									  //게시물 등록일

	//댓글 등록일 처리
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	date = formatter.format(new java.util.Date()); 

	// 정보를 DBMS에 저장한다.
	myBoard.DBOpen();

	//댓글 정보를 MySQL 에 저장한다.
	String mInsertSQL = "";
	mInsertSQL += "insert into reply ";
	mInsertSQL += "(writer,pw,content,date,no) ";
	mInsertSQL += "values ('" + writer + "','" + pw + "','" + content + "','" + date + "','" + no + "')";
	//out.print(mInsertSQL);
	myBoard.Excute(mInsertSQL);	

	//등록된 댓글의 번호를 얻는다.
	String mReplySQL1 = "select max(reno) as reno from reply";
	myBoard.OpenQuery(mReplySQL1);
	myBoard.ResultNext();
	reno =  myBoard.getString("reno");
	myBoard.CloseQuery();
	myBoard.DBClose();
}
%>

<script language="javascript">	

	//댓글 올리기를 누르면 호출되는 함수
	function FormCheck()
	{
		if(reply_form.reply_writer.value == "")
		{
			alert("닉네임을 입력하세요.");
			reply_form.reply_writer.focus();
			return;
		}
		if(reply_form.reply_pw.value == "")
		{
			alert("비밀번호를 입력하세요.");
			reply_form.reply_pw.focus();
			return;
		}		
		if(reply_form.reply_content.value == "")
		{
			alert("내용을 입력하세요.");
			reply_form.reply_content.focus();
			return;
		}
		reply_form.submit();
	}

</script>
	<form id="reply_form" name="reply_form" method="post" action="inter_news_view.jsp">
		<input type="hidden" id="no" name="no" value="<%= no %>">
		<input type="hidden" id="key" name="key" value="<%= key %>">
		<input type="hidden" id="pageno" name="pageno" value="<%= pageno %>">	
		<input type="hidden" id="isreply" name="isreply" value="Y">	
		<tr>
			<td>
				<input type="text" id="reply_writer" name="reply_writer" size="20"  placeholder="닉네임을 입력하세요.">
				<input type="password" id="reply_pw" name="reply_pw" size="24" placeholder="비밀번호를 입력하세요.">
			</td>			
		</tr>
		<tr>
			<td style="padding-bottom: 60px;">
				<textarea id="reply_content" height="30px" name="reply_content" class="nosize" cols="90" rows="3" placeholder="내용을 입력하세요."></textarea>
					
				<input type="button" value="댓글 올리기" onclick="FormCheck();" />
			</td>
		</tr>
	<%
	//등록된 댓글의 목록을 얻는다.
	myBoard.DBOpen();
	
	String mReplySQL = "";
	
	mReplySQL += "select writer,pw,content,date ";
	mReplySQL += "from reply where no = '" + no + "' ";
	mReplySQL += "order by date asc ";
	//out.print(mReplySQL);
	myBoard.OpenQuery(mReplySQL);	
	//검색된 결과를 얻는다.
	while( myBoard.ResultNext() )
	{
		String r_writer  =  myBoard.getString("writer");
		String r_pw  	 =  myBoard.getString("pw");
		String r_content =  myBoard.getString("content");
		String r_date    =  myBoard.getString("date");
		%>

<div>
		<tr >
			<td class="reply_part">
				<div class="reply1"><%= r_content %></div>
				<div class="reply2"><%= r_writer %><br><%= r_date %></div>
			</td>
			
		</tr>
</div>		
		

		
		<%		
	}
	myBoard.CloseQuery();

	//MySQL 접속을 종료한다.
	myBoard.DBClose();	
	%> 
	</form>