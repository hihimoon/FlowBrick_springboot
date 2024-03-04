package com.web.spring.vo;

import java.util.List;

public class ProjectPaging {
	private ProjectSch sch;
	private List<ProjectBasic> pblist;
	
	public ProjectPaging() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ProjectPaging(ProjectSch sch, List<ProjectBasic> pblist) {
		super();
		this.sch = sch;
		this.pblist = pblist;
	}
	
	public ProjectSch getSch() {
		return sch;
	}
	public void setSch(ProjectSch sch) {
		this.sch = sch;
	}
	public List<ProjectBasic> getPblist() {
		return pblist;
	}
	public void setPblist(List<ProjectBasic> pblist) {
		this.pblist = pblist;
	}
	
}
