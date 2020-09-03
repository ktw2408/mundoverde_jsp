<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
if( isopinion.equals("Y") )
{
	//의견 정보를 분석한다.
	String opno      = "";								      //의견 번
	String writer    = request.getParameter("opinion_writer");  //의견 작성자
	String pw        = request.getParameter("opinion_pw");	  //의견 비밀번호
	String content   = request.getParameter("opinion_content"); //내용
	String date      = "";									  //게시물 등록일

	//의견 등록일 처리
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	date = formatter.format(new java.util.Date()); 

	// 정보를 DBMS에 저장한다.
	myBoard.DBOpen();

	//의견 정보를 MySQL 에 저장한다.
	String mInsertSQL = "";
	mInsertSQL = "insert into opinion ";
	mInsertSQL += "(content, writer, date) ";
	mInsertSQL += "values ('" + content + "','" + writer + "','" + date + "')";
	//out.print(mInsertSQL);
	myBoard.Excute(mInsertSQL);	

	//등록된 의견의 번호를 얻는다.
	String mOpinionSQL = "select max(opno) as opno from opinion";
	myBoard.OpenQuery(mOpinionSQL);
	myBoard.ResultNext();
	opno =  myBoard.getString("opno");
	myBoard.CloseQuery();
	myBoard.DBClose();
}
%>

<script language="javascript">	

	//의견 올리기를 누르면 호출되는 함수
	function FormCheck()
	{
		if(opinion_form.opinion_writer.value == "")
		{
			alert("닉네임을 입력하세요.");
			opinion_form.opinion_writer.focus();
			return;
		}
		if(opinion_form.opinion_pw.value == "")
		{
			alert("비밀번호를 입력하세요.");
			opinion_form.opinion_pw.focus();
			return;
		}		
		if(opinion_form.opinion_content.value == "")
		{
			alert("내용을 입력하세요.");
			opinion_form.opinion_content.focus();
			return;
		}
		opinion_form.submit();
	}

</script>
	<form id="opinion_form" name="opinion_form" method="post" action="inter_discuss.jsp" align="center">	
        <input type="hidden" id="isopinion" name="isopinion" value="Y">	
		<tr>
			<td>
				<input type="text" id="opinion_writer" name="opinion_writer" size="20"  placeholder="닉네임을 입력하세요.">
				<input type="password" id="opinion_pw" name="opinion_pw" size="24" placeholder="비밀번호를 입력하세요.">
			</td>			
		</tr>
		<tr>
			<td>
				<textarea id="opinion_content" name="opinion_content" class="nosize" cols="100" rows="10" placeholder="내용을 입력하세요."></textarea><br />
			</td>
		</tr>
		<tr>
			<td>			
				<input type="button" value="의견 올리기" onclick="FormCheck();" />
			</td>
		</tr>
	<%
	//등록된 의견의 목록을 얻는다.
	myBoard.DBOpen();
	
	String mOpinionSQL = "";
	
	mOpinionSQL = "select content, writer, date, no ";
	mOpinionSQL += "from opinion where type = 'C' and league = 'I' and 'no' ";
	mOpinionSQL += "order by date desc ";
	myBoard.OpenQuery(mOpinionSQL);	
	//검색된 결과를 얻는다.
	while( myBoard.ResultNext() )
	{
		String o_writer  =  myBoard.getString("writer");
		String o_pw  	 =  myBoard.getString("pw");
		String o_content =  myBoard.getString("content");
		String o_date    =  myBoard.getString("date");
		%>
		<tr>
            <td align="center"> 내용: <%= o_content %></td>
            
            <td align="center"> 작성자: <%= o_writer %></td>
            

            <td align="center"> 작성일: <%= o_date %></td>		
		</tr>
        <%
		
	}
	myBoard.CloseQuery();

	//MySQL 접속을 종료한다.
	myBoard.DBClose();	
	%> 
	</form>