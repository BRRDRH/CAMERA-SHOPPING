<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 전체</title> <%-- 쇼핑몰 전체 : 상단 + 메인  + 하단 --%>
<%-- slider --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<style>

#container{width: 95%; margin:0 auto;}

/* 신상품   */
.new_items{text-align:center;} 
.new_items .slider{width:100%;}

/* 소개 사진  */
.main1_image { float: left; margin: 30px 0 50px 150px; position: relative;}

.main2_image { float: right; margin: 30px 150px 50px 0; position: relative;}

.m1_d {  right: 42px; top: 420px; text-align: center; position: absolute; color: white; 
font-size: 2em; font-weight: bold;cursor: pointer;}
.m1_a { width: 200px; height: 50px; background: white; border-radius: 47%; line-height:40px;
text-align: center; margin-top: 12px; padding: 5px;}
.m1_a span { text-decoration: none; color: black; font-size: 25px;}

.m1_d:hover .m1_a { background: black;}
.m1_d:hover .m1_a span { color: white;}

.m2_d {  right: 42px; top: 420px; text-align: center; position: absolute; color: white; 
font-size: 2em; font-weight: bold;cursor: pointer;}
.m2_a { width: 200px; height: 50px; background: white; border-radius: 47%; line-height:40px;
text-align: center; margin-top: 12px; padding: 5px;}
.m2_a span { text-decoration: none; color: black; font-size: 25px;}

.m2_d:hover .m2_a { background: black;}
.m2_d:hover .m2_a span { color: white;}


/* 추천 상품  */
.good_items{ clear: both;  text-align:center;} 

.c_good_img:hover {transform : scale(1.05); transition:.5s;}
</style>
<script>
//슬라이더(slider),캐러셀(carousel)
$(document).ready(function () {
    $('.slider').bxSlider({
        autoControls: true, 		//기본값 : false, 재생/정지 컨트롤 버튼 유무
        stopAutoOnClick: true, 		//기본값 : false, 블릿을 누르고 나면 슬라이드 정지
        auto: true, 				//슬라이드가 자동으로 넘어간다.
        speed: 2000, 				//화면 전환 속도
        pause: 3000,  				//화면 전환 속도 + 전환 지연 시간 
        autoHover: true, 			// 기본값 : false 마우스 위에 올렸을 때 슬라이드 정지
        // 중요한 속성 
        slideWidth: 400, 			//이미지의 너비
        slideHeight: 340, 			// 이미지의 높이
        maxSlides: 5, 				//이미지의 최대 노출 갯수
        minSlides: 2, 				//이미지의 최소 노출 갯수
        moveSlides: 2, 				//슬라이드 이동 갯수
        slideMargin: 30,			
        touchEnabled:false 			//웹 하면의 touch 이벤트 제거 -> 이미지를 클릭했을 때 해당 페이지로 이동이 가능
    });
});

document.addEventListener("DOMContentLoaded", function(){
	let m1_a = document.querySelector(".m1_a");
	let m2_a = document.querySelector(".m2_a");
	m1_a.addEventListener("click", function(){
		location="shopContent.jsp?product_id=3";
	})
	m2_a.addEventListener("click", function(){
		location="shopContent.jsp?product_id=102";
	})
})

</script>
</head>

<body>
<% 
ProductDAO productDAO = ProductDAO.getInstance();

// 메인 2 : 추천 상품(모든 상품에서 최신상품 1개씩 리스트에 담아서 리턴)
String[] nProducts2 = {"110","120","130","210","220","230","310","320","410","420"};
List<ProductDTO> goodProductList = productDAO.getProductList(nProducts2);

%>
<div id="container">
	<div><%-- 상단 --%>
		<header><jsp:include page="../common/shopTop.jsp"/></header>
	</div>
	<div><%-- 메인 (본문)--%>
		<main>
			<div class="main1_image"><img src="../../background/main1.png" width="600" height="600"><div class="m1_d">Film Camera<div class="m1_a"><span>show</span></div></div></div>
			<div class="main2_image"><img src="../../background/main2.png" width="600" height="600"><div class="m2_d">Digital Camera<div class="m2_a"><span>show</span></div></div></div>
			<article class="good_items"> <%-- 메인2 : 모든 상품에서 신상품 한 개씩을 가져온다 slick으로 노출   --%>
				<h3>추천 상품</h3>
				<div class="slider">
				
				<%for(ProductDTO product : goodProductList){ %>
					<a href="shopContent.jsp?product_id=<%=product.getProduct_id() %>">
					<img class="c_good_img" src="/images_camera/<%=product.getProduct_image1() %>" width="400" height="400">
					</a>	
				<%}%>	
				</div>
			</article>  
			<hr>
			<article class="best_item"> <%-- 메인 3 : 베스트셀러(주문수량이 가장 많은 상품 20개를 가져와서 노출) --%>
			</article> 
			<article class="kind_items">  <%-- 메인 4 : 상품 종류 별로 나열되도록 설정한 영역 --%>    
				<jsp:include page="shopMain.jsp"/>
			</article>
		</main>
	</div>
	<div> <%-- 하단 --%>
		<footer><jsp:include page="../common/shopBottom.jsp"/></footer>
	</div>
</div>
</body>
</html>