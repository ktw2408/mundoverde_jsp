<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<TITLE> MUNDO VERDE </TITLE>
			<link rel="stylesheet" href="/football/css/style.css">
			<link href="https://fonts.googleapis.com/css2?family=Holtwood+One+SC&display=swap" rel="stylesheet">
			<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap&subset=korean" rel="stylesheet">
			<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap&subset=korean" rel="stylesheet">
			<link href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/CookieRunOTF-Black00.woff">
			<link href="https://fonts.googleapis.com/css?family=Girassol&display=swap&subset=latin-ext" rel="stylesheet">
			<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo:400,700,800&display=swap" rel="stylesheet">


<!--바로가기 버튼 기능 제이쿼리-->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
		</script>
		<script>
		
		$(document).ready(function(){
			$("button").click(function(){
			$("div.links").toggle();
			});
		});
		
		</script>

	<script type="text/javascript"> /* 사용자가 새로고침, F5 눌럿을 때만, 배경화면이 자동 변경 자바스크립트 함수*/

		window.onload = function(){

			
			var background_img = "/football/img/background/1.jpeg"; 

			var number = Math.floor(Math.random() * 4) + 1;

			var container = document.getElementById("container");
		
			

			background_img = "/football/img/background/" + number + ".jpeg";

			container.style.backgroundImage = "url('" + background_img + "')";

		}


	</script> 
	</HEAD>

<!-------------------------------------------------------제목부----------------------------------------->
	<body id="container">
		<div class="board">
			<div class="pannel">
				<div class="pannel_img" >
				<div class="pannel_title">
				<a href = "/football/home.jsp">
					<h1>
						<p class="title">MUNDO<br>VERDE</p>
					</h1>
				</a>
				</div>
				</div>
			</div>
<!-------------------------------------------------------------------------------------------------------->

<!----------------------------------------------대기능부-------------------------------------------------->

<nav class="navigation">
    <div class="menu">
        <div class="menu__item">
            <a class="menu__link">
				<div class="dropdown">
					<span class="menu__title">
						<span class="menu__first-word" data-hover="한국">
						K
						</span><!--
						--><span class="menu__second-word" data-hover="경기">
						LEAGUE
						</span>	
							<div class="dropdown-content">
								<span>
									<a href="/football/kor_free/kor_free.jsp" class="rollover">자유게시판</a>
								</span>
								<span>
									<a href="/football/kor_news/kor_news.jsp" class="rollover">최신뉴스</a>
								</span>	
								<span>
									<a href="/football/discuss/kor_discuss.jsp" class="rollover">토론게시판</a>
								</span>
								<span>
									<a href="/football/kor_teaminfo/kor_teaminfo.jsp" class="rollover">국내팀정보</a>
								</span>
							</div>
					</span>
				</div>
            </a>
        </div>
		
        <div class="menu__item">
            <a class="menu__link">
				<div class="dropdown">
					<span class="menu__title">
						<span class="menu__first-word" data-hover="국제">
                        INT.
						</span><!--
						--><span class="menu__second-word" data-hover="경기">
                        LEAGUE
						</span>
							<div class="dropdown-content">
								<span>
									<a href="/football/inter_free/inter_free.jsp"  class="rollover">자유게시판</a>
								</span>
								<span>
									<a href="/football/inter_news/inter_news.jsp" class="rollover">최신뉴스</a>
								</span>
								<span>
									<a href="/football/discuss/inter_discuss.jsp" class="rollover">토론게시판</a>
								</span>
								<span>
									<a href="/football/inter_teaminfo/inter_teaminfo.jsp" class="rollover">해외팀정보</a>
								</span>
							</div>
					</span>
				</div>
            </a>
        </div>

        <div class="menu__item">
            <a href="../../football/agora/agoraMain.jsp" class="menu__link">
				<div class="dropdown">
					<span class="menu__title">
						<span class="menu__first-word" data-hover="자유">
						AGORA
						</span><!--
						--><span class="menu__second-word" data-hover="광장">
						SQUARE
						</span>
							<div class="dropdown-content">
								<span>
									<a href="../../football/agora/agoraMain.jsp" class="rollover"></a>
							</div>
					</span>
				</div>
            </a>
        </div>

    </div>
</nav>
<br><br>
<!-------------------------------------------------------------------------------------------------------->
<div class="article_part">	