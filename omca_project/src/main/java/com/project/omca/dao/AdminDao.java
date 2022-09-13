package com.project.omca.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.project.omca.bean.Product;
import com.project.omca.bean.AttachImage;
import com.project.omca.bean.Member;
import com.project.omca.model.Criteria;

@Repository
public interface AdminDao {

	/* 상품 등록 */
	public void productEnroll(Product pr);
	
	/* 상품 목록 */
	public List<Product> productGetList(Criteria cri);
	
//	  상품 총 개수 
	public int productGetTotal(Criteria cri);
	
	/* 상품 삭제 */
	public int productDelete(int p_id);
	
	/* 이미지 등록 */
	public void imageEnroll(AttachImage attimg);
	
	//회원 관리
	public List<Member> memberList();
}
