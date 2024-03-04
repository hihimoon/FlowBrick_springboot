package com.web.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.service.WebService_calendar;
import com.web.spring.vo.Calendar;
import com.web.spring.vo.ProjectBasic;

import jakarta.servlet.http.HttpSession;

@Controller
public class WebController_calendar {
	@Autowired(required = false)
	private WebService_calendar service;
	
	// 캘린더 화면
	// http://localhost:2222/calendar
	@GetMapping("calendar")
	public String calendar() {
		return "calendar";
	}
	
	// 캘린더 json 처리
	@GetMapping("calendarJson")
	public ResponseEntity<?> calendarJson(HttpSession session) {
		return ResponseEntity.ok(service.getCalList(session));
	}
	
	@ModelAttribute("projectByEmp")
	public List<ProjectBasic> getProjectByEmp(HttpSession session) {
		return service.getProjectByEmp(session);
	}
	
	// 캘린더 등록
	@PostMapping("insertCalendar")
	public ResponseEntity<?> insertCalendar(Calendar ins, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("msg", service.insertCalendar(ins));
	    resultMap.put("calList", service.getCalList(session));
	    
	    // ResponseEntity에 Map을 담아 반환
	    return ResponseEntity.ok(resultMap);
	}
	
	// 캘린더 수정
	@PostMapping("updateCalendar")
	public ResponseEntity<?> updateCalendar(Calendar upt, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("msg", service.updateCalendar(upt));
	    resultMap.put("calList", service.getCalList(session));
	    
	    // ResponseEntity에 Map을 담아 반환
	    return ResponseEntity.ok(resultMap);
	}
	
	// 캘린더 삭제
	@PostMapping("deleteCalendar")
	public ResponseEntity<?> deleteCalendar(@RequestParam("calId") int calId, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("msg", service.deleteCalendar(calId));
	    resultMap.put("calList", service.getCalList(session));
	    
	    // ResponseEntity에 Map을 담아 반환
	    return ResponseEntity.ok(resultMap);
	}

}
