package com.project.omca.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.project.omca.bean.Product;
import com.project.omca.model.Criteria;

@Repository
public interface ProductDao {

	/* 상품 검색 */
	public List<Product> getProductList(Criteria cri);
	
	/* 상품 총 갯수 */
	public int productGetTotal(Criteria cri);
	
	/*상품 이름 검색 */
	public String[] productGetIdList(String keyword);
	
}
