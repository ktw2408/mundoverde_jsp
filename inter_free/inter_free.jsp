<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/dbinfo.jsp" %>
<%@ include file="../include/head.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
//검색 파라메터를 분석한다.

String key       = request.getParameter("key");
String pageno  = request.getParameter("pageno");
String keyfield = request.getParameter("keyfield");
String keyword = request.getParameter("keyword");

int perpage  = 5;
int startPage = 0;
int maxPage  = 0;

if(key == null || key.equals(""))
{
	key = "";
}
if(pageno == null || pageno.equals(""))
{
	pageno = "1";
}
if(keyword == null || keyword.equals(""))
{
	keyword = "";
}
if(keyfield == null || keyfield.equals(""))
{
	keyfield = "0";
}

//현재 페이지 번호에 따른 시작 결과값 계산
int curpage = Integer.parseInt(pageno);
startPage = (curpage - 1) * perpage;
%>
<script language="javascript">

//검색을 수행하기 위한 함수
function DoSearch()
{
	document.search_form.submit();
}
</script>

<%

myBoard.DBOpen();

String mTotalSQL = "";
mTotalSQL  += " select									";
mTotalSQL  += " 	count(no) as totalrow 				";
mTotalSQL  += " 	from board 							";
mTotalSQL  += " where 									";
mTotalSQL  += " 	type = 'A' and league = 'I' 		";

//검색 조건을 생성한다.
String mWhere = "";

if(!keyword.equals(""))
{
	mWhere  += " and  ";

	
	if("0".equals(keyfield))
	{
		mWhere += " title like '%" + keyword + "%' or writer like '%" + keyword + "%' or content like '%" + keyword + "%' ";
	}
	else if("1".equals(keyfield))
	{
		mWhere  += "title like '%" + keyword + "%' ";
	}
	else if("2".equals(keyfield))
	{
		mWhere  += "content like '%" + keyword + "%' ";
	}
	else if("3".equals(keyfield))
	{
		mWhere  += "writer like '%" + keyword + "%' ";
	}			
		
	//mWhere  += " title like '%" + key + "%' ";
}


//현재 게시판에서 총 게시물의 갯수를 얻는다.
mTotalSQL  += mWhere;
//String v1 = mTotalSQL + mWhere;

//out.print(v1);
//out.print("<br>");
//out.println(1);
//out.println(myBoard.OpenQuery(mTotalSQL));
//out.println(2);
//out.println(myBoard.ResultNext());
//out.println(3);

myBoard.OpenQuery(mTotalSQL);
myBoard.ResultNext();
int totalRow = myBoard.getInt("totalrow");
myBoard.CloseQuery();

//최대 페이지 번호를 얻는다.
maxPage = totalRow / perpage;
if( totalRow % perpage != 0)
	{
		maxPage = maxPage + 1;
	}
%>
<!----------------------------------------------자유게시판 주 기능-------------------------------------------------->
	<table class="freeboard" align="center">
		<tr class="boardmenu">
			<td class="boardmenu" id="no">번호</td>
			<td class="boardmenu" id="title">제목</td>
			<td class="boardmenu" id="writer">작성자</td>
			<td class="boardmenu" id="date">날짜</td>
			<td class="boardmenu" id="hit">조회수</td>
		</tr>
		<%
	//등록된 게시물의 목록을 얻는다.
	String mSelectSQL = "";
	
	mSelectSQL += "select no,title,writer,date,hit ";
	mSelectSQL += "from board where type = 'A' and league = 'I' ";
	mSelectSQL += mWhere;
	mSelectSQL += "order by no desc ";
	mSelectSQL += "limit " + startPage + "," + perpage;
	//out.print(mSelectSQL);
	myBoard.OpenQuery(mSelectSQL);


	//검색된 결과를 얻는다.
	while( myBoard.ResultNext() )
	{
		String no    =  myBoard.getString("no");
		String title  =  myBoard.getString("title");
		String writer  =  myBoard.getString("writer");
		String date    =  myBoard.getString("date");
		String hit    =  myBoard.getString("hit");

		%>

		<tr class="boardcontent">
			<td id="no"><%= no %></td>
			<td id="title"><a href="inter_view.jsp?no=<%= no %>"><%= title %></a></td>
			<td id="writer"><%= writer %></td>
			<td id="date"><%= date %></td>
			<td id="hit"><%= hit %></td>
		</tr>
		<%
	}

	myBoard.DBClose();
	%>
		
		<tr class="boardcontent">
			<td colspan="5" align="center">
			<%
			if(curpage <= 1)
			{
				%>
				[ <a href="javascript:alert('첫 번째 페이지입니다.');">이전페이지</a> ] 
				<%
			}else
			{
				%>
				[ <a href="inter_free.jsp?key=<%= key %>&pageno=<%= curpage - 1 %>">이전페이지</a> ] 
				<%
			}
			for(int i=1;i<=maxPage;i++)
			{
				if(i == curpage)
				{
					%>
					&nbsp;<a href="inter_free.jsp?&key=<%= key %>&pageno=<%= i %>"><strong><font color="red"><%= i %></font></strong></a>&nbsp;
					<%
				}else
				{
					%>
					&nbsp;<a href="inter_free.jsp?&key=<%= key %>&pageno=<%= i %>"><%= i %></a>&nbsp;
					<%
				}
			}
			
			if(curpage >= maxPage)
			{
				%>
				[ <a href="javascript:alert('마지막 페이지입니다.');">다음페이지</a> ]
				<%
			}else
			{
				%>
				[ <a href="inter_free.jsp?key=<%= key %>&pageno=<%= curpage + 1 %>">다음페이지</a> ]
				<%
			}
			%>
			</td>
		</tr>
		<tr class="boardcontent">
			<form id="search_form" name="search_form" method="get" action="inter_free.jsp">
			<td id="search" colspan="5" >
				<select id = "keyfield" name = "keyfield">					
					<%
					if (keyfield.equals("0"))
					{
						%><option value="0" selected>전체</option><%
					}else
					{
						%><option value="0">전체</option><%
					}
					%>
					<%
					if (keyfield.equals("1"))
					{
						%><option value="1" selected>제목</option><%
					}else
					{
						%><option value="1">제목</option><%
					}
					%>
					<%
					if (keyfield.equals("2"))
					{
						%><option value="2" selected>내용</option><%
					}else
					{
						%><option value="2">내용</option><%
					}
					%>
					<%
					if (keyfield.equals("3"))
					{
						%><option value="3" selected>작성자</option><%
					}else
					{
						%><option value="3">작성자</option><%
					}
					%>
				</select>
				<input type="text" id = "keyword" name="keyword" size="50" value="<%= keyword %>" placeholder="검색어">&nbsp;&nbsp;&nbsp;
				<input type="button" value="검색" onclick="DoSearch();">&nbsp;&nbsp;&nbsp;
				<input type="button" id="write" name="write" value="글쓰기" onclick="location.href = 'inter_write.jsp?key=<%= key %>&pageno=<%= curpage %>';">
			</td>
			</form>
		</tr>
	</table>
<%@ include file="../include/tail.jsp" %>