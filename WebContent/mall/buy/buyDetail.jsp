<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.buy.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매아이디별 상세보기</title>
<style>
.container { width:95%; margin: 0 auto;}
.buy_detail {width: 100%;}

/* 상품 정보 테이블  */
.d1 .t1 { width: 90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left:none; border-top: none; border-right:none; clear: both;}
.d1 .t1 tr { height: 40px;}
.d1 .t1 td, .d1 .t1 th { border-top:1px solid #dee2e6; border-bottom:1px solid #dee2e6; border-left:none; border-right:none;}
.d1 .t1 th { background: #1e94be; color: #fff; text-shadow: 1px 1px 1px black;}
.d1 .t1 td { padding: 20px;}
.right { text-align: right; padding-right: 30px;}
.center { text-align:center; padding: 5px;}
.left { text-align: left; padding-left: 5px;}
.t1 .s1 { color: gray;}
.t1 .s3 a { text-decoration: none; color: #32708d; font-weight: bold;}
.t1 .s4, .t1 .s5{ color: #1e94be; font-weight: bold; font-size: 1.1em; }
.t1 .s6 { color: #99424f; font-weight: bold; font-size: 1.2em;}
.t1 .s7 { color: #1e9faa; font-weight: bold;}

/* d2 - 총 구매 정보  */
.d2 .t2 { width: 90%; border : 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left:none; border-top: none; border-right:none; clear: both;}
.d2 .t2 tr { height: 40px;}
.d2 .t2 td, .d1 .t1 th { border-top:1px solid #dee2e6; border-bottom:1px solid #dee2e6; border-left:none; border-right:none;}
.d2 .t2 th { background: #1e94be; color: #fff; text-shadow: 1px 1px 1px black;}
.right { text-align: right; padding-right: 30px;}
.center { text-align:center; padding: 5px;}
.left { text-align: left; padding-left: 5px;}
.t2 .s1 { font-size: 1.2em; color: #32708d; font-weight: bold;}
.t2 .s2 { font-size: 1.3em; color: #1e9faa; font-weight: bold;}
.t2 tr:nth-of-type(2) { height: 100px;}
.t2 input[type=button] { width: 120px; height: 40px; background: #2f9e77; color: #fff;
 font-weight: bold; font-size: 1.1em; border-radius: 5px; border: none; cursor: pointer;}

/* 마지막 줄 */
.end_line { width: 100%; border: 1px solid lightgray; margin: 30px 0;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let btn_buy_list = document.getElementById("btn_buy_list");
		btn_buy_list.addEventListener("click",function(){
			location = "buyList.jsp";
			
		})
		
		
	})
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
DecimalFormat df = new DecimalFormat("#,###,###");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String memberId = (String)session.getAttribute("memberId");
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location = '../logon/memberLoginForm.jsp';</script>");
	return;
}

String buy_id = request.getParameter("buy_id");
BuyDAO buyDAO = BuyDAO.getInstance();
List<BuyDTO> buyListDetail = buyDAO.getBuyListDetail(buy_id);

int tot1=0, tot2 =0;
int cnt1 = buyListDetail.size();
int cnt2 =0;

%>
<div class="container">
	<jsp:include page="../common/shopTop.jsp"/>
 	<div class="buy_detail">
 	<div class="d1">
 		<table class="t1">
 		<tr>
 			<th width="18%">주문일자(주문번호)</th>
 			<th colspan="2" width="37%">주문상품정보</th>
 			<th width="10%">구매금액</th>
 			<th width="10%">구매수량</th>
 			<th width="11%">총금액</th>
 			<th width="14%">주문상태</th>
 		</tr>
 		<%for(BuyDTO buy : buyListDetail) {
 			tot1 = buy.getBuy_price() * buy.getBuy_count();
 			tot2 += tot1;
 			
 		%>
 			<tr>
 				<td class="center">
 				<span class="s1"><%=sdf.format(buy.getBuy_date())%><br>(<%=buy.getBuy_id() %>)
 				</span></td>
 				<td width="8%" class="left"><span class="s2"><a href="../shopping/shopContent.jsp?product_id=<%=buy.getProduct_id()%>">
 				<img src="/images_camera/<%=buy.getProduct_image1() %>" width="60" height="90">
 				</a></span></td>
 				<td width="29%" class="left"><span class="s3"><a href="../shopping/shopContent.jsp?product_id=<%=buy.getProduct_id()%>">
 				<%=buy.getProduct_name() %>
 				</a></span></td>
 				<td class="right"><span class="s4"><%=df.format(buy.getBuy_price()) %>원</span></td>
 				<td class="center"><span class="s5"><%=buy.getBuy_count() %>개</span></td>
 				<td class="center"><span class="s6"><%=df.format(tot2) %>원</span></td>
 				<td class="center"><span class="s7"><%=buy.getDelivery_state() %></span></td>
 			</tr>
 		<%} %>
 		</table>
 	</div>
 	<div class="d2">
 		<table class="t2">
 			<tr>
 				<th colspan="3">구매 정보 확인</th>
 			</tr>
 			<tr class="tr2">
 				<td class="center" width="40%">
 					<span class="s1">구매 상품 종류 <%=cnt1 %>건<br>구매 상품 수량 : <%=cnt2 %>개</td>
 				<td class="center" width="40%">
 					<span class="s2">총 구매 금액 : <%=df.format(tot2) %>원</span>
 				</td>
 				<td class="center" width="20%">
 					
 					<input type="button" value="구매목록" id="btn_buy_list"> 
 				</td>
 			</tr>
 		</table>
 	</div>	
 	</div>
 	<hr class="end_line">
	<jsp:include page="../common/shopBottom.jsp"/>
</div>
</body>
</html>