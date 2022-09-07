<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/loginForm.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

</head>
<body>
	<form action="/member/login" id="login" method="post">

		<div class="wrapper">

			<div class="wrap">
				<div class="logo_wrap">
					<span>OMCA_LOGIN</span>
				</div>
				<div class="login_wrap">
					<div class="id_wrap">
						<div class="id_input_box">

							<input class="id_input" name="m_id">
						</div>
					</div>
				</div>
				<div class="pw_wrap">
					<div class="pw_input_box">
						<input type="password" class="pw_iput" name="m_password">
					</div>
				</div>
				<div class="id_search">
					<div class="id_search_box">
						<span><a href="idSearch">아이디 찾기</a></span>
					</div>
				</div>
				<div class="pw_search">
					<div class="pw_search_box">
						<span><a href="pwSearch">비밀번호 찾기</a></span>
					</div>
				</div>

				<c:if test="${result == 0 }">
					<div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
				</c:if>
				<div class="login_button_wrap">
					<input type="submit" class="login_button" value="로그인">
				</div>
			</div>


		</div>


	</form>

</body>
</html>