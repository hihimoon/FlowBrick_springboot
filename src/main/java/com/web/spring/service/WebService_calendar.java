package com.web.spring.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.dao.Dao_calendar;
import com.web.spring.dao.Dao_notice;
import com.web.spring.dao.Dao_risk;
import com.web.spring.vo.Calendar;
import com.web.spring.vo.Emp;
import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeFile;
import com.web.spring.vo.NoticeSch;
import com.web.spring.vo.ProjectBasic;
import com.web.spring.vo.Risk;
import com.web.spring.vo.RiskFile;
import com.web.spring.vo.RiskSch;

import jakarta.servlet.http.HttpSession;

@Service
public class WebService_calendar {
	@Autowired(required = false)
	private Dao_calendar dao;
	
	@Autowired(required = false)
	private Dao_risk dao2;
	
	// 캘린더 화면
	public List<Calendar> getCalList(HttpSession session){
        // 세션에서 empno 값을 가져옴
		Emp empnoObject = new Emp();
		empnoObject = (Emp)session.getAttribute("empResult");
		
		// empno 값이 null인지 확인
		if (empnoObject != null) {
			int empno = empnoObject.getEmpno();
			
			// service의 getProject 메서드를 호출하여 프로젝트 목록을 가져옴
			return dao.getCalList(empno);
		} else {
			return new ArrayList<>();
		}
		
	}
	
	// 캘린더 등록
	public String insertCalendar(Calendar ins) {
		return dao.insertCalendar(ins)>0?"등록성공":"등록실패";
	}
	
	// 캘린더 수정
	public String updateCalendar(Calendar upt) {
		return dao.updateCalendar(upt)>0?"수정성공":"수정실패";
	}
	
	// 캘린더 삭제
	public String deleteCalendar(int calId) {
		return dao.deleteCalendar(calId)>0?"삭제성공":"삭제실패";
	}
	
	public List<ProjectBasic> getProjectByEmp(HttpSession session) {
        // 세션에서 empno 값을 가져옴
    	Emp empnoObject = new Emp();
        empnoObject = (Emp)session.getAttribute("empResult");
     
        // empno 값이 null인지 확인
        if (empnoObject != null) {
            int empno = empnoObject.getEmpno();
            
            // service의 getProject 메서드를 호출하여 프로젝트 목록을 가져옴
            return dao2.getProjectByEmp(empno);
        } else {
            // empno 값이 null이면 빈 리스트를 반환
            return new ArrayList<>();
        }
	}
	
}
