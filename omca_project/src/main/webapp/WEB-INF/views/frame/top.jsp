<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/main.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<ul class="list">
		<c:if test="${mb == null}">
			<li><a href="/member/loginForm">로그인</a></li>
			<li><a href="/member/joinForm">회원가입</a></li>
		</c:if>
		<c:if test="${mb != null}">
			<c:if test="${mb.m_admin==1}">
				<li><a id="admin_page" href="/admin/main">관리자 페이지</a></li>
			</c:if>
			<li><a id="gnb_logout_button">로그아웃</a></li>
			<li><a href="/member/">마이페이지</a></li>
		</c:if>
		<li>고객센터</li>
	</ul>
</body>
<script>
/* 	/* gnb_area 로그아웃 버튼 작동 */
	$("#gnb_logout_button").click(function() {
		$.ajax({
			type : "POST",
			url : "logout.do",
			success : function(data) {
				alert("로그아웃 성공");
				document.location.reload();
			}
		}) // ajax 
	})
</script>
</html>