<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hammersmith+One&family=Nanum+Brush+Script&family=Paytone+One&display=swap');
/* 상단 - 메인, 서브 타이틀  */
#container {width:700px; margin: 0 auto;}
.m_title{font-family: 'Paytone One', sans-serif; font-size:3em;text-align:center;}
.s_title{font-family: 'Do Hyeon', sans-serif;font-size:2.3em;text-align:center;margin-bottom:30px;}
a{text-decoration:none; color:#59637f;}
.c_logout{text-align:right; margin-bottom:20px;}
.c_logout a {color:blue; font-size:0.95em; font-weight:bold;}
/* 중단 - 상품 등록 테이블   */
table{width:100%; border:1px solid #2f9e77; border-collapse:collapse;
border-top:3px solid #2f9e77; border-bottom:3px solid #2f9e77; border-left:hidden; border-right:hidden;}
tr{height:45px;}
td,th{border:1px solid gray;}
th{background:#d8f4e6;}
td{padding-left:5px;}
/* 중단 - 테이블 안의 입력상자    */
input[type="number"]{width:100px;}
textarea {margin-top:5px;}
/* 하단 - 버튼  */
select{height:24px;}
input::file-selector-button {width:90px;height:30px; background:#2f9e77; color:#fff; 
border:none;cursor:pointer; border-radius:5px; font-weight:bold;}
.btns{text-align:center; margin-top:10px;}
.btns input { width:110px; height:39px; border: none; background:#495057; color:#fff; 
margin: 5px; font-weight:bold; cursor:pointer; border-radius: 10px;}
.btns input:nth-child(1) {background:#2f9e77;}
.btns input:nth-child(1):hover {border: 2px solid #2f9e77; background:#fff; 
color:#2f9e77; font-weight:bold;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let form = document.registerForm;
	let btn_register = form.btn_register;
	
	//상품 등록 처리 페이지
	btn_register.addEventListener("click",function(){
		if(!form.product_name.value){
			alert(`상품 명을 입력하시오.`);
			return;
		}
		if(!form.product_price.value){
			alert(`상품 가격을 입력하시오.`);
			return;
		}
		if(!form.product_count.value){
			alert(`상품 수량을 입력하시오.`);
			return;
		}
		if(!form.product_com.value){
			alert(`제조사를 입력하시오.`);
			return;
		}
		if(!form.product_country.value){
			alert(`제조국을 입력하시오.`);
			return;
		}
		if(!form.product_date.value){
			alert(`제조일을 입력하시오.`);
			return;
		}
		form.submit();
	})
	
	// 상품 목록 페이지
	let btn_list = form.btn_list;
	btn_list.addEventListener("click",function(){
		location = 'productList.jsp';
	})
	
	
	// 관리자 페이지로 이동
	let btn_main = form.btn_main;
	btn_main.addEventListener("click",function(){
		location = '../managerMain.jsp';
		
	})
	
	
})
</script>
</head>
<body>
<% 
String managerId = (String)session.getAttribute("managerId");
if(managerId == null){
	out.print("<script>location='../logon/managerLoginForm.jsp'</script>");
}
%>
<div id="container">
	<div class="m_title"><a href="../managerMain.jsp">CAMERA STORE</a></div>
	<div class="s_title">상품 등록</div>
	
	<form action="productRegisterPro.jsp" method="post" name="registerForm" enctype="multipart/form-data">
		<table>
			<tr>			
				<th width="20%">상품 분류</th>
				<td width="80%">
					<select name="product_kind">
						<option value="110" selected>Kodak</option>
						<option value="120">Polaroid</option>
						<option value="130">Lomography</option>
						<option value="210">Colley</option>
						<option value="220">Pototree</option>
						<option value="230">하이라라</option>
						<option value="310">Canon</option>
						<option value="320">Sony</option>
						<option value="410">Nikon</option>
						<option value="420">삼성전자</option>
						<option value="510">파우치</option>
						<option value="520">삼각대</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td><input type="text" name="product_name" size="56"></td>
			</tr>
			<tr>
				<th>컬러</th>
				<td><input type="text" name="product_color" size="13"></td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td><input type="number" name="product_price" min="1000" max="1000000" size="25">원</td>
			</tr>
			<tr>
				<th>상품 수량</th>
				<td><input type="number" name="product_count" min="0" max="10000" size="30">권</td>
			</tr>
			<tr>
				<th>제조사</th>
				<td><input type="text" name="product_com" size="56"></td>
			</tr>
			<tr>
				<th>제조국</th>
				<td><input type="text" name="product_country" size="56"></td>
			</tr>
			<tr>
				<th>제조일</th>
				<td><input type="date" name="product_date"></td>
			</tr>
			<tr>
				<th>상품 이미지1</th>
				<td><input type="file" name="product_image1"></td>
			</tr>
			<tr>
				<th>상품 이미지2</th>
				<td><input type="file" name="product_image2"></td>
			</tr>
			<tr>
				<th>상품 이미지3</th>
				<td><input type="file" name="product_image3"></td>
			</tr>
			<tr>
				<th>상품 상세내용</th>
				<td><input type="file" name="product_content"></td>
			</tr>
			<tr>
				<th>할인율</th>
				<td><input type="number" name="discount_rate" min="0" max="90">%</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="상품 등록" id="btn_register">
			<input type="reset" value="다시 입력">
			<input type="button" value="상품 목록" id="btn_list">
			<input type="button" value="관리자 페이지" id="btn_main">
		</div>
	</form>
</div>
</body>
</html>