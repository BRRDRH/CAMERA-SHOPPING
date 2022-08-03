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

String member_id = (String)session.getAttribute("memberId");
if(member_id == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location = '../mall/logon/memberLoginForm.jsp';</script>");
	return;
}
String cart_id = request.getParameter("cart_id");
String card_no = request.getParameter("card_no");

BankDAO bankDAO = BankDAO.getInstance();
bankDAO.deleteBank(member_id, card_no);


response.sendRedirect("../buy/buyForm.jsp?cart_id="+cart_id);



%>
</body>
</html>