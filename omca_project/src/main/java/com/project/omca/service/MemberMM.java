package com.project.omca.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.omca.bean.Member;
import com.project.omca.dao.MemberDao;

@Service
public class MemberMM {

	@Autowired
	private MemberDao mDao;

	public void memberJoin(Member mb) {

		mDao.memberJoin(mb);

	}

	public int idCheck(String m_id) {

		return mDao.idCheck(m_id);
	}

	public Member memberLogin(Member mb) {
		return mDao.memberLogin(mb);
	}

	public int mailCheck(String m_email) {
		return mDao.mailCheck(m_email);
	}
	public Member memberIdSearch(Member mb) {
		return mDao.memberIdSearch(mb);
	}
	public Member memberPwSearch(Member mb) {
		return mDao.memberPwSearch(mb);
	}
	public Member memberPwUpdate(String m_password) {
		return mDao.memberPwUpdate(m_password);
	}

}
