package com.project.omca.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.omca.bean.AttachImage;
import com.project.omca.bean.Product;
import com.project.omca.model.Criteria;
import com.project.omca.model.PageDTO;
import com.project.omca.service.AdminAM;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private AdminAM am;

	// 포인트 상품 목록
	@RequestMapping(value = "/productManage", method = RequestMethod.GET)
	public void productListGET(Model model) {

		logger.info("productListGET 진입");

		/* 상품 리스트 데이터 */
		model.addAttribute("list", am.productGetList());

		/*
		 * int total=am.productGetTotal(cri);
		 * 
		 * PageDTO pageMake=new PageDTO(cri,total);
		 * 
		 * model.addAttribute("pageMaker",pageMake);
		 */
//		  페이지 인터페이스 데이터 
		/*
		 * model.addAttribute("pageMaker", new PageDTO(cri, am.productGetTotal(cri)));
		 */

	}

	// 포인트 상품 등록
	@RequestMapping(value = "/Enroll", method = RequestMethod.GET)
	public String productEnrolwlPost(HttpServletRequest request, Product pr, RedirectAttributes rttr) {

		logger.info("ProductEnrollPost 진입");

		am.productEnroll(pr);

		logger.info("am.productEnroll 성공");

		rttr.addFlashAttribute("enroll_result", pr.getP_name()); // 등록 성공 메시지 상품이름

		return "/admin/main";

	}

	// 포인트 상품 삭제
	@PostMapping("/productDelete")
	public String productDeletePOST(int p_id, RedirectAttributes rttr) {

		logger.info("상품 삭제 진입");

		int result = am.productDelete(p_id);

		rttr.addFlashAttribute("delete_result", result);

		return "/admin/productManage";

	}

	// 관리자 페이지 이동
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void AdminMainGet() {
		logger.info("관리자 페이지 이동");
	}

	// 상품 등록 페이지 이동
	@RequestMapping(value = "/productEnroll", method = RequestMethod.GET)
	public void ProductEnrollGet() {
		logger.info("상품 등록 페이지 이동");
	}

	/* 첨부 파일 업로드 */
	@RequestMapping(value = "/uploadAjaxAction", method = RequestMethod.POST)
	public ResponseEntity<List<AttachImage>> uploadAjaxActionPOST(MultipartFile[] p_img) {
		logger.info("파일 업로드 진입");
		/* 이미지 파일 체크 */
		for (MultipartFile multipartFile : p_img) {
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;

			try {
				type = Files.probeContentType(checkfile.toPath());
				logger.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if (!type.startsWith("image")) {

				List<AttachImage> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);

			}

		}
		// 업로드 경로 초기화
		String uploadFolder = "C:\\upload";

		// 날짜 폴더 경로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		String datePath = str.replace("-", File.separator);

		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		/* 이미저 정보 담는 객체 */
		List<AttachImage> list = new ArrayList();

		for (MultipartFile multipartFile : p_img) {
//			 이미지 정보 객체 
			AttachImage AttImg = new AttachImage();

			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();
			AttImg.setFileName(uploadFileName);
			AttImg.setUploadPath(datePath);

			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();

			uploadFileName = uuid + "_" + uploadFileName;
			AttImg.setUuid(uuid);

			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);

			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile);

				// 썸네일 설정
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

				BufferedImage pr_img = ImageIO.read(saveFile);

				/* 비율 */
				double ratio = 3;
				/* 넓이 높이 */
				int width = (int) (pr_img.getWidth() / ratio);
				int height = (int) (pr_img.getHeight() / ratio);

				logger.info("파일저장 성공");

				BufferedImage pt_img = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);

				Graphics2D graphic = pt_img.createGraphics();

				graphic.drawImage(pr_img, 0, 0, width, height, null);

				ImageIO.write(pt_img, "jpg", thumbnailFile);

			} catch (Exception e) {
				e.printStackTrace();
			}
			list.add(AttImg);
		} // for
		ResponseEntity<List<AttachImage>> result = new ResponseEntity<List<AttachImage>>(list, HttpStatus.OK);
		return result;
	}

	@RequestMapping(value="/display", method=RequestMethod.GET)
	public ResponseEntity<byte[]> getImage(String fileName) {
		File file = new File("c:\\upload\\" + fileName);

		ResponseEntity<byte[]> result = null;
		

		try {

			HttpHeaders header = new HttpHeaders();

			header.add("Content-type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;

	}
}
