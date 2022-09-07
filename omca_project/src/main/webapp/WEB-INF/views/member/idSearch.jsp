<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="id_search_wrap">
		<form action="idSearchForm" method="post">
			<span>아이디 찾기</span>
			<div class="id_search_input_box">
				<span>가입한 이메일을 입력하세요.</span> <input class="mail_input"
					name="m_email"> <span>가입한 핸드폰 번호를 입력하세요.</span> <input
					class="phone_input" name="m_phone">
			</div>
			<input type="submit" value="아이디 찾기">
			<!-- 이름과 비밀번호가 일치하지 않을 때 -->
			<c:if test="${check == 0 }">
				<span>찾으시는 아이디는' ${m_id}' 입니다.</span>
			</c:if>
		</form>
	</div>
</body>
</html>