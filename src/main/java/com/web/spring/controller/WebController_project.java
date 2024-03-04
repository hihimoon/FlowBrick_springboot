package com.web.spring.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.service.WebService_project;
import com.web.spring.service.WebService_risk;
import com.web.spring.vo.Emp;
import com.web.spring.vo.InsertProjectRequest;
import com.web.spring.vo.ProjectBasic;
import com.web.spring.vo.ProjectPaging;
import com.web.spring.vo.ProjectSch;
import com.web.spring.vo.ProjectTeam;
import com.web.spring.vo.TeamEmp;
import com.web.spring.vo.TeamMate;

@Controller
public class WebController_project {
	@Autowired(required = false)
	private WebService_project service;

	@Autowired(required = false)
	private WebService_risk service2;
	
	// http://localhost:2222/projectList
	@GetMapping("projectList")
	public String projectList() {
		return "project_list";
	}
	/*
	// http://localhost:2222/projectListJson
	@RequestMapping("projectListJson")
	public ResponseEntity<List<ProjectBasic>> projectListJson(ProjectSch sch){
		List<ProjectBasic> projectList = service.projectList(sch);
		return ResponseEntity.ok(projectList);
	}
	*/
	
	// http://localhost:2222/projectListJson
	@PostMapping("projectListJson")
	public ResponseEntity<?> projectListJson(ProjectSch sch) {
		return ResponseEntity.ok(new ProjectPaging(sch, service.projectList(sch)));
	}
	
	@ModelAttribute("empList")
	public List<TeamEmp> empList(){
		return service.empList();
	}
	
	// http://localhost:2222/insertProjectBasic
	@RequestMapping("insertProjectBasic")
	public String insertProjectBasic(ProjectBasic ins, Model d, ProjectSch sch) {
		d.addAttribute("msg", service.insertProjectBasic(ins));
		d.addAttribute("projectlist", service.projectList(sch));
		return "pageJsonReport";
	}
	
	
	@RequestMapping("insertProjectTeam")
	public String insertProjectTeam(ProjectTeam ins, Model d) {
		d.addAttribute("msg", service.insertProjectTeam(ins));
		return "pageJsonReport";
	}
	
	@RequestMapping("insertTeamMate")
	public String insertTeamMate(int empno, Model d) {
		d.addAttribute("msg", service.insertTeamMate(empno));
		return "pageJsonReport";
	}

	@RequestMapping("insertProject")
	public String insertProject(ProjectBasic pb, ProjectTeam pt, @RequestParam("empno") List<String> empno, Model d, ProjectSch sch) {
		d.addAttribute("msg", service.insertProject(pb, pt, empno));
		d.addAttribute("projectlist", service.projectList(sch));
		return "pageJsonReport";
	}

}
