<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.bank.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="bank" class="mall.bank.BankDTO"/>
<jsp:setProperty property="*" name="bank"/>
<%
request.setCharacterEncoding("utf-8");
String member_id = (String)session.getAttribute("memberId");
if(member_id == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location = '../mall/logon/memberLoginForm.jsp';</script>");
	return;
}

String cart_id = request.getParameter("cart_id");

BankDAO bankDAO = BankDAO.getInstance();
bankDAO.insertBank(bank);

response.sendRedirect("../buy/buyForm.jsp?cart_id=" + cart_id);


%>
</body>
</html>