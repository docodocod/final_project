package com.project.omca.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.omca.bean.Product;
import com.project.omca.dao.AdminDao;
import com.project.omca.model.Criteria;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminAM {

	@Autowired
	public AdminDao pDao;

	// 상품 등록
	public void productEnroll(Product pr) {

		log.info("service.enroll 진입");

		pDao.productEnroll(pr);
	}

	// 상품 목록
//	public List<Product> getListPaging(Criteria cri) {
//		return pDao.getListPaging(cri);
//	}

	/* 상품 리스트 */
	public List<Product> productGetList() {
		// TODO Auto-generated method stub
		return pDao.productGetList();
	}
	
	/* 상품 상세조회 */
	public Product productGetPage(int p_id) {
		return pDao.productGetPage(p_id);
	}
	
	/* 상품 삭제 */
	public int productDelete(int p_id){
		return pDao.productDelete(p_id);
	}

	
//	  상품 총 갯수 
	/*
	 * public int productGetTotal(Criteria cri) {
	 * log.info("productGetTotal()........."); return pDao.productGetTotal(cri); }
	 */
	 
}
