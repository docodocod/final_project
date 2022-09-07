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
	<div class="pw_search_wrap">
		<form action="pwSearchForm" method="post">
			<span>비밀번호 찾기</span>
			<div class="id_search_input_box">
				<span>가입한 아이디를 입력하세요.</span> <input class="mail_input" name="m_id">
				<span>가입한 핸드폰 번호를 입력하세요.</span> <input class="phone_input"
					name="m_phone">
			</div>
			<input type="submit" value="비밀번호 찾기">
		</form>
		<c:if test="${check == 0 }">
			<form action="pwUpdateForm" method="post">
				<div>
					<label>비밀번호를 변경해주세요.</label>
				</div>
				<div class="form-label-group">
					<input type="hidden" id="id" name="m_id" value="${m_id } ">

					<input type="password" id="password" name="m_password"
						class="form-control" /> <label for="password">password</label>
				</div>

				<div class="form-label-group">
					<input type="password" id="confirmpassword" name="confirmpwd"
						class="form-control" /> <label for="confirmpassword">confirm
						password</label>
				</div>
				<div class="form-label-group">
					<input class="pw_update_btn" type="submit" value="비밀번호 변경하기">
				</div>
			</form>
		</c:if>
	</div>
</body>

</html>