<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/side.jsp" %>
<%@ include file="../include/dbinfo.jsp"%>	
<%
String no = request.getParameter("no");
if( no == null )
{
	no = "";
}
myBoard.DBOpen();
%>
<br>
<br>
<br>
<br>
<br>
<script language="javascript">

	//var IsViewed = 0;
	function ShowJuje(obj)
	{
		/*
		alert(IsViewed);
		if(IsViewed == 0)
		{
			juje.style.display = "block";
			IsViewed = 1;			
		}else
		{
			juje.style.display = "none";
			IsViewed = 0;			
		}
		*/		
		if(obj.nextSibling.nextSibling.style.display == "none")
		{
			obj.nextSibling.nextSibling.style.display = "block";
		}else
		{
			obj.nextSibling.nextSibling.style.display = "none";			
		}
	}
	

</script>
<table border="1" align="center" width="550" height="80">
			<tr>
				<td>
					토론 주제 선택
					<input type="button" value="더보기" name="openbtn" onclick="javascript:ShowJuje(this);" />
					<div id="juje" name="juje" style="display:none">
						<br />
						<%
						//등록된 게시물의 목록을 얻는다.
						String mSelectSQL = "";
						
						mSelectSQL += "select no,title ";
						mSelectSQL += "from board ";
						mSelectSQL += "where type = 'C' and league = 'I' ";
						mSelectSQL += "order by no desc ";
						//out.print(mSelectSQL);
						myBoard.OpenQuery(mSelectSQL);		
						//검색된 결과를 얻는다.
						while( myBoard.ResultNext() )
						{
							String num    =  myBoard.getString("no");
							String title  =  myBoard.getString("title");				
							%>
							<a href="inter_discuss.jsp?no=<%= num %>"><%= title %></a><br /><br />
							<%
						}
						%>
						<br />
					</div>
				</td>
			</tr>
			<tr>
				<td>
				<%
                if(!no.equals(""))
                {
                    //토론주제에 대한 게시물 번호가 선택되어 있은 경우 토론에 대한 의견을 표시한다.
					%>               	                
						토론 주제 : 중동머니의 막대한 자본은 구단의 성장에 도움이 될 수 있는가?
                    <%
				}else
				{
                    %>                	                
					<font color="#ff6600">토론 주제를 선택하여 주시기 바랍니다.</font>
                    <%					
				}
				myBoard.DBClose();
				%>
				
				</td>
			</tr>
		</table>
		  
    
            <br>
            <br>
            <br>
            <table border="1" id="opinion" align="center" width="550" height="30">
				<tr>
					<td> 번호 </td>
                    <td> 의견 내용 </td>
					<td> 작성자 </td>
					<td> 작성일 </td>
				</tr>
				<tr>
					<td> 1 </td>
                    <td> 구단 리빌딩에는 이득이 있을지 몰라도 운용을 못하면 의미가 없다. </td>
					<td> k1111 </td>
					<td> 2020-04-21 </td>
				</tr>
            </table>
            <br />
            <br />
            <br />			
          
<script language="javascript">	

	//의견 보내기를 누르면 호출되는 함수
	function FormCheck()
	{
		if(comment_form.comment_writer.value == "")
		{
			alert("닉네임을 입력하세요.");
			comment_form.comment_writer.focus();
			return;
		}
		if(comment_form.comment_pw.value == "")
		{
			alert("비밀번호를 입력하세요.");
			comment_form.comment_pw.focus();
			return;
		}		
		if(comment_form.comment_content.value == "")
		{
			alert("내용을 입력하세요.");
			comment_form.comment_content.focus();
			return;
		}
		comment_form.submit();
	}
	
</script>
            <form id="comment_form" name="comment_form" action="inter_discuss.jsp?no=<%= no %>" method="post">
			<input type="hidden" id="no" name="no" value="<%= no %>">
			<input type="hidden" id="isreply" name="isreply" value="Y">	
                <div class="comment_write" align="center">
				<tr>
					<td>
						<input type="text" id="comment_writer" name="comment_writer" size="20"  placeholder="닉네임을 입력하세요.">
						<input type="password" id="comment_pw" name="comment_pw" size="24" placeholder="비밀번호를 입력하세요.">
					</td>			
				</tr>
                    <label for="comment" class="lab_write"></label>
                    <textarea id="comment" name="comment" class="tf_reply" placeholder="의견을 입력해주세요" tabindex="1" cols="60" rows="8"></textarea>
                </div>
                <div class="comment_button" align="center">			
                    <input type="button" value="의견 보내기" onclick="FormCheck();">&nbsp;&nbsp;
                    <button type="reset">다시 작성하기</button>		
                </div>
            </form>
		
<%@ include file="../include/tail.jsp" %>