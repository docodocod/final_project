<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>omca.main</title>
<link rel="stylesheet" href="/resources/main.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>

<div class="wrapper">
	<div class="wrap">
		<div class="top_gnb_area">
			<jsp:include page="frame/top.jsp"></jsp:include>
		</div>
		<div class="top_area">
			<jsp:include page="frame/nav.jsp"></jsp:include>
		</div>
		<div class="content_area">
			<jsp:include page="frame/bottom.jsp"></jsp:include>
		</div>
		<div class="footer_are">
			<jsp:include page="frame/footer.jsp"></jsp:include>
		</div>
	</div>
</div>
</body>
</html>