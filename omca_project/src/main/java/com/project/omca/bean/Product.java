package com.project.omca.bean;

import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Product {
	private int p_id;
	private String m_id;
	private String p_name;
	private String p_img;
	private int p_price;
	private int p_count;
	private Date p_date;
	private String p_info;
	
	//이미지 정보
	private List<AttachImage> imageList;
}
