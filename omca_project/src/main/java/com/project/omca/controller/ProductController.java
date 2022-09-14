package com.project.omca.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.omca.bean.AttachImage;
import com.project.omca.bean.Product;
import com.project.omca.model.Criteria;
import com.project.omca.model.PageDTO;
import com.project.omca.service.AttachAM;
import com.project.omca.service.ProductPM;

@Controller
@RequestMapping(value="/product")
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private ProductPM productService;
	
	@Autowired
	private AttachAM attachService;
	
	/* 상품 검색 */
	@GetMapping("/search")
	public String searchProductGET(Criteria cri, Model model) {
		
		logger.info("cri : " + cri);
		
		List<Product> list = productService.getProductList(cri);
		logger.info("pre list : " + list);
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			logger.info("list : " + list);
		} else {
			model.addAttribute("listcheck", "empty");
			
			return "/product/productManage";
		}
		
		model.addAttribute("pageMaker", new PageDTO(cri, productService.productGetTotal(cri)));
		
		return "/product/productManage";
		
	}
	// 상품 이미지 호출
		@RequestMapping(value = "/display", method = RequestMethod.GET)
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
		
		/* 이미지 정보 반환 */
		@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		public ResponseEntity<List<AttachImage>> getAttachList(int p_id){
			
			logger.info("getAttachList.........." + p_id);
			
			return new ResponseEntity<List<AttachImage>>(attachService.getAttachList(p_id), HttpStatus.OK);
			
		}
		@GetMapping(value="/main")
		public void pointShopGET() {
			logger.info("포인트 샵 이동");
		}
		
}
