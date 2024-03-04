package com.web.spring.service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.dao.Dao_Dashboard;
import com.web.spring.dao.Dao_risk;
import com.web.spring.vo.RiskSch;
import com.web.spring.vo.Wizet_PrjList;
import com.web.spring.vo.Wizet_PrjStep;

@Service
public class WebService_dashboard {
	@Autowired(required = false)
	private Dao_Dashboard dao;
	@Autowired(required = false)
	private Dao_risk Rdao;
	
	// 프로젝트 목록
	public List<Wizet_PrjList> getPrjList(int empno) {
	    // 오늘 날짜
        LocalDate today = LocalDate.now();

        List<Wizet_PrjList> wiz = dao.getPrjList(empno);
        
        for (Wizet_PrjList w : wiz) {     	
            // Dao에서 받아온 마감일을 받아옴
            Date date = w.getPrjEnd();

            // Date를 Instant로 변환하고, Instant를 특정 ZoneId로 변환하여 LocalDate로 얻음
            LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

            // 날짜 차이 계산
            long differenceInDays = today.toEpochDay() - localDate.toEpochDay();
            // 계산한 날짜차이를 vo객체에 저장
            w.setDiff(differenceInDays);
            
            // 프로젝트의 리스크수를 가져오는 코드
            RiskSch risk = new RiskSch();
            risk.setPrjName(w.getPrjName());
            risk.setRiskName("");
            risk.setEname("");
            
            w.setRisk(Rdao.cntRisk(risk));
		}
		return wiz;
	}
	
	// 프로젝트 진행도
	public Wizet_PrjStep getPrjStep(int empno) {
		Wizet_PrjStep test = dao.getPrjStep(empno);
		
		return test;
	}
	// 프로젝트 예산
	public Integer getPrjHM(int empno) {
		int tmp = dao.getProjH(empno)+dao.getProjM(empno);
		
		return tmp;
	}
	
	// 프로젝트 리스크 수
	public int getCntRisk(RiskSch sch) {
		
		return Rdao.cntRisk(sch);
	}
	
	 
}
