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
		<div class="wrap">
			<!-- gnv_area -->
			<div class="top_gnb_area">
				<ul class="list">
					<li><a href="/">메인 페이지</a></li>
					<li><a href="/member/logout">로그아웃</a></li>
					<li>고객센터</li>
				</ul>
			</div>
			<!-- top_subject_area -->
			<div class="admin_top_wrap">
				<span>관리자 페이지</span>
			</div>
			<!-- contents-area -->
			<div class="admin_wrap">
				<!-- 네비영역 -->
				<div class="admin_navi_wrap">
					<ul>
						<li><a class="admin_list_01">상품 등록</a></li>
						<li><a class="admin_list_02">상품 목록</a></li>
						<li><a class="admin_list_03" href="productDelete">상품 삭제</a></li>
						<lI><a class="admin_list_05" href="memberManage">회원 관리</a></lI>
					</ul>
					<!-- 
                    <div class="admin_list_01">
                        <a>상품 관리</a>
                    </div>
                     -->
				</div>
				<div class="admin_content_wrap">
					<div>관리자 페이지 입니다.</div>
				</div>
				<div class="clearfix"></div>
			</div>
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

	$(".admin_list_01").click(function() {
		$.ajax({
			url : "/admin/productEnroll",
			async : true,
			type : "GET",
			dataType : "html",
			success : function(data) {
				$('.content_area').children().remove();
				// Contents 영역 교체
				$('.content_area').html(data);
			}
		})
	})

	$(".admin_list_02").click(function() {
		$.ajax({
			url : "/admin/productManage",
			async : true,
			type : "GET",
			dataType : "html",
			success : function(data) {
				$('.content_area').children().remove();
				$('.content_area').html(data);
			}
		})
	})
</script>
</html>
