package com.web.spring.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.spring.service.WebService_JangSunWoong;
import com.web.spring.service.WebService_dashboard;
import com.web.spring.service.WebService_notice;
import com.web.spring.service.WebService_risk;
import com.web.spring.vo.Emp;
import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeSch;

import jakarta.servlet.http.HttpSession;

@Controller
public class WebController_dashboard {
	@Autowired(required = false)
	private WebService_dashboard service;
	@Autowired(required = false)
	private WebService_notice Nservice;
	
	// http://211.63.89.67:2222/index.do	
	// http://localhost:2222/index.do
	// http://localhost:2222/login.do
	@GetMapping("index.do")
	public String index(HttpSession session, Model d) {
		// 로그인 정보 받아오기
		Emp emp = new Emp();
		
		emp = (Emp) session.getAttribute("empResult");
		
		// 공지사항 위젯
		LocalDate today = LocalDate.now();
		NoticeSch sch = new NoticeSch();
		List<Notice> notice = Nservice.noticeList(sch);
        for (Notice n : notice) {
        	
            Date date = n.getRegdte();
            LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

            long differenceInDays = today.toEpochDay() - localDate.toEpochDay();
            n.setDiff(differenceInDays);
		}		
		d.addAttribute("noticeList", notice);
		
		if (emp != null) {
			// 내 프로젝트 위젯
			d.addAttribute("prjList", service.getPrjList(emp.getEmpno()));
			
			// 프로젝트 진행도 위젯
			d.addAttribute("prj_chart", service.getPrjStep(emp.getEmpno()));
			
			// 내 프로젝트 총예산
			d.addAttribute("prj_HM",service.getPrjHM(emp.getEmpno()));
			
			// 프로젝트 리스크
			//d.addAttribute("prj_risk", service.getCntRisk(null))
			
		}
		return "index";
	}


}
