<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.text.*, mall.member.*, java.util.*, mall.review.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세</title>
<style>

.container {width: 100%; margin: 0 auto;}
.d_kind {margin-top: 30px; margin-left: 200px; margin-bottom: 50px;}

.d_kind a { text-decoration:none; color: #32aaff; font-weight:bold; margin: 40px; font-size:18px; }
.d_kind a:hover {color:black; font-size:18.3px;}

/* 구역1 : 왼쪽 상단, 상품 이미지   */
.s1 { width:53%; float:left; text-align:center; }
.big_img { border: 1px solid white; margin-left: 230px;}
.big_img:hover { transform:scale(1.02); transition:.5s; border: 1px solid black;}
.small_imgs {margin-left: 230px; margin-top: 15px; margin-bottom: 60px;}
.small_imgs .thumb {margin:0 10px; cursor:pointer; border: 1px solid white;}
.small_imgs .thumb:hover {transform:scale(1.07); transition:.3s; border: 1px solid black; }

/* 구역2 : 오른쪽 상단, 상품 기본 정보, 버튼  */


.s2 {width:35%; float:left; background: #f8f9fa; padding: 20px 0 30px 30px;}
.s2 > div { margin-bottom: 22px;}
.s2_d1 {font-size: 1.2em; color: gray; font-weight: bold; }
.s2_d2 {font-size:1.8em; font-weight:bold; color: #32aaff;}
.s2_d3 span:nth-child(2) { font-weight:bold; color:gray; text-decoration: line-through;}
.s2 .ss { display: inline-block; width:100px; font-size:0.9em; color: gray;}
.s2_d4 span:nth-child(2), .s2_d5 span:nth-child(2) { color: #ff607f;}
.s2_d4 b { font-size:25px;}
.s2_d6 span { font-size:0.9em; color:gray;}
.s2_d8 span:not(.ss) { font-size:0.9em; color:gray; margin-left:20px;}
.s2_d8 b { font-size:1.05em; color:#1e9faa;}
.s2_d9 span:not(.ss) { font-size:0.9em; color:gray; margin-left:20px; }
.btns { margin-top:60px; text-align:center; margin-bottom:0;}
.btns input[type='button'], .btns input[type='submit'] { width:240px;  height: 60px; border:none; font-size:1.2em; font-weight:bold;
cursor:pointer;}

/* number 화살표 항상 보이는 효과  */
.s2_d7 input[type='number']::-webkit-inner-spin-button, 
.s2_d7 input[type='number']::-webkit-outer-spin-button { 
-webkit-appearance: "Always Show Up/Down Arrows"; opacity:1;}

.btns #btn_cart { background:#ff607f; color:#fff; margin-right:20px;}
.btns #btn_cart:hover { background: #fff; color: #ff607f; border: 2px solid #ff607f; font-weight:bold;}
.btns #btn_buy { background: #32aaff; color:#fff;}
.btns #btn_buy:hover { background:#fff; color: #32aaff; border: 2px solid #32aaff; font-weight:bold;}

/* 구역3 : 리뷰, 하단, 상품 내용 */
.t_line{border: 1px solid black; width: 81%;  margin:30px 0px; margin-left: 180px; margin-bottom: 70px; clear:both;}
.s3_c1 { background: #32aaff; padding:10px; border-radius:5px; width: 80%; text-align: center; margin: 0 auto; margin-bottom:60px;}
.s3_c1 span { display:inline-block; width:120px; height:30px; padding:10px; margin: 0 20px; border: 2px solid #32aaff;
text-align:center; line-height:30px; border-radius:5px; color:#fff; font-size:1.1em; cursor:pointer;}
.s3_c1 span:hover { border: 2px solid #fff; font-weight:bold; }
.s3_c2 { line-height:40px; text-align: center; padding:20px;}

.s3_c3_top { text-align: left; margin-left: 300px; margin-bottom: 10px; font-weight: bold; color:f7f8f0; }
.s3_c3 .s3_review  { line-height:27px; text-align:justify; padding:20px; width: 100%; height: 200px;  margin-bottom:10px;}
.s3_review .s3_r1 { width:75%; float:left; border:1px solid #f1f3f5; padding:20px; background:#f7f8f0; margin-right:20px;}
.s3_r1 .s3_subject { font-size:1.1em; font-weight:bold; margin-bottom:10px;}
.s3_r1 .s3_content { width:100%; height:110px; white-space:pre-line; overflow:hidden;}
.s3_r1 .s3_content_all, .s3_r1 .s3_content_part { font-size:0.9em; color:#1e94be; cursor:pointer;}
.s3_r1 .s3_content_part { display: none;}
.s3_review .s3_r2 { width:16%; float:right; border:1px solid #f1f3f5; padding:20px; background: #f8f9fa;}

.review_table { width: 70%; margin: 0 auto;}
.review_table th { background: lightgray; height: 40px; border: 1px solid gray;}
.review_table td { border-bottom: 1px solid gray; height: 40px;}

.s3_r2 { font-size:0.9em; color: gray; height:175px;}
/* 페이징 영역  */
#paging{text-align:center; margin-top:20px; clear:both;}
#paging a {color :#000;}
#pBox{display:inline-block; width:22px; height:22px; padding:5px; margin:5px;}
#pBox:hover{background:#f1617d; color:white; font-weight:bold;border-radius:50%; cursor:pointer;}
.pBox_c{background:#f1617d; color:white; font-weight:bold;border-radius:50%;}
.pBox_b{font-weight:900px;}
.f_row{text-align:center; font-weight:bold; color:#c84557}

.t_l_line { border: 1px solid #e9ecef; margin:30px 0px;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let big_img = document.querySelector(".big_img");
	let thumb_imgs = document.querySelectorAll(".thumb");
	
	for(let thumb of thumb_imgs) {
		thumb.addEventListener("click",function(){
			big_img.src = thumb.src;
		})
	}
	
	// 상품 수량을 100 미만으로 제한하는 효과
	let buy_count = document.getElementById("buy_count");
	buy_count.addEventListener("keyup",function(event){
		if(buy_count.value< 1){
			buy_count.value = 1;
		} else if(buy_count.value >100) {
			buy_count.value = 100;
		}
	})
	
	
	// 하단 - 상세 설명, 상품 리뷰 변환 효과
	let s3_c2 = document.querySelector(".s3_c2");
	let s3_c3 = document.querySelector(".s3_c3");
	let ss1 = document.querySelector(".ss1");
	let ss2 = document.querySelector(".ss2");
	ss1.addEventListener("click", function(){
		s3_c2.style.display="block";
		s3_c3.style.display = "none";
	})
	ss2.addEventListener("click", function(){
		s3_c2.style.display = "none";
		s3_c3.style.display = "block";
	})
	
	
	
	// 내용 전체 보기 효과 
	let content = document.querySelectorAll(".s3_content");
	let content_all = document.querySelectorAll(".s3_content_all");
	let content_part = document.querySelectorAll(".s3_content_part");
	for(let i in content_all){
		content_all[i].addEventListener("click", function(){
			content[i].style.overflow = "visible";
			content[i].style.height = "200px";
			content[i].style.display = "block";
			content_all[i].style.display = "none";
			content_part[i].style.display = "block";
		})
		content_part[i].addEventListener("click", function(){
			content[i].style.overflow = "hidden";
			content[i].style.height = "110px";
			content_all[i].style.display = "block";
			content_part[i].style.display = "none";
		})
	}
	
	
})

</script>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:MM");
DecimalFormat df = new DecimalFormat("#,###,###");

String memberId = (String)session.getAttribute("memberId");
int product_id = Integer.parseInt(request.getParameter("product_id"));

//상품 DB 연결, 질의
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);

//개인 쇼핑몰에서 이미지가  5장이고, 1번만 not null이고, 나머지가  nothing.jpg가 저장되어 있다고 가정할 때
String product_image1 = product.getProduct_image1();
if(product.getProduct_image2() == null) product.setProduct_image2(product_image1);
if(product.getProduct_image3() == null) product.setProduct_image3(product_image1);

//회원 DB 연결, 질의 - 세션의 여부 확인
MemberDAO memberDAO = null;
MemberDTO member = null;
String name = null;
String address = null;
String local = null;
String d_day = null;
if(memberId != null) {
	memberDAO = MemberDAO.getInstance();
	member = memberDAO.getMember(memberId);
	name = member.getName();
	address = member.getAddress();
	local = address.substring(0,2);
	
	// 배송 날짜 계산과 포맷
	// 규칙1. 서울: 다음날에 배송, 경기 : 2일 안에 배송, 지방 : 3일 안에 배송, 제주도: 5일 안에 배송
	// 규칙3. 토요일, 일요일은 제외.
	// 전체 날짜, 요일판단, 주소판단
	int n = 0;
	Calendar c = Calendar.getInstance();
	int w = c.get(Calendar.DAY_OF_WEEK); // 일1 월2 화3 수4 목5 금6 토 7

	switch(local){
	case "서울":
		if(w >=2 && w <=5) ++n;
		else if(w == 6 || w == 7) n += 3;
		else if(w == 1) n +=2;
		break;
	case "경기":
		if(w >=2 && w <=4) n +=2;
		else if(w >= 5 || w <= 7) n += 4;
		else if(w == 1) n +=3;
		break;
	case "제주":
		n +=7;
		break;
	default:
		if(w ==2 || w == 3) n+=3;
		else if(w >= 4 && w <= 7) n +=5;
		else if(w == 1) n +=4;
		break;
	}

	// 추가된 일수를 더한 날짜 
	c.add(Calendar.DATE, n);
	int month = c.get(Calendar.MONTH) +1; //0 ~ 11로 표현, 1을 더해서 보정
	int date = c.get(Calendar.DATE);
	int week = c.get(Calendar.DAY_OF_WEEK); // 1~7
	String[] weekday = {"일","월","화","수","목","금","토"};
	d_day = month + "월 " + date + "일 (" +weekday[week-1] +")";
}

//########## 페이징(paging) 처리 ##########
//페이징(paging) 처리를 위한 변수 선언
int pageSize = 5; // 1페이지에 5건의 게시글을 보여줌.
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1";                // 페이지 번호가 없다면 1페이지로 설정

int currentPage = Integer.parseInt(pageNum);    // 현재 페이지
int startRow = (currentPage -1) * pageSize + 1; // 현재 페이지의 첫번째 행
int endRow = currentPage * pageSize;            // 현재 페이지의 마지막 행
//##########                  ##########

// 리뷰 DB 연결
ReviewDAO reviewDAO = ReviewDAO.getInstance();
List<ReviewDTO> reviewList = reviewDAO.getReviewList(startRow, pageSize, product_id);
int cnt = reviewDAO.getReviewCount(product_id);


String product_kindName="";
String product_kind = request.getParameter("product_kind");
switch(product.getProduct_kind()){
case"110": product_kindName="Kodak"; break;
case"120": product_kindName="Polaroid"; break;
case"130": product_kindName="Lomography"; break;
case"210": product_kindName="Colley"; break;
case"220": product_kindName="캔디 카메라"; break;
case"230": product_kindName="하이라라"; break;
case"310": product_kindName="Canon"; break;
case"320": product_kindName="SONY"; break;
case"410": product_kindName="Nikon"; break;
case"420": product_kindName="Panasonic"; break;
case"510": product_kindName="파우치"; break;
case"520": product_kindName="앨범"; break;
}

String p_date = product.getProduct_date();
String product_date = p_date.substring(0, 4) + "년 " + p_date.substring(5,7) +"월 "+p_date.substring(8,10)+"일";

// 판매가 계산
int price = product.getProduct_price();
int d_rate = product.getDiscount_rate();
int sale_price = price - (price * d_rate/100);



%>
</head>
<body>
<div class="container">
	<jsp:include page="../common/shopTop.jsp" />
	<div class="d_kind"><a href="shopAll.jsp">메인</a>&emsp;>&emsp;<a href="shopAll.jsp?product_kind=<%=product.getProduct_kind()%>&#t_kind"><%=product_kindName %></a></div>
	<div class="detail">
	<%-- 구역1 : 왼쪽 상단, 상품 이미지 --%>
		<div class="s1">
			<div><img src="/images_camera/<%=product.getProduct_image1() %>" width="600" height="600" class="big_img"></div>
			<div class="small_imgs">
				<img src="/images_camera/<%=product.getProduct_image1() %>" width= "80" height="80" class="thumb">
				<img src="/images_camera/<%=product.getProduct_image2() %>" width= "80" height="80" class="thumb">
				<img src="/images_camera/<%=product.getProduct_image3() %>" width= "80" height="80" class="thumb">
			</div>
		</div>
		<%-- 구역2 : 오른쪽 상단, 상품 기본 정보, 버튼 --%>
		<form action="../cart/cartInsertPro.jsp" method="post" name="contentForm">
		<%-- 장바구니로 이동 : cart_id, buy_count를 제외한 5가지 필드 정보 --%>
			<input type="hidden" name="buyer" value="<%=memberId %>">
			<input type="hidden" name="product_id" value="<%=product_id %>">
			<input type="hidden" name="product_name" value="<%=product.getProduct_name() %>">
			<input type="hidden" name="product_color" value="<%=product.getProduct_color() %>">
			<input type="hidden" name="product_com" value="<%=product.getProduct_com() %>">
			<input type="hidden" name="product_country" value="<%=product.getProduct_country() %>">
			<input type="hidden" name="product_price" value="<%=product.getProduct_price() %>">
			<input type="hidden" name="discount_rate" value="<%=product.getDiscount_rate() %>">
			<input type="hidden" name="buy_price" value="<%=sale_price %>">
			<input type="hidden" name="product_image1" value="<%=product.getProduct_image1() %>">
			<div class="s2">
				<div class="s2_d1"><%=product.getProduct_com() %></div>
				<div class="s2_d2">
					<span><%=product.getProduct_name() %></span>
				</div>	
				<div class="s2_d3"><span class="ss">정가</span><span><%=df.format(product.getProduct_price()) %>원</span></div>
				<div class="s2_d4"><span class="ss">판매가</span><span><b><%=df.format(sale_price) %>원</b></span></div>
				<div class="s2_d5"><span class="ss">할인율</span><span><b><%=product.getDiscount_rate() %>%</b></span></div>
				<div class="s2_d6"><span class="ss">컬러</span><span><b><%=product.getProduct_color() %></b></span></div>
				<div class="s2_d6"><span class="ss">제조국</span><span><b><%=product.getProduct_country() %></b></span></div>
				<div class="s2_d7"><span class="ss">구매수량</span><input type="number" name="buy_count" id="buy_count" value="1" min="1" max="99"></div>
				<div class="s2_d8"><span class="ss">배송안내</span><br>
					<%if(memberId != null) { %>
					<span><b><%=name %></b>님의 주소로 <b><%=d_day %></b>까지 배송합니다.</span><br>
					<span>주소 : <b><%=address %></b></span>
					<%} else { %>
						<span>배송일은 서울은 익일, 경기는 2일, 지방은 3일</span> <br>
						<span>제주 및 도서 지역은 평균 5일이 소요됩니다.</span><br>
						<span>(단. 토, 일요일은 배송 업무를 하지 않습니다.)</span>
					<% } %>
				</div>
				<div class="s2_d9"><span class="ss">배송비</span><br>
					
						<span>무료</span><br>
						<span>제주도 : 3,000원 / 도서산간 3,000원</span>
					
				</div>
				<div class="btns">
					<input type="submit" value="장바구니" id="btn_cart">
					<input type="button" value="구매" id="btn_buy">
				</div>
			</div>
		</form>
		<%-- 구역 3 : 하단, 상품 내용, 상품 리뷰 --%>
		<hr class="t_line">
		<div class="s3">
			<div class="s3_c1"><span class="ss1">상세설명</span><span class="ss2">리뷰</span><span class="ss3">상품문의</span><span class="ss4">교환/반품</span></div>
			<div class="s3_c2"><img src="/images_camera/<%=product.getProduct_content() %>"></div>
			<div class="s3_c3_top">게시물 개수 : <%=cnt %> 개</div>
			<div class="s3_c3" id="s3">
				<table class="review_table">
					<tr>
						<th width="5%">번호</th>
						<th width="65%">상품평</th>
						<th width="15%">작성자</th>
						<th width="15%">작성일</th>
					</tr>
					<% for(ReviewDTO review : reviewList) {   
					
						if(review.getContent() == null){ %>
							<tr>
								<td colspan="4">작성된 상품평이 없습니다.</td>
							</tr>
					<%} else { %>
							<tr>
								<td><%=review.getNum() %></td>
								<td><%=review.getSubject() %></td>
								<td><%=review.getMember_id() %></td>
								<td><%=review.getRegDate() %></td>
							</tr>
					<%} }%>
					
				</table>
			<div id="paging">
			<%
			if(cnt > 0) {
				int pageCount = cnt / pageSize + (cnt%pageSize==0 ? 0 : 1); // 전체 페이지수
				int startPage = 1;  // 시작 페이지 번호
				int pageBlock = 5; // 페이징의 개수
				
				// 시작 페이지 설정
				if(currentPage % 5 != 0) startPage = (currentPage/5) * 5 + 1;
				else startPage = (currentPage/5-1) * 5 + 1;
					
				// 끝 페이지 설정
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) endPage = pageCount;
				
				// 맨 처음 페이지 이동 처리
				if(startPage > 5){
					out.print("<a href='shopContent.jsp?pageNum=1&product_kind="+product_kind+"&product_id="+product_id+"#s3'><div id='pBox' class='pBox_b' title='첫 페이지'>" + "〈〈" + "</div></a>");
				}
				
				
				// 이전 페이지 처리
				if(startPage > 5){
					out.print("<a href='shopContent.jsp?pageNum="+(currentPage-5)+"&product_kind="+product_kind+"&product_id="+product_id+"#s3' title='다음 5페이지'><div id='pBox' class='pBox_b'>" + "〈" + "</div></a>");
				}
				
				
				
				// 페이징 블럭 출력 처리
				for(int i=startPage; i<=endPage; i++) {
					if(currentPage == i){    // 선택된 페이지가 현재 페이지일 때
						out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");
					}else{                   // 다른 페이지로 이동하고자 할 때 -> 이동에 대한 링크 설정
						out.print("<a href='shopContent.jsp?pageNum="+ i+"&product_kind="+product_kind+"&product_id="+product_id+"#s3'><div id='pBox'>" + i + "</div></a>");
					}
				}
				
				// 다음 페이지 처리
				if(endPage < pageCount ){
					int movePage = currentPage + 5;
					if(movePage > pageCount) movePage = pageCount;
					out.print("<a href='shopContent.jsp?pageNum="+movePage+"&product_kind="+product_kind+"&product_id="+product_id+"#s3'' title='다음 5페이지'><div id='pBox' class='pBox_b'>" + "〉" + "</div></a>");
				}
				
				// 맨 끝 페이지 이동 처리
				if(endPage < pageCount){
					out.print("<a href='shopContent.jsp?pageNum="+pageCount+"&product_kind="+product_kind+"&product_id="+product_id+"#s3'' title='마지막 페이지'><div id='pBox' class='pBox_b'>" + "〉〉" + "</div></a>");
				}
			}
			%>
			</div>
			
			</div>
		</div>
		
	</div>
	
	<hr class="t_l_line">
	<jsp:include page="../common/shopBottom.jsp"></jsp:include>
</div>

</body>
</html>