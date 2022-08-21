<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--  쇼핑몰 상단 페이지 : 쇼핑몰의 모든 페이지 상단에 포함되는 페이지  --%>
<style>
@import url('https://fonts.googleapis.com/css2?family=Kdam+Thmor+Pro&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Luckiest+Guy&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Gugi&display=swap');
/* 전체 레이아웃    */
body { margin:0;}
.top { background-image: url('../../background/background.jpg'); background-repeate: no-repeate; background-size: cover;}
.top a{text-decoration:none; color:#000;}
.t_box1, .t_box2, .t_box3, .t_box4{ display:inline-block; padding:2%;}
.t_box1, .t_box3{width:61%;}
.t_box2, .t_box4{width:29%;}

/* 제목   부제목 */
.t_box1 .m_title{ text-align: left; margin-top:20px; }
.t_box1 .m_title a{ font-family: 'Kdam Thmor Pro', sans-serif; font-size:55px; 
margin-left: 80px; color: #32aaff;}
.t_box1 .s_title {font-family: 'Gugi', cursive; color: black; font-size:20px; text-align:center;}

/* 검색   */
.t_box1 .t_search {text-align: left; width:400px;  margin-top:15px; margin-left: 80px;
border:1px solid #000; border-radius:35px; padding:5px;}
.t_box1 .t_search #keyword {height:35px; text-align: left; margin-left: 40px;  background: none; width:300px; border:none; font-size:1.1em;}
.t_box1 .t_search #keyword:focus {outline:none;}
.t_search form[type='searchForm'] { position: absolute;}
.t_box1 .t_search button {border:none; background: none; padding:0; cursor:pointer; 
position: relative; top: 5px; right: 0px;}
.t_search form input::placeholder {  color: black; font-size:19px; font-weight: bold;   }


/* 구역2(상단 우측) : 회원정보, 구매정보, 장바구니 정보   */
.t_box2 {float:right; line-height:170px; padding:0; width:300px; height:100px; margin-right: 55px; text-aligh: right;}
.t_box2_a { text-align: right; width:300px; height:100px; margin-top: 140px; }
.t_box2 .t_b2_img1:hover {content: url('../../icons/user2.png');}
.t_box2 .t_b2_img2:hover {content: url('../../icons/buy4.png');}
.t_box2 .t_b2_img3:hover {content: url('../../icons/cart4.png');}


/* 구역3(하단 좌측) : 메뉴(하위메뉴)  */
.t_box3{float:left; position:relative;}
.m_menu0 {display:inline-block;}
.m_menu0:hover {content:url('../../icons/menu2.png');width:30px; height:30px;}
.m_menu{display:inline-block;}
.m_menu a {font-family: 'Gugi', cursive; text-shadow : 1px 1px 1px #32aaff; color: black; font-weight:bold; 
font-size:23px; width:100px; padding:5px; margin:15px;}
.m_menu a:hover { font-size:23.2px; font-weight:bold; text-shadow : 2px 2px 14px black; color: white;}
.s_menu {display:none; position:absolute; top:64px; width:130px; z-index:10; background: #fde6be; }
.sm1{left:87px;}
.sm2{left:230px;}
.sm3{left:390px;}
.sm4{left:497px;}
.sm5{left:681px;}
.m_menu:hover .s_menu{display:block;}
.s_menu div {padding:10px 0;}
.s_menu div a { font-family: 'Gugi', cursive; color: black; text-shadow :none; font-size:0.9em; }
.s_menu div a:hover { font-family: 'Gugi', cursive; text-shadow :none; font-weight:bold; font-size:1em; color: blue;}

/* 구역4(하단 우측) : 로그인, 회원가입, 고객센터  */
.t_box4 {float:right;text-align:right;}
.t_box4 a {color: black; font-size:16px; font-weight:bold;}
.top_end{clear:both;}
.color_id{color: #a2e9ff;}
.out_id{color: #ffa2ad;}
</style>
<%
String memberId = (String)session.getAttribute("memberId");

%>
<div class="top">
		<div class="t_box1"> <%-- 구역1(상단 좌측) : 타이틀, 검색 --%>
			<div class="m_title"><a href="../shopping/shopAll.jsp">CAMERA STORE</a></div>
			<div class="t_search">
				<form action="" method="post" name="searchForm">
					<input type="search" name="keyword" id="keyword" placeholder="Search">
					<button type="submit"><img src="../../icons/camera3.png"></button>
				</form>
			</div>
		</div>
		<div class="t_box2"> <%-- 구역2(상단 우측) : 회원정보, 구매정보, 장바구니 정보 --%>
			<div class="t_box2_a">
				<a href="../member/memberInfoForm.jsp"><img src="../../icons/user1.png" width="40" class="t_b2_img1" title="회원정보"></a>&emsp;&emsp;
				<a href="../buy/buyList.jsp"><img src="../../icons/buy3.png" width="40" class="t_b2_img2" title="구매정보"></a>&emsp;&emsp;
				<a href="../cart/cartList.jsp"><img src="../../icons/cart3.png" width="40" class="t_b2_img3" title="장바구니"></a>
			</div>
		</div>
		<div class="t_box3"> <%-- 구역3(하단 좌측) : 메뉴(하위메뉴) --%>
				<div class="m_menu0"><a href="#"><img src="../../icons/menu1.png" width="30" class="m_menu_img"></a></div>
				<div class="m_menu mm1"><a href="#">폴라로이드</a>
					<div class="s_menu sm1">
						<div><a href="../shopping/shopAll.jsp?product_kind=110#t_kind">Kodak</a></div>
						<div><a href="../shopping/shopAll.jsp?product_kind=120#t_kind">Polaroid</a></div>
						<div><a href="../shopping/shopAll.jsp?product_kind=130#t_kind">Lomography</a></div>
					</div>
				</div>
				<div class="m_menu mm2"><a href="#">토이 카메라</a>
					<div class="s_menu sm2">
						<div><a href="../shopping/shopAll.jsp?product_kind=210#t_kind">Colley</a></div>
						<div><a href="../shopping/shopAll.jsp?product_kind=220#t_kind">캔디 카메라</a></div>	
						<div><a href="../shopping/shopAll.jsp?product_kind=230#t_kind">하이라라</a></div>
					</div>
				</div>
				<div class="m_menu mm3"><a href="#">DSLR</a>
					<div class="s_menu sm3">
						<div><a href="../shopping/shopAll.jsp?product_kind=310#t_kind">Canon</a></div>
						<div><a href="../shopping/shopAll.jsp?product_kind=320#t_kind">SONY</a></div>	
					</div>
				</div>
				<div class="m_menu mm4"><a href="#">디지털 카메라</a>
					<div class="s_menu sm4">
						<div><a href="../shopping/shopAll.jsp?product_kind=410#t_kind">Nikon</a></div>
						<div><a href="../shopping/shopAll.jsp?product_kind=420#t_kind">Panasonic</a></div>	
					</div>
				</div>
				<div class="m_menu mm5"><a href="#">기타</a>
					<div class="s_menu sm5">
						<div><a href="../shopping/shopAll.jsp?product_kind=610#t_kind">파우치</a></div>	
						<div><a href="../shopping/shopAll.jsp?product_kind=620#t_kind">앨범</a></div>
					</div>
				</div>
		</div>	
		<div class="t_box4"> <%-- 구역4(하단 우측) : 로그인, 회원가입, 고객센터 --%>
		<%if(memberId == null) { %>
			<a href="../logon/memberLoginForm.jsp"><span>로그인</span></a>&ensp;|&ensp;
			<a href="../member/memberJoinForm.jsp"><span>회원가입</span></a>&ensp;|&ensp;
		<%} else { %>
			<a href="../member/memberInfoForm.jsp"><span class="color_id"><%=memberId %>님</span></a>&ensp;|&ensp;
			<a href="../logon/memberLogout.jsp"><span class="out_id">로그아웃</span></a>&ensp;|&ensp;
		<% } %>
			<a href=""><span>고객센터</span></a>
		</div>
		<div class="top_end"></div>
		<hr>
	
	
</div>

