<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 보기</title>
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
table{width:100%; border:1px solid #705e7b; border-collapse:collapse;
border-top:3px solid #705e7b; border-bottom:3px solid #705e7b; border-left:hidden; border-right:hidden;}
tr{height:35px;}
td,th{border:1px solid #705e7b;}
th{background:#e6c9e1;}
td{padding-left:5px; height:40px;}
/* 중단 - 테이블 안의 입력상자    */
.c_p_id,.c_p_regdate {background:#e9ecef; padding-left:5px;}
.s_p_id, .s_p_regdate{color:red; font-size:0.88em;font-weight:bold; margin-left:10px;}
.s_p_image1{color:blue; font-size:0.85em;}
input[type="number"]{width:100px;}
textarea {margin-top:5px;}
/* 하단 - 버튼  */
select{height:24px;}
input::file-selector-button {width:90px;height:28px; background:#705e7b; color:#fff; 
border:none;cursor:pointer; border-radius:5px; font-weight:bold;}
.btns{text-align:center; margin-top:10px;}
.btns input { width:100px; height:37px; border: none; background:#495057; color:#fff; 
margin: 5px; font-weight:bold; cursor:pointer;}
.btns input:nth-child(1),input:nth-child(2) {background:#705e7b;}
.btns input:nth-child(1):hover,input:nth-child(2):hover {border: 2px solid #705e7b; background:#fff; 
color:#705e7b; font-weight:bold;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let form = document.updateForm;
	let btn_update = form.btn_update;
	let btn_delete = form.btn_delete;
	let pageNum = form.pageNum.value;
	
	// 상품 분류가 선택되도록 설정 
	let product_kind = form.product_kind;   //select 전체를 가지고 온다.그리고 [i]로 돌린다.
	let p_kind = form.p_kind;			  // ex) 자기계발 : 310있는 option
	for(let i=0; i<product_kind.length; i++){
		            // 옵션의 길이 = 개수
		if(p_kind.value == product_kind[i].value){
			product_kind[i].selected = true;
			break;
		}
	}
	
	
	
	//상품 수정 처리로 이동
	btn_update.addEventListener("click", function(){
			if(!form.product_name.value){
				alert(`상품명을 입력하시오.`);
				return;
			}
			if(!form.product_price.value){
				alert(`상품 가격을 입력하시오.`);
				return;
			}
			if(!form.product_color.value){
				alert(`컬러를 입력하시오.`);
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
		
		// 상품 삭제 처리 페이지 이동
		let product_id = form.product_id.value;
		btn_delete.addEventListener("click",function(){
			location = 'productDeletePro.jsp?product_id=' + product_id +'&pageNum='+ pageNum;
		})
		
		
		// 상품 목록 페이지
		let btn_list = form.btn_list;
		btn_list.addEventListener("click",function(){
			location = 'productList.jsp?pageNum='+pageNum;
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
String pageNum = request.getParameter("pageNum");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
int product_id = Integer.parseInt(request.getParameter("product_id"));
// DB 연결, 질의
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);
%>
<div id="container">
	<div class="m_title"><a href="../managerMain.jsp">CAMERA STORE</a></div>
	<div class="s_title">상품 정보 확인 </div>
	
	<form action="productUpdatePro.jsp?pageNum=<%=pageNum %>" method="post" name="updateForm" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<table>
			<tr>
				<th>상품 번호</th>
				<td>
					<input type="text" class="c_p_id" name="product_id" size="10" value="<%=product.getProduct_id() %>" readonly >
					<span class="s_p_id">상품번호는 변경불가</span>
				</td>
			</tr>
			<tr>			
				<th width="20%">상품 분류</th>
				<td width="80%">
					<input type="hidden" name="p_kind" value="<%=product.getProduct_kind() %>">
					<select name="product_kind">
						<option value="110" selected>Kodak</option>
						<option value="120">polaroid</option>
						<option value="130">lomography</option>
						<option value="210">pototree</option>
						<option value="220">colley</option>
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
		 		<td><input type="text" name="product_name" size="56" value="<%=product.getProduct_name()%>"></td>
			</tr>
			<tr>
				<th>컬러</th>
				<td><input type="text" name="product_color" size="13" value="<%=product.getProduct_color() %>"></td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td><input type="number" name="product_price" min="1000" max="1000000"value="<%=product.getProduct_price() %>">원</td>
			</tr>
			<tr>
				<th>상품 수량</th>
				<td><input type="number" name="product_count" min="0" max="10000" value="<%=product.getProduct_count() %>">권</td>
			</tr>
			
			<tr>
				<th>제조사</th>
				<td><input type="text" name="product_com" size="56" value="<%=product.getProduct_com() %>"></td>
			</tr>
			<tr>
				<th>제조국</th>
				<td><input type="text" name="product_country" size="56" value="<%=product.getProduct_country()%>"></td>
			</tr>
			<tr>
				<th>제조일</th>
				<td><input type="date" name="product_date" value="<%=product.getProduct_date() %>"></td>
			</tr>
			<tr>
				<th>상품 이미지1</th>
				<td>
					<input type="file" name="product_image1"><br>
					<span class="s_p_image1">상품 이미지1를 다시 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>상품 이미지2</th>
				<td>
					<input type="file" name="product_image2"><br>
					<span class="s_p_image1">상품 이미지2를 다시 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>상품 이미지3</th>
				<td>
					<input type="file" name="product_image3"><br>
					<span class="s_p_image1">상품 이미지3를 다시 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>상품 이미지4</th>
				<td>
					<input type="file" name="product_image4"><br>
					<span class="s_p_image1">상품 이미지4를 다시 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>할인율</th>
				<td><input type="number" name="discount_rate" min="0" max="90" value="<%=product.getDiscount_rate() %>">%</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>
				<input type="text" class="c_p_regdate" name="reg_date" value="<%=sdf.format(product.getReg_date()) %>" size="15" readonly>
				<span class="s_p_regdate">등록일은 변경불가</span>
				</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="상품  정보 수정" id="btn_update">
			<input type="button" value="상품 정보 삭제" id="btn_delete">
			<input type="button" value="상품 목록" id="btn_list">
			<input type="button" value="관리자 페이지" id="btn_main">
		</div>
	</form>
</div>
</body>
</html>