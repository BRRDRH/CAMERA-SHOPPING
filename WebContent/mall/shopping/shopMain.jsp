<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*, java.text.*" %>
<%-- 쇼핑몰 메인 페이지 : 상품이 나열되는 페이지 --%>
<%-- 상품의 분류별 전체 보기 --%>

<style>
/* 상품 분류  */
.t_kind{margin:30px auto; width:1600px; }
.d_kind1{text-align:right; margin-left:20px; margin-bottom:10px;}
.d_kind1 .s_kind1 {display:inline-block; float:left;}
.d_kind1 .s_kind11{font-size: 1.2em; color:navy;}
.d_kind1 .s_kind2 select {margin-right:40px; width:150px; height:25px;}
.d_kind2 {margin-left:20px; margin-bottom:10px;}
.d_kind2 .s_kind21{color: #f1617d;}


/* 상품 분류별 노출  */
.d_kind3 {   float: left; text-align: center; margin-right: 28px; position:relative; font-size:0.9em;}
.d_kind3 a {text-decoration:none; color:black;}
.c_product{display:inline-block; margin: 15px;  border:3px solid lightgray; width: 400px; height: 400px; 
padding:10px; cursor: pointer;}
.d_kind3:nth-child(3n) { margin-left: 90px;}
.c_product .c_p2, .c_product .c_p4 { font-weight:bold; }
.c_product .c_p2 { font-size: 20px; text-align: left;  margin-left: 21px; color: #ff607f; }
.c_product .c_p3{font-size:1.1em; text-align: left; margin-left: 21px; font-weight: bold; margin-top: 8px;}
.c_product .c_p3, .c_product .c_p2 {white-space:nowrap; overflow:hidden; text-overflow:ellipsis;}
.c_product .c_p4 { font-size: 25px; font-weight: bold; text-align: left; margin-left: 20px; margin-top: 10px;}
.c_product .s_p_discount{color: #ff607f;}
.c_product .s_p_price { font-size: 17px; font-weight: bold; text-decoration: line-through;}


/* 페이징 영역 */
#paging{text-align:center; margin-top:20px; clear:both;}
#paging a {color :#000;}
#pBox{display:inline-block; width:22px; height:22px;padding:5px; margin:5px;}
#pBox:hover{background:#f1617d; color:white; font-weight:bold;border-radius:50%; cursor:pointer;}
.pBox_c{background:#f1617d; color:white; font-weight:bold;border-radius:50%;}
.pBox_b{font-weight:900px;}
.f_row{text-align:center; font-weight:bold; color:#c84557}

.main_end{margin:60px 0 20px;}

</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let product_kind = document.getElementById("product_kind");
	
	// 상품 분류 선택에 대한 change 이벤트 처리
	product_kind.addEventListener("change", function(event){
		location = 'shopAll.jsp?product_kind='+product_kind.value+"&#t_kind";
	})
	

	
	
	
	
})
</script>
<%
request.setCharacterEncoding("utf-8");
DecimalFormat df = new DecimalFormat("#,###,###");

String product_kind = request.getParameter("product_kind");
if(product_kind == null) product_kind = "110";

// 상품 붐류별 상품명 설정
String product_kindName="";
switch(product_kind){
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

ProductDAO productDAO = ProductDAO.getInstance();

//########## 페이징(paging) 처리 ##########
//페이징(paging) 처리를 위한 변수 선언
int pageSize = 9; // 1페이지에 12건의 게시글을 보여줌.
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1";                // 페이지 번호가 없다면 1페이지로 설정

int currentPage = Integer.parseInt(pageNum);    // 현재 페이지
int startRow = (currentPage -1) * pageSize + 1; // 현재 페이지의 첫번째 행
int endRow = currentPage * pageSize;            // 현재 페이지의 마지막 행
//##########                  ##########

// 총 상품 수
// 분류별 상품에 대한 페이징 처리
int cnt = productDAO.getProductCount(product_kind);
List<ProductDTO> productList = productDAO.getProductList(startRow, pageSize, product_kind); 
//cnt = productDAO.getProductCount();




%>
<%-- 분류별 상품을 4개씩 3단으로 처리 --%>
<div class="t_kind" id="t_kind"> 
	<div class="d_kind1">
		<span class="s_kind1"><b class="s_kind11"><%=product_kindName %></b> 분야 상품 목록</span>
		<span class="s_kind2">
			<select id="product_kind">
				<option value="110" <% if(product_kind.equals("110")) {%> selected <%} %>>Kodak</option>
				<option value="120" <% if(product_kind.equals("120")) {%> selected <%} %>>Polaroid</option>
				<option value="130" <% if(product_kind.equals("130")) {%> selected <%} %>>Lomography</option>
				<option value="210" <% if(product_kind.equals("210")) {%> selected <%} %>>Colley</option>
				<option value="220" <% if(product_kind.equals("220")) {%> selected <%} %>>캔디 카메라</option>
				<option value="230" <% if(product_kind.equals("230")) {%> selected <%} %>>하이라라</option>
				<option value="310" <% if(product_kind.equals("310")) {%> selected <%} %>>Canon</option>
				<option value="320" <% if(product_kind.equals("320")) {%> selected <%} %>>SONY</option>
				<option value="410" <% if(product_kind.equals("410")) {%> selected <%} %>>Nikon</option>
				<option value="420" <% if(product_kind.equals("420")) {%> selected <%} %>>Panasonic</option>
				<option value="510" <% if(product_kind.equals("510")) {%> selected <%} %>>파우치</option>
				<option value="520" <% if(product_kind.equals("520")) {%> selected <%} %>>앨범</option>
			</select>
		</span>
	</div>
	<div class="d_kind2">상품 수 : 총  <b class="s_kind21"><%=cnt %></b>건</div>
		<%for(ProductDTO product : productList) {
			// 판매가 계산
			int price = product.getProduct_price();
			int d_rate = product.getDiscount_rate();
			int sale_price = price - (price * d_rate/100);
			
		%>
			<div class="d_kind3">
				<div class="c_product">
				<a href="shopContent.jsp?product_id=<%=product.getProduct_id() %>">
					<div class="c_p1"><img src="/images_camera/<%=product.getProduct_image1() %>" name="camera_image" width="320" height="300" class= "images"></div>
					<div class="c_p2"><span title="<%=product.getProduct_com() %>"><%=product.getProduct_com() %></span></div>
					<div class="c_p3"><span title="<%=product.getProduct_name() %>"><%=product.getProduct_name() %></span> </div>
					<div class="c_p4">
						<span class="s_p_discount"><%=product.getDiscount_rate() %>%</span>&ensp;
						<span><%=df.format(sale_price) %>원</span> 
						<span class="s_p_price"><%=df.format(price) %></span>
					</div>
				</a>
				</div>
			</div>
		<%} %>
		<div id="paging">
		<%
		if(cnt > 0) {
			int pageCount = cnt / pageSize + (cnt%pageSize==0 ? 0 : 1); // 전체 페이지수
			int startPage = 1;  // 시작 페이지 번호
			int pageBlock = 3; // 페이징의 개수
			
			// 시작 페이지 설정
			if(currentPage % 3 != 0) startPage = (currentPage/3) * 3 + 1;
			else startPage = (currentPage/3-1) * 3 + 1;
				
			// 끝 페이지 설정
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;
			
			// 맨 처음 페이지 이동 처리
			if(startPage > 3){
				out.print("<a href='shopAll.jsp?pageNum=1&product_kind="+product_kind+"#t_kind'><div id='pBox' class='pBox_b' title='첫 페이지'>" + "〈〈" + "</div></a>");
			}
			
			
			// 이전 페이지 처리
			if(startPage > 3){
				out.print("<a href='shopAll.jsp?pageNum="+(currentPage-3)+"&product_kind="+product_kind+"#t_kind' title='다음 3페이지'><div id='pBox' class='pBox_b'>" + "〈" + "</div></a>");
			}
			
			
			
			// 페이징 블럭 출력 처리
			for(int i=startPage; i<=endPage; i++) {
				if(currentPage == i){    // 선택된 페이지가 현재 페이지일 때
					out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");
				}else{                   // 다른 페이지로 이동하고자 할 때 -> 이동에 대한 링크 설정
					out.print("<a href='shopAll.jsp?pageNum="+ i+"&product_kind="+product_kind+"#t_kind'><div id='pBox'>" + i + "</div></a>");
				}
			}
			
			// 다음 페이지 처리
			if(endPage < pageCount ){
				int movePage = currentPage + 3;
				if(movePage > pageCount) movePage = pageCount;
				out.print("<a href='shopAll.jsp?pageNum="+movePage+"&product_kind="+product_kind+"#t_kind' title='다음 3페이지'><div id='pBox' class='pBox_b'>" + "〉" + "</div></a>");
			}
			
			// 맨 끝 페이지 이동 처리
			if(endPage < pageCount){
				out.print("<a href='shopAll.jsp?pageNum="+pageCount+"&product_kind="+product_kind+"#t_kind' title='마지막 페이지'><div id='pBox' class='pBox_b'>" + "〉〉" + "</div></a>");
			}
		}
		%>
		</div>
	
	<div class="main_end"></div>
	<hr>
	<br>

</div>


