<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/dbinfo.jsp" %>
<%@ include file="../../include/head.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>



<%

	//검색 파라메터를 분석한다.
	String type   = request.getParameter("type");
	String league = request.getParameter("league");
	String key    = request.getParameter("key");
	String pageno = request.getParameter("pageno");
	int     perpage  = 5;
	int     startPage = 0;
	int     maxPage  = 0;

	if(key == null || key.equals(""))
		{
			key = "";
		}
	if(pageno == null || pageno.equals(""))
		{
			pageno = "1";
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
	//검색 조건을 생성한다.
	String mWhere = "";

	if(!key.equals(""))
		{
			if(!mWhere.equals(""))
				{
					mWhere  += " and ";
				}else
				{
					mWhere  += " where ";
				}
			mWhere  += " title like '%" + key + "%' ";
		}
	//현재 게시판에서 총 게시물의 갯수를 얻는다.
	String mTotalSQL = "";
	mTotalSQL  += "select count(no) as totalrow ";
	mTotalSQL  += "from board where type = 'B' and league = 'K' ";
	mTotalSQL  += mWhere;
	//out.print(mTotalSQL);
	//out.print("<br>");
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

<!----------------------------------------자유게시판 주 기능--------------------------------------->

	<table class="freeboard" align="center" cellspacing="0">
	
		<tr>
				<td class="boardmenu" id="no">번호</td>
				<td class="boardmenu" id="title">제목</td>
				<td class="boardmenu" id="writer">작성자</td>
				<td class="boardmenu" id="date">날짜</td>
				<td class="boardmenu" id="hit">조회수</td>
				<td class="boardmenu" id="date">바로가기</td>
		</tr>
		<tr>
			<td colspan="6"  class="boardline"></td>
		</tr>

		<%

			//등록된 게시물의 목록을 얻는다.
			String mSelectSQL = "";
			
			mSelectSQL += "select no,title,writer,date,type,league,hit,link ";
			mSelectSQL += "from board where type = 'B' and league = 'K' ";
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
					String link    =  myBoard.getString("link");

		%>

			<tr class="boardcontent">
				<td id="no"><%= no %></td>
				<td id="title">
					<a href="kor_news_view.jsp?no=<%= no %>"><%= title %></a></td>
				<td id="writer"><%= writer %></td>
				<td id="date"><%= date %></td>
				<td id="hit"><%= hit %></td>
				<td id="date">
					<a href="<%= link %>" target="_blank">링크이동</a></td>
			</tr>
		
		<%
				}

			//myBoard.DBClose();

		%>
			
			<tr class="boardcontent">
				<td id="pagenum" colspan="6" align="center">

				<%
				
					if(curpage <= 1)
						{
							%>
							[ 
							<a href="javascript:alert('첫 번째 페이지입니다.');">
							이전페이지
							</a>
							]
						
							<%
						}else
							{
								%>
								[ <a href="kor_news.jsp?key=<%= key %>&pageno=<%= curpage - 1 %>">
								이전페이지</a> ] 
								<%
							}
							for(int i=1;i<=maxPage;i++)
							{
								if(i == curpage)
								{
									%>
									&nbsp;<a href="kor_news.jsp?&key=<%= key %>&pageno=<%= i %>"><strong><font color="red"><%= i %></font></strong></a>&nbsp;
									<%
								}else
								{
									%>
									&nbsp;<a href="kor_news.jsp?&key=<%= key %>&pageno=<%= i %>"><%= i %></a>&nbsp;
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
					[ <a href="kor_news.jsp?key=<%= key %>&pageno=<%= curpage + 1 %>">다음페이지</a> ]
					<%
				}
				%>
				</td>
			</tr>
			
			<tr class="boardcontent">
				<td id="search" colspan="5" >
					<select id = "keyfield" name = "keyfield">
						<option id = "title" name = "title" value = "title">제목</option>
						<option id = "content" name = "content" value = "content">내용</option>
						<option id = "content" name = "content" value = "content">작성자</option>
					</select>
					<input type="text" id = "keyword" name="keyword" size="50" placeholder="검색어">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" id="search" value="검색" size="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="write" name="write" value="글쓰기" onclick="location.href = 'kor_news_write.jsp';">
				</td>
			</tr>
	</table>

<%@ include file="../../include/tail.jsp" %>

<!----------------------------------------------내용부-------------------------------------------------->	
<!--<div>
	<table border="1" align= "center" class="kor_news_list" id="_newslist">
		<tr>
			<th>
				<a href="https://sports.news.naver.com/kfootball/news/read.nhn?oid=396&aid=0000546510" class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
					<img src="https://imgnews.pstatic.net/image/396/2020/04/14/0000546510_001_20200414120921349.jpg?type=w140">						
				</a>
			</th>
				<td>
					<a href="https://sports.news.naver.com/kfootball/news/read.nhn?oid=396&aid=00005465102" class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
						<strong>소속팀을 많이 거친 선수는? K리그 저니맨을 찾아서</strong>
						<p>[스포츠월드=김진엽 기자] 2000년 이후 K리그 선수들이 리그에서 활약하는 기간은 평균 3.6년이다. 국내 선수의 평균 활동 기간이 4.1년, 외국인 선수...</p>
					</a>
				</td>			
		</tr>
		<tr>
			<th>
				<a href="https://sports.news.naver.com/news.nhn?oid=343&aid=0000097922" class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
					<img src="https://imgnews.pstatic.net/image/343/2020/04/14/20200414121_20200414111618675.JPG?type=w140">						
				</a>
			</th>
				<td>
					<a href="https://sports.news.naver.com/news.nhn?oid=343&aid=0000097922" class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
						<strong>[박공원의 축구 현장] K리거들도 함께 상생하는 법 찾자</strong>				
						<p>(베스트 일레븐)박공원의 축구 현장최근 K리그에서도 점점 이 이슈가 떠오르고 있다. 바로 코로나 19에 따른 선수 급여 삭감 논쟁이다. 몇몇 구단에서 임직원...</p>
					</a>
				</td>			
		</tr>
		<tr>
			<th>
				<a href="https://sports.news.naver.com/news.nhn?oid=117&aid=0003351101" class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
					<img src="https://imgnews.pstatic.net/image/117/2020/04/09/202004091718509735_1_20200409171913674.jpg?type=w140">						
				</a>
			</th>
				<td>
					<a href="https://sports.news.naver.com/news.nhn?oid=117&aid=0003351101" class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
						<strong>경남FC, 인터넷 방송 통해 자체 홍백전 중계</strong>				
						<p>"경남FC가 코로나19 사태로 인한 K리그 개막 연기로 축구에 목마른 도민과 팬들을 위해 자체 홍백전을 중계한다. 경남은 아프리카 TV..."</p>
					</a>
				</td>			
		</tr>
		<tr>
			<th>
				<a href="https://sports.news.naver.com/kfootball/news/read.nhn?oid=410&aid=0000684228" class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
					<img src="https://imgnews.pstatic.net/image/origin/410/2020/04/13/684228.jpg?type=w140">
			</th>
				<td>
				<a href="https://sports.news.naver.com/kfootball/news/read.nhn?oid=410&aid=0000684228" class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
					<strong>전북 로페즈 판매, K리그 역대 최고 이적료 [오피셜]</strong>
						<p>"전북 현대가 공격수 로페즈(30·브라질)를 지난 2월 팔면서 발생한 이적료가 K리그 사상 최고액으로 밝혀졌다.상하...</p>
				</a>
				</td>						
		</tr>	
		<tr>
			<th>
				<a href="https://sports.news.naver.com/kfootball/news/read.nhn?oid=382&aid=0000812884"  class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
					<img src="https://imgnews.pstatic.net/image/382/2020/04/13/0000812884_001_20200413145921081.jpg?type=w140">
				</a>
			</th>
				<td>
				<a href="https://sports.news.naver.com/kfootball/news/read.nhn?oid=382&aid=0000812884"  class="k_news" onclick="clickcr(this, 'nwl.image','','', event);">
					<strong>유튜브로 소환된 K리그 추억의 명승부</strong>
						<p>K리그 유튜브 채널 화면 캡처한국프로축구연맹이 축구에 굶주린 팬들을 위해 ‘하드 털기’에 나섰다.전 세계 프로스포츠는 신종 코로나바이러스 감염증(코로나19)...</p>
				</a>
				</td>			
		</tr>-->
