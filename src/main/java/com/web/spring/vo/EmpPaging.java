package com.web.spring.vo;

import java.util.List;

public class EmpPaging {
	private EmpSch sch;
	private List<Emp> elist;
	private EmpPaging() {
		super();
		// TODO Auto-generated constructor stub
	}
	public EmpPaging(EmpSch sch, List<Emp> elist) {
		super();
		this.sch = sch;
		this.elist = elist;
	}
	public EmpSch getSch() {
		return sch;
	}
	public void setSch(EmpSch sch) {
		this.sch = sch;
	}
	public List<Emp> getElist() {
		return elist;
	}
	public void setElist(List<Emp> elist) {
		this.elist = elist;
	}
	
	
}
