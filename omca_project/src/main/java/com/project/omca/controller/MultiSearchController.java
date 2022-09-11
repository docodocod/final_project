package com.project.omca.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping (value = "/multiSearch")
public class MultiSearchController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping(value = "/multiSearch", method = RequestMethod.GET)
	public void MultiSearch() {
		logger.info("멀티서치 페이지 이동");

	}
}
