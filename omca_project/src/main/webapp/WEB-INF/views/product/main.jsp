<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트샵</title>
<link rel="stylesheet" href="/resources/adminmanage.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<h1>포인트 샵</h1>
	<div class="goods_table_wrap">
		<form id="pr_Form" action="/admin/productEnroll" method="get">
			<input type="submit" class="product_enroll" value="상품 등록하기">
		</form>
		<!-- 상품 리스트 O -->
		<%-- 		<c:if test="${listcheck != 'empty'}"> --%>

		<c:forEach items="${list}" var="list">
				<table class="goods_table" border="1">
					<tr>
						<td colspan="2"><c:out value='${list.p_img}'></c:out></td>
					</tr>
					<tr>
						<td colspan="2"><c:out value='${list.p_name}'></c:out></td>
					</tr>
					<tr>
						<td colspan="2"><c:out value='${list.p_price}'></c:out></td>
					</tr>
					<c:if test='${mb.m_admin == 1}'>
						<tr>
							<td><button id="modifyBtn" class="btn_modify_btn">수정</button></td>
							<td><button id="deleteBtn" class="btn_delete_btn">삭제</button></td>
						</tr>
					</c:if>
					<c:if test='${mb.m_admin == 0 }'>
						<tr>
							<td colspan="2"><input type="button" class="buy_btn"
								value="구매"></td>
							<td><input type="button" id="delete" class="cart_btn"
								value="장바구니 담기"></td>
						</tr>
					</c:if>
				</table>
		</c:forEach>
		<div class="search_wrap">
                		<form id="searchForm" action="/search" method="get">
                			<div class="search_input">
                				<input type="text" name="keyword">
                    			<button class='btn search_btn'>검 색</button>                				
                			</div>
                		</form>
                	</div>
		<!-- 페이지 이동 인터페이스 영역 -->
		<div class="pageMaker_wrap">

			<ul class="pageMaker">

				<!-- 이전 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageMaker_btn prev"><a
						href="${pageMaker.pageStart - 1}">이전</a></li>
				</c:if>

				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}"
					var="num">
					<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
						<a href="/admin/productManage?pageNum=${num}%amount=10">${num}</a>
					</li>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageMaker_btn next"><a
						href="${pageMaker.pageEnd + 1 }">다음</a></li>
				</c:if>

			</ul>

		</div>
		<form id="moveForm" action="/admin/productManage" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
	</div>
</body>
</html>