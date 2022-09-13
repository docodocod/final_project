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
		<form id="pr_Form" action="/admin/productEnroll" method="get">
			<input type="submit" class="product_enroll" value="상품 등록하기">
		</form>
		<!-- 상품 리스트 O -->
		<%-- 		<c:if test="${listcheck != 'empty'}"> --%>

		<c:forEach items="${list}" var="list">
			<table class="goods_table" border="1">
				<tr>
					<td>
						<div class="image_wrap" data-p_id="${list.imageList[0].p_id}"
							data-path="${list.imageList[0].uploadPath}"
							data-uuid="${list.imageList[0].uuid}"
							data-filename="${list.imageList[0].fileName}">
							<img>
						</div>
					</td>
				</tr>
				<tr>
					<td><c:out value='${list.p_img}'></c:out></td>
				</tr>
				<tr>
					<td><c:out value='${list.p_name}'></c:out></td>
				</tr>
				<tr>
					<td><c:out value='${list.p_price}'></c:out></td>
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
						<a href="${num}">${num}</a>
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
<script>
	let moveForm = $('#moveForm');
	let searchForm = $('#searchForm');

	/* 페이지 이동 버튼 */
	$(".pageMaker_btn a").on("click", function(e) {
		e.preventDefault();
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		moveForm.submit();
	});

	/* 상품 검색 버튼 동작 */
	$("#searchForm button").on("click", function(e) {

		e.preventDefault();

		/* 검색 키워드 유효성 검사 */
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하십시오");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		searchForm.submit();

	});
	let p_id = "147";
	let uploadReslut = $("#uploadReslut");
	$
			.getJSON(
					"/product/getAttachList",
					{
						p_id : p_id
					},
					function(arr) {
						let str = "";
						let obj = arr[0];

						let fileCallPath = encodeURIComponent(obj.uploadPath
								+ "/s_"
								+ obj.uuid
								+ "_"
								+ obj.fileName);
						str += "<div id='result_card'";
str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
str += ">";
						str += "<img src='/product/display?fileName="
								+ fileCallPath + "'>";
						str += "</div>";
						uploadReslut.html(str);
					})

	$(document)
			.ready(
					function() {
						/* 이미지 정보 호출 */
						
						/* 이미지 삽입 */
						$(".image_wrap")
								.each(
										function(i, obj) {

											const bobj = $(obj);

											const uploadPath = bobj
													.data("path");
											const uuid = bobj.data("uuid");
											const fileName = bobj
													.data("filename");

											const fileCallPath = encodeURIComponent(uploadPath
													+ "/s_"
													+ uuid
													+ "_"
													+ fileName);

											$(this).find("img").attr(
													'src',
													'/product/display?fileName='
															+ fileCallPath);

										});
					});
</script>
</html>