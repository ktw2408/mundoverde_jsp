<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/dbinfo.jsp" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
String no = request.getParameter("no");
String isopinion = request.getParameter("opinion");
if( no == null )
{
	no = "";
}
if( isopinion == null || isopinion.equals(""))
{
	isopinion = "N";
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
<script language = "javascript">
	function FormCheck()
	{
		if (opinion_form.opinion_writer.value == "")
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
<table border="1" align="center" width="550" height="80">
			<tr>
				<td colspan="4">
					토론 주제 선택
					<input type="button" value="더보기" name="openbtn" onclick="javascript:ShowJuje(this);" />
					<div id="juje" name="juje" style="display:none">
						<br />
						<a href="kor_discuss.jsp?no=">해외에서 중계권을 판매 할때 어떤 방법으로 효과를 볼 것인가?</a><br /><br />
							
							
						<a href="kor_discuss.jsp?no=">시즌권 환불에 대한 대책은 있는가?</a><br /><br />
						<%
						//등록된 게시물의 목록을 얻는다.
						String mSelectSQL = "";
						
						mSelectSQL += "select no,title,type ";
						mSelectSQL += "from board ";
						mSelectSQL += "where type = 'C' and league = 'K' ";
						mSelectSQL += "order by no desc ";
						//out.print(mSelectSQL);
						myBoard.OpenQuery(mSelectSQL);		
						//검색된 결과를 얻는다.
						while( myBoard.ResultNext() )
						{
							String xno    =  myBoard.getString("no");
							String title  =  myBoard.getString("title");
							String type   =  myBoard.getString("type");				
							%>
							<a href="kor_discuss.jsp?no=<%= xno %>"><%= title %></a><br /><br />
							
							<%
						}
						myBoard.CloseQuery();
						%>
						<br />
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<%
                if(!no.equals(""))
                {
                    //토론주제에 대한 게시물 번호가 선택되어 있는 경우 토론에 대한 의견을 표시한다.
                    %>                	                
					토론 주제 : 
                    <%
				}else
				{
                    %>                	                
					<font color="#ff6600">토론 주제를 선택하여 주시기 바랍니다.</font>
                    <%					
				}
				%>
				
				</td>
			</tr>
        <%
		if(!no.equals(""))
		{
			
			%>
            <br>
            <br>
			<br>
			           
			
				<%
				    mSelectSQL  = "select opno, content, writer, date, type ";
					mSelectSQL += "from opinion ";
					mSelectSQL += "where no = '"+ no + "' ";
					myBoard.OpenQuery(mSelectSQL);
				%>
				<tr>
					<td> 번호 </td>
					<td> 의견 </td>
					<td> 작성자 </td>
					<td> 작성일 </td>	
				</tr>
				<%
				while(myBoard.ResultNext())
				{
					String opinion_no = myBoard.getString("opno");
					String opinion_content = myBoard.getString("content");
					String opinion_writer = myBoard.getString("writer");
					String opinion_date = myBoard.getString("date");
					String opinion_type = myBoard.getString("type");
					%>					
					<tr>
						<td class="opinionboard_no" width="50px"><%= opinion_no %></td>
						<td class="opinionboard_content" width="50px"><%= opinion_content %></td>
						<td class="opinionboard_writer" width="50px"><%= opinion_writer %></td>
						<td class="opinionboard_date" width="50px"><%= opinion_date %></td>
						<td class="opinionboard_type" width="50px"><%= opinion_type %></td>
					</tr>
					<%
				}
				%>

			myBoard.CloseQuery();
			%>
			<br>
			<br>
			<%
		}
		myBoard.DBClose();
%>
<%@ include file="../include/kor_opinion.jsp" %>
</table>
<%@ include file="../include/tail.jsp" %>