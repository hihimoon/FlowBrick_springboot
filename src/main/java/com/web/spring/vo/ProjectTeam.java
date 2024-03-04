package com.web.spring.vo;

public class ProjectTeam {
	private int teamNo;			//팀 번호
	private long prjNo;			//프로젝트 번호
	private String teamName;	//팀 이름
	private ProjectBasic projectInfo;
	
	public ProjectTeam() {
		// TODO Auto-generated constructor stub
	}
	
	public ProjectTeam(int teamNo, long prjNo, String teamName) {
		this.teamNo = teamNo;
		this.prjNo = prjNo;
		this.teamName = teamName;
	}
	
	public int getTeamNo() {
		return teamNo;
	}
	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}
	public long getPrjNo() {
		return prjNo;
	}
	public void setPrjNo(long prjNo) {
		this.prjNo = prjNo;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public ProjectBasic getProjectInfo() {
		return projectInfo;
	}
	public void setProjectInfo(ProjectBasic projectInfo) {
		this.projectInfo = projectInfo;
	}
	
}
