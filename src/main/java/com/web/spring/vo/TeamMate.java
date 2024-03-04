package com.web.spring.vo;

import java.util.List;

public class TeamMate {
	private int tmNo;		//팀원 번호
	private int teamNo;		//팀 번호
	private ProjectTeam projectTeam;
	private List<Emp> emp;	// 사원
	private List<Integer> empno; // 사원 번호
	private String auth;	//권한
	private long taskNo;
	
	public TeamMate() {
		// TODO Auto-generated constructor stub
	}
	
	public TeamMate(int tmNo, String auth) {
		super();
		this.tmNo = tmNo;
		this.auth = auth;
	}

	public TeamMate(int tmNo, int teamNo, ProjectTeam projectTeam, List<Emp> emp, List<Integer> empno, String auth) {
		super();
		this.tmNo = tmNo;
		this.teamNo = teamNo;
		this.projectTeam = projectTeam;
		this.emp = emp;
		this.empno = empno;
		this.auth = auth;
	}

	public TeamMate(int tmNo, int teamNo, ProjectTeam projectTeam, List<Emp> emp, List<Integer> empno, String auth,
			long taskNo) {
		super();
		this.tmNo = tmNo;
		this.teamNo = teamNo;
		this.projectTeam = projectTeam;
		this.emp = emp;
		this.empno = empno;
		this.auth = auth;
		this.taskNo = taskNo;
	}

	public int getTmNo() {
		return tmNo;
	}
	public void setTmNo(int tmNo) {
		this.tmNo = tmNo;
	}
	public int getTeamNo() {
		return teamNo;
	}
	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}
	public ProjectTeam getProjectTeam() {
		return projectTeam;
	}
	public void setProjectTeam(ProjectTeam projectTeam) {
		this.projectTeam = projectTeam;
	}
	public List<Emp> getEmp() {
		return emp;
	}
	public void setEmp(List<Emp> emp) {
		this.emp = emp;
	}
	public List<Integer> getEmpno() {
		return empno;
	}
	public void setEmpno(List<Integer> empno) {
		this.empno = empno;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public long getTaskNo() {
		return taskNo;
	}
	public void setTaskNo(long taskNo) {
		this.taskNo = taskNo;
	}
}
