<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/admin_main.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
</head>
<body>
	<div class="wrapper">
		<!-- contents-area -->
		<div class="admin_wrap">
			<!-- 네비영역 -->
			<div class="admin_navi_wrap">
				<ul>
					<li><a class="admin_list_01" href="/admin/productManage">상품 관리</a></li>
					<lI><a class="admin_list_05" href="/admin/memberList">회원 관리</a></lI>
				</ul>
			</div>
			<div class="admin_content_wrap">
				<div>관리자 페이지 입니다.</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</body>
<script>
	$(document).ready(function() {

		let result = '<c:out value="${enroll_result}"/>';

		checkResult(result);
		function checkResult(result) {

			if (result === '') {
				return;
			}
			alert("상품'${enroll_result}' 을 등록하였습니다.");
		}

		let delete_result = '${delete_result}';

		if (delete_result == 1) {
			alert("삭제 완료");
		}
	});

</script>
</html>
