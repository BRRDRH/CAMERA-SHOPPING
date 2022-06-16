<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="util.*, manager.logon.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리</title>
</head>
<body>
<%
String managerId = request.getParameter("managerId");
String managerPwd = request.getParameter("managerPwd");
ManagerDAO managerDAO = ManagerDAO.getInstance();

int cnt = managerDAO.checkManager(managerId, managerPwd);

out.print("<script>");
if(cnt == 1){
	session.setAttribute("managerId", managerId);
	out.print("alert(`로그인 성공`);location='../managerMain.jsp'");
} else {
	out.print("alert(`로그인 실패`);history.back();");
}
out.print("</script>");

%>

</body>
</html>