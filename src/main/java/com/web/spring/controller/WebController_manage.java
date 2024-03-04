package com.web.spring.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.web.spring.service.WebService_manage;
import com.web.spring.service.WebService_risk;
import com.web.spring.vo.Risk;
import com.web.spring.vo.RiskSch;


@Controller
public class WebController_manage {
	@Autowired(required = false)
	private WebService_manage service;
	
	 //리스크 리스트 화면
	 //http://localhost:2222/riskManage
	@RequestMapping("riskManage")
	public String riskList(RiskSch sch, Model d) {
	
		d.addAttribute("sch", sch);
		//d.addAttribute("riskList", service.riskList(sch));
		
		return "risk_manage";
	}
	//http://localhost:2222/riskManageSch
	@GetMapping("riskManageSch")
	public String schRiskList(RiskSch sch, Model d) {

		d.addAttribute("sch", sch);
		d.addAttribute("riskList", service.riskList(sch));
		
		return "pageJsonReport";
	}
	
	@RequestMapping("allowRisk")
	public String allowRisk(@RequestParam("riskNo") int[] riskNos, @ModelAttribute("sch") RiskSch sch, Model d) {
		for (int riskNo : riskNos) {
			service.allowRisk(riskNo);
		}
		d.addAttribute("riskList", service.riskList(sch));
		return "risk_manage";
	}
	
	@RequestMapping("denyRisk")
	public String denyRisk(@RequestParam("riskNo") int[] riskNos, @ModelAttribute("sch") RiskSch sch, Model d) {
		for (int riskNo : riskNos) {
			service.denyRisk(riskNo);
		}
		d.addAttribute("riskList", service.riskList(sch));
		return "risk_manage";
	}
	


}
