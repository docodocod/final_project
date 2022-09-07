<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트샵</title>
</head>
<body>
	<h1>포인트 샵</h1>
	<table>
		<c:forEach var="list" items="${list}">
		<tr height="30">
			<td align="center">${list. }</td>
			<td align="center">${list. }</td>
			<td align="center"></td>
			<td align="center"></td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>