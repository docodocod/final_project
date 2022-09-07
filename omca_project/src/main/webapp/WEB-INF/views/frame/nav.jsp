<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/main.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="logo_area">
		<img src="resources/omca.jpg" width=100% height=100%>
	</div>
	<div class="search_area">
		<div id="home" class="menu_bar">홈</div>
		<div id="champion_analysis" class="menu_bar">챔피언 분석</div>
		<div id="champion_synerge" class="menu_bar">듀오 시너지</div>
		<div id="play_report" class="menu_bar">플레이 리포트</div>
		<div id="multi_search" class="menu_bar">멀티서치</div>
		<div id="point_shop" class="menu_bar">포인트샵</div>
		<div id="duo_find" class="menu_bar">듀오찾기</div>
	</div>
	<div class="login_area">
		<!-- 로그인 하지 않은 상태 -->
		<c:if test="${mb == null }">
			<input type="button" class="login_click" value="로그인">
			<input type="button" class="join_click" value="회원가입">
		</c:if>
		<!-- 로그인한 상태 -->
		<c:if test="${ mb != null }">
			<div class="login_success_area">
				<span>회원 : ${mb.m_name}</span> <span>포인트 : ${mb.m_point}</span> <a
					href="/member/logout">로그아웃</a>
			</div>
		</c:if>
	</div>
	<div class="clearfix"></div>
</body>

<script>

	$("#home").click(function() {
		location.href="/"
	});
	
	$("#point_shop").click(function(){
		$.ajax({
			url : "/admin/main",
			async : true,
			type : "GET",
			dataType : "html",
			success : function(data) {
				$('.content_area').children().remove();
				// Contents 영역 교체
				$('.content_area').html(data);
			},
			error: function(err){
				console.log(err);
			}
		
		})
	})

	$(".login_click").click(function() {
		$.ajax({
			url : "/member/loginForm",
			async : true,
			type : "GET",
			dataType : "html",
			success : function(data) {
				$('.content_area').children().remove();
				// Contents 영역 교체
				$('.content_area').html(data);
			},
			error: function(err){
				console.log(err);
			}
		
		})
	})
	
	$(".join_click").click(function() {
		$.ajax({
			url : "/member/joinForm",
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
</script>

</html>