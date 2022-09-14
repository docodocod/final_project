package com.project.omca.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.omca.bean.AttachImage;
import com.project.omca.bean.Member;
import com.project.omca.bean.Product;
import com.project.omca.dao.AdminDao;
import com.project.omca.dao.AttachDao;
import com.project.omca.model.Criteria;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminAM {

	@Autowired
	private AdminDao aDao;

	@Autowired
	private AttachDao attDao;

	// 상품 등록
	public void productEnroll(Product pr) {

		log.info("service.enroll 진입");

		aDao.productEnroll(pr);

		if (pr.getImageList() == null || pr.getImageList().size() <= 0) {
			return;
		}
		for (AttachImage attach : pr.getImageList()) {
			attach.setP_id(pr.getP_id());
			aDao.imageEnroll(attach);
		}
	}

	// 상품 목록
	public List<Product> productGetList(Criteria cri) {
		log.info("상품 목록 진입");

		List<Product> list = aDao.productGetList(cri);

		list.forEach(product -> {

			int p_id = product.getP_id();

			List<AttachImage> imageList = attDao.getAttachList(p_id);

			product.setImageList(imageList);

		});
		return list;
	}

	// 상품 총 개수
	public int productGetTotal(Criteria cri) {
		log.info("상품 총 개수 진입");
		return aDao.productGetTotal(cri);
	}

	/* 상품 삭제 */
	public int productDelete(int p_id) {
		return aDao.productDelete(p_id);
	}

	/* 회원 관리 */
	public List<Member> memberList() {
		log.info("회원 관리 진입");
		return aDao.memberList();
	}

	/* 이미지 등록 */
	public void imageEnroll(AttachImage attimg) {
		log.info("이미지 등록 진입");
		
	}

}
