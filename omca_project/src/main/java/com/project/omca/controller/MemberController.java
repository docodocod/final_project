package com.project.omca.controller;

import java.io.File;
import java.net.URLDecoder;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.omca.bean.Member;
import com.project.omca.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value="/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public void loginGET() {
		logger.info("로그인 페이지 이동");

	}

	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public void joinGET() {
		logger.info("회원가입 페이지 이동");
	}

	@RequestMapping(value = "/idSearch", method = RequestMethod.GET)
	public void idsearchGET() {
		logger.info("아이디 찾기 페이지 이동");
	}

	@RequestMapping(value = "/pwSearch", method = RequestMethod.GET)
	public void pwsearchGET() {
		logger.info("비밀번호 찾기 페이지 이동");
	}

	/* 로그인 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, Member mb, RedirectAttributes rttr) {

		HttpSession session = request.getSession();

		String rawPw = "";
		String encodePw = "";

		Member lvo = memberService.memberLogin(mb); // 제출한아이디와 일치하는 아이디 있는지

		if (lvo != null) { // 일치하는 아이디 존재시

			rawPw = mb.getM_password(); // 사용자가 제출한 비밀번호
			encodePw = lvo.getM_password(); // 데이터베이스에 저장한 인코딩된 비밀번호

			if (true == pwEncoder.matches(rawPw, encodePw)) { // 비밀번호 일치여부 판단

				lvo.setM_password(""); // 인코딩된 비밀번호 정보 지움
				session.setAttribute("mb", lvo); // session에 사용자의 정보 저장
				return "redirect:/"; // 메인페이지 이동
			} else {
				rttr.addFlashAttribute("result", 0);
				return "/member/loginForm"; // 로그인 페이지로 이동

			}

		} else { // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)

			rttr.addFlashAttribute("result", 0);
			return "/member/loginForm"; // 로그인 페이지로 이동

		}

	}

	// 회원가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String memberJoin(Member mb) {

		logger.info("회원가입 진입");

		String rawPw = ""; // 인코딩 전 비밀번호
		String encodePw = ""; // 인코딩 후 비밀번호

		rawPw = mb.getM_password(); // 비밀번호 데이터 얻음
		System.out.println("비밀번호 데이터 얻음 : " + rawPw);
		encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		System.out.println("비밀번호 인코딩 : " + encodePw);
		mb.setM_password(encodePw); // 인코딩된 비밀번호 member객체에 다시 저장

		// 회원가입 서비스 실행
		memberService.memberJoin(mb);

		logger.info("회원가입 완료");

		return "main";
	}

	// 아이디 중복 검사
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String m_id) throws Exception {

		logger.info("아이디 확인 진입");

		int result = memberService.idCheck(m_id);

		logger.info("결과값 = " + result);

		if (result != 0) {
			return "fail"; // 중복 아이디가 존재
		} else {
			return "success"; // 중복 아이디 x
		}
	} // memberIdChkPOST() 종료

	// 이메일 중복 검사
	@RequestMapping(value = "/memberMailChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberMailChkPOST(String m_email) throws Exception {

		logger.info("이메일 확인 진입");

		int result = memberService.mailCheck(m_email);

		logger.info("결과값 = " + result);

		if (result != 0) {

			return "fail"; // 중복 이메일 존재

		} else {

			return "success"; // 중복 아이디 미존재
		}
	} // memberIdChkPOST() 종료

	/* 메인페이지 로그아웃 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutMainGET(HttpServletRequest request) {

		logger.info("logoutMainGET메서드 진입");

		HttpSession session = request.getSession();

		session.invalidate();

		return "redirect:/";
	}

	/* 비동기방식 로그아웃 메서드 */
	@RequestMapping(value = "/logout.do", method = RequestMethod.POST)
	@ResponseBody
	public void logoutPOST(HttpServletRequest request) throws Exception {

		logger.info("비동기 로그아웃 메서드 진입");

		HttpSession session = request.getSession();

		session.invalidate();

	}

	/* 이메일 인증 */
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {

		/* 뷰(View)로부터 넘어온 데이터 확인 */
		logger.info("이메일 데이터 전송 확인");
		logger.info("인증번호 : " + email);

		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("인증번호 " + checkNum);

		/* 이메일 보내기 */
		String setFrom = "dongan0618@naver.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String num = Integer.toString(checkNum);
		return num;
	}

	@RequestMapping(value = "/sendMail", method = RequestMethod.GET)
	public void sendMail() throws Exception {

		String subject = "test 메일";
		String content = "메일 테스트 내용";
		String from = "dongan0618@naver.com";
		String to = "받는이 아이디@도메인주소";

		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, false, "UTF-8");
			// true는 멀티파트 메세지를 사용하겠다는 의미

			/*
			 * 단순한 텍스트 메세지만 사용시엔 아래의 코드도 사용 가능 MimeMessageHelper mailHelper = new
			 * MimeMessageHelper(mail,"UTF-8");
			 */

			mailHelper.setFrom(from);
			// 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
			// 보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용하시면 됩니다.
			// mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content);
			// true는 html을 사용하겠다는 의미입니다.

			/*
			 * 단순한 텍스트만 사용하신다면 다음의 코드를 사용하셔도 됩니다. mailHelper.setText(content);
			 */
			mailSender.send(mail);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 아이디 찾기 실행
	@RequestMapping(value = "/idSearchForm", method = RequestMethod.POST)
	public String idSearchGET(Member mb, Model model) {
		logger.info("아이디 찾기 메소드 진입");
		Member member = memberService.memberIdSearch(mb);
		if (member == null) {
			model.addAttribute("check", 1);
		} else {
			model.addAttribute("check", 0);
			model.addAttribute("m_id", member.getM_id());
		}

		return "member/idSearch";
	}

	// 비밀번호 찾기 실행
	@RequestMapping(value = "/pwSearchForm", method = RequestMethod.POST)
	public String pwSearchGET(Member mb, Model model) {
		Member member = memberService.memberPwSearch(mb);
		if (member == null) {
			model.addAttribute("check", 1);
		} else {
			model.addAttribute("check", 0);
			model.addAttribute("m_id-++", member.getM_id());
		}
		return "member/pwSearch";
	}


	@RequestMapping(value = "/pwUpdateForm", method = RequestMethod.POST)
	public String pwUpdateGET(Member mb, String m_password) {
		logger.info("비밀반호 변경 페이지 진입");
		String imb = mb.getM_password();
		memberService.memberPwUpdate(imb);

		return "main";
	}
	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		
		logger.info("deleteFile........" + fileName);
		File file = null;
		try {
			/* 썸네일 파일 삭제 */
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			
			logger.info("originFileName : " + originFileName);
			
			file = new File(originFileName);
			
			file.delete();
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
}

