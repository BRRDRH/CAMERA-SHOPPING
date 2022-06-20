<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*, mall.cart.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
<style>

.container { width:95%; margin : 0 auto;}
/* 상단 1  */
.d2 { width:40%; padding:15px; margin: 15px 45px; float:left; display: inline-block;}
.d2 .s1 { font-size:1.1em; font-weight: bold; margin-right: 30px;}
.d2 .s2 { display: inline-block; width: 120px; text-align: center; font-size: 0.8em; font-weight: bold;  
padding: 6px 17px; border: 1px solid #333; font-size: 0.8em; border-radius: 15px; font-weight:bold; background: #443cc3; color:#fff;}
.d2 .s3 { width: 300px; padding: 6px 17px; border: 1px solid gray; font-size: 0.8em; border-radius: 15px; font-weight:bold; background:#fff; color:#333;}

/* 상단 2  */
.d1 { width: 40%; padding: 15px; margin: 5px 45px; float: left; display: inline-block; text-align: left;}
.d_line { clear: both; width: 90%; border: 1px solid lightgray;}
/* 상단 3  */

.d3 { width: 90%; padding: 15px;  margin: 5px 45px;}
.d3 input[type=checkbox] { zoom: 1.6; margin-right: 5px; float: left;}
.d3 label { font-size: 0.9em; margin-right:20px;}
.d3 input[type=button] { width: 80px; height:30px; border-radius:3px; color:#fff; font-weight: bold; cursor: pointer;}
.d3 #btn_buy_select { background: #1e94be; border: none; margin-right:5px;}
.d3 #btn_delete_select { background:#c84557; border: none;}

/* 상품 정보 테이블  */
.cart_list { width: 100%;}
.t_cart_list { width:90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left:none; border-right:none; clear: both;}
.t_cart_list tr { height: 40px;}
.t_cart_list td, .t_cart_list th { border-top:1px solid #dee2e6; border-bottom:1px solid #dee2e6; border-left:none; border-right:none;}
.t_cart_list th { background: #f1f3f5;}
.t_cart_list td { }
.t_cart_list tr:last-child { font-weight:normal;}
.t_cart_list .center { text-align:center;}
.t_cart_list .left { text-align: left; padding-left:10px;}
.t_cart_list .right { text-align: right; padding-right:10px;}
.td1 .ck_cart_one { zoom: 1.6;}
.td0 {text-align: center; font-weight: bold; font-size: 1.1em; padding: 30px 0;}
.td3 .s1 a { text-decoration: none; font-weight: bold; color: #1e94be;}
.td3 .s2 { font-size: 0.9em; color: gray;}
.td3 .s3 { font-size: 0.9em; color: gray; text-decoration: line-through;}
.td3 .s4, .td3 .s5 { font-size: 0.9em; font-weight: bold; color: #c84557;}
.td4 input[type='number'] { width: 45px;  margin-bottom:5px;}
.td5 { font-size: 1.1em; color: #c84557; font-weight: bold;}
/* number 화살표 항상 보이는 효과  */
input[type='number']::-webkit-inner-spin-button, 
input[type='number']::-webkit-outer-spin-button { 
-webkit-appearance: "Always Show Up/Down Arrows"; opacity:1;}

.td4 input[type='submit'] { width: 53px; height: 25px; border:1px solid gray; background: #fff;
font-size: 0.8em; cursor:pointer; border-radius:2px;}
.td5 { padding-right:5px;}
.td7 input[type='button'] { width: 80px; height: 30px; border:none; cursor: pointer; border-radius:5px; color:#fff; font-weight:bold;}
.td7 .btn_buy_one { background: #1e94be;  margin-bottom: 5px;}
.td7 .btn_delete_one { background: #c84557;}

/* 하단 d4 */
.d4 { width: 90%; padding: 15px; margin: 10px 45px;}
.d4 input[type='button'] { width: 80px; color: white; height: 30px; border:1px solid gray; background: #fff;
font-size: 0.8em; cursor:pointer; border-radius:2px;}
.d4 span { font-size: 0.9em;  font-weight: bold; color:gray; margin-right:10px; margin-left: 34px;}
.d4 #btn_buy_select2 { background: #1e94be; border: 1px solid #32708d; margin-right:5px;}
.d4 #btn_delete_select2 { background:#c84557; border:1px solid #99424f;}


/* 하단- 총 상품 금액 테이블   */
.t_cart_tot { width:90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border: 1px solid #196ab3; clear: both; background: #e6f0fa ;}
.t_cart_tot tr { height: 100px;}
.t_cart_tot td, .t_cart_tot th {}
.t_cart_tot tr:first-child th:last-of-type { background: #d4e3f1;}
.t_cart_tot span { font-size: 1.5em; display: inline-block; margin-top: 5px;}
.t_cart_tot tr:first-child th:cth-of-type(5) { color: #196ab3;}
.t_cart_tot tr:first-child th:cth-of-type(7) { color: #a13b66;}

.t_cart_tot tr:nth-child(2) { font-size: 0.8em;}
.s_color { color: gray;}
.t_cart_tot tr:nth-child(2) span{  font-weight: nomal;}
.t_cart_tot tr:nth-child(2) span b { color: #a13b66;}
.t_cart_tot tr:nth-child(2) th { border-top: 1px solid #196ab3;}

/* 하단 - 배송지 테이블  */
.t_cart_address { width:90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
clear: both; margin: 20px auto;}
.t_cart_address tr { height: 40px;}
.t_cart_address td, .t_cart_address th { border:1px solid #dee2e6; }
.t_cart_address th { background: #f1f3f5;}
.t_cart_address td { padding-left: 20px;}
.t_cart_address th input { margin-top: 10px;}
.t_cart_address td input { margin-left : 20px;}
.t_cart_address input[type=button] { width: 90px; height: 30px; background: #fff; border: 1px solid lightgray; padding: 5px;
font-size:0.9em; border-radius: 3px;}

/* 하단 - 주문, 쇼핑계속하기 버튼  */
.d5 { width: 90%; padding: 0 15px; margin: 0 45px 30px;  text-align:center;}
.d5 input[type=button] { width:150px; height: 50px; font-size: 1.05em; font-weight: bold; color:#fff;
cursor:pointer; border-radius: 5px;}  
.d5 #btn_buy_select3 { background: #3a85c8; border:none;}
.d5 #btn_shopping { background: #2f9e77; border:none;}

/* 마지막 줄 */
.t_line{border: 1px solid #e9ecef; margin:30px 0px; clear:both;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.cartForm;
		let cart_ids = document.getElementsByName("cart_id"); // cart_id 태그의 배열
		let btn_buy_select = document.getElementById("btn_buy_select");
		let btn_buy_select2 = document.getElementById("btn_buy_select2");
		let btn_buy_select3 = document.getElementById("btn_buy_select3");
		let btn_delete_select = document.getElementById("btn_delete_select");
		let btn_delete_select2 = document.getElementById("btn_delete_select2");
		let btn_shopping = document.getElementById("btn_shopping");
		
		// 수량 제한 효과 (1 ~ 100)
		let buy_counts = document.querySelectorAll(".buy_count");
		for(let buy_count of buy_counts) {
			buy_count.addEventListener("keyup", function(){
				if(buy_count.value > 100 ){
					buy_count.value = 100;
				} else if(buy_count.value < 1) {
					buy_count.value = 1;
				}
			})
		}
		// 각 상품 별 삭제 버튼 처리
		
		let btn_delete_ones = document.querySelectorAll(".btn_delete_one");

		for(let i=0; i < btn_delete_ones.length; i++) {
			btn_delete_ones[i].addEventListener("click", function(){
				location = 'cartDeletePro.jsp?cart_id=' + cart_ids[i].value;
			})
		}
		// 각 주문별 주문 버튼 처리 (1개 상품)
		let btn_buy_ones = document.querySelectorAll(".btn_buy_one");
		for(let i=0; i< btn_buy_ones.length; i++) {
			btn_buy_ones[i].addEventListener("click", function(){
				location = '../buy/buyForm.jsp?cart_id=' + cart_ids[i].value;
			})
		}
		///////////////////////////
		// 판매가 계산(원가에서 할인된 가격)
		let p_sums = document.getElementsByName("p_sum");
		let p_s1 = 0;
		let c1_s1 = document.querySelector(".c1_s1");
		let c2_s1 = document.querySelector(".c2_s1");
		let c3_s1 = document.querySelector(".c3_s1");
		
		// 원가 계산
		let p_sums2 = document.getElementsByName("p_sum2");
		let p_s2 = 0;
		let c1_s2 = document.querySelector(".c1_s2");
		
		// 할인금액 계산
		let p_sums3 = document.getElementsByName("p_sum3");
		let p_s3 = 0;
		let c1_s3 = document.querySelector(".c1_s3");
		
		// 총 개수 계산
		let k_count = 0;
		let p_count = 0;
		let c1_s4 = document.querySelector(".c1_s4");
		let c1_s5 = document.querySelector(".c1_s5");
		
		// 전체 선택
		let cart_ids_list = []; // 카트 아이디를 저잗하는 배열
		let ck_count=0; // 각 상품별 체크박스의 체크 개수
		let ck_cart_ones = document.querySelectorAll(".ck_cart_one");
		let ck_cart_all = document.getElementById("ck_cart_all");
		ck_cart_all.addEventListener("change", function(){
			p_s1 = 0;
			p_s2 = 0;
			p_s3 = 0;
			k_count = 0;
			p_count = 0;
			if(ck_cart_all.checked == true){ // 전체 선택을 하였을 때 -> 하위의 모든 체크박스를 선택
				ck_count = ck_cart_ones.length;
				
				for(let i=0; i<ck_cart_ones.length; i++){
					ck_cart_ones[i].checked = true;
					cart_ids_list.push(cart_ids[i].value);
					p_s1 += parseInt(p_sums[i].value);
					p_s2 += parseInt(p_sums2[i].value);
					p_s3 += parseInt(p_sums3[i].value);
					++k_count;
					p_count += parseInt(buy_counts[i].value);
				}
			} else {						 // 전체 선택을 해제하였을 때 -> 하위의 모든 체크박스를 해제
				ck_count = 0;
				cart_ids_list = [];
				
				for(let i=0; i<ck_cart_ones.length; i++){
					ck_cart_ones[i].checked = false;			
				}
			}
			cart_ids_list = [...new Set(cart_ids_list)];  // 중복 카트 아이디를 제거
			c1_s1.innerHTML = p_s1.toLocaleString() + '원';
			c2_s1.innerHTML = p_s1.toLocaleString() + '원';
			c3_s1.innerHTML = p_s1.toLocaleString() + '원';
			c1_s2.innerHTML = p_s2.toLocaleString() + '원';
			c1_s3.innerHTML = p_s3.toLocaleString() + '원';
			c1_s4.innerHTML = k_count + "총";
			c1_s5.innerHTML = p_count;
			console.log(cart_ids_list);
		})			
	
		// 각 상품별 체크 박스 중에서 해제된 것이 있다면 전체 선택을 해제
		// 각 상품별 체크박스가 모두 체크되었다면 전체 선택 체크박스를 선택
		for(let i=0; i< ck_cart_ones.length; i++){
			ck_cart_ones[i].addEventListener("change", function(){
				if(ck_cart_ones[i].checked == false) {  // 전체 해제
					ck_cart_all.checked = false;
					-- ck_count;
					cart_ids_list = cart_ids_list.filter((e) => e!== cart_ids[i].value); // 해제되지 않은 카트 아이디를 다시 저장
					p_s1 -= parseInt(p_sums[i].value);
					p_s2 -= parseInt(p_sums2[i].value);
					p_s3 -= parseInt(p_sums3[i].value);
					--k_count;
					p_count -= parseInt(buy_counts[i].value);
				} else {
					++ck_count;
					cart_ids_list.push(cart_ids[i].value);
					p_s1 += parseInt(p_sums[i].value);
					p_s2 += parseInt(p_sums2[i].value);
					p_s3 += parseInt(p_sums3[i].value);
					++k_count;
					p_count += parseInt(buy_counts[i].value);
				}
				//
				if(ck_count == ck_cart_ones.length) {
					ck_cart_all.checked = true;	
				}
				c1_s1.innerHTML = p_s1.toLocaleString() + '원';
				c2_s1.innerHTML = p_s1.toLocaleString() + '원';
				c3_s1.innerHTML = p_s1.toLocaleString() + '원';
				c1_s2.innerHTML = p_s2.toLocaleString() + '원';
				c1_s3.innerHTML = p_s3.toLocaleString() + '원';
				c1_s4.innerHTML = k_count + "총";
				c1_s5.innerHTML = p_count;
				console.log(cart_ids_list);
			})
		}
		
		// 삭제 버튼 처리
		btn_delete_select.addEventListener("click", function(){
			if(ck_count == 0) return;
			location = 'cartDeletePro2.jsp?cart_ids_list=' + cart_ids_list;
		})
		
		btn_delete_select2.addEventListener("click", function(){
			if(ck_count == 0) return;
			location = 'cartDeletePro2.jsp?cart_ids_list=' + cart_ids_list;
		})
		
		// 주문 버튼 처리
		btn_buy_select.addEventListener("click", function(){
			if(ck_count == 0) return;
			location = '../buy/buyForm.jsp?cart_ids_list=' + cart_ids_list;
		})
		
		btn_buy_select2.addEventListener("click", function(){
			if(ck_count == 0) return;
			location = '../buy/buyForm.jsp?cart_ids_list=' + cart_ids_list;
		})
		
		btn_buy_select3.addEventListener("click", function(){
			if(ck_count == 0) return;
			location = '../buy/buyForm.jsp?cart_ids_list=' + cart_ids_list;
		})
		
		// 쇼핑 계속하기 버튼 처리
		btn_shopping.addEventListener("click", function() {
			location= '../shopping/shopAll.jsp';
		})
		
		
	})
</script>
</head>
<body>
<%
DecimalFormat df = new DecimalFormat("#,###,###");
SimpleDateFormat sdf = new SimpleDateFormat("MM월 dd일");


String memberId = (String)session.getAttribute("memberId");
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location = '../logon/memberLoginForm.jsp';</script>");
	return;
}
	//회원 DB 연결 질의 -> 주소 정보 활용
	MemberDAO memberDAO = MemberDAO.getInstance();
	MemberDTO member = memberDAO.getMember(memberId);

	String address = member.getAddress();
	String local = address.substring(0,2);



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
String d_day = month + "월 " + date + "일 (" +weekday[week-1] +")";


// 장바구니 DB 연결, 질의
CartDAO cartDAO = CartDAO.getInstance();
List<CartDTO> cartList = cartDAO.getCartList(memberId);
int cartListCount = cartDAO.getCartListCount(memberId);



// 상품 가격(정가), 할인율, 개수, 할인가격(판매가)
int product_price=0;
int discount_rate = 0;
int buy_price =0;
int buy_count =0;
int p_sum = 0;
int p_tot = 0;

int p_sum2 = 0; // 각 상품의 합계( 원가 )
int p_tot2 = 0; // 주문 상품의 총합계(원가)

int d_count = 0; // 실제 할인된금액
int p_sum3 = 0; // 각 상품의 실제 할인된 금액의 합계
int p_tot3 = 0; // 주문 상품의 실제 할인된 금액의 총합계

int k_count = 0; // 주문 상품의 종류
int p_count = 0; // 주문 상품 총 개수
%>
<div class="container">
	<jsp:include page="../common/shopTop.jsp" />
	<div class="cart_list">
		
		<div class="d1">
			 <img src="../../icons/progress01.PNG" width="450" height="70">
		</div>
		<div class="d2">
			<span class="s1">EZENMALL 배송</span>
			<span class="s2">당일/하루/일반배송</span>
			<span class="s3">아침배송</span>
		</div>
		
		<hr class="d_line">
		
		<div class="d3">
			<input type="checkbox" name="ck_cart_all" id="ck_cart_all"><label for="ck_cart_all">전체 선택</label> 
			<input type="button" value="주문" id="btn_buy_select">
			<input type="button" value="삭제" id="btn_delete_select">
		</div>
	<table class="t_cart_list">
		<tr>
			<th colspan="3">상품정보</th>
			<th>수량</th>
			<th>상품금액</th>
			<th>배송정보</th>
			<th>주문</th>
		</tr>
		<%if(cartListCount == 0 ) { %>
			<tr><td class="td0" colspan="7">장바구니에 상품이 없습니다.</td></tr>
		<% } else {%>
		<%for(CartDTO cart : cartList) {
			product_price = cart.getProduct_price();
			buy_count = cart.getBuy_count();
			buy_price = cart.getBuy_price();
			discount_rate = cart.getDiscount_rate();
			p_sum = buy_price * buy_count;      // 각 상품의 합계 ( 할인 가격)
			p_tot += p_sum;        			    // 총합계(할인 가격)
			
			p_sum2 = product_price * buy_count; // 각 상품의 합계
			p_tot2 += p_sum2; 					// 총 합계(원가)
			
			p_sum3 = product_price * discount_rate / 100 * buy_count;  // 각 상품의 할인된 가격 
			p_tot3 += p_sum3;							   // 각 상품의 할인된 가격의 총합계
			
			++k_count;  		      // 주문 상품 종류
			p_count += buy_count;    // 주문 상품 총 개수
			
			
		%>
		<form action="cartUpdatePro.jsp" method="post" name="cartForm">
			<input type="hidden" name="cart_id" value="<%=cart.getCart_id() %>">
			<input type="hidden" name="product_id" value="<%=cart.getProduct_id() %>">
			<input type="hidden" name="p_sum" value="<%=p_sum %>">
			<input type="hidden" name="p_sum2" value="<%=p_sum2 %>">
			<input type="hidden" name="p_sum3" value="<%=p_sum3 %>">
			<tr>
				<td class="center td1" width="3%"><input type="checkbox" name="ck_cart_one" class="ck_cart_one"></td>
				<td class="center td2" width="8%">
					<a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id() %>"><img src="/images_camera/<%=cart.getProduct_image1() %>" width="60" height="90"></a>
				</td>
				<td class="left td3" width="48%">
					<span class="s1">
						<a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id() %>"><%=cart.getProduct_name() %><span class="s_color"> - <%=cart.getProduct_color() %></span></a>
					</span><br>
					<span class="s2"><%=cart.getProduct_com() %> | <%=cart.getProduct_country() %></span><br>
					<span class="s3"><%=df.format(product_price) %>원</span> | <span class="s4"><%=df.format(buy_price) %>원</span>(<span class="s5"><%=discount_rate %>% 할인</span>)
				</td>
				<td class="center td4" width="8%">
					<input type="number" name="buy_count" value="<%=buy_count %>" class="buy_count"><br>
					<input type="submit" name="btn_update" value="변경">
				</td>
				<td class="right td5" width="9%"><%=df.format(p_sum) %>원</td>
				<td class="center td6" width="12%"><%=d_day %><br>도착예정</td>
				<td class="center td7" width="12%">
					<input type="button" name="btn_buy_one" value="주문" class="btn_buy_one"><br>
					<input type="button" name="btn_delete_one" value="삭제" class="btn_delete_one">
				</td>
			</tr>
		</form>
		<% } }%>
		<tr>
			<th colspan="7">EZENMALL 배송 상품 총 금액 : <b class="c1_s1"></b>(+배송비<b>0원</b>)</td>
		</tr>
	</table>
	<div class="d4"> 
		<span>선택한 상품</span>
		<input type="button" value="주문" id="btn_buy_select2">
		<input type="button" value="삭제" id="btn_delete_select2">
	</div>
	<table class="t_cart_tot">
		<tr>
			<th>총 상품금액<br><span class="s1 c2_s1">0원</span></th>
			<th><img src="../../icons/plus.PNG" width="30"></th>
			<th>총 추가금액<br><span class="s2"><%=0 %></span>원</th>
			<th><img src="../../icons/minus.PNG" width="30"></th>
			<th>총 할인금액<br><span class="s3"><%=0 %></span>원</th>
			<th><img src="../../icons/equal.PNG" width="30"></th>
			<th>최종 결재금액<br><span class="s4 c3_s1">0원</span></th>
			
		</tr>
		<tr>
			<th colspan="7">
				<span>정가<b class="c1_s2">0원</b>에서<b class="c1_s3">0원</b>할인</span><br>
				<span>총 주문수량 : <b class="c1_s4">총</b> (<b class="c1_s5"></b>개)</span>
			</th>
		</tr>
	</table>
	<table class="t_cart_address">
		<tr>
			<th>배송일 안내<br><input type="button" value="배송안내"></th>
			<td>배송지 : <%=address %> <input type="button" value="배송지 변경"></td>
		</tr>
	</table>
	<div class="d5">
		<input type="button" value="주문하기" id="btn_buy_select3">&ensp;&ensp;
		<input type="button" value="쇼핑계속하기" id="btn_shopping">
	</div>
	<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp" />
</div>
</body>
</html>