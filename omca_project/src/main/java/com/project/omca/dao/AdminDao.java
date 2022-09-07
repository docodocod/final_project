package com.project.omca.dao;

import java.util.List;

import com.project.omca.bean.Product;
import com.project.omca.model.Criteria;

public interface AdminDao {

	public void productEnroll(Product pr); // 상품 등록

//	public List<Product> getListPaging(Criteria cri); //상품 목록

	/* 상품 리스트 */
	public List<Product> productGetList();

	/* 상품 상세조회 */
	public Product productGetPage(int p_id);
//	  상품 총 개수 
//	public int productGetTotal(Criteria cri);

	public int productDelete(int p_id);
}
