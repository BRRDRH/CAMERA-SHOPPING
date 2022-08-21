<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.bank.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>은행 카드 삭제</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String member_id = (String)session.getAttribute("memberId");
if(member_id == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location = '../mall/logon/memberLoginForm.jsp';</script>");
	return;
}

String  product_id = null;
String cart_id = null;
String buy_count = null;

product_id = request.getParameter("product_id");
cart_id = request.getParameter("cart_id");
buy_count = request.getParameter("buy_count");
String card_no =request.getParameter("card_no");
String part = request.getParameter("part");

BankDAO bankDAO = BankDAO.getInstance();
bankDAO.deleteBank(card_no);

if(cart_id == null) {
	response.sendRedirect("../buy/buyForm.jsp?product_id="+product_id+"&buy_count=" + buy_count + "&part=" + part);
} else if(product_id == null){
	response.sendRedirect("../buy/buyForm.jsp?cart_id="+cart_id+ "&part=" + part);
}




%>
</body>
</html>