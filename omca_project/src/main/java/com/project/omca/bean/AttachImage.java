package com.project.omca.bean;

import lombok.Data;

@Data
public class AttachImage {
	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String fileName;
	
	/* 상품 id */
	private int p_id;
}
