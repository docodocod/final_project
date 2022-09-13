<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
</style>
</head>
<body>
	<div class="form_section">
		<div class="form_section_title">
			<label>상품 이미지</label>
		</div>
		<div class="form_section_content">
			<div id="uploadReslut"></div>
		</div>
		<div>
		<c:out value='${list.p_id}'></c:out>
		</div>
	</div>
</body>
<script>



</script>
</html>