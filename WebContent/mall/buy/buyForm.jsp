<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, mall.member.*, mall.bank.*" %> 
<%@ page import="java.util.*" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매확인폼</title>
<style>
.container { width: 95%; margin: 0 auto;}
.buy_form { width: 100%;}
/* 상단 1  */
.d1 { width:40%;   text-align: right; margin-left: 50px; margin-top: 38px; display: inline-block;}
.d1 .s1 { font-size:1.1em; font-weight: bold; }
.d1 .s2 { display: inline-block; width: 120px; text-align: center; font-size: 0.8em; font-weight: bold;  
padding: 6px 17px; border: 1px solid #333; font-size: 0.8em; border-radius: 15px; font-weight:bold; background: #443cc3; color:#fff;}
.d1 .s3 { width: 300px; padding: 6px 17px; border: 1px solid gray; font-size: 0.8em; border-radius: 15px; font-weight:bold; background:#fff; color:#333;}

/* 상단 2  */
.d2 { width: 40%; padding: 15px; margin: 5px 45px; float: left; display: inline-block; text-align: left;}
.d_line { clear: both; width: 90%; border: 1px solid lightgray;}


/* 상품 정보 테이블  */
.d3 .t1 { width: 90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left:none; border-top: none; border-right:none; clear: both;}
.d3 .t1 tr { height: 40px;}
.d3 .t1 td, .d3 th { border-top:1px solid #dee2e6; border-bottom:1px solid #dee2e6; border-left:none; border-right:none;}
.d3 .t1 th { background: #b191bd; color: #fff; text-shadow: 1px 1px 1px black;}
.d3 .t1 td { padding: 10px;}
.d3 .t1 tr:last-child th { font-weight:normal;}
.d3 .t1 td{}
.d3 .t1 input[type=number] { width: 60px;}
.right { text-align: right; padding-right: 30px;}
.center { text-align:center; padding: 5px;}

.d3 input[type='number']::-webkit-inner-spin-button, 
.d3 input[type='number']::-webkit-outer-spin-button { 
-webkit-appearance: "Always Show Up/Down Arrows"; opacity:1;}


.d3 a { text-decoration: none; color: #32708d;}
.d3 .s1 { color: #32708d; font-weight: bold; font-size: 1.1em; margin-bottom: 10px; display: inline-block;}
.d3 .s2 { color: #abd5bd; font-size: 0.95em;}
.d3 .s3 { color: #1e94be; font-weight: bold;}
.d3 .s4 { color: #c84557; font-weight: bold;}
.d3 .s6 { color: #99424f; font-weight: bold; font-size: 1.05em;}
/* 중단 - d4, 총 구매정보  */
.d4 { margin-top: 20px;}
.d4 .t2 { width: 90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left:none; border-top: none; border-right:none; clear: both;}
.d4 .t2 tr { height: 60px;}
.d4 .t2 td, .d4 .t2 th { border-top:1px solid #dee2e6; border-bottom:1px solid #dee2e6; border-left:none; border-right:none;}
.d4 .t2 th { background: #eeb558; font-size: 1.1em; color: #fff; text-shadow: 1px 1px 1px #c5c4d4;}
.d4 .t2 td { text-align: center; background: #f7f8f0;}
.d4 .s1 { color: #c84557; font-size: 1.2em; font-weight: bold;}
.d4 .s2 { color: #32708d; font-size: 1.2em; font-weight: bold;}
.d4 .s3 { color: #99424f; font-size: 1.4em; font-weight: bold;}
.d4 .s4, .d4 .s5 { color: #1e94be; font-size: 1.1em; font-weight: bold; }

/* 중단 - d5, 총 구매정보  */
.d5 { margin-top: 20px;}
.d5 .t3 { width: 90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left:none; border-top: none; border-right:none; clear: both;}
.d5 .t3 tr { height: 40px;}
.d5 .t3 td, .d5 .t3 th { border-top:1px solid #dee2e2; border-bottom:1px solid #dee2e6; border-left:none; border-right:none;}
.d5 .t3 th:nth-of-type(1) { background: #6e87b2; font-size: 1.1em; color: #fff; text-shadow: 1px 1px 1px #c5c4d4;}
.d5 .t3 td { text-align: left; background: #dddce9; padding-left: 20px;}
.d5 .t3 input { margin: 5px 0; height: 22px; } 
.d5 .t3 .add1, .d5 .t3 .add2 { width: 600px;}
.d5 .t3 span { color: #707fa0; font-weight: bold; margin-right: 10px;}
.d5 .t3 #btn_address { background: #63647f; border: 1px solid #63647f; color: #fff; 
border-radius: 3px; width: 100px; height:35px; font-size: 0.95em; font-weight: bold;}


/*  중단 - d6 주문자 정보   */
.d6 { margin-top: 20px;}
.d6 .t4 { width: 90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left:none; border-top: none; border-right:none; clear: both;}
.d6 .t4 tr { height: 40px;}
.d6 .t4 td, .d6 .t4 th { border-top:1px solid #dee2e2; border-bottom:1px solid #dee2e6; border-left:none; border-right:none;}
.d6 .t4 th:nth-of-type(1) { background: #6e87b2; font-size: 1.1em; color: #fff; text-shadow: 1px 1px 1px #c5c4d4;}
.d6 .t4 td { text-align: left; background: #dddce9; padding-left: 20px;}
.d6 .t4 input { margin: 5px 0; height: 22px; } 
.d6 .t4 .add1, .d6 .t4 .add2 { width: 600px;}
.d6 .t4 span { color: #707fa0; font-weight: bold; margin-right: 10px;}
.d6 .t4 #btn_address { background: #63647f; border: 1px solid #63647f; color: #fff; 
border-radius: 3px; width: 100px; height:35px; font-size: 0.95em; font-weight: bold;}
.d6 .account { width: 230px; height:25px;}
#btn_delete_bank, #btn_regist_bank, #btn_insert_bank { width: 80px; height: 30px; color: #fff; 
border-radius: 5px; cursor: pointer; margin-right: 10px;}

#btn_delete_bank { background: #c84557; border: 1px solid #c84557;}
#btn_regist_bank { background: #2f9e77; border: 1px solid #2f9e77;}
.tr_card_insert_td input[type=text] { width: 200px; margin-right: 5px;}
.tr_card_insert_td input[type=button] { background: #1e94be; border: 1px solid #1e94be;}
.tr_card_insert_hidden { display: none;}
/*  중단 - d7 결제   */
.d7 { margin: 20px 0;}
.d7 .t5 { width: 90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left:none; border-top: none; border-right:none; clear: both;}
.d7 .t5 tr { height: 60px;}
.d7 .t5 td, .d7 .t5 th { border-top:1px solid #dee2e2; border-bottom:1px solid #dee2e6; border-left:none; border-right:none;}
.d7 .t5 tr:nth-of-type(1) { background: #6e87b2; font-size: 1.1em; color: #fff; text-shadow: 1px 1px 1px #c5c4d4;}
.d7 .t5 tr:nth-of-type(2) { background: #dddce9; font-size:1.3em; color:#99424f; }
.d7 input[type=button] { width: 170px; height: 60px; background: #2f9e77; border: none; color: #fff; 
font-size: 1em; cursor: pointer; font-weight: bold; border-radius: 5px; margin: 5px;}
.d7 input[type=button]:hover { background: #fff; border: 2px solid #2f9e77; color: #2f9e77;}

/* 마지막 줄 */
.t_line{border: 1px solid #e9ecef; margin:30px 0px; clear:both;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let form = document.buyForm;
	let cart_id = form.cart_id.value;
	// 주소 찾기 버튼  - 다음 라이브러리 활용
	let btn_address = document.getElementById("btn_address");
	// daum의 라이브러리를 활용한 주소 찾기 문법
	btn_address.addEventListener("click",function(){
		new daum.Postcode({
			oncomplete:function(data) {
				form.delivery_address1.value = data.address;
				
			}
		}).open();
	})
	//수량 제한 효과 (1 ~ 100)
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
	
	// 카드 삭제 버튼
	let btn_delete_bank = document.getElementById("btn_delete_bank");
	btn_delete_bank.addEventListener("click", function(){
		let account = form.account;
		let value = account.options[account.selectedIndex].value;
		let card_no = value.substring(0, 19);
		account.remove(account.selectedIndex);
		location = "../bank/bankDeletePro.jsp?cart_id=" + cart_id +"&card_no=" + card_no;
	})
	
	// 카드 등록 버튼 클릭 했을 때
	let tr_card_insert = document.querySelector(".tr_card_insert");
	let btn_regist_bank = document.getElementById("btn_regist_bank");
	btn_regist_bank.addEventListener("click", function(){
		tr_card_insert.className = ".tr_card_insert";
	})
	let btn_insert_bank = document.getElementById("btn_insert_bank");
	
	btn_insert_bank.addEventListener("click", function() {
		let card_no = document.querySelector(".card_no").value;
		let card_com = document.querySelector(".card_com").value;
		let member_id = document.querySelector(".member_id").value;
		let member_name = document.querySelector(".member_name").value;
		location = "../bank/bankInsertPro.jsp?cart_id=" + cart_id + "&card_no=" + card_no +"&card_com=" + card_com +"&member_id=" +member_id + "&member_name=" +member_name;
	})
})

</script>
</head>
<body>
<%
// buyForm.jsp -> 구매정보 확인폼(구매여부를 결정하는 폼),buyList.jsp -> 구매 목록 폼(최종 구매 확인 폼)
request.setCharacterEncoding("utf-8");

DecimalFormat df = new DecimalFormat("#,###,###");
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

//배송 날짜 계산과 포맷
//규칙1. 서울: 다음날에 배송, 경기 : 2일 안에 배송, 지방 : 3일 안에 배송, 제주도: 5일 안에 배송
//규칙3. 토요일, 일요일은 제외.
//전체 날짜, 요일판단, 주소판단
int n = 0;
Calendar cal = Calendar.getInstance();
int w = cal.get(Calendar.DAY_OF_WEEK); // 일1 월2 화3 수4 목5 금6 토 7

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

//추가된 일수를 더한 날짜 
cal.add(Calendar.DATE, n);
int month = cal.get(Calendar.MONTH) +1; //0 ~ 11로 표현, 1을 더해서 보정
int date = cal.get(Calendar.DATE);
int week = cal.get(Calendar.DAY_OF_WEEK); // 1~7
String[] weekday = {"일","월","화","수","목","금","토"};
String d_day = month + "월 " + date + "일 (" +weekday[week-1] +")";

// cartList.jsp에서 넘어오는 cart_id를 확인, 배열 -> 리스트로 저장
String cart_id_str = request.getParameter("cart_id");
String[] cart_id_arr = cart_id_str.split(",");

List<Integer> cart_id_list = new ArrayList<Integer>();
for(String c : cart_id_arr){
	cart_id_list.add(Integer.parseInt(c));
}

// 카트 확인
//System.out.println("카트 : " + Arrays.toString(cart_id_arr));
//System.out.println("카트 리스트 : " + cart_id_list);

// Cart DB연동 -> cartList에서 넘어오는 정보 -> 1개 또는 여러개
CartDAO cartDAO = CartDAO.getInstance();
List<CartDTO> cartList = cartDAO.getCartList(cart_id_list);



// CartList 정보 1개
//CartDTO cart = cartDAO.getCart(cart_id);

// Member DB연동 

// Bank DB연동
BankDAO bankDAO = BankDAO.getInstance();
List<BankDTO> bankList = bankDAO.getBankList(memberId);


// 총 상품금액, 총 할인금액, 총 구매금액, 구매 상품 종류, 구매 상품 개수
int tot1=0, tot2=0, tot3=0, cnt1=0, cnt2=0;
%>
<div class="container">
	<jsp:include page="../common/shopTop.jsp" />
	<div class="buy_form">
		<div class="d1">
			<span class="s1">EZENMALL 배송</span>
			<span class="s2">당일/하루/일반배송</span>
			<span class="s3">아침배송</span>
		</div>
		<div class="d2">
			<img src="../../icons/progress02.PNG" width="450" height="70">
		</div>
		<hr class="d_line">
		<form action="buyList.jsp" method="post" name="buyForm">
		<input type="hidden" id="cart_id" value="<%=cart_id_str %>">
		<div class="d3"> <!-- 카트 정보 -->
			<table class="t1">
				<tr>
					<th colspan="2">상품정보</th>
					<th>정가</th>
					<th>판매가</th>
					<th>구매수량</th>
					<th>합계</th>
					<th>배송일</th>
				</tr>
				<%for(CartDTO cart : cartList) {
					
					int p_sum1 = cart.getProduct_price() * cart.getBuy_count(); // 정가 합계
					int p_sum3 = cart.getBuy_price() * cart.getBuy_count();     // 총 합꼐
					int p_sum2 = p_sum1 - p_sum3;
					tot1 += p_sum1;
					tot2 += p_sum2;
					tot3 += p_sum3;
					++cnt1;
					cnt2 += cart.getBuy_count();
				%>
				
					<tr>
						<td width="10%">
							<a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id() %>"><img src="/images_camera/<%=cart.getProduct_image1() %>" width="100" height="140"> </a>
						</td>
						<td width="40%">
							<a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id() %>"><span><%=cart.getProduct_name() %> - <%=cart.getProduct_color() %></span></a><br><br>
							<span><%=cart.getProduct_com() %> | <%=cart.getProduct_country() %></span>
						</td>
						<td width="10%" class="right"><span class="s3"><%=df.format(cart.getProduct_price()) %>원</span></td>
						<td width="10%" class="right"><span class="s4"><%=df.format(cart.getBuy_price()) %>원</span></td>
						<td width="10%" class="center"><span class="s5"><input type="number" name="buy_count" class="buy_count" value="<%=cart.getBuy_count() %>" max="100" min="1"></span></td>
						<td width="10%" class="right"><span class="s6"><%=df.format(p_sum3) %>원</span></td>
						<td width="10%" class="center"><span class="s7"><%=d_day %></span></td>
					</tr>
				
				<% } %>
			</table>
		</div>
		<div class="d4"> <!-- 구매 총 정보  -->
			<table class="t2">
				<tr>
					<th width="33.3%">총 상품금액</th>
					<th width="33.4%">총 할인금액</th>
					<th cwidth="33.3%">총 구매금액</th>
				</tr>
				<tr>
					<td><span class="s1"><%=df.format(tot1) %></span></td>
					<td><span class="s2"><%=df.format(tot2) %></span></td>
					<td><span class="s3"><%=df.format(tot3) %></span></td>
				</tr>
				<tr>
					<td colspan="3">
						구매 상품 종류 : <span class="s4"><%=cnt1 %> 종</span> &emsp;|&emsp; 구매 상품 개수 : <span  class="s5"><%=cnt2 %>개</span>
					</td>
				</tr>
			</table>
		</div>
		<div class="d5"> <!-- 배송지 정보 : 변경 가능하도록--->
			<table class="t3">
				<tr>
					<th colspan="2">배송정보</th>
				</tr>
				<tr>
					<th width="20%">수령인 이름</th>
					<td width="80%"><input type="text" name="delivery_name" value="<%=member.getName() %>"></td>
				</tr>
				<tr>
					<th>배송지 연락처</th>
					<td><input type="text" name="delivery_tel" value="<%=member.getTel() %>"></td>
				</tr>
				<tr>
					<th>배송지 주소</th>
					<td>
						<input type="button" value="주소 찾기" id="btn_address"><br>
						<span>기본 주소</span> <input type="text" name="delivery_address1" class="add1" placeholder="주소 찾기 버튼을 클릭하여 검색하시오."><br>
						<span>상세 주소</span> <input type="text" name="delivery_address2" class="add2" placeholder="상세 주소는 직접 입력하시오.">
					</td>
				</tr>
			</table>
		</div>
		<div class="d6"> <!-- 주문자 정보 : 결제 정보 포함-->
			<table class="t4">
				<tr><th colspan="3">주문자 정보</th></tr>
				<tr>
					<th width="20%">주문자 이름</th>
					<td width="80%" colspan="2"><span><%=member.getName() %></span></td>
				</tr>
				<tr>
					<th>주문자 연락처</th>
					<td colspan="2"><span><%=member.getTel() %></span></td>
				</tr>
				<tr>
					<th>주문자 주소</th>
					<td colspan="2"><span><%=member.getAddress() %></span></td>
				</tr>
				<tr>
					<th>결제 카드</th>
					<td  width="28%">
						<select name="account" class="account">
						<%if(bankList.size() == 0) {%>
							<option value="0">등록된 카드 없음</option>
							<%} else {
							for(BankDTO bank : bankList) {
								String account = bank.getCard_no() +" " + bank.getCard_com();
							%>
								<option value="<%=account %>"><%=account %></option>
							<%}}%>
						</select>
					</td>
					<td>
						<input type="button" value="카드 삭제" id="btn_delete_bank">
						<input type="button" value="카드 등록" id="btn_regist_bank">
					</td>
				</tr>
				<tr class="tr_card_insert tr_card_insert_hidden">
				
					<th width="20%">카드등록</th>
					<td width="80%"colspan="2" class="tr_card_insert_td">
						<input type="hidden" class="member_id" value="<%=member.getId() %>">
						<input type="hidden" class="member_name" value="<%=member.getName() %>">
						<input type="text" class="card_no" placeholder="카드번호 입력">
						<input type="text" class="card_com" placeholder="발행은행 입력">
						<input type="button" value="카드 추가" id="btn_insert_bank">
					
					</td>
				</tr>
			</table>
		</div>
		<div class="d7"> <!--  결제 -->
			<table class="t5">
				<tr>
					<th width="30%">상품 도착 예정일</th>
					<th width="30%">총 구매금액</th>
					<th width="40%">결제</th>
				</tr>
				<tr>
					<th><span><%=d_day %></span></th>
					<th><span><%=df.format(tot3) %>원</span></th>
					<th><input type="button" value="최종결제" id="btn_buy"></th>
				</tr>
			</table>
		</div>
		</form>
	</div>
	<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp"></jsp:include>
	
	
</div>
</body>
</html>