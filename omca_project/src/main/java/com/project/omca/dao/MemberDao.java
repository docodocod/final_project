package com.project.omca.dao;

import org.springframework.stereotype.Repository;

import com.project.omca.bean.Member;

@Repository
public interface MemberDao {
	// 회원가입
	public void memberJoin(Member mb);

	// 아이디 중복 검사
	public int idCheck(String m_id);
	
	// 이메일 중복 검사
	public int mailCheck(String m_email);
	
	/* 로그인 */
    public Member memberLogin(Member mb);
    
    /* 아이디 찾기 */
    public Member memberIdSearch(Member mb);
    
    /* 비밀번호 찾기 */
    public Member memberPwSearch(Member mb);

    /* 비밀번호 변경 */
	public Member memberPwUpdate(String m_password);
    
}
