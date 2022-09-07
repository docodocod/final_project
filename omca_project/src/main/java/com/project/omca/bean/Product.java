package com.project.omca.bean;

import java.util.Date;

import lombok.Data;

@Data
public class Product {
	
	private String p_id;
	private String m_id;
	private String p_name;
	private String p_img;
	private int p_price;
	private int p_count;
	private Date p_date;
	private String p_info;
}
