package com.project.omca.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("Member")
public class Member {
	private String m_name;
	private String m_id;
	private String m_password;
	private String m_email;
	private String m_phone;
	private int m_point;
	private int m_admin;
}
