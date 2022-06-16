<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 관리자 페이지</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hammersmith+One&family=Nanum+Brush+Script&family=Paytone+One&display=swap');
/* 상단 - 메인, 서브 타이틀  */
#container {width:400px; margin: 0 auto;}
.m_title{font-family: 'Paytone One', sans-serif; font-size:3em;text-align:center;}
.s_title{font-family: 'Do Hyeon', sans-serif;font-size:2.3em;text-align:center;margin-bottom:30px;}
a{text-decoration:none; color:#59637f;}
.c_logout{text-align:right; margin-bottom:20px;}
.c_logout a {color:blue; font-size:0.95em; font-weight:bold;}
/* 테이블 메뉴   */
table {width:100%; border:1px solid black; border-collapse:collapse;
border-bottom:3px solid gray; border-top:3px solid gray;
 border-left:hidden; border-right:hidden;}
tr {height:50px;}
th {border: 1px solid black;}
.title_row{background : #dee2e6; font-size:1.1em;}
.a_row{background:#f8f9fa;}
</style>
<script>
</script>
</head>
<body>
<div id="container">
	<div class="m_title"><a href="#">CAMERA STORE</a></div>
	<div class="s_title">쇼핑몰 관리자 페이지 </div>
	
	<div class="c_logout"><a href="logon/managerLogout.jsp">로그아웃</a></div>
	<table>
		<tr class="title_row"><th>상품 관리</th></tr>
		<tr class="a_row"><th><a href="product/productRegisterForm.jsp">상품 등록</a></th></tr>
		<tr class="a_row"><th><a href="product/productList.jsp">상품 목록(수정/삭제)</a></th></tr>
		<tr class="title_row"><th>주문 관리</th></tr>
		<tr class="a_row"><th><a href="#">주문 목록(수정/삭제)</a></th></tr>
		<tr class="title_row"><th>회원 관리</th></tr>
		<tr class="a_row"><th><a href="#">회원 목록(수정/삭제)</a></th></tr>
		
		
	</table>
</div>
<%
String managerId = (String)session.getAttribute("managerId");
if(managerId == null){
	out.print("<script>location='logon/managerLoginForm.jsp'</script>");
}
%>
</body>
</html>