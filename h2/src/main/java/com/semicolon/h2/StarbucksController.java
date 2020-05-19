package com.semicolon.h2;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.StarbucksDAO;
import dao.StarbucksDAOImpl;
import vo.StarbucksVO;

@Controller
public class StarbucksController {

	@Autowired
	StarbucksDAOImpl dao;
	
	@RequestMapping("/starbucks")
	public ModelAndView sbinfo(StarbucksVO vo) {
		ModelAndView mav = new ModelAndView();
		List<StarbucksVO> list = new ArrayList<>();
		list = dao.listAll();
		mav.addObject("listAll", list);
		mav.setViewName("starbucks");
		System.out.println(list);
		return mav;
	}
}
