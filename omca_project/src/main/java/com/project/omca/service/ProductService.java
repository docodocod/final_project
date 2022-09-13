package com.project.omca.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.omca.bean.AttachImage;
import com.project.omca.bean.Product;
import com.project.omca.dao.AttachDao;
import com.project.omca.dao.ProductDao;
import com.project.omca.model.Criteria;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ProductService {

	@Autowired
	private ProductDao pDao;

	@Autowired
	private AttachDao attDao;

	/* 상품 검색 */
	public List<Product> getProductList(Criteria cri) {
		log.info("getProductList 진입");

		List<Product> list = pDao.getProductList(cri);

		list.forEach(product -> {

			int p_id = product.getP_id();

			List<AttachImage> imageList = attDao.getAttachList(p_id);

			product.setImageList(imageList);

		});
		return list;
	}

	/* 상품 총 갯수 */
	public int productGetTotal(Criteria cri) {
		log.info("productGetTotal 진입");
		return pDao.productGetTotal(cri);
	}
}
