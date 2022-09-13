<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/resources/joinForm.css">
</head>
<body>
	<form action="join" method="POST">
		<div class="wrap"></div>
		<div class="subject" align="center">
			<h1>회원가입</h1>
		</div>
		<div class="id_wrap">
			<div class="id_name">아이디</div>
			<div class="id_input_box">
				<input type="text" class="id_input" name="m_id">
			</div>
			<span class="id_input_re_1">사용 가능한 아이디 입니다.</span> 
			<span class="id_input_re_2">아이디가 이미 존재합니다.</span> 
			<span class="final_id_ck">아이디를 입력하세요.</span>
		</div>
		<div class="mail_wrap">
			<div class="mail_name">이메일</div>
			<div class="mail_input_box">
				<input type="text" class="mail_input" name="m_email">
			</div>
			<span class="mail_input_re_1">사용 가능한 이메일 입니다.</span>
			<span class="mail_input_re_2">이메일이 이미 존재합니다.</span>
			<span class="final_mail_ck">이메일을 입력하세요.</span>
			<span class="mail_input_box_warn"> </span>
		</div>
		<div class="mail_check_wrap">
			<div class="mail_check_input_box" id="mail_check_input_box_false">
				<input class="mail_check_input" disabled="disabled">
			</div>
			<div class="mail_check_button">
				<span>인증번호 전송</span>
			</div>
			<div class="clearfix"></div>
			<span id="mail_check_input_box_warn"></span>
		</div>
		<div class="pw_wrap">
			<div class="pw_name">비밀번호</div>
			<div class="pw_input_box">
				<input type="password" class="pw_input" name="m_password">
			</div>
			<span class="final_pw_ck">비밀번호를 입력하세요.</span>
		</div>
		<div class="pwck_wrap">
			<div class="pwck_name">비밀번호 확인</div>
			<div class="pwck_input_box">
				<input type="password" class="pwck_input" name="ck_password">
			</div>
			<span class="final_pwck_ck">비밀번호를 확인을 눌러주세요.</span> 
			<span class="pwck_input_re_1">비밀번호가 일치합니다.</span> 
			<span class="pwck_input_re_2">비밀번호가 일치 하지 않습니다.</span>
		</div>
		<div class="name_wrap">
			<div class="name_name">게임 닉네임</div>
			<div class="name_input_box">
				<input type="text" class="name_input" name="m_name">
			</div>
		</div>
		<div class="phone_wrap">
			<div class="phone_name">핸드폰 번호</div>
			<div class="phone_input_box">
				<input type="text" class="phone_input" name="m_phone">
			</div>
		</div>
		<div class="join_wrap">
			<input type="submit" class="join_button" value="가입하기">
		</div>
	</form>
</body>

<script>
	$(".id_input").on("propertychange change keyup paste input", function() {
		var m_id = $('.id_input').val(); // .id_input에 입력되는 값
		var data = {
			m_id : m_id
		} // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)' JSON으로 해서 보냄

		$.ajax({
			type : "post",
			url : "/member/memberIdChk",
			data : data,
			success : function(result) {
				// console.log("성공 여부" + result);
				if (result != 'fail') {
					$('.id_input_re_1').css("display", "inline-block");
					$('.id_input_re_2').css("display", "none");
					idckCheck = "true";
				} else {
					$('.id_input_re_2').css("display", "inline-block");
					$('.id_input_re_1').css("display", "none");
					idckCheck = "false";
				}
			}// success 종료
		}); // ajax 종료
	});
	
	$(".mail_input").on("propertychange change keyup paste input", function() {
		var m_mail = $('.mail_input').val(); // .mail_input에 입력되는 값
		var data = {
			m_mail : m_mail
		} // '컨트롤에 넘길 데이터 이름' : '데이터(.mail_input에 입력되는 값)' JSON으로 해서 보냄

		$.ajax({
			type : "post",
			url : "/member/memberMailChk",
			data : data,
			success : function(result) {
				// console.log("성공 여부" + result);
				if (result != 'fail') {
					$('.mail_input_re_1').css("display", "inline-block");
					$('.mail_input_re_2').css("display", "none");
					mailckCheck = "true";
				} else {
					$('.mail_input_re_2').css("display", "inline-block");
					$('.mail_input_re_1').css("display", "none");
					mailckCheck = "false";
				}
			}// success 종료
		}); // ajax 종료
	});

	/* 인증번호 이메일 전송 */
	$(".mail_check_button").click(function() {

		var email = $(".mail_input").val(); // 입력한 이메일
		var cehckBox = $(".mail_check_input"); // 인증번호 입력란
		var boxWrap = $(".mail_check_input_box"); // 인증번호 입력란 박스
		var warnMsg = $(".mail_input_box_warn");    // 이메일 입력 경고글
		var code;

		/* 이메일 형식 유효성 검사 */
		if (mailFormCheck(email)) {
			warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
			warnMsg.css("display", "inline-block");
		} else {
			warnMsg.html("올바르지 못한 이메일 형식입니다.");
			warnMsg.css("display", "inline-block");
			return false;
		}

		$.ajax({
			type : "GET",
			url : "/member/mailCheck?email=" + email,
			success : function(data) {

				//console.log("data : " + data);
				cehckBox.attr("disabled", false);
				boxWrap.attr("id", "mail_check_input_box_true");
				code = data;
			}
		});
	});
	/* 인증번호 비교 */
	$(".mail_check_input").blur(function() {
		var inputCode = $(".mail_check_input").val(); // 입력코드    
		var checkResult = $("#mail_check_input_box_warn"); // 비교 결과  
		if (inputCode == code) { // 일치할 경우
			checkResult.html("인증번호가 일치합니다.");
			checkResult.attr("class", "correct");
			mailnumCheck = true;
		} else { // 일치하지 않을 경우
			checkResult.html("인증번호를 다시 확인해주세요.");
			checkResult.attr("class", "incorrect");
			mailnumCheck = false;
		}
	});
	$(".join_button").click(
			function() {

				/* 입력값 변수 */
				var id = $('.id_input').val(); // id 입력란
				var pw = $('.pw_input').val(); // 비밀번호 입력란
				var pwck = $('.pwck_input').val(); // 비밀번호 확인 입력란
				var mail = $('.mail_input').val(); // 이메일 입력란
				var warnMsg = $(".mail_input_box_warn"); // 이메일 입력 경고글

				/* 아이디 유효성검사 */
				if (id == "") {
					$('.final_id_ck').css('display', 'block');
					idCheck = false;
				} else {
					$('.final_id_ck').css('display', 'none');
					idCheck = true;
				}

				/* 비밀번호 유효성 검사 */
				if (pw == "") {
					$('.final_pw_ck').css('display', 'block');
					pwCheck = false;
				} else {
					$('.final_pw_ck').css('display', 'none');
					pwCheck = true;
				}

				/* 이메일 유효성 검사 */
				if (mail == "") {
					$('.final_mail_ck').css('display', 'block');
					mailCheck = false;
				} else {
					$('.final_mail_ck').css('display', 'none');
					mailCheck = true;
				}

				/* 최종 유효성 검사 */
				if (idCheck && idckCheck && pwCheck && pwckCheck
						&& pwckcorCheck&& mailCheck
						&& mailnumCheck) {
					$("#join_form").attr("action", "join");
					$("#join_form").submit();
				}
				return false;
			});
	/* 비밀번호 확인 일치 유효성 검사 */
	$('.pwck_input').on("propertychange change keyup paste input", function() {
		var pw = $('.pw_input').val();
		var pwck = $('.pwck_input').val();
		$('.final_pwck_ck').css('display', 'none');

		if (pw == pwck) {
			$('.pwck_input_re_1').css('display', 'block');
			$('.pwck_input_re_2').css('display', 'none');
			pwckcorCheck = true;
		} else {
			$('.pwck_input_re_1').css('display', 'none');
			$('.pwck_input_re_2').css('display', 'block');
			pwckcorCheck = false;
		}
	});
	/* 입력 이메일 형식 유효성 검사 */
	function mailFormCheck(email) {
		var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return form.test(email);
	}
</script>
</html>