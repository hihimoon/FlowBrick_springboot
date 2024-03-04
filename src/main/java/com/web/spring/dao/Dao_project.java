package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.Emp;
import com.web.spring.vo.ProjectBasic;
import com.web.spring.vo.ProjectSch;
import com.web.spring.vo.ProjectTeam;
import com.web.spring.vo.TeamEmp;
import com.web.spring.vo.TeamMate;

@Mapper
public interface Dao_project {
	// 총 프로젝트 건수
	public int cntProject(ProjectSch sch);
	
	// 프로젝트 리스트
	public List<ProjectBasic> projectList(ProjectSch sch);
	
	// 프로젝트 기본정보 등록
	public int insertProjectBasic(ProjectBasic ins);
	// 프로젝트 팀 등록	
	public int insertProjectTeam(ProjectTeam ins);
	// 프로젝트 팀원 등록
	public int insertTeamMate(int empno);
	
	// 사원 리스트
	@Select("SELECT DISTINCT e.empno, e.ename, e.job, d.dname \r\n"
			+ "FROM fb_emp e, fb_dept d\r\n"
			+ "WHERE e.deptno = d.deptno\r\n"
			+ "ORDER BY empno")
	public List<TeamEmp> empList();
	
	public List<TeamMate> tmList(TeamMate sch);
	
}



