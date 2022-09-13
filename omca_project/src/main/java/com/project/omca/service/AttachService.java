package com.project.omca.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.omca.bean.AttachImage;
import com.project.omca.dao.AttachDao;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AttachService {
	
	@Autowired
	private AttachDao attDao;
	
	/* 이미지 데이터 반환 */
	public List<AttachImage> getAttachList(int p_id) {
		
		log.info("getAttachList.........");
		
		return attDao.getAttachList(p_id);
	}
}
