<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/adminmanage.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="goods_table_wrap">
		<input type="button" class="product_enroll" value="상품 등록하기">
		<!-- 상품 리스트 O -->
		<%-- 		<c:if test="${listcheck != 'empty'}"> --%>
		<c:forEach items="${list}" var="list">
			<table class="goods_table" border="1">
				<tr>
					<td colspan="2"><c:out value="${list.p_img}"></c:out></td>
				</tr>
				<tr>
					<td colspan="2"><c:out value="${list.p_name}"></c:out></td>
				</tr>
				<tr>
					<td colspan="2"><c:out value="${list.p_price}"></c:out></td>
				</tr>
				<c:if test="${mb.m_admin == 1}">
				<tr>
					<td colspan="2"><input type="button" class="modify" value="수정"></td>
					<td><button id="deleteBtn" class="btn_delete_btn">삭 제</button></td>
				</tr>
				</c:if>
				<c:if test="${mb.m_admin == 0 }">
				<tr>
					<td colspan="2"><input type="button" class="buy_btn" value="구매"></td>
					<td><input type="button" id="delete" class="cart_btn" value="장바구니 담기"></td>
				</tr>
				</c:if>
				<!-- <tr>
						<td class="th_column_1">상품 번호</td>
						<td class="th_column_2">상품 이름</td>
						<td class="th_column_3">상품 가격</td>
						<td class="th_column_4">상품 개수</td>
					</tr> -->
				<%-- <c:forEach items="${list}" var="list">
						<tr>
							<td><c:out value="${list.p_id}"></c:out></td>
							<td><c:out value="${list.p_name}"></c:out></td>
							<td><c:out value="${list.p_price}"></c:out></td>
							<td><c:out value="${list.p_count}"></c:out></td>
						</tr>
					</c:forEach> --%>
			</table>
		</c:forEach>
	</div>
	<%-- </c:if>
		<!-- 상품 리스트 X -->
		<c:if test="${listCheck == 'empty'}">
			<div class="table_empty">등록된 상품이 없습니다.</div>
		</c:if>
	</div>

	<!-- 검색 영역 -->
	<div class="search_wrap">
		<div class="search_input">
			<input type="text" name="keyword"
				value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
			<button class='search_btn'>검 색</button>
		</div>
	</div>

	<form id="moveForm" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	</form>

	<!-- 페이지 이름 인터페이스 영역 -->
	<div class="pageMaker_wrap">
		<ul class="pageMaker">

			<!-- 이전 버튼 -->
			<c:if test="${pageMaker.prev }">
				<li class="pageMaker_btn prev"><a
					href="${pageMaker.pageStart -1}">이전</a></li>
			</c:if>

			<!-- 페이지 번호 -->
			<c:forEach begin="${pageMaker.pageStart }"
				end="${pageMaker.pageEnd }" var="num">
				<li
					class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
					<a href="${num}">${num}</a>
				</li>
			</c:forEach>

			<!-- 다음 버튼 -->
			<c:if test="${pageMaker.next}">
				<li class="pageMaker_btn next"><a
					href="${pageMaker.pageEnd + 1 }">다음</a></li>
			</c:if>
		</ul>
	</div> --%>
</body>
<script>
	/* $(".search_btn").click(function() {
	let val = $("input[name='keyword']')").val();
	moveForm.find("input[name='keyword']").val(val);
	moveForm.find("input[name='pageNum']").val(1);
	moveForm.submit();
	}) */
	$(".product_enroll").click(function() {
		$.ajax({
			url : "/admin/productEnroll",
			dataType : "html",
			async : true,
			type : "GET",
			success : function(data) {
				$('.content_area').children().remove();
				// Contents 영역 교체
				$('.content_area').html(data);
			}
		})
	})
	
	$(".deleteBtn").on("click", function(e){
		e.preventDefault();
		let moveForm = $("#moveForm");
		moveForm.find("input").remove();
		moveForm.append('<input type="hidden" name="p_id" value="${Product.p_id}">');
		moveForm.attr("action", "/admin/productDelete");
		moveForm.attr("method", "post");
		moveForm.submit();
	});
	
	let delete_result = '${delete_result}';
	
	if(delete_result == 1){
		alert("삭제 완료");
	}
</script>
</html>