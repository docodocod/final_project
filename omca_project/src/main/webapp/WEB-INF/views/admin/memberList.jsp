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
	<table border="1">
		<thead>
			<tr align="center">
				<td>챔피언 닉네임</td>
				<td>아이디</td>
				<td>이메일</td>
				<td>핸드폰 번호</td>
				<td>포인트</td>
				<td>관리자 권한</td>
				<td>수정/삭제</td>
			</tr>
		</thead>
		<c:forEach items="${mb}" var="mb">
			<tr align="center">
				<td><c:out value='${mb.m_name}'></c:out></td>
				<td><c:out value='${mb.m_id}'></c:out></td>
				<td><c:out value='${mb.m_email}'></c:out></td>
				<td><c:out value='${mb.m_phone}'></c:out></td>
				<td><c:out value='${mb.m_point}'></c:out></td>
				<td><c:out value='${mb.m_admin}'></c:out></td>
				<td colspan="2"><input type="submit" value="수정"></input>
				<input type="submit" value="삭제"></input></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>