package com.project.omca.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.project.omca.bean.AttachImage;

@Repository
public interface AttachDao {
	
	//이미지 데이터 변환
	public List<AttachImage> getAttachList(int p_id);
}
