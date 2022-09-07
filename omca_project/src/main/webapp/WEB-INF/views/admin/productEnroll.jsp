<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/adminenroll.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="admin_content_main">
		<form action="/admin/Enroll" method="get" id="enrollForm">
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 이름</label>
				</div>
				<div class="form_section_content">
					<input name="p_name">
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 이미지</label>
				</div>
				<div class="form_section_content"></div>
				<input type="file" id="fileItem" name='p_img' style="height: 30px;">
				<div id="uploadResult"></div>
				<!-- <div id="result_card">
					<div class="imgDeleteBtn">x</div>
					<img src="/resources/img/Logo.png">
				</div> -->
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 가격</label>
				</div>
				<div class="form_section_content">
					<input name="p_price">
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 개수</label>
				</div>
				<div class="form_section_content">
					<input name="p_count">
				</div>
			</div>
		</form>
		<div class="btn_section">
			<button id="cancelBtn" class="btn">취 소</button>
			<button id="enrollBtn" class="btn enroll_btn">등 록</button>
		</div>
	</div>
</body>
<script>
	let enrollForm = $("#enrollForm")

	/* 취소 버튼 */
	$("#cancelBtn").click(function() {

		location.href = "/admin/productManage"

	});

	/* 상품 등록 버튼 */
	$("#enrollBtn").on("click", function(e) {
		e.preventDefault();
		enrollForm.submit();
	});

	/* 이미지 업로드 */
	$("input[type='file']").on("change", function(e) {
		let formData = new FormData();
		let fileInput = $('input[name="p_img"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];

		if (!fileCheck(fileObj.name, fileObj.size)) {
			return false;
		}
		formData.append("p_img", fileObj);

		$.ajax({
			url : "/admin/uploadAjaxAction",
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				console.log(result);
				showUploadImage(result);
			},
			error : function(result) {
				alert("이미지 파일이 아닙니다.");
			}
		});
	});

	/* var, method related with attachFile */
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB	

	function fileCheck(fileName, fileSize) {

		if (fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}

		if (!regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}

		return true;

	}
	/* 이미지 출력 */
	function showUploadImage(uploadResultArr){
		
		/* 전달받은 데이터 검증 */
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		
		let obj = uploadResultArr[0];
		
		let str = "";
		
		/* let fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName; */
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
		str += "<div id='result_card'>";
		str += "<img src='/admin/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn'>x</div>";
		str += "</div>";		
		
   		uploadResult.append(str);     
        
	}	
</script>
</html>