<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="mall.member.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 확인 폼</title>
<style>

@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hammersmith+One&family=Nanum+Brush+Script&family=Paytone+One&display=swap');

#container{width:95%; margin:0 auto;}
a{text-decoration:none; color:black;}
input[type="text"],[type="password"]{height:20px;}

/* 상단 - 메인, 서브 타이틀  */

.t_title{font-family: 'Do Hyeon', sans-serif;font-size:2.3em;  color: #5ad2ff; text-align:center;margin:30px 0;}

/* 중단 - 입력 테이블   */

table{width:600px; border-collapse:collapse;  margin:0 auto;}
tr{height:70px;}
td,th{border-bottom: 1px solid #fff;}
td{padding-left:10px; background: lightgray;}
th{background:#5ad2ff; color: white;}
.c_id{background:#5ad2ff;}
.s_id{color:red; font-size: 0.9em; padding-left:5px; }
.addr_row{height:100px;}
.addr_row input{margin:2px 0;}
#btn_address{width:110px; height:28px; border:none; background:#5ad2ff;  font-size:12px;
cursor:pointer; border-radius:8px; color: #fff; font-weight:bold; }
table span{font-size:11px;}

/* 하단 - 가입, 취소 버튼*/

.btns{text-align:center;margin-top:30px;}
.btns input[type="button"]{width:120px; height:40px;background: #5ad2ff; color:white;border:none;
font-size:1em; font-weight:bold; cursor:pointer; border-radius: 5px;}

.t_line{border: 1px solid #e9ecef; margin:30px 0px;}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<script>

document.addEventListener("DOMContentLoaded",function(){
	let form = document.infoForm;
	
	//비밀번호 유효성 검사 - 8글자 이상 입력하도록
	form.pwd.addEventListener("keyup", function(){
		let chk_pwd = document.getElementById("chk_pwd");
		if(form.pwd.value.length <4){
			chk_pwd.innerHTML = "비밀 번호는 4글자 이상이어야 합니다.";
			chk_pwd.style.color= "red";
		}else{
			chk_pwd.innerHTML = "사용 가능한 비밀번호입니다.";
			chk_pwd.style.color= "blue";
		}
	})
	// 비밀번호 확인 - pwd2
	// 비밀번호와 비밀번호 확인과 내용이 같은 지 판다.
	form.pwd2.addEventListener("keyup", function(){
		let chk_pwd2 = document.getElementById("chk_pwd2");
		if(form.pwd.value==form.pwd2.value){
			chk_pwd2.innerHTML="비밀번호가 일치합니다."
			chk_pwd2.style.color="blue";
		}else{
			chk_pwd2.innerHTML="비밀번호가 다릅니다.";
			chk_pwd2.style.color="red";
		}
	})

	//이메일 검사 함수
	let isEmail = function(value){
		return (value.indexOf('@') > 2)&& (value.split('@')[1].indexOf('.')>2)
	}

	
	// 이메일 확인
	// 1. '@'문자를 포함하고 있는지의 여부 -> 아이디가 세글자 이상인지 판별
	// 2. '@'문자 다음에 ','을 포함하고 있는지의 여부 -> 회사이름도 3글자 이상인지를 판별한다.
	let chk_email = document.getElementById("chk_email");
	form.email.addEventListener("keyup",function(event){
		let value = event.currentTarget.value;
		if(isEmail(value)){    //이메일 형식이 맞을 때
			chk_email.innerHTML = "이메일 형식이 맞습니다. : " + value;
			chk_email.style.color="blue";
		}else{   // 이메일 형식이 아닐 때
			chk_email.innerHTML = "이메일 형식이 아닙니다. : "+ value;
			chk_email.style.color="red";
		} 
	})
	
	// 주소 찾기 버튼  - 다음 라이브러리 활용
	let btn_address = document.getElementById("btn_address");
	// daum의 라이브러리를 활용한 주소 찾기 문법
	btn_address.addEventListener("click",function(){
		new daum.Postcode({
			oncomplete:function(data) {
				form.address.value = data.address;
				
			}
		}).open();
	})
	
	//회원 정보 수정 버튼을 클릭 할 때
	// 회원 정보 수정 페이지의 전체 내용 입력 유무에 따른 유효성 검사와 페이지 이동 처리
	let btn_update = document.getElementById("btn_update");
	btn_update.addEventListener("click",function(){
		
		if(form.pwd.value.length == 0){
			alert(`비밀번호를 입력하시오!`);
			form.pwd.focus();
			return;
		}
		if(form.pwd2.value.length == 0){
			alert(`비밀번호 확인을 하시오!`);
			form.pwd2.focus();
			return;
		}
		if(form.pwd.value != form.pwd2.value){
			alert(`비밀번호와 비밀번호 확인이 다릅니다.`);
			form.pwd2.focus();
			return;
		}
		if(form.name.value.length == 0){
			alert(`이름을 입력하시오`);
			form.name.focus();
			return;
		}
		if(form.email.value.length == 0){
			alert(`이메일을 입력하시오!`);
			form.email.focus();
			return;
		}
		if(form.tel.value.length == 0){
			alert(`전화번호를 입력하시오!`);
			form.tel.focus();
			return;
		}
		if(form.address.value.length == 0){
			alert(`주소 찾기 버튼을 클릭하여 도로명 주소를 선택하시오!`);
			form.address.focus();
			return;
		}
		if(form.address2.value.length == 0){
			alert(`상세주소를 입력하시오!`);
			form.address2.focus();
			return;
		}
		form.submit();
	})
	
	//  회원 탈퇴 버튼을 클릭 할 때 회원 탈퇴(삭제)
	let btn_delete = document.getElementById("btn_delete");
	btn_delete.addEventListener("click", function(){
		if(!form.id.value){
			alert('아이디를 입력하시오!');
			form.id.focus();
			return;
		}
		if(!form.pwd.value){
			alert('비밀번호를 입력하시오!');
			form.pwd.focus();
			return;
		}
		if(!form.pwd2.value){
			alert('비밀번호 확인을 입력하시오!');
			form.pwd2.focus();
			return;
		}
		if(form.pwd.value != form.pwd2.value){
			alert('비밀번호가 일치하지 않습니다.');
			form.pwd2.focus();
			return;
		}
		let answer = confirm('정말 회원을 탈퇴하겠습니까?');
		if(answer){
			form.action = 'memberDeletePro.jsp';
			form.submit();
		}else{
			return;
		}
	
	})
	
		
})

</script>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>location='../logon/memberLoginForm.jsp' </script>");
	
}

// 아래는 session memberID가 있을 때 실행
MemberDAO memberDAO = MemberDAO.getInstance();
MemberDTO member = new MemberDTO();
member = memberDAO.getMember(memberId);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<div id="container">
	<jsp:include page="../common/shopTop.jsp"></jsp:include>
	<div class="t_title">회원 정보 확인</div>
	
	<form action="memberUpdatePro.jsp" method="post" name="infoForm">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="id" size="15" value="<%=member.getId() %>" readonly class="c_id">
					&emsp;<span class="s_id">아이디는 변경불가</span>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pwd" size="15" value="<%=member.getPwd() %>"><br>
					<span id="chk_pwd"></span>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="pwd2" size="15"><br>
					<span id="chk_pwd2"></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" size="15" value="<%=member.getName() %>"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email" size="30" value="<%=member.getEmail() %>"><br>
					<span id="chk_email"></span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel" size="20" value="<%=member.getTel() %>"></td>
			</tr>
			<tr class="addr_row">
				<th>주소</th>
				<td>
					<input type="button" value="주소 찾기" id="btn_address"><br>
					<input type="text" name="address" size="50"><br>
					<input type="text" name="address2" size="50">
				</td>
			</tr>	
			<tr>
				<th>가입 일시</th>
				<td>
					<%=sdf.format(member.getRegDate()) %>
				</td>
			</tr>	
		</table>
		<div class="btns">
			<input type="button" value="회원정보수정" id="btn_update" name="btn">&emsp;&emsp;&emsp;&emsp;
			<input type="button" value="회원탈퇴" id="btn_delete">
		</div>
	</form>
	<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp"></jsp:include>
</div>	
</body>
</html>